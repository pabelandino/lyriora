//
//  SimplePlayConnectionIndicator.swift
//  Lyriora
//

import SwiftUI

struct SimplePlayConnectionIndicator: View {
    let isConnected: Bool
    let action: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private var accentColor: Color {
        isConnected ? Color(red: 0.18, green: 0.82, blue: 0.42) : Color(red: 0.95, green: 0.28, blue: 0.28)
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                if !reduceMotion {
                    TimelineView(.animation(minimumInterval: 1.0 / 30, paused: false)) { context in
                        let phase = (sin(context.date.timeIntervalSinceReferenceDate * 2.2) + 1) / 2
                        let glowOpacity = 0.22 + phase * 0.38
                        let glowRadius: CGFloat = 5 + phase * 7

                        Circle()
                            .fill(accentColor.opacity(glowOpacity * 0.35))
                            .frame(width: 34, height: 34)
                            .blur(radius: glowRadius)
                    }
                }

                Circle()
                    .fill(accentColor.opacity(0.16))
                    .frame(width: 30, height: 30)

                Circle()
                    .strokeBorder(accentColor.opacity(isConnected ? 0.75 : 0.55), lineWidth: 1.5)
                    .frame(width: 30, height: 30)

                Image(systemName: isConnected ? "app.connected.to.app.below.fill" : "app.dashed")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(accentColor)
                    .symbolEffect(.pulse, options: .repeating, isActive: !reduceMotion)
            }
            .frame(width: 34, height: 34)
            .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(isConnected ? "SimplePlay connected" : "SimplePlay not connected")
        .accessibilityHint("Shows SimplePlay sync status")
    }
}

struct SimplePlayConnectionInfoSheet: View {
    let isConnected: Bool
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 14) {
                    SimplePlayConnectionIndicator(isConnected: isConnected) {}
                        .allowsHitTesting(false)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(isConnected ? "SimplePlay Connected" : "Looking for SimplePlay")
                            .font(.title3.weight(.semibold))

                        Text(isConnected ? "Live sync is active on your network." : "Waiting for SimplePlay on the same Wi‑Fi.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

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

                if isConnected {
                    Label("SimplePlay was seen recently on this network.", systemImage: "checkmark.circle.fill")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.green)
                } else {
                    Label("Keep Lyriora open with a lyric selected. On first connect, macOS may ask SimplePlay for local network access — allow it to discover Lyriora.", systemImage: "info.circle")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

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
        .frame(minWidth: 420, minHeight: 380)
        #endif
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
