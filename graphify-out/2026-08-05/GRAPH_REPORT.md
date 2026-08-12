# Graph Report - Lyriora  (2026-08-05)

## Corpus Check
- 99 files · ~46,224 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1270 nodes · 2614 edges · 104 communities (61 shown, 43 thin omitted)
- Extraction: 92% EXTRACTED · 8% INFERRED · 0% AMBIGUOUS · INFERRED: 199 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `4b193801`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- ExternalDisplayManager
- EditorAdaptivePresentationText
- LyricEditorView
- LyricTheme
- SwiftUI
- PresentationFontFamily
- GlassIconButton
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
- PresentationBackgroundLayer
- LyricImportParser
- CenterPanelView
- VideoPlaybackController
- SlideTextStyle
- BackgroundFitToolbar
- CodingKeys
- PresentationPreviewView
- LyrioraUITests
- GlobalStyleEditorContent
- MediaAsset
- LyricSlideTag
- SlideGridView
- MediaAsset
- DefaultBackgroundPreset
- LyricsLibraryPanelView
- PresentationTextConfiguration
- Foundation
- LyricEditorNavigationOption
- .body
- LyricLanguage
- View
- .saveLyric
- .saveTheme
- .rechunkSlides
- LyricSlideLayoutEngine
- ExternalDisplayInfo
- .measureSingleLine
- LyricRepository
- LyrioraTests.swift
- ThemeSavePromptSheet
- ColorScheme
- .postScriptName
- .deleteSlide
- AVLayerVideoGravity
- SettingsRepository
- CGRect
- Task
- WorkspaceCompactLayout.swift
- LyricImportError
- Animation
- PresentationState
- Content
- Font
- Bool
- AdaptivePresentationText
- NSCoder
- PresentationFontWeight
- MainView
- AppViewModel.swift
- LyrioraApp
- CodableColor
- GlassMorphAnimation.swift
- BackgroundContentMode
- GridItem
- DefaultBackgroundSettings
- Double
- DefaultBackgroundSettings
- LyricStyleProfile
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
- PresentationState
- PresentationTextConfiguration
- RoundedRectangle
- Void

## God Nodes (most connected - your core abstractions)
1. `AppViewModel` - 101 edges
2. `LyricEditorView` - 51 edges
3. `ExternalDisplayManager` - 50 edges
4. `LyricSlide` - 36 edges
5. `PresentationTextConfiguration` - 31 edges
6. `LyricSlideTag` - 30 edges
7. `PresentationFontFamily` - 30 edges
8. `PresentationPreviewView` - 29 edges
9. `DefaultBackgroundSettings` - 27 edges
10. `LyricSlideLivePreview` - 27 edges

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

## Communities (104 total, 43 thin omitted)

### Community 0 - "ExternalDisplayManager"
Cohesion: 0.06
Nodes (42): AnyView, AppViewModel, Bool, CGSize, ExternalDisplayInfo, ExternalDisplayMetrics, ExternalPresentationContainerViewController, Int (+34 more)

### Community 1 - "EditorAdaptivePresentationText"
Cohesion: 0.14
Nodes (19): EnvironmentKey, EditorAdaptivePresentationText, .body, .lines, .resolvedConfiguration, EditorPreviewSizing, exact, scaledApproximation (+11 more)

### Community 2 - "LyricEditorView"
Cohesion: 0.08
Nodes (27): Binding, Color, EditorCard, .cardBackground, LyricEditorView, .activeTheme, .activeThemeName, .editorBackground (+19 more)

### Community 3 - "LyricTheme"
Cohesion: 0.05
Nodes (48): LyricTheme, Date, Int, SlideTextStyle, String, UUID, FileManager, URL (+40 more)

### Community 4 - "SwiftUI"
Cohesion: 0.25
Nodes (5): AppKit, AVFoundation, AVKit, SwiftUI, UIKit

### Community 5 - "PresentationFontFamily"
Cohesion: 0.13
Nodes (15): PresentationFontFamily, arial, avenirNext, courierNew, futura, georgia, helveticaNeue, .id (+7 more)

### Community 6 - "GlassIconButton"
Cohesion: 0.05
Nodes (43): Content, Font, LyricGradient, Color, LinearGradient, UInt64, .body, .body (+35 more)

### Community 7 - ".configure"
Cohesion: 0.10
Nodes (30): TimeInterval, UUID, VideoSeekRequest, TimeInterval, Void, VideoProgressReporter, Coordinator, LoopingVideoBackground (+22 more)

### Community 8 - "CodingKeys"
Cohesion: 0.11
Nodes (18): CodingKeys, fontDesign, fontFamily, fontWeight, horizontalPaddingRatio, isAdaptiveScalingEnabled, lineSpacing, maxFontSize (+10 more)

### Community 9 - "LyricDocument"
Cohesion: 0.15
Nodes (14): LyricDocument, .previewSnippet, .slides, CGSize, Date, Decoder, SlideTextStyle, String (+6 more)

### Community 10 - ".resolvedMetrics"
Cohesion: 0.19
Nodes (13): ExternalDisplayDiscovery, ExternalDisplayMetrics, Source, liveContainer, liveWindow, sceneCoordinateSpace, screenBounds, Bool (+5 more)

### Community 11 - "MediaThumbnailView"
Cohesion: 0.15
Nodes (17): Image, .body, .body, LocalFileThumbnailImage, LocalFileVideoThumbnail, MediaThumbnailView, .body, .resolvedDurationLabel (+9 more)

### Community 12 - "AppViewModel"
Cohesion: 0.09
Nodes (21): ExternalDisplayManager, LyricRepositoryProtocol, AppViewModel, .activePresentationBackground, .hasCustomBackgroundSelected, .hasVideoBackgroundSelected, .presentationState, .selectedLyricSlides (+13 more)

### Community 13 - ".loadThumbnail"
Cohesion: 0.15
Nodes (16): AVAssetImageGenerator, CGImage, Error, Metadata, MetadataError, cancelled, thumbnailFailed, CGSize (+8 more)

### Community 14 - "LyricSlideLivePreview"
Cohesion: 0.11
Nodes (21): LyricPreviewBackgroundStyle, borderOnly, settingsDefault, LyricSlideLivePreview, .body, .compactHeight, .cornerRadius, .displayText (+13 more)

### Community 15 - "LyricSlide"
Cohesion: 0.16
Nodes (16): LyricSlide, .index, Int, SlideTextStyle, String, UUID, LyricEditorSlideCard, .body (+8 more)

### Community 16 - "Identifiable"
Cohesion: 0.09
Nodes (22): ButtonRole, CaseIterable, Hashable, Identifiable, PresentationFontWeight, bold, .id, .label (+14 more)

### Community 17 - "PlayerLayerView"
Cohesion: 0.08
Nodes (24): AnyClass, AVPlayerView, Context, AVPlayerLayerRepresentable, AVPlayerLayerView, .body, AVPlayerViewRepresentable, PlayerLayerView (+16 more)

### Community 18 - "Sendable"
Cohesion: 0.16
Nodes (19): Codable, Equatable, AppSettings, PresentationTextSettings, Bool, Decoder, Double, PresentationFontWeight (+11 more)

### Community 19 - "BackgroundContentMode"
Cohesion: 0.18
Nodes (11): BackgroundContentMode, auto, fill, fit, .id, .label, landscape, portrait (+3 more)

### Community 20 - "PresentationBackgroundLayer"
Cohesion: 0.07
Nodes (41): Animation, CGSize, Entry, LocalImageCache, CGSize, Image, URL, ConfigurableDefaultGradientView (+33 more)

### Community 21 - "LyricImportParser"
Cohesion: 0.25
Nodes (5): LyricImportParser, ParsedSections, Bool, Int, String

### Community 22 - "CenterPanelView"
Cohesion: 0.22
Nodes (9): CenterPanelView, .body, .presentationToolbar, String, WorkspaceDisplayToolbar, .displayButtonAccessibilityLabel, .iPadPortraitDetailWorkspace, .iPhoneLandscapeDetailWorkspace (+1 more)

### Community 23 - "VideoPlaybackController"
Cohesion: 0.19
Nodes (10): Any, AVPlayer, AVPlayerItem, AVPlayerLooper, CMTime, NSObjectProtocol, TimeInterval, Void (+2 more)

### Community 24 - "SlideTextStyle"
Cohesion: 0.29
Nodes (8): Encoder, SlideTextStyle, .fontSize, Bool, Decoder, Double, Int, PresentationFontWeight

### Community 25 - "BackgroundFitToolbar"
Cohesion: 0.20
Nodes (14): BackgroundFitBadgeLabel, .body, BackgroundFitToggleLabel, .body, BackgroundFitToolbar, .body, .expandedOptions, .toggleButton (+6 more)

### Community 26 - "CodingKeys"
Cohesion: 0.10
Nodes (23): CodingKey, CodingKeys, colorSeed, content, createdAt, id, language, storedSlides (+15 more)

### Community 27 - "PresentationPreviewView"
Cohesion: 0.09
Nodes (29): PresentationLayout, CGFloat, CGSize, .presentationLayoutCanvasSize, .body, PresentationContentView, .textConfiguration, PresentationPreviewView (+21 more)

### Community 28 - "LyrioraUITests"
Cohesion: 0.15
Nodes (6): LyrioraUITests, LyrioraUITestsLaunchTests, .runsForEachTargetApplicationUIConfiguration, Bool, XCTest, XCTestCase

### Community 29 - "GlobalStyleEditorContent"
Cohesion: 0.23
Nodes (9): GlobalStyleEditorContent, GlobalStyleEditorView, .body, .hasStyleChanges, Bool, SlideTextStyle, String, UUID (+1 more)

### Community 30 - "MediaAsset"
Cohesion: 0.11
Nodes (19): Data, MediaAsset, MediaAssetKind, image, video, Date, UUID, Bool (+11 more)

### Community 31 - "LyricSlideTag"
Cohesion: 0.12
Nodes (16): LyricSlideTag, bridge, chorus, .displayName, .id, instrumental, intro, outro (+8 more)

### Community 32 - "SlideGridView"
Cohesion: 0.16
Nodes (18): SlideGridView, .thumbnailWidth, SlideThumbnailView, .textConfiguration, .thumbnailStyle, .usesDefaultGradientBackground, BackgroundContentMode, Bool (+10 more)

### Community 33 - "MediaAsset"
Cohesion: 0.27
Nodes (6): MediaRepositoryProtocol, Bool, MediaAsset, URL, .body, .body

### Community 34 - "DefaultBackgroundPreset"
Cohesion: 0.07
Nodes (31): Decoder, Float, .body, DefaultBackgroundMeshStyle, .colors, daylightWaves, morningHaze, twilightWaves (+23 more)

### Community 35 - "LyricsLibraryPanelView"
Cohesion: 0.22
Nodes (12): Layout, .trailingControlInset, LyricCardView, .footerShape, LyricsLibraryPanelView, .deleteAlertBinding, Binding, Bool (+4 more)

### Community 36 - "PresentationTextConfiguration"
Cohesion: 0.20
Nodes (11): EdgeInsets, PresentationTextConfiguration, SlideTextStyle, Bool, CGFloat, CGSize, Color, Double (+3 more)

### Community 37 - "Foundation"
Cohesion: 0.16
Nodes (5): CoreGraphics, Foundation, ResolvedBackgroundContentMode, fill, fit

### Community 38 - "LyricEditorNavigationOption"
Cohesion: 0.20
Nodes (7): LyricEditorNavigationOption, .id, .systemImage, .title, typography, String, Self

### Community 39 - ".body"
Cohesion: 0.28
Nodes (6): .body, SettingsSheet, .body, Binding, String, PresentationTextSettings

### Community 40 - "LyricLanguage"
Cohesion: 0.16
Nodes (12): LyricLanguage, .displayName, english, .id, spanish, unknown, SlideDetailEditorView, .activeStyle (+4 more)

### Community 41 - "View"
Cohesion: 0.32
Nodes (11): ImageLibrarySection, MediaLibraryPanelView, .body, sectionHeader(), SectionHeaderView, Binding, PhotosPickerItem, String (+3 more)

### Community 42 - ".saveLyric"
Cohesion: 0.17
Nodes (9): LyricEditorLaunch, LyricSectionSource, LyricRepositoryProtocol, LyricDocument, LyricLanguage, UUID, lyrics, .body (+1 more)

### Community 43 - ".saveTheme"
Cohesion: 0.43
Nodes (4): LyricTheme, ThemeRepositoryProtocol, SlideTextStyle, String

### Community 45 - "LyricSlideLayoutEngine"
Cohesion: 0.38
Nodes (6): LyricSlideLayoutEngine, CGFloat, CGSize, Int, SlideTextStyle, String

### Community 46 - "ExternalDisplayInfo"
Cohesion: 0.15
Nodes (12): ExternalDisplayInfo, .resolutionDescription, Bool, CGFloat, CGSize, String, DisplayInfoSheet, .body (+4 more)

### Community 47 - ".measureSingleLine"
Cohesion: 0.42
Nodes (6): PresentationTextMeasurer, Bool, CGFloat, CGSize, String, NSAttributedString

### Community 48 - "LyricRepository"
Cohesion: 0.29
Nodes (4): LyricRepository, FileManager, URL, UUID

### Community 50 - "ThemeSavePromptSheet"
Cohesion: 0.29
Nodes (6): Bool, String, Void, ThemeSavePromptSheet, .body, .trimmedThemeName

### Community 52 - ".postScriptName"
Cohesion: 0.36
Nodes (5): CGFloat, Font, NSFont, PresentationFontWeight, UIFont

### Community 55 - "SettingsRepository"
Cohesion: 0.32
Nodes (4): SettingsRepository, SettingsRepositoryProtocol, FileManager, URL

### Community 58 - "WorkspaceCompactLayout.swift"
Cohesion: 0.33
Nodes (6): EnvironmentValues, .workspaceCompactLayout, Bool, WorkspaceDevice, .isPad, .isPhone

### Community 59 - "LyricImportError"
Cohesion: 0.33
Nodes (6): LocalizedError, LyricImportError, empty, .errorDescription, notText, unsupportedContent

### Community 61 - "PresentationState"
Cohesion: 0.33
Nodes (5): PresentationState, Bool, PresentationBackground, SlideTextStyle, String

### Community 65 - "AdaptivePresentationText"
Cohesion: 0.33
Nodes (5): .body, .body, AdaptivePresentationText, .lines, String

### Community 67 - "PresentationFontWeight"
Cohesion: 0.29
Nodes (7): PresentationFontWeight, .nsWeight, .swiftUIWeight, .uiWeight, Font, NSFont, UIFont

### Community 68 - "MainView"
Cohesion: 0.19
Nodes (9): ContentView, .body, MainView, .adaptiveWorkspace, .iPadPortraitWorkspace, .iPhoneLandscapeWorkspace, CGFloat, WorkspaceLayout (+1 more)

### Community 69 - "AppViewModel.swift"
Cohesion: 0.33
Nodes (4): VideoControlsReveal, Observation, PhotosUI, UniformTypeIdentifiers

### Community 70 - "LyrioraApp"
Cohesion: 0.40
Nodes (4): App, LyrioraApp, .body, Scene

### Community 71 - "CodableColor"
Cohesion: 0.60
Nodes (4): CodableColor, .color, Color, Double

### Community 88 - ".importLyricsFromClipboard"
Cohesion: 0.29
Nodes (4): LyricImportResult, LyricClipboardImporter, String, LyricStyleProfile

## Knowledge Gaps
- **195 isolated node(s):** `meshWaves`, `twilightWaves`, `daylightWaves`, `violetDusk`, `morningHaze` (+190 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **43 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AppViewModel` connect `AppViewModel` to `ExternalDisplayManager`, `LyricEditorView`, `GlassIconButton`, `LyricDocument`, `LyricImportParser`, `CenterPanelView`, `VideoPlaybackController`, `PresentationPreviewView`, `GlobalStyleEditorContent`, `MediaAsset`, `MediaAsset`, `LyricsLibraryPanelView`, `LyricEditorNavigationOption`, `.body`, `View`, `.saveLyric`, `.saveTheme`, `.rechunkSlides`, `Task`, `MainView`, `AppViewModel.swift`, `.importLyricsFromClipboard`?**
  _High betweenness centrality (0.184) - this node is a cross-community bridge._
- **Why does `SwiftUI` connect `SwiftUI` to `EditorAdaptivePresentationText`, `LyricEditorView`, `LyricTheme`, `GlassIconButton`, `LyricSlideLivePreview`, `LyricSlide`, `PlayerLayerView`, `PresentationBackgroundLayer`, `CenterPanelView`, `BackgroundFitToolbar`, `CodingKeys`, `GlobalStyleEditorContent`, `SlideGridView`, `DefaultBackgroundPreset`, `LyricsLibraryPanelView`, `Foundation`, `LyricEditorNavigationOption`, `LyricLanguage`, `View`, `ExternalDisplayInfo`, `ThemeSavePromptSheet`, `WorkspaceCompactLayout.swift`, `AdaptivePresentationText`, `MainView`, `AppViewModel.swift`, `LyrioraApp`, `GlassMorphAnimation.swift`?**
  _High betweenness centrality (0.149) - this node is a cross-community bridge._
- **Why does `DefaultBackgroundSettings` connect `Sendable` to `SlideGridView`, `DefaultBackgroundPreset`, `LyricTheme`, `LyricLanguage`, `LyricSlideLivePreview`, `LyricSlide`, `PresentationBackgroundLayer`, `PresentationPreviewView`?**
  _High betweenness centrality (0.067) - this node is a cross-community bridge._
- **Are the 10 inferred relationships involving `AppViewModel` (e.g. with `.body` and `.body`) actually correct?**
  _`AppViewModel` has 10 INFERRED edges - model-reasoned connections that need verification._
- **Are the 2 inferred relationships involving `LyricEditorView` (e.g. with `.body` and `.body`) actually correct?**
  _`LyricEditorView` has 2 INFERRED edges - model-reasoned connections that need verification._
- **What connects `meshWaves`, `twilightWaves`, `daylightWaves` to the rest of the system?**
  _195 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `ExternalDisplayManager` be split into smaller, more focused modules?**
  _Cohesion score 0.057711950970377936 - nodes in this community are weakly interconnected._