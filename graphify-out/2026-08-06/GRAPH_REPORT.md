# Graph Report - Lyriora  (2026-08-05)

## Corpus Check
- 101 files · ~47,630 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1318 nodes · 2723 edges · 123 communities (64 shown, 59 thin omitted)
- Extraction: 92% EXTRACTED · 8% INFERRED · 0% AMBIGUOUS · INFERRED: 212 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `a44de51c`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- ExternalDisplayManager
- PresentationTextConfiguration
- LyricEditorView
- LyricTheme
- SwiftUI
- PresentationFontFamily
- GlassPanel.swift
- .configure
- CodingKeys
- LyricDocument
- .resolvedMetrics
- MediaThumbnailView
- AppViewModel
- .loadThumbnail
- LyricSlideLivePreview
- LyricSlide
- Identifiable
- PlayerLayerView
- Sendable
- BackgroundContentMode
- LocalFileImageBackground
- LyricImportParser
- CenterPanelView
- VideoPlaybackController
- GlassIconButton
- View
- BlurredBackgroundLayer
- PresentationPreviewView
- LyrioraUITests
- GlobalStyleEditorContent
- MediaRepository
- LyricSlideTag
- SlideGridView
- MediaAsset
- DefaultBackgroundSettings
- LyricsLibraryPanelView
- PresentationBackgroundView
- Foundation
- LyricEditorNavigationOption
- .loadInitialData
- LyricLanguage
- Binding
- .saveLyric
- .saveTheme
- .performSaveLyric
- PresentationBackgroundLayer
- DisplayInfoSheet
- DefaultBackgroundPreset
- LyricRepository
- LyrioraTests.swift
- ThemeSavePromptSheet
- ColorScheme
- GlassPanel
- .deleteSlide
- AVLayerVideoGravity
- SettingsRepository
- CGRect
- Task
- DefaultBackgroundMeshStyle
- AppSettings
- Animation
- PresentationState
- Content
- Font
- Bool
- EditorCard
- NSCoder
- .importSelectedPhotos
- MainView
- AppViewModel.swift
- LyrioraApp
- PresentationActionsToolbar
- .resolved
- BackgroundContentMode
- GridItem
- DefaultBackgroundSettings
- Double
- DefaultBackgroundSettings
- VideoPlaybackMode
- LinearGradient
- AVPlayer
- DefaultBackgroundSettings
- Binding
- Color
- Content
- UUID
- Animation
- DefaultBackgroundSettings
- .importLyricsFromClipboard
- Bool
- CGSize
- Int
- UIWindow
- UIWindowScene
- Any
- AVPlayer
- AVPlayerItem
- CMTime
- URL
- Image
- GlassToolbarIconSize
- PresentationTextConfiguration
- .makeSlides
- Void
- ExternalDisplayInfo
- Date
- FileManager
- CGSize
- Int
- LyricDocument
- LyricLanguage
- LyricSlide
- LyricStyleProfile
- MediaAsset
- PresentationBackground
- PresentationState
- SlideTextStyle
- TimeInterval
- CGFloat
- MediaAsset
- RoundedRectangle
- MediaRepositoryProtocol
- PHPickerFilter

## God Nodes (most connected - your core abstractions)
1. `AppViewModel` - 104 edges
2. `LyricEditorView` - 51 edges
3. `ExternalDisplayManager` - 50 edges
4. `MediaAsset` - 37 edges
5. `LyricSlide` - 36 edges
6. `PresentationTextConfiguration` - 31 edges
7. `LyricSlideTag` - 30 edges
8. `PresentationFontFamily` - 30 edges
9. `PresentationPreviewView` - 29 edges
10. `DefaultBackgroundSettings` - 27 edges

## Surprising Connections (you probably didn't know these)
- `.selectedBackgroundAsset` --references--> `MediaAsset`  [INFERRED]
  Lyriora/ViewModels/AppViewModel.swift → Lyriora/Models/MediaAsset.swift
- `.activeTheme` --references--> `AppViewModel`  [INFERRED]
  Lyriora/Views/Modals/LyricEditorView.swift → Lyriora/ViewModels/AppViewModel.swift
- `.presentationToolbar` --calls--> `PresentationActionsToolbar`  [INFERRED]
  Lyriora/Views/CenterPanel/CenterPanelView.swift → Lyriora/Views/Components/PresentationActionsToolbar.swift
- `.previewBackground` --calls--> `PresentationBackgroundLayer`  [INFERRED]
  Lyriora/Views/Components/LyricSlideLivePreview.swift → Lyriora/Views/Components/AppBackgroundView.swift
- `.body` --calls--> `PresentationBackgroundLayer`  [INFERRED]
  Lyriora/Views/Components/ThemePreviewCard.swift → Lyriora/Views/Components/AppBackgroundView.swift

## Import Cycles
- None detected.

## Communities (123 total, 59 thin omitted)

### Community 0 - "ExternalDisplayManager"
Cohesion: 0.06
Nodes (42): AnyView, AppViewModel, Bool, CGSize, ExternalDisplayInfo, ExternalDisplayMetrics, ExternalPresentationContainerViewController, Int (+34 more)

### Community 1 - "PresentationTextConfiguration"
Cohesion: 0.07
Nodes (43): Any, EdgeInsets, EnvironmentKey, LyricSlideLayoutEngine, CGFloat, CGSize, Int, SlideTextStyle (+35 more)

### Community 2 - "LyricEditorView"
Cohesion: 0.10
Nodes (20): Binding, LyricEditorView, .activeTheme, .activeThemeName, .editorBackground, .hasStyleChanges, .importErrorBinding, .isEditing (+12 more)

### Community 3 - "LyricTheme"
Cohesion: 0.08
Nodes (31): LyricTheme, Date, Int, SlideTextStyle, String, UUID, FileManager, URL (+23 more)

### Community 4 - "SwiftUI"
Cohesion: 0.08
Nodes (25): AppKit, AVFoundation, AVKit, GlassMorphAnimation, Animation, LyricGradient, Color, LinearGradient (+17 more)

### Community 5 - "PresentationFontFamily"
Cohesion: 0.07
Nodes (32): Encoder, PresentationFontFamily, arial, avenirNext, courierNew, futura, georgia, helveticaNeue (+24 more)

### Community 6 - "GlassPanel.swift"
Cohesion: 0.21
Nodes (11): GlassCircleIcon, .body, GlassOverflowMenu, .body, GlassToolbarIconStyle, GlassToolbarMetrics, .controlHeight, CGFloat (+3 more)

### Community 7 - ".configure"
Cohesion: 0.10
Nodes (30): TimeInterval, UUID, VideoSeekRequest, TimeInterval, Void, VideoProgressReporter, Coordinator, LoopingVideoBackground (+22 more)

### Community 8 - "CodingKeys"
Cohesion: 0.07
Nodes (28): CodingKey, CodingKeys, colorSeed, createdAt, id, language, storedSlides, styleProfile (+20 more)

### Community 9 - "LyricDocument"
Cohesion: 0.23
Nodes (12): Codable, LyricDocument, .previewSnippet, .slides, Date, Decoder, String, UInt64 (+4 more)

### Community 10 - ".resolvedMetrics"
Cohesion: 0.19
Nodes (13): ExternalDisplayDiscovery, ExternalDisplayMetrics, Source, liveContainer, liveWindow, sceneCoordinateSpace, screenBounds, Bool (+5 more)

### Community 11 - "MediaThumbnailView"
Cohesion: 0.14
Nodes (23): CGFloat, ImageLibrarySection, LocalFileThumbnailImage, LocalFileVideoThumbnail, MediaImportContentTypes, MediaImportSectionHeader, .photoPickerSelection, MediaLibraryPanelView (+15 more)

### Community 12 - "AppViewModel"
Cohesion: 0.10
Nodes (20): ExternalDisplayManager, LyricRepositoryProtocol, LyricSlide, AppViewModel, .activePresentationBackground, .hasCustomBackgroundSelected, .hasVideoBackgroundSelected, .presentationState (+12 more)

### Community 13 - ".loadThumbnail"
Cohesion: 0.15
Nodes (16): AVAssetImageGenerator, CGImage, Error, Metadata, MetadataError, cancelled, thumbnailFailed, CGSize (+8 more)

### Community 14 - "LyricSlideLivePreview"
Cohesion: 0.05
Nodes (43): LyricPreviewBackgroundStyle, borderOnly, settingsDefault, LyricSlideLivePreview, .body, .compactHeight, .cornerRadius, .displayText (+35 more)

### Community 15 - "LyricSlide"
Cohesion: 0.17
Nodes (15): LyricSlide, Int, SlideTextStyle, String, UUID, LyricEditorSlideCard, .body, .textConfiguration (+7 more)

### Community 16 - "Identifiable"
Cohesion: 0.16
Nodes (11): Hashable, Identifiable, LyricEditorLaunch, PresentationFontDesign, `default`, .id, .label, monospaced (+3 more)

### Community 17 - "PlayerLayerView"
Cohesion: 0.08
Nodes (24): AnyClass, AVPlayerView, Context, AVPlayerLayerRepresentable, AVPlayerLayerView, .body, AVPlayerViewRepresentable, PlayerLayerView (+16 more)

### Community 18 - "Sendable"
Cohesion: 0.17
Nodes (15): Equatable, LocalizedError, LyricSectionSource, String, UUID, PresentationBackground, URL, LyricImportError (+7 more)

### Community 19 - "BackgroundContentMode"
Cohesion: 0.18
Nodes (11): BackgroundContentMode, auto, fill, fit, .id, .label, landscape, portrait (+3 more)

### Community 20 - "LocalFileImageBackground"
Cohesion: 0.27
Nodes (12): Entry, LocalImageCache, CGSize, Image, URL, LocalFileImageBackground, .body, CGSize (+4 more)

### Community 21 - "LyricImportParser"
Cohesion: 0.32
Nodes (5): LyricImportParser, ParsedSections, Bool, Int, String

### Community 22 - "CenterPanelView"
Cohesion: 0.22
Nodes (9): CenterPanelView, .body, .presentationToolbar, String, WorkspaceDisplayToolbar, .displayButtonAccessibilityLabel, .iPadPortraitDetailWorkspace, .iPhoneLandscapeDetailWorkspace (+1 more)

### Community 23 - "VideoPlaybackController"
Cohesion: 0.17
Nodes (10): AVPlayer, AVPlayerItem, AVPlayerLooper, CMTime, NSObjectProtocol, TimeInterval, Void, VideoPlaybackController (+2 more)

### Community 24 - "GlassIconButton"
Cohesion: 0.17
Nodes (15): ButtonRole, Image, .body, .body, Action, GlassIconButton, .body, .foregroundColor (+7 more)

### Community 25 - "View"
Cohesion: 0.24
Nodes (13): BackgroundFitBadgeLabel, BackgroundFitToggleLabel, BackgroundFitToolbar, .body, .expandedOptions, .toggleButton, Constants, Layout (+5 more)

### Community 26 - "BlurredBackgroundLayer"
Cohesion: 0.29
Nodes (9): BlurredBackgroundLayer, .body, BlurredBackgroundModifier, CGFloat, Content, Double, View, View (+1 more)

### Community 27 - "PresentationPreviewView"
Cohesion: 0.07
Nodes (35): PresentationLayout, CGFloat, CGSize, .presentationLayoutCanvasSize, .body, PresentationContentView, .body, .textConfiguration (+27 more)

### Community 28 - "LyrioraUITests"
Cohesion: 0.15
Nodes (6): LyrioraUITests, LyrioraUITestsLaunchTests, .runsForEachTargetApplicationUIConfiguration, Bool, XCTest, XCTestCase

### Community 29 - "GlobalStyleEditorContent"
Cohesion: 0.24
Nodes (9): GlobalStyleEditorContent, GlobalStyleEditorView, .body, .hasStyleChanges, Bool, SlideTextStyle, String, UUID (+1 more)

### Community 30 - "MediaRepository"
Cohesion: 0.14
Nodes (14): Data, FileManager, .index, MediaAssetKind, image, video, MediaRepository, String (+6 more)

### Community 31 - "LyricSlideTag"
Cohesion: 0.12
Nodes (16): LyricSlideTag, bridge, chorus, .displayName, .id, instrumental, intro, outro (+8 more)

### Community 32 - "SlideGridView"
Cohesion: 0.16
Nodes (18): SlideGridView, .thumbnailWidth, SlideThumbnailView, .textConfiguration, .thumbnailStyle, .usesDefaultGradientBackground, BackgroundContentMode, Bool (+10 more)

### Community 33 - "MediaAsset"
Cohesion: 0.20
Nodes (10): Date, MediaAsset, .listLabel, UUID, MediaRepositoryProtocol, importSelectedVideos(), URL, .body (+2 more)

### Community 34 - "DefaultBackgroundSettings"
Cohesion: 0.15
Nodes (14): ConfigurableDefaultGradientView, .body, .layerIdentity, DefaultBackgroundMeshView, .body, .style, DefaultBackgroundSettings, ColorScheme (+6 more)

### Community 35 - "LyricsLibraryPanelView"
Cohesion: 0.22
Nodes (12): Layout, .trailingControlInset, LyricCardView, .footerShape, LyricsLibraryPanelView, .deleteAlertBinding, Binding, Bool (+4 more)

### Community 36 - "PresentationBackgroundView"
Cohesion: 0.17
Nodes (13): Animation, AppBackgroundAnimation, .transition, .body, .body, Double, PresentationBackgroundView, .backgroundContent (+5 more)

### Community 38 - "LyricEditorNavigationOption"
Cohesion: 0.20
Nodes (8): LyricEditorNavigationOption, .id, .systemImage, .title, typography, String, .body, Self

### Community 39 - ".loadInitialData"
Cohesion: 0.22
Nodes (6): .body, SettingsSheet, .body, Binding, String, PresentationTextSettings

### Community 40 - "LyricLanguage"
Cohesion: 0.13
Nodes (15): CaseIterable, PresentationFontWeight, bold, .id, .label, medium, regular, semibold (+7 more)

### Community 42 - ".saveLyric"
Cohesion: 0.19
Nodes (9): LyricDocument, LyricEditorLaunch, LyricLanguage, LyricSectionSource, seedSampleLyricsIfNeeded(), UUID, lyrics, .body (+1 more)

### Community 43 - ".saveTheme"
Cohesion: 0.43
Nodes (3): LyricTheme, ThemeRepositoryProtocol, SlideTextStyle

### Community 45 - "PresentationBackgroundLayer"
Cohesion: 0.26
Nodes (12): AppBackgroundView, .layerIdentity, .shellBackground, PresentationBackgroundLayer, .layerIdentity, BackgroundContentMode, Bool, CGSize (+4 more)

### Community 46 - "DisplayInfoSheet"
Cohesion: 0.29
Nodes (6): DisplayInfoSheet, .body, .statusDescription, Bool, String, Void

### Community 47 - "DefaultBackgroundPreset"
Cohesion: 0.17
Nodes (11): Decoder, DefaultBackgroundPreset, daylightWaves, .id, .isAdaptive, .label, meshWaves, morningHaze (+3 more)

### Community 48 - "LyricRepository"
Cohesion: 0.27
Nodes (5): LyricRepository, LyricRepositoryProtocol, FileManager, URL, UUID

### Community 50 - "ThemeSavePromptSheet"
Cohesion: 0.29
Nodes (6): Bool, String, Void, ThemeSavePromptSheet, .body, .trimmedThemeName

### Community 52 - "GlassPanel"
Cohesion: 0.22
Nodes (11): Content, content, .body, GlassCapsuleToolbar, .body, GlassPanel, .body, .panelShape (+3 more)

### Community 55 - "SettingsRepository"
Cohesion: 0.47
Nodes (4): SettingsRepository, SettingsRepositoryProtocol, FileManager, URL

### Community 58 - "DefaultBackgroundMeshStyle"
Cohesion: 0.22
Nodes (10): Float, DefaultBackgroundMeshStyle, .colors, daylightWaves, morningHaze, twilightWaves, violetDusk, .wavePoints (+2 more)

### Community 59 - "AppSettings"
Cohesion: 0.24
Nodes (6): AppSettings, PresentationTextSettings, Bool, Decoder, Double, PresentationFontWeight

### Community 61 - "PresentationState"
Cohesion: 0.33
Nodes (5): PresentationState, Bool, PresentationBackground, SlideTextStyle, String

### Community 65 - "EditorCard"
Cohesion: 0.22
Nodes (7): Color, EditorCard, .cardBackground, .importSection, .lyricsInfoSection, .rawLyricsSection, String

### Community 67 - ".importSelectedPhotos"
Cohesion: 0.22
Nodes (6): PhotosPickerDisplayNameResolver, PhotosPickerItem, String, .selectedPhotoItems, Photos, PhotosUI

### Community 68 - "MainView"
Cohesion: 0.19
Nodes (9): ContentView, .body, MainView, .adaptiveWorkspace, .iPadPortraitWorkspace, .iPhoneLandscapeWorkspace, CGFloat, WorkspaceLayout (+1 more)

### Community 69 - "AppViewModel.swift"
Cohesion: 0.27
Nodes (9): PickedImageFile, .transferRepresentation, PickedVideoFile, .transferRepresentation, String, VideoControlsReveal, Transferable, TransferRepresentation (+1 more)

### Community 70 - "LyrioraApp"
Cohesion: 0.40
Nodes (4): App, LyrioraApp, .body, Scene

### Community 71 - "PresentationActionsToolbar"
Cohesion: 0.25
Nodes (7): Constants, PresentationActionsToolbar, .body, .clearActionsCapsule, Bool, CGFloat, Void

### Community 72 - ".resolved"
Cohesion: 0.29
Nodes (5): ResolvedBackgroundContentMode, fill, fit, CGSize, .resolvedMode

### Community 78 - "VideoPlaybackMode"
Cohesion: 0.29
Nodes (6): Bool, VideoPlaybackMode, loop, .loopsVideo, playOnce, .toggled

### Community 88 - ".importLyricsFromClipboard"
Cohesion: 0.33
Nodes (4): LyricImportResult, LyricStyleProfile, LyricClipboardImporter, String

### Community 100 - "GlassToolbarIconSize"
Cohesion: 0.33
Nodes (6): Font, GlassToolbarIconSize, .frameSize, .iconFont, prominent, regular

### Community 102 - ".makeSlides"
Cohesion: 0.33
Nodes (4): CGSize, SlideTextStyle, CGSize, SlideTextStyle

### Community 104 - "ExternalDisplayInfo"
Cohesion: 0.33
Nodes (6): ExternalDisplayInfo, .resolutionDescription, Bool, CGFloat, CGSize, String

## Knowledge Gaps
- **199 isolated node(s):** `image`, `video`, `.listLabel`, `Photos`, `.hasCustomBackgroundSelected` (+194 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **59 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `SwiftUI` connect `SwiftUI` to `PresentationTextConfiguration`, `LyricTheme`, `GlassPanel.swift`, `MediaThumbnailView`, `LyricSlideLivePreview`, `LyricSlide`, `PlayerLayerView`, `CenterPanelView`, `View`, `BlurredBackgroundLayer`, `PresentationPreviewView`, `GlobalStyleEditorContent`, `SlideGridView`, `DefaultBackgroundSettings`, `LyricsLibraryPanelView`, `Foundation`, `LyricEditorNavigationOption`, `PresentationBackgroundLayer`, `DisplayInfoSheet`, `ThemeSavePromptSheet`, `EditorCard`, `.importSelectedPhotos`, `MainView`, `AppViewModel.swift`, `LyrioraApp`, `PresentationActionsToolbar`?**
  _High betweenness centrality (0.172) - this node is a cross-community bridge._
- **Why does `AppViewModel` connect `AppViewModel` to `ExternalDisplayManager`, `LyricEditorView`, `LyricDocument`, `MediaThumbnailView`, `CenterPanelView`, `VideoPlaybackController`, `PresentationPreviewView`, `GlobalStyleEditorContent`, `MediaAsset`, `LyricsLibraryPanelView`, `LyricEditorNavigationOption`, `.loadInitialData`, `.saveLyric`, `.saveTheme`, `.performSaveLyric`, `.deleteSlide`, `Task`, `.importSelectedPhotos`, `MainView`, `AppViewModel.swift`, `.importLyricsFromClipboard`?**
  _High betweenness centrality (0.166) - this node is a cross-community bridge._
- **Why does `LyricEditorView` connect `LyricEditorView` to `ExternalDisplayManager`, `EditorCard`, `LyrioraApp`, `.loadInitialData`, `LyricEditorNavigationOption`, `.saveLyric`, `.saveTheme`, `.performSaveLyric`, `LyricSlide`, `.deleteSlide`, `View`?**
  _High betweenness centrality (0.089) - this node is a cross-community bridge._
- **Are the 11 inferred relationships involving `AppViewModel` (e.g. with `.body` and `VideoPlaybackController`) actually correct?**
  _`AppViewModel` has 11 INFERRED edges - model-reasoned connections that need verification._
- **Are the 2 inferred relationships involving `LyricEditorView` (e.g. with `.body` and `.body`) actually correct?**
  _`LyricEditorView` has 2 INFERRED edges - model-reasoned connections that need verification._
- **What connects `image`, `video`, `.listLabel` to the rest of the system?**
  _199 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `ExternalDisplayManager` be split into smaller, more focused modules?**
  _Cohesion score 0.056679151061173536 - nodes in this community are weakly interconnected._