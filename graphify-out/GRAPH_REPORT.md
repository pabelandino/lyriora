# Graph Report - Lyriora  (2026-08-05)

## Corpus Check
- 97 files · ~44,854 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1299 nodes · 2585 edges · 96 communities (74 shown, 22 thin omitted)
- Extraction: 93% EXTRACTED · 7% INFERRED · 0% AMBIGUOUS · INFERRED: 192 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `0ac613aa`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- ExternalDisplayManager
- EditorAdaptivePresentationText
- LyricEditorView
- DefaultBackgroundSettings
- SwiftUI
- PresentationFontFamily
- View
- .configure
- CodingKeys
- MediaAsset
- .resolvedMetrics
- MediaLibraryPanelView.swift
- AppViewModel
- .loadThumbnail
- LyricSlideLivePreview
- LyricSlide
- Identifiable
- PlayerLayerView
- Sendable
- BackgroundContentMode
- BlurredBackgroundLayer
- LyricImportParser
- CenterPanelView
- VideoPlaybackController
- What You Must Do When Invoked
- BackgroundFitToolbar
- PresentationTextConfiguration
- PresentationPreviewView
- LyrioraUITests
- GlobalStyleEditorContent
- DefaultBackgroundPreset
- PresentationLayout
- SlideGridView
- MediaAsset
- LyricTheme
- LyricCardView
- VideoPlaybackMode
- SettingsRepository
- LyricDocument
- View
- LyricStyleProfile
- MediaThumbnailView
- .saveLyric
- .saveTheme
- ThemePickerMenu
- Codable
- DisplayInfoSheet
- What You Must Do When Invoked
- PresentationState
- LyrioraTests.swift
- ThemeSavePromptSheet
- GlassIconButton
- LyricDocument
- LyricSlideTag
- AVLayerVideoGravity
- AVPlayer
- CGRect
- CMTime
- Context
- Double
- Animation
- Color
- Content
- Font
- Bool
- RoundedRectangle
- NSCoder
- .measureSingleLine
- LyricSlideLayoutEngine
- LyricRepository
- .loadInitialData
- SlideStyleControlsView
- graphify reference: extra exports and benchmark
- graphify reference: extra exports and benchmark
- CodingKeys
- LyricLanguage
- .linearGradient
- StickyPreviewEditorLayout
- graphify reference: query, path, explain
- graphify reference: query, path, explain
- GlassToolbarIconSize
- content
- graphify reference: add a URL and watch a folder
- graphify reference: commit hook and native AGENTS.md integration
- graphify reference: incremental update and cluster-only
- graphify reference: add a URL and watch a folder
- graphify reference: commit hook and native CLAUDE.md integration
- graphify reference: incremental update and cluster-only
- graphify reference: GitHub clone and cross-repo merge
- graphify reference: transcribe video and audio
- graphify reference: GitHub clone and cross-repo merge
- graphify reference: transcribe video and audio
- .agents/skills/graphify/references/extraction-spec.md
- CLAUDE.md
- .claude/CLAUDE.md
- .claude/skills/graphify/references/extraction-spec.md

## God Nodes (most connected - your core abstractions)
1. `AppViewModel` - 103 edges
2. `LyricEditorView` - 50 edges
3. `ExternalDisplayManager` - 49 edges
4. `LyricSlide` - 37 edges
5. `PresentationTextConfiguration` - 31 edges
6. `LyricSlideTag` - 30 edges
7. `PresentationFontFamily` - 30 edges
8. `PresentationPreviewView` - 29 edges
9. `LyricSlideLivePreview` - 27 edges
10. `LyricDocument` - 26 edges

## Surprising Connections (you probably didn't know these)
- `.activeTheme` --references--> `AppViewModel`  [INFERRED]
  Lyriora/Views/Modals/LyricEditorView.swift → Lyriora/ViewModels/AppViewModel.swift
- `.presentationToolbar` --calls--> `PresentationActionsToolbar`  [INFERRED]
  Lyriora/Views/CenterPanel/CenterPanelView.swift → Lyriora/Views/Components/PresentationActionsToolbar.swift
- `.previewBackground` --calls--> `PresentationBackgroundLayer`  [INFERRED]
  Lyriora/Views/Components/LyricSlideLivePreview.swift → Lyriora/Views/Components/AppBackgroundView.swift
- `.body` --calls--> `PresentationBackgroundLayer`  [INFERRED]
  Lyriora/Views/Components/ThemePreviewCard.swift → Lyriora/Views/Components/AppBackgroundView.swift
- `.videoControlsCapsule` --calls--> `GlassIconButton`  [INFERRED]
  Lyriora/Views/Components/PresentationActionsToolbar.swift → Lyriora/Views/Components/GlassPanel.swift

## Import Cycles
- None detected.

## Communities (96 total, 22 thin omitted)

### Community 0 - "ExternalDisplayManager"
Cohesion: 0.06
Nodes (41): AnyView, ExternalDisplayInfo, .resolutionDescription, Bool, CGFloat, CGSize, String, ExternalDisplayManager (+33 more)

### Community 1 - "EditorAdaptivePresentationText"
Cohesion: 0.15
Nodes (18): EnvironmentKey, EditorAdaptivePresentationText, .body, .lines, .resolvedConfiguration, EditorPreviewSizing, exact, scaledApproximation (+10 more)

### Community 2 - "LyricEditorView"
Cohesion: 0.06
Nodes (35): sourceSections, KeyboardDismissal, LyricEditorNavigationOption, .id, lyrics, .systemImage, .title, typography (+27 more)

### Community 3 - "DefaultBackgroundSettings"
Cohesion: 0.16
Nodes (16): DefaultBackgroundSettings, Double, Bool, CGFloat, SlideTextStyle, String, ThemeMiniPreview, .body (+8 more)

### Community 4 - "SwiftUI"
Cohesion: 0.06
Nodes (26): AppKit, AVFoundation, AVKit, CoreGraphics, Foundation, ResolvedBackgroundContentMode, fill, fit (+18 more)

### Community 5 - "PresentationFontFamily"
Cohesion: 0.12
Nodes (20): PresentationFontFamily, arial, avenirNext, courierNew, futura, georgia, helveticaNeue, .id (+12 more)

### Community 6 - "View"
Cohesion: 0.24
Nodes (12): Content, GlassCapsuleToolbar, GlassCircleIcon, .body, GlassOverflowMenu, .body, GlassPanel, GlassToolbarMetrics (+4 more)

### Community 7 - ".configure"
Cohesion: 0.10
Nodes (30): TimeInterval, UUID, VideoSeekRequest, TimeInterval, Void, VideoProgressReporter, Coordinator, LoopingVideoBackground (+22 more)

### Community 8 - "CodingKeys"
Cohesion: 0.07
Nodes (31): CodingKey, Encoder, CodingKeys, fontDesign, fontFamily, fontWeight, horizontalPaddingRatio, isAdaptiveScalingEnabled (+23 more)

### Community 9 - "MediaAsset"
Cohesion: 0.16
Nodes (13): Data, MediaAsset, MediaAssetKind, image, video, Date, UUID, MediaRepository (+5 more)

### Community 10 - ".resolvedMetrics"
Cohesion: 0.19
Nodes (13): ExternalDisplayDiscovery, ExternalDisplayMetrics, Source, liveContainer, liveWindow, sceneCoordinateSpace, screenBounds, Bool (+5 more)

### Community 11 - "MediaLibraryPanelView.swift"
Cohesion: 0.22
Nodes (10): ImageLibrarySection, MediaLibraryPanelView, .body, sectionHeader(), Binding, PhotosPickerItem, String, VideoLibrarySection (+2 more)

### Community 12 - "AppViewModel"
Cohesion: 0.09
Nodes (20): ExternalDisplayManager, LyricRepositoryProtocol, AppViewModel, .activePresentationBackground, .hasCustomBackgroundSelected, .hasVideoBackgroundSelected, .selectedLyricSlides, .selectedPhotoItems (+12 more)

### Community 13 - ".loadThumbnail"
Cohesion: 0.15
Nodes (16): AVAssetImageGenerator, CGImage, Error, Metadata, MetadataError, cancelled, thumbnailFailed, CGSize (+8 more)

### Community 14 - "LyricSlideLivePreview"
Cohesion: 0.11
Nodes (21): LyricPreviewBackgroundStyle, borderOnly, settingsDefault, LyricSlideLivePreview, .body, .compactHeight, .cornerRadius, .displayText (+13 more)

### Community 15 - "LyricSlide"
Cohesion: 0.15
Nodes (17): LyricSlide, .index, Int, SlideTextStyle, String, UUID, .body, LyricEditorSlideCard (+9 more)

### Community 16 - "Identifiable"
Cohesion: 0.13
Nodes (14): ButtonRole, Hashable, Identifiable, LyricEditorLaunch, PresentationFontDesign, `default`, .id, .label (+6 more)

### Community 17 - "PlayerLayerView"
Cohesion: 0.10
Nodes (22): AnyClass, AVPlayerView, CGSize, AVPlayerLayerRepresentable, AVPlayerLayerView, .body, AVPlayerViewRepresentable, PlayerLayerView (+14 more)

### Community 18 - "Sendable"
Cohesion: 0.17
Nodes (15): Equatable, LocalizedError, LyricSectionSource, String, UUID, PresentationBackground, URL, LyricImportError (+7 more)

### Community 19 - "BackgroundContentMode"
Cohesion: 0.18
Nodes (11): BackgroundContentMode, auto, fill, fit, .id, .label, landscape, portrait (+3 more)

### Community 20 - "BlurredBackgroundLayer"
Cohesion: 0.29
Nodes (9): BlurredBackgroundLayer, .body, BlurredBackgroundModifier, CGFloat, Content, Double, View, View (+1 more)

### Community 21 - "LyricImportParser"
Cohesion: 0.29
Nodes (5): LyricImportParser, ParsedSections, Bool, Int, String

### Community 22 - "CenterPanelView"
Cohesion: 0.22
Nodes (6): CenterPanelView, .body, .displayButtonAccessibilityLabel, .displayToolbar, .presentationToolbar, String

### Community 23 - "VideoPlaybackController"
Cohesion: 0.21
Nodes (9): Any, AVPlayer, AVPlayerItem, CMTime, NSObjectProtocol, TimeInterval, URL, Void (+1 more)

### Community 24 - "What You Must Do When Invoked"
Cohesion: 0.08
Nodes (24): For /graphify add and --watch, For /graphify query, For the commit hook and native AGENTS.md integration, For --update and --cluster-only, /graphify, Honesty Rules, Interpreter guard for subcommands, Part A - Structural extraction for code files (+16 more)

### Community 25 - "BackgroundFitToolbar"
Cohesion: 0.22
Nodes (13): BackgroundFitBadgeLabel, .body, BackgroundFitToggleLabel, .body, BackgroundFitToolbar, .body, .toggleButton, Constants (+5 more)

### Community 26 - "PresentationTextConfiguration"
Cohesion: 0.16
Nodes (13): PresentationTextConfiguration, SlideTextStyle, Bool, CGFloat, CGSize, Color, Double, PresentationFontWeight (+5 more)

### Community 27 - "PresentationPreviewView"
Cohesion: 0.13
Nodes (23): ExternalDisplayInfo, .body, PresentationContentView, .body, .textConfiguration, PresentationPreviewView, .displayedCurrentTime, .isVideoBackground (+15 more)

### Community 28 - "LyrioraUITests"
Cohesion: 0.15
Nodes (6): LyrioraUITests, LyrioraUITestsLaunchTests, .runsForEachTargetApplicationUIConfiguration, Bool, XCTest, XCTestCase

### Community 29 - "GlobalStyleEditorContent"
Cohesion: 0.23
Nodes (9): GlobalStyleEditorContent, GlobalStyleEditorView, .body, .hasStyleChanges, Bool, SlideTextStyle, String, UUID (+1 more)

### Community 30 - "DefaultBackgroundPreset"
Cohesion: 0.18
Nodes (12): DefaultBackgroundPreset, arcticGlow, cobaltFade, .colors, deepNavy, .id, .label, .linearGradient (+4 more)

### Community 31 - "PresentationLayout"
Cohesion: 0.26
Nodes (8): PresentationLayout, CGFloat, CGSize, .presentationLayoutCanvasSize, .canvasAspectRatio, .canvasSize, .layoutCanvasSize, .previewSection

### Community 32 - "SlideGridView"
Cohesion: 0.14
Nodes (19): GridItem, SlideGridView, .columns, SlideThumbnailView, .textConfiguration, .thumbnailStyle, .usesDefaultGradientBackground, BackgroundContentMode (+11 more)

### Community 33 - "MediaAsset"
Cohesion: 0.30
Nodes (5): MediaRepositoryProtocol, MediaAsset, URL, .body, .body

### Community 34 - "LyricTheme"
Cohesion: 0.21
Nodes (10): LyricTheme, Date, Int, SlideTextStyle, String, UUID, FileManager, URL (+2 more)

### Community 35 - "LyricCardView"
Cohesion: 0.22
Nodes (12): Layout, .trailingControlInset, LyricCardView, .footerShape, LyricsLibraryPanelView, .deleteAlertBinding, Binding, Bool (+4 more)

### Community 36 - "VideoPlaybackMode"
Cohesion: 0.13
Nodes (13): Bool, VideoPlaybackMode, loop, .loopsVideo, playOnce, .toggled, Constants, PresentationActionsToolbar (+5 more)

### Community 37 - "SettingsRepository"
Cohesion: 0.38
Nodes (4): SettingsRepository, SettingsRepositoryProtocol, FileManager, URL

### Community 38 - "LyricDocument"
Cohesion: 0.31
Nodes (4): LyricEditorLaunch, LyricDocument, .body, UUID

### Community 39 - "View"
Cohesion: 0.16
Nodes (13): EdgeInsets, ContentView, .sidebarList, DefaultBackgroundPresetPreview, .body, DefaultBackgroundPreviewCard, .body, SettingsSheet (+5 more)

### Community 40 - "LyricStyleProfile"
Cohesion: 0.29
Nodes (8): LyricStyleProfile, .activeThemeName, SlideDetailEditorView, .activeStyle, Binding, Bool, SlideTextStyle, Void

### Community 41 - "MediaThumbnailView"
Cohesion: 0.05
Nodes (57): Double, Entry, LocalImageCache, CGSize, Image, URL, ConfigurableDefaultGradientView, .body (+49 more)

### Community 42 - ".saveLyric"
Cohesion: 0.25
Nodes (6): LyricImportResult, LyricSectionSource, LyricLanguage, LyricStyleProfile, String, UUID

### Community 43 - ".saveTheme"
Cohesion: 0.43
Nodes (3): LyricTheme, ThemeRepositoryProtocol, SlideTextStyle

### Community 44 - "ThemePickerMenu"
Cohesion: 0.32
Nodes (8): UUID, Void, ThemeGalleryView, .body, ThemePickerMenu, .body, .selectedTheme, .body

### Community 45 - "Codable"
Cohesion: 0.14
Nodes (15): CaseIterable, Codable, AppSettings, PresentationFontWeight, bold, .id, .label, medium (+7 more)

### Community 46 - "DisplayInfoSheet"
Cohesion: 0.29
Nodes (6): DisplayInfoSheet, .body, .statusDescription, Bool, String, Void

### Community 47 - "What You Must Do When Invoked"
Cohesion: 0.08
Nodes (24): For /graphify add and --watch, For /graphify query, For the commit hook and native CLAUDE.md integration, For --update and --cluster-only, /graphify, Honesty Rules, Interpreter guard for subcommands, Part A - Structural extraction for code files (+16 more)

### Community 48 - "PresentationState"
Cohesion: 0.29
Nodes (6): .presentationState, PresentationState, Bool, PresentationBackground, SlideTextStyle, String

### Community 50 - "ThemeSavePromptSheet"
Cohesion: 0.29
Nodes (6): Bool, String, Void, ThemeSavePromptSheet, .body, .trimmedThemeName

### Community 51 - "GlassIconButton"
Cohesion: 0.28
Nodes (8): Color, ColorScheme, GlassIconButton, .body, .foregroundColor, GlassToolbarIconStyle, Bool, .clearActionsCapsule

### Community 52 - "LyricDocument"
Cohesion: 0.15
Nodes (13): LyricDocument, .previewSnippet, .slides, CGSize, Date, Decoder, SlideTextStyle, String (+5 more)

### Community 53 - "LyricSlideTag"
Cohesion: 0.12
Nodes (16): LyricSlideTag, bridge, chorus, .displayName, .id, instrumental, intro, outro (+8 more)

### Community 67 - ".measureSingleLine"
Cohesion: 0.37
Nodes (7): Any, PresentationTextMeasurer, Bool, CGFloat, CGSize, String, NSAttributedString

### Community 68 - "LyricSlideLayoutEngine"
Cohesion: 0.38
Nodes (6): LyricSlideLayoutEngine, CGFloat, CGSize, Int, SlideTextStyle, String

### Community 69 - "LyricRepository"
Cohesion: 0.27
Nodes (5): LyricRepository, LyricRepositoryProtocol, FileManager, URL, UUID

### Community 70 - ".loadInitialData"
Cohesion: 0.20
Nodes (7): App, .body, LyrioraApp, .body, MainView, .body, Scene

### Community 71 - "SlideStyleControlsView"
Cohesion: 0.29
Nodes (9): SlideStyleControlsView, .body, .fontSizeBinding, .horizontalMarginBinding, .verticalMarginBinding, Binding, Double, SlideTextStyle (+1 more)

### Community 72 - "graphify reference: extra exports and benchmark"
Cohesion: 0.22
Nodes (8): graphify reference: extra exports and benchmark, Step 6b - Wiki (only if --wiki flag), Step 7 - Neo4j export (only if --neo4j or --neo4j-push flag), Step 7a - FalkorDB export (only if --falkordb or --falkordb-push flag), Step 7b - SVG export (only if --svg flag), Step 7c - GraphML export (only if --graphml flag), Step 7d - MCP server (only if --mcp flag), Step 8 - Token reduction benchmark (only if total_words > 5000)

### Community 73 - "graphify reference: extra exports and benchmark"
Cohesion: 0.22
Nodes (8): graphify reference: extra exports and benchmark, Step 6b - Wiki (only if --wiki flag), Step 7 - Neo4j export (only if --neo4j or --neo4j-push flag), Step 7a - FalkorDB export (only if --falkordb or --falkordb-push flag), Step 7b - SVG export (only if --svg flag), Step 7c - GraphML export (only if --graphml flag), Step 7d - MCP server (only if --mcp flag), Step 8 - Token reduction benchmark (only if total_words > 5000)

### Community 74 - "CodingKeys"
Cohesion: 0.22
Nodes (9): CodingKeys, colorSeed, createdAt, id, language, storedSlides, styleProfile, title (+1 more)

### Community 75 - "LyricLanguage"
Cohesion: 0.25
Nodes (6): LyricLanguage, .displayName, english, .id, spanish, unknown

### Community 76 - ".linearGradient"
Cohesion: 0.32
Nodes (5): LyricGradient, Color, LinearGradient, UInt64, .body

### Community 77 - "StickyPreviewEditorLayout"
Cohesion: 0.29
Nodes (6): StickyPreviewEditorLayout, .stickyBackground, CGFloat, Content, .body, Preview

### Community 78 - "graphify reference: query, path, explain"
Cohesion: 0.33
Nodes (5): For /graphify explain, For /graphify path, graphify reference: query, path, explain, Step 0 — Constrained query expansion (REQUIRED before traversal), Step 1 — Traversal

### Community 79 - "graphify reference: query, path, explain"
Cohesion: 0.33
Nodes (5): For /graphify explain, For /graphify path, graphify reference: query, path, explain, Step 0 — Constrained query expansion (REQUIRED before traversal), Step 1 — Traversal

### Community 80 - "GlassToolbarIconSize"
Cohesion: 0.33
Nodes (6): Font, GlassToolbarIconSize, .frameSize, .iconFont, prominent, regular

### Community 81 - "content"
Cohesion: 0.40
Nodes (5): content, .body, .body, .body, .body

### Community 82 - "graphify reference: add a URL and watch a folder"
Cohesion: 0.50
Nodes (3): For /graphify add, For --watch, graphify reference: add a URL and watch a folder

### Community 83 - "graphify reference: commit hook and native AGENTS.md integration"
Cohesion: 0.50
Nodes (3): For git commit hook, For native AGENTS.md integration, graphify reference: commit hook and native AGENTS.md integration

### Community 84 - "graphify reference: incremental update and cluster-only"
Cohesion: 0.50
Nodes (3): For --cluster-only, For --update (incremental re-extraction), graphify reference: incremental update and cluster-only

### Community 85 - "graphify reference: add a URL and watch a folder"
Cohesion: 0.50
Nodes (3): For /graphify add, For --watch, graphify reference: add a URL and watch a folder

### Community 86 - "graphify reference: commit hook and native CLAUDE.md integration"
Cohesion: 0.50
Nodes (3): For git commit hook, For native CLAUDE.md integration, graphify reference: commit hook and native CLAUDE.md integration

### Community 87 - "graphify reference: incremental update and cluster-only"
Cohesion: 0.50
Nodes (3): For --cluster-only, For --update (incremental re-extraction), graphify reference: incremental update and cluster-only

## Knowledge Gaps
- **263 isolated node(s):** `Usage`, `What graphify is for`, `Step 0 - GitHub repos and multi-path merge (only if a URL or several paths)`, `Step 1 - Ensure graphify is installed`, `Step 2 - Detect files` (+258 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **22 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AppViewModel` connect `AppViewModel` to `ExternalDisplayManager`, `LyricEditorView`, `SwiftUI`, `MediaAsset`, `MediaLibraryPanelView.swift`, `CenterPanelView`, `VideoPlaybackController`, `PresentationPreviewView`, `GlobalStyleEditorContent`, `PresentationLayout`, `MediaAsset`, `LyricCardView`, `VideoPlaybackMode`, `LyricDocument`, `View`, `.saveLyric`, `.saveTheme`, `PresentationState`, `LyricDocument`, `.loadInitialData`?**
  _High betweenness centrality (0.180) - this node is a cross-community bridge._
- **Why does `SwiftUI` connect `SwiftUI` to `EditorAdaptivePresentationText`, `LyricEditorView`, `DefaultBackgroundSettings`, `View`, `MediaLibraryPanelView.swift`, `LyricSlideLivePreview`, `LyricSlide`, `BlurredBackgroundLayer`, `CenterPanelView`, `BackgroundFitToolbar`, `PresentationTextConfiguration`, `GlobalStyleEditorContent`, `SlideGridView`, `LyricCardView`, `VideoPlaybackMode`, `View`, `LyricStyleProfile`, `MediaThumbnailView`, `DisplayInfoSheet`, `ThemeSavePromptSheet`, `.loadInitialData`, `SlideStyleControlsView`, `.linearGradient`, `StickyPreviewEditorLayout`?**
  _High betweenness centrality (0.141) - this node is a cross-community bridge._
- **Why does `View` connect `View` to `ExternalDisplayManager`, `SlideGridView`, `LyricCardView`, `VideoPlaybackMode`, `.loadInitialData`, `.configure`, `MediaThumbnailView`, `MediaLibraryPanelView.swift`, `PlayerLayerView`, `GlassIconButton`, `CenterPanelView`, `BackgroundFitToolbar`, `PresentationPreviewView`?**
  _High betweenness centrality (0.087) - this node is a cross-community bridge._
- **Are the 12 inferred relationships involving `AppViewModel` (e.g. with `.body` and `LyrioraApp`) actually correct?**
  _`AppViewModel` has 12 INFERRED edges - model-reasoned connections that need verification._
- **Are the 2 inferred relationships involving `LyricEditorView` (e.g. with `.body` and `.body`) actually correct?**
  _`LyricEditorView` has 2 INFERRED edges - model-reasoned connections that need verification._
- **Are the 10 inferred relationships involving `LyricSlide` (e.g. with `.presentationState` and `.saveLyric()`) actually correct?**
  _`LyricSlide` has 10 INFERRED edges - model-reasoned connections that need verification._
- **What connects `Usage`, `What graphify is for`, `Step 0 - GitHub repos and multi-path merge (only if a URL or several paths)` to the rest of the system?**
  _263 weakly-connected nodes found - possible documentation gaps or missing edges._