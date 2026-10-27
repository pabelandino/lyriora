//
//  BibleXMLDocumentPicker.swift
//  Lyriora
//

import SwiftUI
import UniformTypeIdentifiers

#if os(iOS)
import UIKit

struct BibleXMLDocumentPicker: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let onPick: (URL) -> Void
    let onCancel: () -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        controller.view.isHidden = true
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        guard isPresented else { return }
        guard context.coordinator.isPresenting == false else { return }

        let picker = UIDocumentPickerViewController(
            forOpeningContentTypes: BibleVersionRepository.importableContentTypes,
            asCopy: true
        )
        picker.delegate = context.coordinator
        picker.allowsMultipleSelection = false
        picker.modalPresentationStyle = .formSheet

        context.coordinator.isPresenting = true
        let presenter = uiViewController.topMostPresentedController()
        presenter.present(picker, animated: true)
    }

    final class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: BibleXMLDocumentPicker
        var isPresenting = false

        init(parent: BibleXMLDocumentPicker) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            isPresenting = false
            parent.isPresented = false
            guard let url = urls.first else { return }
            parent.onPick(url)
        }

        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            isPresenting = false
            parent.isPresented = false
            parent.onCancel()
        }
    }
}

private extension UIViewController {
    func topMostPresentedController() -> UIViewController {
        var controller: UIViewController = self
        while let presented = controller.presentedViewController {
            controller = presented
        }
        return controller
    }
}

extension View {
    func bibleXMLDocumentPicker(
        isPresented: Binding<Bool>,
        onPick: @escaping (URL) -> Void,
        onCancel: @escaping () -> Void = {}
    ) -> some View {
        background {
            BibleXMLDocumentPicker(
                isPresented: isPresented,
                onPick: onPick,
                onCancel: onCancel
            )
            .frame(width: 0, height: 0)
        }
    }
}
#endif

enum BibleImportPresentation {
    @ViewBuilder
    static func attach<Content: View>(
        to content: Content,
        isPresented: Binding<Bool>,
        onPick: @escaping (URL) -> Void,
        onCancel: @escaping () -> Void = {}
    ) -> some View {
        #if os(iOS)
        content
            .bibleXMLDocumentPicker(
                isPresented: isPresented,
                onPick: onPick,
                onCancel: onCancel
            )
        #else
        content
            .fileImporter(
                isPresented: isPresented,
                allowedContentTypes: BibleVersionRepository.importableContentTypes,
                allowsMultipleSelection: false
            ) { result in
                switch result {
                case let .success(urls):
                    guard let url = urls.first else { return }
                    onPick(url)
                case .failure:
                    onCancel()
                }
            }
        #endif
    }
}

struct BibleImportRootModifier: ViewModifier {
    @Bindable var viewModel: AppViewModel

    func body(content: Content) -> some View {
        BibleImportPresentation.attach(
            to: content,
            isPresented: $viewModel.isBibleVersionImportPresented,
            onPick: { url in
                viewModel.importBibleVersion(from: url)
            }
        )
    }
}
