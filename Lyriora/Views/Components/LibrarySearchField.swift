//
//  LibrarySearchField.swift
//  Lyriora
//

import SwiftUI

enum LibraryPanelMetrics {
    static func actionDiameter(compact: Bool) -> CGFloat {
        compact ? 32 : 36
    }

    static func actionSymbolSize(compact: Bool) -> CGFloat {
        compact ? 13 : 15
    }
}

struct LibraryMorphSearchHeader<Trailing: View>: View {
    let title: String
    let systemImage: String
    @Binding var searchText: String
    let placeholder: String
    var horizontalPadding: CGFloat?
    @ViewBuilder var trailing: () -> Trailing

    @Environment(\.workspaceCompactLayout) private var workspaceCompactLayout
    @Environment(\.colorScheme) private var colorScheme
    @FocusState private var isFocused: Bool
    @State private var isExpanded = false

    private var isSearchActive: Bool {
        isExpanded || !LibrarySearch.normalize(searchText).isEmpty
    }

    private var controlSize: CGFloat {
        LibraryPanelMetrics.actionDiameter(compact: workspaceCompactLayout)
    }

    private var resolvedHorizontalPadding: CGFloat {
        horizontalPadding ?? (workspaceCompactLayout ? 10 : 12)
    }

    var body: some View {
        HStack(spacing: isSearchActive ? 0 : Layout.contentSpacing) {
            Label(title, systemImage: systemImage)
                .font(workspaceCompactLayout ? .subheadline.weight(.semibold) : .headline)
                .foregroundStyle(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.85)
                .layoutPriority(isSearchActive ? 0 : 1)
                .opacity(isSearchActive ? 0 : 1)
                .frame(maxWidth: isSearchActive ? 0 : .infinity, alignment: .leading)
                .clipped()
                .allowsHitTesting(!isSearchActive)

            if !isSearchActive {
                Spacer(minLength: 0)
            }

            trailing()
                .opacity(isSearchActive ? 0 : 1)
                .scaleEffect(isSearchActive ? 0.85 : 1, anchor: .trailing)
                .frame(width: isSearchActive ? 0 : nil)
                .clipped()
                .allowsHitTesting(!isSearchActive)

            searchSlot
                .layoutPriority(isSearchActive ? 1 : 0)
                .frame(maxWidth: isSearchActive ? .infinity : nil, alignment: .trailing)
        }
        .padding(.horizontal, resolvedHorizontalPadding)
        .animation(GlassMorphAnimation.standard, value: isSearchActive)
        .onChange(of: searchText) { _, newValue in
            if !LibrarySearch.normalize(newValue).isEmpty {
                isExpanded = true
            }
        }
    }

    private var searchSlot: some View {
        ZStack(alignment: .trailing) {
            expandedSearchField
                .opacity(isSearchActive ? 1 : 0)
                .frame(maxWidth: isSearchActive ? .infinity : 0)
                .clipped()
                .allowsHitTesting(isSearchActive)

            collapsedSearchButton
                .opacity(isSearchActive ? 0 : 1)
                .allowsHitTesting(!isSearchActive)
        }
    }

    private var collapsedSearchButton: some View {
        Button {
            withAnimation(GlassMorphAnimation.standard) {
                isExpanded = true
            }
            isFocused = true
        } label: {
            GlassCircleIcon(
                systemName: "magnifyingglass",
                diameter: controlSize,
                symbolSize: LibraryPanelMetrics.actionSymbolSize(compact: workspaceCompactLayout)
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Search \(title.lowercased())")
    }

    private var expandedSearchField: some View {
        HStack(spacing: Layout.fieldSpacing) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: workspaceCompactLayout ? 13 : 14, weight: .bold))
                .foregroundStyle(GlassControlChrome.iconForeground(for: colorScheme))
                .frame(width: controlSize, height: controlSize)

            TextField(placeholder, text: $searchText)
                .font(workspaceCompactLayout ? .caption : .subheadline)
                .textFieldStyle(.plain)
                .focused($isFocused)
                .autocorrectionDisabled()
                .submitLabel(.search)
                #if os(iOS)
                .background(Color.clear)
                #endif

            if !searchText.isEmpty {
                Button(action: collapseSearch) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: workspaceCompactLayout ? 14 : 16))
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Clear search")
            } else {
                Button(action: collapseSearch) {
                    Image(systemName: "xmark")
                        .font(.system(size: workspaceCompactLayout ? 12 : 13, weight: .semibold))
                        .foregroundStyle(.secondary)
                        .frame(width: controlSize, height: controlSize)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Close search")
            }
        }
        .padding(.leading, 4)
        .padding(.trailing, workspaceCompactLayout ? 6 : 8)
        .padding(.vertical, Layout.fieldVerticalPadding)
        .frame(maxWidth: .infinity)
        .glassEffect(.regular.interactive(), in: .capsule)
        .shadow(
            color: GlassControlChrome.shadowColor(for: colorScheme),
            radius: 2,
            y: 1
        )
        .glassControlBorder(Capsule())
        .onAppear {
            isFocused = true
        }
    }

    private func collapseSearch() {
        withAnimation(GlassMorphAnimation.standard) {
            searchText = ""
            isExpanded = false
            isFocused = false
        }
    }
}

private enum Layout {
    static let contentSpacing: CGFloat = 8
    static let fieldSpacing: CGFloat = 6
    static let fieldVerticalPadding: CGFloat = 4
}

struct LibrarySearchEmptyState: View {
    let query: String

    @Environment(\.workspaceCompactLayout) private var workspaceCompactLayout

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: "magnifyingglass")
                .font(.title3)
                .foregroundStyle(.tertiary)

            Text("No results for \"\(query)\"")
                .font(workspaceCompactLayout ? .caption : .subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, workspaceCompactLayout ? 16 : 24)
    }
}
