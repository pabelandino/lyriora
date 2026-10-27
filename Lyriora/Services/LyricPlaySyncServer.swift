//
//  LyricPlaySyncServer.swift
//  Lyriora
//

import Foundation
import Network

@MainActor
final class LyricPlaySyncServer {
    enum State: Equatable {
        case stopped
        case starting
        case ready
        case failed(String)
    }

    private(set) var state: State = .stopped
    private(set) var lastClientActivityAt: Date?

    private var listener: NWListener?
    private let queue = DispatchQueue(label: "com.lyriora.sync.server", qos: .userInitiated)

    typealias MessageHandler = @MainActor (LyricPlaySyncMessage) -> LyricPlaySyncMessage

    private var messageHandler: MessageHandler?

    func start(handler: @escaping MessageHandler) {
        guard listener == nil else { return }
        messageHandler = handler
        state = .starting

        do {
            let parameters = NWParameters.tcp
            parameters.allowLocalEndpointReuse = true
            parameters.includePeerToPeer = true
            let listener = try NWListener(using: parameters, on: .any)
            listener.service = NWListener.Service(
                name: LyricPlaySync.serviceName,
                type: LyricPlaySync.bonjourType
            )

            listener.stateUpdateHandler = { [weak self] update in
                Task { @MainActor in
                    self?.handleListenerState(update)
                }
            }

            listener.newConnectionHandler = { [weak self] connection in
                Task { @MainActor in
                    self?.handleIncomingConnection(connection)
                }
            }

            listener.start(queue: queue)
            self.listener = listener
        } catch {
            state = .failed(error.localizedDescription)
        }
    }

    func stop() {
        listener?.cancel()
        listener = nil
        messageHandler = nil
        lastClientActivityAt = nil
        state = .stopped
    }

    func noteClientActivity() {
        lastClientActivityAt = .now
    }

    private func handleListenerState(_ update: NWListener.State) {
        switch update {
        case .ready:
            state = .ready
        case .failed(let error):
            state = .failed(error.localizedDescription)
            stop()
        case .cancelled:
            state = .stopped
        default:
            break
        }
    }

    private func handleIncomingConnection(_ connection: NWConnection) {
        connection.start(queue: queue)
        receiveMessage(on: connection) { [weak self] result in
            guard let self else {
                connection.cancel()
                return
            }

            Task { @MainActor in
                self.noteClientActivity()
                let response: LyricPlaySyncMessage
                switch result {
                case .success(let message):
                    if let handler = self.messageHandler {
                        response = handler(message)
                    } else {
                        response = LyricPlaySyncMessage(
                            kind: .error,
                            errorMessage: "Lyriora sync handler unavailable."
                        )
                    }
                case .failure(let error):
                    response = LyricPlaySyncMessage(
                        kind: .error,
                        errorMessage: error.localizedDescription
                    )
                }

                self.send(response, on: connection) {
                    connection.cancel()
                }
            }
        }
    }

    private func receiveMessage(
        on connection: NWConnection,
        completion: @escaping (Result<LyricPlaySyncMessage, Error>) -> Void
    ) {
        var buffer = Data()

        func readMore() {
            connection.receive(minimumIncompleteLength: 1, maximumLength: 65_536) { data, _, isComplete, error in
                if let error {
                    completion(.failure(error))
                    return
                }

                if let data {
                    buffer.append(data)
                }

                if let newlineIndex = buffer.firstIndex(of: 0x0A) {
                    let line = buffer[..<newlineIndex]
                    do {
                        completion(.success(try LyricPlaySyncCodec.decode(line)))
                    } catch {
                        completion(.failure(error))
                    }
                    return
                }

                if isComplete {
                    if buffer.isEmpty {
                        completion(.failure(LyricPlaySyncTransportError.emptyResponse))
                    } else {
                        do {
                            completion(.success(try LyricPlaySyncCodec.decode(buffer)))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                    return
                }

                readMore()
            }
        }

        readMore()
    }

    private func send(
        _ message: LyricPlaySyncMessage,
        on connection: NWConnection,
        completion: @escaping () -> Void
    ) {
        do {
            let payload = try LyricPlaySyncCodec.encode(message)
            connection.send(content: payload, completion: .contentProcessed { _ in
                completion()
            })
        } catch {
            completion()
        }
    }
}

enum LyricPlaySyncTransportError: LocalizedError {
    case emptyResponse
    case noLyrioraHost
    case unexpectedResponse

    var errorDescription: String? {
        switch self {
        case .emptyResponse:
            return "Lyriora returned an empty response."
        case .noLyrioraHost:
            return "No Lyriora host found on the local network."
        case .unexpectedResponse:
            return "Unexpected response from Lyriora."
        }
    }
}
