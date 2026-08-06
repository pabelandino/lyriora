# Graph Report - Lyriora  (2026-08-05)

## Corpus Check
- 97 files · ~44,854 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1175 nodes · 2481 edges · 67 communities (52 shown, 15 thin omitted)
- Extraction: 92% EXTRACTED · 8% INFERRED · 0% AMBIGUOUS · INFERRED: 192 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `d199c4c8`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- ExternalDisplayManager
- PresentationTextConfiguration
- LyricEditorView
- View
- SwiftUI
- PresentationFontFamily
- GlassPanel.swift
- .configure
- LyricDocument
- MediaAsset
- .resolvedMetrics
- View
- AppViewModel
- .loadThumbnail
- LyricSlideLivePreview
- LyricSlide
- Identifiable
- PlayerLayerView
- Sendable
- Codable
- PresentationBackgroundLayer
- LyricSlideTag
- CenterPanelView
- VideoPlaybackController
- SlideTextStyle
- BackgroundFitToolbar
- AdaptivePresentationText
- PresentationPreviewView
- LyrioraUITests
- GlobalStyleEditorContent
- DefaultBackgroundPreset
- PresentationLayout
- SlideGridView
- MediaAsset
- LyricTheme
- LyricCardView
- PresentationActionsToolbar
- SettingsRepository
- .openLyricEditor
- .body
- LyricLanguage
- LocalFileImageBackground
- .saveLyric
- .saveTheme
- ThemePickerMenu
- PresentationFontWeight
- DisplayInfoSheet
- ThemeRepository
- PresentationState
- LyrioraTests.swift
- ThemeSavePromptSheet
- GlassIconButton
- VideoPlaybackMode
- sectionHeader
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
- `.body` --calls--> `content`  [INFERRED]
  Lyriora/Views/Components/GlassPanel.swift → Lyriora/Models/LyricDocument.swift

## Import Cycles
- None detected.

## Communities (67 total, 15 thin omitted)

### Community 0 - "ExternalDisplayManager"
Cohesion: 0.06
Nodes (41): AnyView, ExternalDisplayInfo, .resolutionDescription, Bool, CGFloat, CGSize, String, ExternalDisplayManager (+33 more)

### Community 1 - "PresentationTextConfiguration"
Cohesion: 0.07
Nodes (42): Any, EnvironmentKey, LyricSlideLayoutEngine, CGFloat, CGSize, Int, SlideTextStyle, String (+34 more)

### Community 2 - "LyricEditorView"
Cohesion: 0.06
Nodes (38): EdgeInsets, sourceSections, KeyboardDismissal, LyricEditorNavigationOption, .id, lyrics, .systemImage, .title (+30 more)

### Community 3 - "View"
Cohesion: 0.24
Nodes (13): Bool, CGFloat, SlideTextStyle, String, ThemeMiniPreview, .body, ThemePickerCard, .body (+5 more)

### Community 4 - "SwiftUI"
Cohesion: 0.05
Nodes (31): App, AppKit, AVFoundation, AVKit, CoreGraphics, Foundation, ContentView, .body (+23 more)

### Community 5 - "PresentationFontFamily"
Cohesion: 0.12
Nodes (20): PresentationFontFamily, arial, avenirNext, courierNew, futura, georgia, helveticaNeue, .id (+12 more)

### Community 6 - "GlassPanel.swift"
Cohesion: 0.15
Nodes (16): Font, GlassCircleIcon, .body, GlassOverflowMenu, .body, GlassToolbarIconSize, .frameSize, .iconFont (+8 more)

### Community 7 - ".configure"
Cohesion: 0.10
Nodes (30): TimeInterval, UUID, VideoSeekRequest, TimeInterval, Void, VideoProgressReporter, Coordinator, LoopingVideoBackground (+22 more)

### Community 8 - "LyricDocument"
Cohesion: 0.05
Nodes (40): CodingKey, CodingKeys, colorSeed, createdAt, id, language, storedSlides, styleProfile (+32 more)

### Community 9 - "MediaAsset"
Cohesion: 0.16
Nodes (13): Data, MediaAsset, MediaAssetKind, image, video, Date, UUID, MediaRepository (+5 more)

### Community 10 - ".resolvedMetrics"
Cohesion: 0.19
Nodes (13): ExternalDisplayDiscovery, ExternalDisplayMetrics, Source, liveContainer, liveWindow, sceneCoordinateSpace, screenBounds, Bool (+5 more)

### Community 11 - "View"
Cohesion: 0.18
Nodes (17): View, ImageLibrarySection, LocalFileThumbnailImage, LocalFileVideoThumbnail, MediaLibraryPanelView, .body, MediaThumbnailView, .body (+9 more)

### Community 12 - "AppViewModel"
Cohesion: 0.09
Nodes (21): ExternalDisplayManager, LyricRepositoryProtocol, .slides, AppViewModel, .activePresentationBackground, .hasCustomBackgroundSelected, .hasVideoBackgroundSelected, .selectedLyricSlides (+13 more)

### Community 13 - ".loadThumbnail"
Cohesion: 0.16
Nodes (15): AVAssetImageGenerator, CGImage, Error, Metadata, MetadataError, cancelled, thumbnailFailed, CGSize (+7 more)

### Community 14 - "LyricSlideLivePreview"
Cohesion: 0.06
Nodes (37): LyricPreviewBackgroundStyle, borderOnly, settingsDefault, LyricSlideLivePreview, .body, .compactHeight, .cornerRadius, .displayText (+29 more)

### Community 15 - "LyricSlide"
Cohesion: 0.12
Nodes (19): CGSize, SlideTextStyle, LyricSlide, .index, Int, SlideTextStyle, String, UUID (+11 more)

### Community 16 - "Identifiable"
Cohesion: 0.13
Nodes (14): ButtonRole, Hashable, Identifiable, LyricEditorLaunch, PresentationFontDesign, `default`, .id, .label (+6 more)

### Community 17 - "PlayerLayerView"
Cohesion: 0.12
Nodes (20): AnyClass, AVPlayerView, AVPlayerLayerRepresentable, AVPlayerLayerView, .body, AVPlayerViewRepresentable, PlayerLayerView, .layerClass (+12 more)

### Community 18 - "Sendable"
Cohesion: 0.17
Nodes (14): Equatable, LocalizedError, PresentationBackground, URL, LyricStyleProfile, LyricImportError, empty, .errorDescription (+6 more)

### Community 19 - "Codable"
Cohesion: 0.13
Nodes (18): Codable, AppSettings, PresentationTextSettings, Bool, Decoder, Double, PresentationFontWeight, BackgroundContentMode (+10 more)

### Community 20 - "PresentationBackgroundLayer"
Cohesion: 0.09
Nodes (32): Double, content, AppBackgroundAnimation, .transition, AppBackgroundView, .body, .layerIdentity, .shellBackground (+24 more)

### Community 21 - "LyricSlideTag"
Cohesion: 0.08
Nodes (30): LyricImportResult, LyricSectionSource, String, UUID, LyricSlideTag, bridge, chorus, .displayName (+22 more)

### Community 22 - "CenterPanelView"
Cohesion: 0.17
Nodes (9): Content, CenterPanelView, .body, .displayButtonAccessibilityLabel, .displayToolbar, .presentationToolbar, String, GlassCapsuleToolbar (+1 more)

### Community 23 - "VideoPlaybackController"
Cohesion: 0.21
Nodes (9): Any, AVPlayer, AVPlayerItem, CMTime, NSObjectProtocol, TimeInterval, URL, Void (+1 more)

### Community 24 - "SlideTextStyle"
Cohesion: 0.20
Nodes (12): Encoder, SlideTextStyle, .fontSize, Bool, Decoder, Double, Int, PresentationFontWeight (+4 more)

### Community 25 - "BackgroundFitToolbar"
Cohesion: 0.22
Nodes (13): BackgroundFitBadgeLabel, .body, BackgroundFitToggleLabel, .body, BackgroundFitToolbar, .body, .toggleButton, Constants (+5 more)

### Community 26 - "AdaptivePresentationText"
Cohesion: 0.20
Nodes (9): .body, .body, .previewStage, .body, AdaptivePresentationText, .lines, String, .shape (+1 more)

### Community 27 - "PresentationPreviewView"
Cohesion: 0.14
Nodes (21): ExternalDisplayInfo, .body, PresentationContentView, .textConfiguration, PresentationPreviewView, .displayedCurrentTime, .isVideoBackground, .previewMetadataBar (+13 more)

### Community 28 - "LyrioraUITests"
Cohesion: 0.15
Nodes (6): LyrioraUITests, LyrioraUITestsLaunchTests, .runsForEachTargetApplicationUIConfiguration, Bool, XCTest, XCTestCase

### Community 29 - "GlobalStyleEditorContent"
Cohesion: 0.23
Nodes (9): GlobalStyleEditorContent, GlobalStyleEditorView, .body, .hasStyleChanges, Bool, SlideTextStyle, String, UUID (+1 more)

### Community 30 - "DefaultBackgroundPreset"
Cohesion: 0.11
Nodes (20): ConfigurableDefaultGradientView, .body, DefaultBackgroundPreset, arcticGlow, cobaltFade, .colors, deepNavy, .id (+12 more)

### Community 31 - "PresentationLayout"
Cohesion: 0.26
Nodes (8): PresentationLayout, CGFloat, CGSize, .presentationLayoutCanvasSize, .canvasAspectRatio, .canvasSize, .layoutCanvasSize, .previewSection

### Community 32 - "SlideGridView"
Cohesion: 0.14
Nodes (19): GridItem, SlideGridView, .columns, SlideThumbnailView, .textConfiguration, .thumbnailStyle, .usesDefaultGradientBackground, BackgroundContentMode (+11 more)

### Community 33 - "MediaAsset"
Cohesion: 0.25
Nodes (7): MediaRepositoryProtocol, Bool, MediaAsset, URL, GlassPanel, .body, .body

### Community 34 - "LyricTheme"
Cohesion: 0.36
Nodes (7): LyricTheme, Date, Int, SlideTextStyle, String, UUID, .stylePreviewText

### Community 35 - "LyricCardView"
Cohesion: 0.13
Nodes (17): LyricGradient, Color, LinearGradient, UInt64, Layout, .trailingControlInset, LyricCardView, .body (+9 more)

### Community 36 - "PresentationActionsToolbar"
Cohesion: 0.22
Nodes (8): Constants, PresentationActionsToolbar, .body, .clearActionsCapsule, .videoControlsCapsule, Bool, CGFloat, Void

### Community 37 - "SettingsRepository"
Cohesion: 0.32
Nodes (4): SettingsRepository, SettingsRepositoryProtocol, FileManager, URL

### Community 39 - ".body"
Cohesion: 0.32
Nodes (5): .body, SettingsSheet, .body, Binding, String

### Community 40 - "LyricLanguage"
Cohesion: 0.16
Nodes (12): LyricLanguage, .displayName, english, .id, spanish, unknown, SlideDetailEditorView, .activeStyle (+4 more)

### Community 41 - "LocalFileImageBackground"
Cohesion: 0.14
Nodes (21): CGSize, Entry, LocalImageCache, CGSize, Image, URL, LocalFileImageBackground, .body (+13 more)

### Community 42 - ".saveLyric"
Cohesion: 0.20
Nodes (7): LyricSectionSource, LyricRepositoryProtocol, LyricDocument, LyricLanguage, String, UUID, .body

### Community 43 - ".saveTheme"
Cohesion: 0.53
Nodes (3): LyricTheme, ThemeRepositoryProtocol, SlideTextStyle

### Community 44 - "ThemePickerMenu"
Cohesion: 0.28
Nodes (9): UUID, Void, ThemeGalleryView, .body, ThemePickerMenu, .body, .selectedTheme, .themePickerLabel (+1 more)

### Community 45 - "PresentationFontWeight"
Cohesion: 0.25
Nodes (8): CaseIterable, PresentationFontWeight, bold, .id, .label, medium, regular, semibold

### Community 46 - "DisplayInfoSheet"
Cohesion: 0.29
Nodes (6): DisplayInfoSheet, .body, .statusDescription, Bool, String, Void

### Community 47 - "ThemeRepository"
Cohesion: 0.36
Nodes (3): FileManager, URL, ThemeRepository

### Community 48 - "PresentationState"
Cohesion: 0.29
Nodes (6): .presentationState, PresentationState, Bool, PresentationBackground, SlideTextStyle, String

### Community 50 - "ThemeSavePromptSheet"
Cohesion: 0.29
Nodes (6): Bool, String, Void, ThemeSavePromptSheet, .body, .trimmedThemeName

### Community 51 - "GlassIconButton"
Cohesion: 0.38
Nodes (6): Color, ColorScheme, GlassIconButton, .body, .foregroundColor, Bool

### Community 52 - "VideoPlaybackMode"
Cohesion: 0.29
Nodes (6): Bool, VideoPlaybackMode, loop, .loopsVideo, playOnce, .toggled

### Community 53 - "sectionHeader"
Cohesion: 0.40
Nodes (5): sectionHeader(), Binding, PhotosPickerItem, String, PHPickerFilter

## Knowledge Gaps
- **179 isolated node(s):** `loop`, `playOnce`, `.toggled`, `.loopsVideo`, `thumbnailFailed` (+174 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **15 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AppViewModel` connect `AppViewModel` to `ExternalDisplayManager`, `LyricEditorView`, `SwiftUI`, `LyricDocument`, `MediaAsset`, `View`, `LyricSlideTag`, `CenterPanelView`, `VideoPlaybackController`, `PresentationPreviewView`, `GlobalStyleEditorContent`, `PresentationLayout`, `MediaAsset`, `LyricCardView`, `.openLyricEditor`, `.body`, `.saveLyric`, `.saveTheme`, `PresentationState`, `VideoPlaybackMode`?**
  _High betweenness centrality (0.272) - this node is a cross-community bridge._
- **Why does `SwiftUI` connect `SwiftUI` to `PresentationTextConfiguration`, `LyricEditorView`, `View`, `GlassPanel.swift`, `View`, `LyricSlideLivePreview`, `LyricSlide`, `PresentationBackgroundLayer`, `CenterPanelView`, `BackgroundFitToolbar`, `AdaptivePresentationText`, `GlobalStyleEditorContent`, `DefaultBackgroundPreset`, `SlideGridView`, `LyricCardView`, `PresentationActionsToolbar`, `LyricLanguage`, `DisplayInfoSheet`, `ThemeSavePromptSheet`?**
  _High betweenness centrality (0.139) - this node is a cross-community bridge._
- **Why does `View` connect `View` to `ExternalDisplayManager`, `SlideGridView`, `MediaAsset`, `LyricCardView`, `PresentationActionsToolbar`, `SwiftUI`, `GlassPanel.swift`, `.configure`, `LocalFileImageBackground`, `PlayerLayerView`, `GlassIconButton`, `PresentationBackgroundLayer`, `sectionHeader`, `CenterPanelView`, `BackgroundFitToolbar`, `PresentationPreviewView`?**
  _High betweenness centrality (0.098) - this node is a cross-community bridge._
- **Are the 12 inferred relationships involving `AppViewModel` (e.g. with `.body` and `LyrioraApp`) actually correct?**
  _`AppViewModel` has 12 INFERRED edges - model-reasoned connections that need verification._
- **Are the 2 inferred relationships involving `LyricEditorView` (e.g. with `.body` and `.body`) actually correct?**
  _`LyricEditorView` has 2 INFERRED edges - model-reasoned connections that need verification._
- **Are the 10 inferred relationships involving `LyricSlide` (e.g. with `.presentationState` and `.saveLyric()`) actually correct?**
  _`LyricSlide` has 10 INFERRED edges - model-reasoned connections that need verification._
- **What connects `loop`, `playOnce`, `.toggled` to the rest of the system?**
  _179 weakly-connected nodes found - possible documentation gaps or missing edges._