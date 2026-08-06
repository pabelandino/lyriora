# Graph Report - .  (2026-08-05)

## Corpus Check
- cluster-only mode — file stats not available

## Summary
- 1010 nodes · 2194 edges · 51 communities (47 shown, 4 thin omitted)
- Extraction: 92% EXTRACTED · 8% INFERRED · 0% AMBIGUOUS · INFERRED: 178 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `4c6c216b`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- ExternalDisplayManager
- PresentationTextConfiguration
- LyricEditorView
- LyricTheme
- SwiftUI
- PresentationFontFamily
- GlassIconButton
- LoopingVideoPlayerView
- CodingKeys
- MediaAsset
- .resolvedMetrics
- View
- AppViewModel
- .loadThumbnail
- LyricSlideLivePreview
- LyricSlide
- Identifiable
- LyricDocument
- DefaultBackgroundSettings
- BackgroundContentMode
- BlurredBackgroundLayer
- LyricImportParser
- CenterPanelView
- LyricSlideTag
- PresentationBackgroundLayer
- BackgroundFitToolbar
- PresentationBackgroundView
- PresentationPreviewView
- LyrioraUITests
- LyricLanguage
- DefaultBackgroundPreset
- PresentationLayout
- SlideThumbnailView
- MediaRepositoryProtocol
- SlideStyleControlsView
- LyricCardView
- LyricRepository
- .init
- LyricEditorLaunch
- .body
- SlideDetailEditorView
- .store
- LyricRepositoryProtocol
- ThemeRepositoryProtocol
- LocalFileImageBackground
- StickyPreviewEditorLayout
- DisplayInfoSheet
- LyricImportError
- PresentationState
- LyrioraTests.swift
- .readText

## God Nodes (most connected - your core abstractions)
1. `AppViewModel` - 88 edges
2. `ExternalDisplayManager` - 50 edges
3. `LyricEditorView` - 50 edges
4. `LyricSlide` - 42 edges
5. `PresentationTextConfiguration` - 37 edges
6. `LyricDocument` - 33 edges
7. `BackgroundContentMode` - 32 edges
8. `LyricSlideTag` - 30 edges
9. `PresentationFontFamily` - 30 edges
10. `DefaultBackgroundSettings` - 28 edges

## Surprising Connections (you probably didn't know these)
- `.headerRow` --references--> `LyricSlide`  [INFERRED]
  Lyriora/Views/Components/LyricSlideLivePreview.swift → Lyriora/Models/LyricSlide.swift
- `.activeThemeName` --references--> `LyricStyleProfile`  [INFERRED]
  Lyriora/Views/Modals/LyricEditorView.swift → Lyriora/Models/SlideTextStyle.swift
- `.activeTheme` --references--> `AppViewModel`  [INFERRED]
  Lyriora/Views/Modals/LyricEditorView.swift → Lyriora/ViewModels/AppViewModel.swift
- `.body` --calls--> `PresentationBackgroundLayer`  [INFERRED]
  Lyriora/Views/Components/ThemePreviewCard.swift → Lyriora/Views/Components/AppBackgroundView.swift
- `.body` --calls--> `AppViewModel`  [INFERRED]
  Lyriora/ContentView.swift → Lyriora/ViewModels/AppViewModel.swift

## Import Cycles
- None detected.

## Communities (51 total, 4 thin omitted)

### Community 0 - "ExternalDisplayManager"
Cohesion: 0.06
Nodes (39): AnyView, ExternalDisplayInfo, .resolutionDescription, Bool, CGFloat, CGSize, String, ExternalDisplayManager (+31 more)

### Community 1 - "PresentationTextConfiguration"
Cohesion: 0.06
Nodes (47): Any, EdgeInsets, EnvironmentKey, LyricSlideLayoutEngine, CGFloat, CGSize, Int, SlideTextStyle (+39 more)

### Community 2 - "LyricEditorView"
Cohesion: 0.06
Nodes (37): sourceSections, KeyboardDismissal, LyricEditorNavigationOption, .id, lyrics, .systemImage, .title, typography (+29 more)

### Community 3 - "LyricTheme"
Cohesion: 0.07
Nodes (41): LyricTheme, Date, Int, SlideTextStyle, String, UUID, FileManager, URL (+33 more)

### Community 4 - "SwiftUI"
Cohesion: 0.07
Nodes (21): AppKit, AVFoundation, CoreGraphics, Foundation, PresentationFontWeight, .nsWeight, .swiftUIWeight, .uiWeight (+13 more)

### Community 5 - "PresentationFontFamily"
Cohesion: 0.07
Nodes (32): Encoder, PresentationFontFamily, arial, avenirNext, courierNew, futura, georgia, helveticaNeue (+24 more)

### Community 6 - "GlassIconButton"
Cohesion: 0.07
Nodes (33): content, LyricGradient, Color, LinearGradient, UInt64, GlassCapsuleToolbar, .body, GlassCircleIcon (+25 more)

### Community 7 - "LoopingVideoPlayerView"
Cohesion: 0.13
Nodes (16): AVLayerVideoGravity, AVPlayer, CGRect, Context, LoopingVideoBackground, LoopingVideoPlayerView, Bool, CGSize (+8 more)

### Community 8 - "CodingKeys"
Cohesion: 0.07
Nodes (28): CodingKey, CodingKeys, colorSeed, createdAt, id, language, storedSlides, styleProfile (+20 more)

### Community 9 - "MediaAsset"
Cohesion: 0.11
Nodes (19): Data, MediaAsset, MediaAssetKind, image, video, Date, UUID, Bool (+11 more)

### Community 10 - ".resolvedMetrics"
Cohesion: 0.19
Nodes (13): ExternalDisplayDiscovery, ExternalDisplayMetrics, Source, liveContainer, liveWindow, sceneCoordinateSpace, screenBounds, Bool (+5 more)

### Community 11 - "View"
Cohesion: 0.14
Nodes (23): ImageLibrarySection, LocalFileThumbnailImage, .body, LocalFileVideoThumbnail, MediaLibraryPanelView, .body, MediaThumbnailView, .durationLabel (+15 more)

### Community 12 - "AppViewModel"
Cohesion: 0.13
Nodes (13): .slides, AppViewModel, .hasCustomBackgroundSelected, .hasVideoBackgroundSelected, .selectedLyricSlides, .selectedPhotoItems, .selectedSlide, .selectedVideoItems (+5 more)

### Community 13 - ".loadThumbnail"
Cohesion: 0.15
Nodes (16): AVAssetImageGenerator, CGImage, CMTime, Error, Metadata, MetadataError, cancelled, thumbnailFailed (+8 more)

### Community 14 - "LyricSlideLivePreview"
Cohesion: 0.11
Nodes (20): LyricPreviewBackgroundStyle, borderOnly, settingsDefault, LyricSlideLivePreview, .body, .compactHeight, .cornerRadius, .displayText (+12 more)

### Community 15 - "LyricSlide"
Cohesion: 0.14
Nodes (17): LyricSlide, .index, Int, SlideTextStyle, String, UUID, .body, LyricEditorSlideCard (+9 more)

### Community 16 - "Identifiable"
Cohesion: 0.11
Nodes (18): ButtonRole, CaseIterable, Identifiable, PresentationFontWeight, bold, .id, .label, medium (+10 more)

### Community 17 - "LyricDocument"
Cohesion: 0.15
Nodes (15): LyricDocument, .previewSnippet, CGSize, Date, Decoder, SlideTextStyle, String, UInt64 (+7 more)

### Community 18 - "DefaultBackgroundSettings"
Cohesion: 0.21
Nodes (14): Codable, Equatable, AppSettings, PresentationTextSettings, Bool, Decoder, Double, PresentationFontWeight (+6 more)

### Community 19 - "BackgroundContentMode"
Cohesion: 0.12
Nodes (16): BackgroundContentMode, auto, fill, fit, .id, .label, landscape, portrait (+8 more)

### Community 20 - "BlurredBackgroundLayer"
Cohesion: 0.17
Nodes (14): BlurredBackgroundLayer, .body, BlurredBackgroundModifier, CGFloat, Content, Double, View, View (+6 more)

### Community 21 - "LyricImportParser"
Cohesion: 0.32
Nodes (5): LyricImportParser, ParsedSections, Bool, Int, String

### Community 22 - "CenterPanelView"
Cohesion: 0.12
Nodes (12): App, ContentView, .body, LyrioraApp, .body, CenterPanelView, .body, .displayButtonAccessibilityLabel (+4 more)

### Community 23 - "LyricSlideTag"
Cohesion: 0.12
Nodes (16): LyricSlideTag, bridge, chorus, .displayName, .id, instrumental, intro, outro (+8 more)

### Community 24 - "PresentationBackgroundLayer"
Cohesion: 0.18
Nodes (14): PresentationBackground, URL, .activePresentationBackground, AppBackgroundView, .layerIdentity, .shellBackground, PresentationBackgroundLayer, .layerIdentity (+6 more)

### Community 25 - "BackgroundFitToolbar"
Cohesion: 0.17
Nodes (15): BackgroundFitBadgeLabel, .body, BackgroundFitToggleLabel, .body, BackgroundFitToolbar, .body, .expandedBadges, .expansionAnimation (+7 more)

### Community 26 - "PresentationBackgroundView"
Cohesion: 0.18
Nodes (13): ConfigurableDefaultGradientView, .body, .body, AppBackgroundAnimation, .transition, .body, .body, Animation (+5 more)

### Community 27 - "PresentationPreviewView"
Cohesion: 0.18
Nodes (13): ExternalPresentationView, .body, PresentationContentView, .textConfiguration, PresentationPreviewView, .body, .previewMetadataBar, .previewStage (+5 more)

### Community 28 - "LyrioraUITests"
Cohesion: 0.15
Nodes (6): LyrioraUITests, LyrioraUITestsLaunchTests, .runsForEachTargetApplicationUIConfiguration, Bool, XCTest, XCTestCase

### Community 29 - "LyricLanguage"
Cohesion: 0.21
Nodes (7): LyricLanguage, .displayName, english, .id, spanish, unknown, String

### Community 30 - "DefaultBackgroundPreset"
Cohesion: 0.18
Nodes (12): DefaultBackgroundPreset, arcticGlow, cobaltFade, .colors, deepNavy, .id, .label, .linearGradient (+4 more)

### Community 31 - "PresentationLayout"
Cohesion: 0.26
Nodes (8): PresentationLayout, CGFloat, CGSize, .presentationLayoutCanvasSize, .canvasAspectRatio, .canvasSize, .layoutCanvasSize, .previewSection

### Community 32 - "SlideThumbnailView"
Cohesion: 0.20
Nodes (11): SlideGridView, SlideThumbnailView, .textConfiguration, .thumbnailStyle, .usesDefaultGradientBackground, Bool, CGFloat, CGSize (+3 more)

### Community 33 - "MediaRepositoryProtocol"
Cohesion: 0.27
Nodes (6): MediaRepositoryProtocol, Bool, URL, UUID, .body, .body

### Community 34 - "SlideStyleControlsView"
Cohesion: 0.29
Nodes (9): SlideStyleControlsView, .body, .fontSizeBinding, .horizontalMarginBinding, .verticalMarginBinding, Binding, Double, SlideTextStyle (+1 more)

### Community 35 - "LyricCardView"
Cohesion: 0.27
Nodes (9): LyricCardView, .footerShape, LyricsLibraryPanelView, .deleteAlertBinding, Binding, Bool, CGFloat, Void (+1 more)

### Community 36 - "LyricRepository"
Cohesion: 0.33
Nodes (4): LyricRepository, FileManager, URL, UUID

### Community 37 - ".init"
Cohesion: 0.31
Nodes (4): SettingsRepository, SettingsRepositoryProtocol, FileManager, URL

### Community 38 - "LyricEditorLaunch"
Cohesion: 0.36
Nodes (4): Hashable, LyricEditorLaunch, UUID, UUID

### Community 39 - ".body"
Cohesion: 0.32
Nodes (5): .body, SettingsSheet, .body, Binding, String

### Community 40 - "SlideDetailEditorView"
Cohesion: 0.36
Nodes (6): SlideDetailEditorView, .activeStyle, Binding, Bool, SlideTextStyle, Void

### Community 41 - ".store"
Cohesion: 0.62
Nodes (5): Entry, LocalImageCache, CGSize, Image, URL

### Community 44 - "LocalFileImageBackground"
Cohesion: 0.57
Nodes (5): LocalFileImageBackground, .body, CGSize, Image, URL

### Community 45 - "StickyPreviewEditorLayout"
Cohesion: 0.29
Nodes (6): StickyPreviewEditorLayout, .stickyBackground, CGFloat, Content, .body, Preview

### Community 46 - "DisplayInfoSheet"
Cohesion: 0.29
Nodes (6): DisplayInfoSheet, .body, .statusDescription, Bool, String, Void

### Community 47 - "LyricImportError"
Cohesion: 0.33
Nodes (6): LocalizedError, LyricImportError, empty, .errorDescription, notText, unsupportedContent

### Community 48 - "PresentationState"
Cohesion: 0.33
Nodes (5): .presentationState, PresentationState, Bool, SlideTextStyle, String

## Knowledge Gaps
- **176 isolated node(s):** `regular`, `medium`, `semibold`, `bold`, `.id` (+171 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **4 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AppViewModel` connect `AppViewModel` to `ExternalDisplayManager`, `LyricEditorView`, `LyricTheme`, `SwiftUI`, `MediaAsset`, `View`, `LyricSlide`, `LyricDocument`, `DefaultBackgroundSettings`, `CenterPanelView`, `PresentationBackgroundLayer`, `PresentationPreviewView`, `LyricLanguage`, `PresentationLayout`, `MediaRepositoryProtocol`, `LyricCardView`, `.init`, `LyricEditorLaunch`, `.body`, `LyricRepositoryProtocol`, `ThemeRepositoryProtocol`, `PresentationState`?**
  _High betweenness centrality (0.185) - this node is a cross-community bridge._
- **Why does `LyricSlide` connect `LyricSlide` to `SlideThumbnailView`, `PresentationTextConfiguration`, `LyricEditorView`, `LyricTheme`, `SwiftUI`, `SlideDetailEditorView`, `AppViewModel`, `LyricSlideLivePreview`, `Identifiable`, `LyricDocument`, `DefaultBackgroundSettings`, `PresentationState`, `LyricImportParser`, `LyricSlideTag`, `LyricLanguage`?**
  _High betweenness centrality (0.115) - this node is a cross-community bridge._
- **Why does `PresentationTextConfiguration` connect `PresentationTextConfiguration` to `SlideThumbnailView`, `SwiftUI`, `PresentationFontFamily`, `LyricSlideLivePreview`, `LyricSlide`, `DefaultBackgroundSettings`, `CenterPanelView`, `PresentationPreviewView`?**
  _High betweenness centrality (0.104) - this node is a cross-community bridge._
- **Are the 11 inferred relationships involving `AppViewModel` (e.g. with `.body` and `LyrioraApp`) actually correct?**
  _`AppViewModel` has 11 INFERRED edges - model-reasoned connections that need verification._
- **Are the 2 inferred relationships involving `LyricEditorView` (e.g. with `.body` and `.body`) actually correct?**
  _`LyricEditorView` has 2 INFERRED edges - model-reasoned connections that need verification._
- **Are the 9 inferred relationships involving `LyricSlide` (e.g. with `.presentationState` and `.selectedSlide`) actually correct?**
  _`LyricSlide` has 9 INFERRED edges - model-reasoned connections that need verification._
- **What connects `regular`, `medium`, `semibold` to the rest of the system?**
  _176 weakly-connected nodes found - possible documentation gaps or missing edges._