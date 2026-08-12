# Graph Report - Lyriora  (2026-08-06)

## Corpus Check
- 103 files · ~48,655 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1369 nodes · 2825 edges · 134 communities (70 shown, 64 thin omitted)
- Extraction: 92% EXTRACTED · 8% INFERRED · 0% AMBIGUOUS · INFERRED: 220 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `0b782187`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- ExternalDisplayManager
- PresentationTextConfiguration
- LyricEditorView
- ThemeMiniPreview
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
- BackgroundFitToolbar
- BlurredBackgroundLayer
- PresentationPreviewView
- LyrioraUITests
- GlobalStyleEditorContent
- MediaRepository
- LyricSlideTag
- SlideGridView
- MediaAsset
- LyricTheme
- LyricCardView
- PresentationBackgroundView
- Foundation
- LyricEditorNavigationOption
- View
- LyricLanguage
- LibraryMorphSearchHeader
- .body
- .loadInitialData
- .body
- DefaultBackgroundSettings
- DisplayInfoSheet
- DefaultBackgroundPreset
- LyricRepository
- LyrioraTests.swift
- ThemeSavePromptSheet
- Color
- GlassPanel
- .deleteSlide
- AVLayerVideoGravity
- SettingsRepository
- CGRect
- .body
- DefaultBackgroundMeshStyle
- .linearGradient
- Animation
- SlideDetailEditorView
- Content
- Font
- Bool
- .store
- NSCoder
- .importSelectedPhotos
- MainView
- AppViewModel.swift
- LyrioraApp
- PresentationActionsToolbar
- PresentationFontWeight
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
- WorkspaceCompactLayout.swift
- MediaAsset
- LyricsLibraryPanelView
- MediaRepositoryProtocol
- PHPickerFilter
- LyricClipboardImporter.swift
- ContentView
- GlassMorphAnimation.swift
- CGFloat
- Color
- ColorScheme
- PhotosPickerItem
- URL
- LyricDocument
- UUID
- RoundedRectangle

## God Nodes (most connected - your core abstractions)
1. `AppViewModel` - 99 edges
2. `LyricEditorView` - 51 edges
3. `ExternalDisplayManager` - 50 edges
4. `LyricSlide` - 36 edges
5. `MediaAsset` - 33 edges
6. `PresentationTextConfiguration` - 31 edges
7. `LyricSlideTag` - 30 edges
8. `PresentationFontFamily` - 30 edges
9. `PresentationPreviewView` - 29 edges
10. `DefaultBackgroundSettings` - 27 edges

## Surprising Connections (you probably didn't know these)
- `.clearActionsCapsule` --calls--> `GlassIconButton`  [INFERRED]
  Lyriora/Views/Components/PresentationActionsToolbar.swift → Lyriora/Views/Components/GlassPanel.swift
- `.videoControlsCapsule` --calls--> `GlassIconButton`  [INFERRED]
  Lyriora/Views/Components/PresentationActionsToolbar.swift → Lyriora/Views/Components/GlassPanel.swift
- `.activeTheme` --references--> `AppViewModel`  [INFERRED]
  Lyriora/Views/Modals/LyricEditorView.swift → Lyriora/ViewModels/AppViewModel.swift
- `.presentationToolbar` --calls--> `PresentationActionsToolbar`  [INFERRED]
  Lyriora/Views/CenterPanel/CenterPanelView.swift → Lyriora/Views/Components/PresentationActionsToolbar.swift
- `.previewBackground` --calls--> `PresentationBackgroundLayer`  [INFERRED]
  Lyriora/Views/Components/LyricSlideLivePreview.swift → Lyriora/Views/Components/AppBackgroundView.swift

## Import Cycles
- None detected.

## Communities (134 total, 64 thin omitted)

### Community 0 - "ExternalDisplayManager"
Cohesion: 0.06
Nodes (41): AnyView, AppViewModel, Bool, CGSize, ExternalDisplayInfo, ExternalDisplayMetrics, ExternalPresentationContainerViewController, ExternalDisplayManager (+33 more)

### Community 1 - "PresentationTextConfiguration"
Cohesion: 0.06
Nodes (48): EdgeInsets, EnvironmentKey, LyricSlideLayoutEngine, CGFloat, CGSize, Int, SlideTextStyle, String (+40 more)

### Community 2 - "LyricEditorView"
Cohesion: 0.09
Nodes (24): Binding, EditorCard, .cardBackground, LyricEditorView, .activeTheme, .editorBackground, .hasStyleChanges, .importErrorBinding (+16 more)

### Community 3 - "ThemeMiniPreview"
Cohesion: 0.15
Nodes (20): Bool, CGFloat, SlideTextStyle, String, UUID, Void, ThemeGalleryView, .body (+12 more)

### Community 4 - "SwiftUI"
Cohesion: 0.28
Nodes (5): AppKit, AVFoundation, AVKit, SwiftUI, UIKit

### Community 5 - "PresentationFontFamily"
Cohesion: 0.07
Nodes (32): Encoder, PresentationFontFamily, arial, avenirNext, courierNew, futura, georgia, helveticaNeue (+24 more)

### Community 6 - "GlassPanel.swift"
Cohesion: 0.19
Nodes (12): GlassCircleIcon, GlassControlBorderModifier, GlassOverflowMenu, .body, GlassToolbarMetrics, .controlHeight, CGFloat, String (+4 more)

### Community 7 - ".configure"
Cohesion: 0.10
Nodes (30): TimeInterval, UUID, VideoSeekRequest, TimeInterval, Void, VideoProgressReporter, Coordinator, LoopingVideoBackground (+22 more)

### Community 8 - "CodingKeys"
Cohesion: 0.07
Nodes (28): CodingKey, CodingKeys, colorSeed, createdAt, id, language, storedSlides, styleProfile (+20 more)

### Community 9 - "LyricDocument"
Cohesion: 0.21
Nodes (13): Codable, LyricDocument, .previewSnippet, .slides, Date, Decoder, String, UInt64 (+5 more)

### Community 10 - ".resolvedMetrics"
Cohesion: 0.19
Nodes (13): ExternalDisplayDiscovery, ExternalDisplayMetrics, Source, liveContainer, liveWindow, sceneCoordinateSpace, screenBounds, Bool (+5 more)

### Community 11 - "MediaThumbnailView"
Cohesion: 0.09
Nodes (33): LibrarySearch, LyricDocument, .searchableText, MediaAsset, Bool, String, ImageLibrarySection, .filteredAssets (+25 more)

### Community 12 - "AppViewModel"
Cohesion: 0.10
Nodes (20): ExternalDisplayManager, Int, LyricRepositoryProtocol, LyricSlide, AppViewModel, .activePresentationBackground, .hasCustomBackgroundSelected, .hasVideoBackgroundSelected (+12 more)

### Community 13 - ".loadThumbnail"
Cohesion: 0.15
Nodes (16): AVAssetImageGenerator, CGImage, Error, Metadata, MetadataError, cancelled, thumbnailFailed, CGSize (+8 more)

### Community 14 - "LyricSlideLivePreview"
Cohesion: 0.06
Nodes (37): LyricPreviewBackgroundStyle, borderOnly, settingsDefault, LyricSlideLivePreview, .body, .compactHeight, .cornerRadius, .displayText (+29 more)

### Community 15 - "LyricSlide"
Cohesion: 0.17
Nodes (15): LyricSlide, Int, SlideTextStyle, String, UUID, LyricEditorSlideCard, .body, .textConfiguration (+7 more)

### Community 16 - "Identifiable"
Cohesion: 0.15
Nodes (12): ButtonRole, Identifiable, LyricEditorLaunch, PresentationFontDesign, `default`, .id, .label, monospaced (+4 more)

### Community 17 - "PlayerLayerView"
Cohesion: 0.08
Nodes (26): AnyClass, AVPlayerView, Context, CGSize, AVPlayerLayerRepresentable, AVPlayerLayerView, .body, AVPlayerViewRepresentable (+18 more)

### Community 18 - "Sendable"
Cohesion: 0.12
Nodes (20): Equatable, LocalizedError, LyricSectionSource, String, UUID, PresentationBackground, URL, LyricImportError (+12 more)

### Community 19 - "BackgroundContentMode"
Cohesion: 0.11
Nodes (17): AppSettings, PresentationTextSettings, Bool, Decoder, Double, PresentationFontWeight, BackgroundContentMode, auto (+9 more)

### Community 20 - "LocalFileImageBackground"
Cohesion: 0.42
Nodes (7): LocalFileImageBackground, .body, CGSize, Image, URL, .body, ResolvedBackgroundContentMode

### Community 21 - "LyricImportParser"
Cohesion: 0.21
Nodes (7): LyricLanguage, LyricSectionSource, LyricImportParser, ParsedSections, Bool, Int, String

### Community 22 - "CenterPanelView"
Cohesion: 0.24
Nodes (8): CenterPanelView, .body, .presentationToolbar, String, WorkspaceDisplayToolbar, .displayButtonAccessibilityLabel, .iPadPortraitDetailWorkspace, .iPhoneLandscapeDetailWorkspace

### Community 23 - "VideoPlaybackController"
Cohesion: 0.17
Nodes (10): Any, AVPlayer, AVPlayerItem, AVPlayerLooper, CMTime, NSObjectProtocol, TimeInterval, Void (+2 more)

### Community 24 - "GlassIconButton"
Cohesion: 0.24
Nodes (10): Image, .body, .body, GlassIconButton, .body, .foregroundColor, GlassToolbarIconStyle, Bool (+2 more)

### Community 25 - "BackgroundFitToolbar"
Cohesion: 0.24
Nodes (12): BackgroundFitBadgeLabel, BackgroundFitToggleLabel, BackgroundFitToolbar, .body, .expandedOptions, .toggleButton, Constants, Layout (+4 more)

### Community 26 - "BlurredBackgroundLayer"
Cohesion: 0.29
Nodes (9): BlurredBackgroundLayer, .body, BlurredBackgroundModifier, CGFloat, Content, Double, View, View (+1 more)

### Community 27 - "PresentationPreviewView"
Cohesion: 0.09
Nodes (30): PresentationLayout, CGFloat, CGSize, .presentationLayoutCanvasSize, .body, PresentationContentView, .textConfiguration, PresentationPreviewView (+22 more)

### Community 28 - "LyrioraUITests"
Cohesion: 0.15
Nodes (6): LyrioraUITests, LyrioraUITestsLaunchTests, .runsForEachTargetApplicationUIConfiguration, Bool, XCTest, XCTestCase

### Community 29 - "GlobalStyleEditorContent"
Cohesion: 0.23
Nodes (9): GlobalStyleEditorContent, GlobalStyleEditorView, .body, .hasStyleChanges, Bool, SlideTextStyle, String, UUID (+1 more)

### Community 30 - "MediaRepository"
Cohesion: 0.14
Nodes (14): Data, FileManager, .index, MediaAssetKind, image, video, MediaRepository, String (+6 more)

### Community 31 - "LyricSlideTag"
Cohesion: 0.12
Nodes (16): LyricSlideTag, bridge, chorus, .displayName, .id, instrumental, intro, outro (+8 more)

### Community 32 - "SlideGridView"
Cohesion: 0.15
Nodes (19): SlideGridView, .body, .thumbnailWidth, SlideThumbnailView, .textConfiguration, .thumbnailStyle, .usesDefaultGradientBackground, BackgroundContentMode (+11 more)

### Community 33 - "MediaAsset"
Cohesion: 0.21
Nodes (10): Date, MediaAsset, .listLabel, UUID, MediaRepositoryProtocol, .selectedBackgroundAsset, .selectedVideoItems, importSelectedVideos() (+2 more)

### Community 34 - "LyricTheme"
Cohesion: 0.18
Nodes (11): LyricTheme, Date, Int, SlideTextStyle, String, UUID, FileManager, URL (+3 more)

### Community 35 - "LyricCardView"
Cohesion: 0.24
Nodes (9): Layout, .trailingControlInset, LyricCardView, .footerShape, Bool, CGFloat, String, Void (+1 more)

### Community 36 - "PresentationBackgroundView"
Cohesion: 0.15
Nodes (16): Animation, ConfigurableDefaultGradientView, .layerIdentity, AppBackgroundAnimation, .transition, .body, .body, Double (+8 more)

### Community 37 - "Foundation"
Cohesion: 0.13
Nodes (5): CoreGraphics, Foundation, ResolvedBackgroundContentMode, fill, fit

### Community 38 - "LyricEditorNavigationOption"
Cohesion: 0.20
Nodes (9): Hashable, LyricEditorNavigationOption, .id, lyrics, .systemImage, .title, typography, String (+1 more)

### Community 39 - "View"
Cohesion: 0.24
Nodes (9): DefaultBackgroundPresetPreview, DefaultBackgroundPreviewCard, SettingsSheet, .body, .defaultBackgroundSection, Binding, String, PresentationTextSettings (+1 more)

### Community 40 - "LyricLanguage"
Cohesion: 0.14
Nodes (15): CaseIterable, PresentationFontWeight, bold, .id, .label, medium, regular, semibold (+7 more)

### Community 41 - "LibraryMorphSearchHeader"
Cohesion: 0.18
Nodes (12): Layout, LibraryMorphSearchHeader, .body, .collapsedSearchButton, .controlSize, .isSearchActive, .resolvedHorizontalPadding, .searchSlot (+4 more)

### Community 42 - ".body"
Cohesion: 0.36
Nodes (4): LyricDocument, LyricEditorLaunch, seedSampleLyricsIfNeeded(), .body

### Community 43 - ".loadInitialData"
Cohesion: 0.27
Nodes (4): LyricTheme, ThemeRepositoryProtocol, .body, SlideTextStyle

### Community 45 - "DefaultBackgroundSettings"
Cohesion: 0.23
Nodes (14): DefaultBackgroundSettings, Double, AppBackgroundView, .layerIdentity, .shellBackground, PresentationBackgroundLayer, .layerIdentity, BackgroundContentMode (+6 more)

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

### Community 51 - "Color"
Cohesion: 0.36
Nodes (6): Color, ColorScheme, LinearGradient, .body, GlassControlChrome, .expandedSearchField

### Community 52 - "GlassPanel"
Cohesion: 0.22
Nodes (10): Content, content, GlassCapsuleToolbar, .body, GlassPanel, .body, .panelShape, RoundedRectangle (+2 more)

### Community 55 - "SettingsRepository"
Cohesion: 0.47
Nodes (4): SettingsRepository, SettingsRepositoryProtocol, FileManager, URL

### Community 57 - ".body"
Cohesion: 0.18
Nodes (7): Bool, UUID, LibrarySearchEmptyState, .body, String, .body, .body

### Community 58 - "DefaultBackgroundMeshStyle"
Cohesion: 0.13
Nodes (16): Float, .body, DefaultBackgroundMeshStyle, .colors, daylightWaves, morningHaze, twilightWaves, violetDusk (+8 more)

### Community 59 - ".linearGradient"
Cohesion: 0.32
Nodes (5): LyricGradient, Color, LinearGradient, UInt64, .body

### Community 61 - "SlideDetailEditorView"
Cohesion: 0.36
Nodes (6): SlideDetailEditorView, .activeStyle, Binding, Bool, SlideTextStyle, Void

### Community 65 - ".store"
Cohesion: 0.62
Nodes (5): Entry, LocalImageCache, CGSize, Image, URL

### Community 67 - ".importSelectedPhotos"
Cohesion: 0.22
Nodes (6): PhotosPickerDisplayNameResolver, PhotosPickerItem, String, .selectedPhotoItems, Photos, PhotosUI

### Community 68 - "MainView"
Cohesion: 0.23
Nodes (9): MediaLibraryPanelView, MainView, .adaptiveWorkspace, .iPadPortraitWorkspace, .iPhoneLandscapeWorkspace, .landscapeWorkspace, CGFloat, WorkspaceLayout (+1 more)

### Community 69 - "AppViewModel.swift"
Cohesion: 0.24
Nodes (9): PickedImageFile, .transferRepresentation, PickedVideoFile, .transferRepresentation, String, VideoControlsReveal, Transferable, TransferRepresentation (+1 more)

### Community 70 - "LyrioraApp"
Cohesion: 0.40
Nodes (4): App, LyrioraApp, .body, Scene

### Community 71 - "PresentationActionsToolbar"
Cohesion: 0.22
Nodes (8): Constants, PresentationActionsToolbar, .body, .clearActionsCapsule, .videoControlsCapsule, Bool, CGFloat, Void

### Community 72 - "PresentationFontWeight"
Cohesion: 0.29
Nodes (6): PresentationFontWeight, .nsWeight, .swiftUIWeight, .uiWeight, NSFont, UIFont

### Community 78 - "VideoPlaybackMode"
Cohesion: 0.29
Nodes (6): Bool, VideoPlaybackMode, loop, .loopsVideo, playOnce, .toggled

### Community 88 - ".importLyricsFromClipboard"
Cohesion: 0.40
Nodes (3): LyricImportResult, LyricStyleProfile, .importSection

### Community 100 - "GlassToolbarIconSize"
Cohesion: 0.33
Nodes (6): Font, GlassToolbarIconSize, .frameSize, .iconFont, prominent, regular

### Community 102 - ".makeSlides"
Cohesion: 0.33
Nodes (4): CGSize, SlideTextStyle, CGSize, SlideTextStyle

### Community 104 - "ExternalDisplayInfo"
Cohesion: 0.29
Nodes (6): ExternalDisplayInfo, .resolutionDescription, Bool, CGFloat, CGSize, String

### Community 118 - "WorkspaceCompactLayout.swift"
Cohesion: 0.33
Nodes (6): EnvironmentValues, .workspaceCompactLayout, Bool, WorkspaceDevice, .isPad, .isPhone

### Community 120 - "LyricsLibraryPanelView"
Cohesion: 0.40
Nodes (6): LyricsLibraryPanelView, .deleteAlertBinding, .filteredLyrics, .isSearching, AppViewModel, Binding

## Knowledge Gaps
- **208 isolated node(s):** `.searchableText`, `.controlHeight`, `regular`, `prominent`, `.iconFont` (+203 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **64 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `SwiftUI` connect `SwiftUI` to `PresentationTextConfiguration`, `LyricEditorView`, `ThemeMiniPreview`, `GlassPanel.swift`, `MediaThumbnailView`, `LyricSlideLivePreview`, `LyricSlide`, `CenterPanelView`, `BackgroundFitToolbar`, `BlurredBackgroundLayer`, `GlobalStyleEditorContent`, `SlideGridView`, `LyricCardView`, `Foundation`, `LyricEditorNavigationOption`, `View`, `LibraryMorphSearchHeader`, `DefaultBackgroundSettings`, `DisplayInfoSheet`, `ThemeSavePromptSheet`, `DefaultBackgroundMeshStyle`, `.linearGradient`, `SlideDetailEditorView`, `.importSelectedPhotos`, `MainView`, `AppViewModel.swift`, `LyrioraApp`, `PresentationActionsToolbar`, `PresentationFontWeight`, `WorkspaceCompactLayout.swift`, `ContentView`, `GlassMorphAnimation.swift`?**
  _High betweenness centrality (0.174) - this node is a cross-community bridge._
- **Why does `AppViewModel` connect `AppViewModel` to `ExternalDisplayManager`, `LyricEditorView`, `LyricDocument`, `LyricImportParser`, `CenterPanelView`, `VideoPlaybackController`, `PresentationPreviewView`, `GlobalStyleEditorContent`, `MediaAsset`, `View`, `.body`, `.loadInitialData`, `.body`, `.deleteSlide`, `.body`, `.importSelectedPhotos`, `MainView`, `AppViewModel.swift`, `.importLyricsFromClipboard`, `ContentView`?**
  _High betweenness centrality (0.158) - this node is a cross-community bridge._
- **Why does `MediaAsset` connect `MediaAsset` to `.importSelectedPhotos`, `Foundation`, `AppViewModel.swift`, `LyricLanguage`, `LyricDocument`, `AppViewModel`, `Identifiable`, `Sendable`, `.body`, `MediaRepository`?**
  _High betweenness centrality (0.067) - this node is a cross-community bridge._
- **Are the 11 inferred relationships involving `AppViewModel` (e.g. with `.body` and `VideoPlaybackController`) actually correct?**
  _`AppViewModel` has 11 INFERRED edges - model-reasoned connections that need verification._
- **Are the 2 inferred relationships involving `LyricEditorView` (e.g. with `.body` and `.body`) actually correct?**
  _`LyricEditorView` has 2 INFERRED edges - model-reasoned connections that need verification._
- **What connects `.searchableText`, `.controlHeight`, `regular` to the rest of the system?**
  _208 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `ExternalDisplayManager` be split into smaller, more focused modules?**
  _Cohesion score 0.059499489274770175 - nodes in this community are weakly interconnected._