//
//  SimplePlayConnectionIndicator.swift
//  Lyriora
//

import SwiftUI

enum SimplePlaySyncDisplayState {
    case connected
    case manual
    case disconnected

    var accentColor: Color {
        switch self {
        case .connected:
            Color(red: 0.18, green: 0.82, blue: 0.42)
        case .manual:
            Color(red: 1.0, green: 0.62, blue: 0.18)
        case .disconnected:
            Color(red: 0.95, green: 0.28, blue: 0.28)
        }
    }

    var systemImage: String {
        switch self {
        case .connected:
            "app.connected.to.app.below.fill"
        case .manual:
            "hand.raised.fill"
        case .disconnected:
            "app.dashed"
        }
    }

    var accessibilityLabel: String {
        switch self {
        case .connected:
            "SimplePlay connected"
        case .manual:
            "SimplePlay manual control"
        case .disconnected:
            "SimplePlay not connected"
        }
    }

    var title: String {
        switch self {
        case .connected:
            "SimplePlay Connected"
        case .manual:
            "Manual Control"
        case .disconnected:
            "Looking for SimplePlay"
        }
    }

    var subtitle: String {
        switch self {
        case .connected:
            "Live sync is active on your network."
        case .manual:
            "Automatic slide changes from SimplePlay are paused."
        case .disconnected:
            "Waiting for SimplePlay on the same Wi‑Fi."
        }
    }
}

struct SimplePlayConnectionIndicator: View {
    let state: SimplePlaySyncDisplayState
    let action: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        Button(action: action) {
            ZStack {
                if !reduceMotion {
                    TimelineView(.animation(minimumInterval: 1.0 / 30, paused: false)) { context in
                        let phase = (sin(context.date.timeIntervalSinceReferenceDate * 2.2) + 1) / 2
                        let glowOpacity = 0.22 + phase * 0.38
                        let glowRadius: CGFloat = 5 + phase * 7

                        Circle()
                            .fill(state.accentColor.opacity(glowOpacity * 0.35))
                            .frame(width: 34, height: 34)
                            .blur(radius: glowRadius)
                    }
                }

                Circle()
                    .fill(state.accentColor.opacity(0.16))
                    .frame(width: 30, height: 30)

                Circle()
                    .strokeBorder(
                        state.accentColor.opacity(state == .disconnected ? 0.55 : 0.75),
                        lineWidth: 1.5
                    )
                    .frame(width: 30, height: 30)

                Image(systemName: state.systemImage)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(state.accentColor)
                    .symbolEffect(.pulse, options: .repeating, isActive: !reduceMotion && state != .manual)
            }
            .frame(width: 34, height: 34)
            .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(state.accessibilityLabel)
        .accessibilityHint("Shows SimplePlay sync status")
    }
}

struct SimplePlayConnectionInfoSheet: View {
    @Bindable var viewModel: AppViewModel
    @Environment(\.dismiss) private var dismiss

    private var state: SimplePlaySyncDisplayState {
        viewModel.simplePlaySyncDisplayState
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 14) {
                    SimplePlayConnectionIndicator(state: state) {}
                        .allowsHitTesting(false)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(state.title)
                            .font(.title3.weight(.semibold))

                        Text(state.subtitle)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

                Toggle(isOn: manualModeBinding) {
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Manual control")
                            .font(.subheadline.weight(.semibold))
                        Text("Pause automatic slide changes so you can control lyrics yourself.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .toggleStyle(.switch)
                .padding(16)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))

                VStack(alignment: .leading, spacing: 12) {
                    infoRow(
                        icon: "1.circle.fill",
                        title: "Open SimplePlay",
                        detail: "Launch SimplePlay on a device connected to the same local network."
                    )
                    infoRow(
                        icon: "2.circle.fill",
                        title: "Assign sections",
                        detail: "In SimplePlay, open Assign Sections and link each section to a lyric slide."
                    )
                    infoRow(
                        icon: "3.circle.fill",
                        title: "Go live",
                        detail: "When a section triggers, Lyriora jumps to the mapped slide automatically."
                    )
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))

                statusFooter

                Spacer(minLength: 0)
            }
            .padding(24)
            .navigationTitle("SimplePlay Sync")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
        #if os(macOS)
        .frame(minWidth: 420, minHeight: 420)
        #endif
    }

    @ViewBuilder
    private var statusFooter: some View {
        switch state {
        case .manual:
            Label("Manual control is on. Turn it off to resume live sync.", systemImage: "hand.raised.fill")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(SimplePlaySyncDisplayState.manual.accentColor)
        case .connected:
            Label("SimplePlay was seen recently on this network.", systemImage: "checkmark.circle.fill")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.green)
        case .disconnected:
            Label("Keep Lyriora open with a lyric selected. On first connect, macOS may ask SimplePlay for local network access — allow it to discover Lyriora.", systemImage: "info.circle")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private var manualModeBinding: Binding<Bool> {
        Binding(
            get: { viewModel.settings.isSimplePlayManualMode },
            set: { viewModel.setSimplePlayManualMode($0) }
        )
    }

    private func infoRow(icon: String, title: String, detail: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.body.weight(.semibold))
                .foregroundStyle(.secondary)
                .frame(width: 22)

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.subheadline.weight(.semibold))
                Text(detail)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}
