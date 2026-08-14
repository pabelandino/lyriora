# Graph Report - Lyriora  (2026-08-14)

## Corpus Check
- 130 files · ~67,524 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1953 nodes · 4408 edges · 94 communities (91 shown, 3 thin omitted)
- Extraction: 92% EXTRACTED · 8% INFERRED · 0% AMBIGUOUS · INFERRED: 351 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `261b2ed5`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- ExternalDisplayManager
- PresentationPreviewView
- LibraryPlaylist
- .configure
- TextAnimationKind
- LyricEditorView
- LyricTheme
- SimplePlaySyncDisplayState
- What You Must Do When Invoked
- MediaAsset
- GlobalStyleEditorContent
- PresentationFontFamily
- TextAnimationEditorSection
- TextAnimationTarget
- LyricImportParser
- SlideDetailEditorView
- LyricSlideLivePreview
- MediaThumbnailView
- VideoPlaybackController
- LyricSectionSource
- .resolvedMetrics
- SlideTransitionTextContainer
- MediaAssetKind
- CodingKeys
- View
- .loadThumbnail
- ExplicitLinePresentationText
- Sendable
- LyricSlide
- PresentationBackgroundLayer
- SlideAnimationProfile
- AnimatedPresentationText
- PlayerLayerView
- Codable
- MetalTextEffectRenderer
- LibraryMorphSearchHeader
- PlaylistEditorSheet
- .transitionTransform
- SwiftUI
- lyricTextFragment
- Equatable
- SettingsRepository
- AppViewModel
- ProTextSegmentView
- LyricDocument
- LyricLanguage
- TypewriterRevealText
- LyricSlideTag
- View
- PlaylistPickerSheet
- LyricSlideLayoutEngine
- .measureSingleLine
- VideoPlaybackMode
- BackgroundFitToolbar
- MainView
- LyrioraUITests
- CodingKeys
- Foundation
- LocalFileImageBackground
- Identifiable
- SlideTextStyle
- PresentationLayout
- PresentationState
- DefaultBackgroundPreset
- .matches
- DefaultBackgroundPresetPreview
- TextAnimationTransform
- GlassCircleIcon
- GlassIconButton
- PresentationTextConfiguration
- AdaptivePresentationText
- .shadowColor
- SlideThumbnailView
- SlideGridView
- StickyPreviewEditorLayout
- content
- LyricRepository
- .body
- BlurredBackgroundLayer
- LyricsLibraryPanelView
- TransitionSpeedControl
- PlaylistMediaPreview
- MacWindowConfigurator
- .parse
- GlassToolbarIconSize
- AppViewModel.swift
- CenterPanelView
- WorkspaceCompactLayout.swift
- DisplayInfoSheet
- LyricImportError
- .saveLyric
- LyrioraApp
- LyrioraTests.swift
- GlassMorphAnimation.swift

## God Nodes (most connected - your core abstractions)
1. `AppViewModel` - 155 edges
2. `TextAnimationKind` - 75 edges
3. `SlideAnimationProfile` - 60 edges
4. `LyricSlide` - 53 edges
5. `ExternalDisplayManager` - 51 edges
6. `LyricEditorView` - 51 edges
7. `TextAnimationEditorSection` - 46 edges
8. `MediaAsset` - 43 edges
9. `PresentationTextConfiguration` - 40 edges
10. `GlobalStyleEditorContent` - 36 edges

## Surprising Connections (you probably didn't know these)
- `.activeTheme` --references--> `AppViewModel`  [INFERRED]
  Lyriora/Views/Modals/LyricEditorView.swift → Lyriora/ViewModels/AppViewModel.swift
- `.resolvedPlaylist` --references--> `AppViewModel`  [INFERRED]
  Lyriora/Views/Modals/PlaylistSheets.swift → Lyriora/ViewModels/AppViewModel.swift
- `.headerRow` --references--> `LyricSlide`  [INFERRED]
  Lyriora/Views/Components/LyricSlideLivePreview.swift → Lyriora/Models/LyricSlide.swift
- `.body` --calls--> `PresentationBackgroundLayer`  [INFERRED]
  Lyriora/Views/Components/ThemePreviewCard.swift → Lyriora/Views/Components/AppBackgroundView.swift
- `.activeThemeName` --references--> `LyricStyleProfile`  [INFERRED]
  Lyriora/Views/Modals/LyricEditorView.swift → Lyriora/Models/SlideTextStyle.swift

## Import Cycles
- None detected.

## Communities (94 total, 3 thin omitted)

### Community 0 - "ExternalDisplayManager"
Cohesion: 0.05
Nodes (46): ExternalDisplayInfo, .resolutionDescription, Bool, CGFloat, CGSize, String, ExternalDisplayManager, .displayMonitorInterval (+38 more)

### Community 1 - "PresentationPreviewView"
Cohesion: 0.15
Nodes (15): PresentationPreviewView, .body, .displayedCurrentTime, .isVideoBackground, .previewMetadataBar, .previewStage, .showsSlidePlaceholder, .showsVideoControls (+7 more)

### Community 2 - "LibraryPlaylist"
Cohesion: 0.09
Nodes (19): LibraryPlaylist, LibraryPlaylistKind, image, lyric, .systemImage, .title, video, Date (+11 more)

### Community 3 - ".configure"
Cohesion: 0.11
Nodes (28): TimeInterval, UUID, VideoSeekRequest, TimeInterval, Void, VideoProgressReporter, Coordinator, LoopingVideoBackground (+20 more)

### Community 4 - "TextAnimationKind"
Cohesion: 0.04
Nodes (47): Bool, TextAnimationKind, .basicCases, blink, blinkSemiRotate, bounce, chromaticShift, .displayName (+39 more)

### Community 5 - "LyricEditorView"
Cohesion: 0.06
Nodes (35): KeyboardDismissal, LyricEditorNavigationOption, .id, lyrics, .systemImage, .title, typography, String (+27 more)

### Community 6 - "LyricTheme"
Cohesion: 0.07
Nodes (33): LyricTheme, Date, Int, SlideTextStyle, String, UUID, FileManager, URL (+25 more)

### Community 7 - "SimplePlaySyncDisplayState"
Cohesion: 0.11
Nodes (22): .slideGridHeader, SimplePlayConnectionIndicator, .body, SimplePlayConnectionInfoSheet, .body, .manualModeBinding, .state, .statusFooter (+14 more)

### Community 8 - "What You Must Do When Invoked"
Cohesion: 0.08
Nodes (24): For /graphify add and --watch, For /graphify query, For the commit hook and native AGENTS.md integration, For --update and --cluster-only, /graphify, Honesty Rules, Interpreter guard for subcommands, Part A - Structural extraction for code files (+16 more)

### Community 9 - "MediaAsset"
Cohesion: 0.12
Nodes (18): MediaAsset, .listLabel, Date, UUID, MediaRepositoryProtocol, PhotosPickerDisplayNameResolver, PhotosPickerItem, String (+10 more)

### Community 10 - "GlobalStyleEditorContent"
Cohesion: 0.06
Nodes (36): SlideStyleControlsView, .body, .fontSizeBinding, .horizontalMarginBinding, .verticalMarginBinding, Binding, Double, SlideTextStyle (+28 more)

### Community 11 - "PresentationFontFamily"
Cohesion: 0.07
Nodes (31): PresentationFontWeight, bold, .id, .label, medium, regular, semibold, PresentationFontFamily (+23 more)

### Community 12 - "TextAnimationEditorSection"
Cohesion: 0.13
Nodes (17): Binding, Bool, Int, String, Void, TextAnimationEditorSection, .animationResetToolbar, .animationStatusSummary (+9 more)

### Community 13 - "TextAnimationTarget"
Cohesion: 0.12
Nodes (16): Int, TextAnimationTarget, all, .label, line, paragraph, word, ParsedSlideText (+8 more)

### Community 14 - "LyricImportParser"
Cohesion: 0.18
Nodes (9): String, LyricImportParser, LyricImportResult, LyricSectionParseResult, ParsedSections, Bool, Int, String (+1 more)

### Community 15 - "SlideDetailEditorView"
Cohesion: 0.07
Nodes (31): LyricPlaySyncServer, LyricPlaySyncTransportError, emptyResponse, .errorDescription, noLyrioraHost, unexpectedResponse, State, failed (+23 more)

### Community 16 - "LyricSlideLivePreview"
Cohesion: 0.11
Nodes (23): LyricPreviewBackgroundStyle, borderOnly, settingsDefault, LyricSlideLivePreview, .body, .compactHeight, .cornerRadius, .displayText (+15 more)

### Community 17 - "MediaThumbnailView"
Cohesion: 0.09
Nodes (30): GlassOverflowMenu, ImageLibrarySection, .filteredAssets, .isPlaylistFiltered, LocalFileThumbnailImage, LocalFileVideoThumbnail, MediaImportContentTypes, MediaLibraryPanelView (+22 more)

### Community 18 - "VideoPlaybackController"
Cohesion: 0.18
Nodes (10): AVPlayerLooper, Any, AVPlayer, AVPlayerItem, CMTime, NSObjectProtocol, TimeInterval, URL (+2 more)

### Community 19 - "LyricSectionSource"
Cohesion: 0.24
Nodes (5): sourceSections, LyricSectionSource, String, UUID, UUID

### Community 20 - ".resolvedMetrics"
Cohesion: 0.19
Nodes (13): ExternalDisplayDiscovery, ExternalDisplayMetrics, Source, liveContainer, liveWindow, sceneCoordinateSpace, screenBounds, Bool (+5 more)

### Community 21 - "SlideTransitionTextContainer"
Cohesion: 0.15
Nodes (18): SlideTransitionTextContainer, .body, .effectiveWordCount, .enterAnimation, .enterDuration, .exitDuration, .transitionState, Animation (+10 more)

### Community 22 - "MediaAssetKind"
Cohesion: 0.13
Nodes (16): .index, MediaAssetKind, image, video, MediaIndexEntry, MediaRepository, Data, FileManager (+8 more)

### Community 23 - "CodingKeys"
Cohesion: 0.06
Nodes (33): CodingKey, CodingKeys, colorSeed, createdAt, id, language, simplePlayProjectID, simplePlayProjectName (+25 more)

### Community 24 - "View"
Cohesion: 0.14
Nodes (27): PlaylistGlassColumn, PlaylistGlassEmptyState, .body, PlaylistGlassNameField, .body, PlaylistGlassRowButton, .body, PlaylistGlassSearchField (+19 more)

### Community 25 - ".loadThumbnail"
Cohesion: 0.15
Nodes (16): AVAssetImageGenerator, Error, Metadata, MetadataError, cancelled, thumbnailFailed, CGImage, CGSize (+8 more)

### Community 26 - "ExplicitLinePresentationText"
Cohesion: 0.14
Nodes (19): EnvironmentKey, .body, EditorAdaptivePresentationText, .body, .resolvedConfiguration, EditorPreviewSizing, exact, scaledApproximation (+11 more)

### Community 27 - "Sendable"
Cohesion: 0.14
Nodes (19): AppSettings, PresentationTextSettings, Bool, Decoder, Double, BackgroundContentMode, auto, fill (+11 more)

### Community 28 - "LyricSlide"
Cohesion: 0.18
Nodes (11): .slides, LyricSlide, Int, SlideTextStyle, String, UUID, LyricSlideMetadataPreservation, String (+3 more)

### Community 29 - "PresentationBackgroundLayer"
Cohesion: 0.10
Nodes (27): PresentationBackground, URL, ConfigurableDefaultGradientView, .body, .layerIdentity, .activePresentationBackground, AppBackgroundAnimation, .transition (+19 more)

### Community 30 - "SlideAnimationProfile"
Cohesion: 0.15
Nodes (10): assignments, SlideAnimationProfile, .hasAnimations, .hasPersistentEffects, .hasTransition, .preferredEffectSelectionTarget, .preferredTransitionSelectionTarget, Encoder (+2 more)

### Community 31 - "AnimatedPresentationText"
Cohesion: 0.23
Nodes (13): AnimatedPresentationText, .animatedBody, .shouldRenderAnimatedContent, .shouldRunEffectTimeline, Bool, CGFloat, CGSize, Double (+5 more)

### Community 32 - "PlayerLayerView"
Cohesion: 0.08
Nodes (24): AnyClass, AVPlayerView, AVPlayerLayerRepresentable, AVPlayerLayerView, .body, AVPlayerViewRepresentable, PlayerLayerView, .layerClass (+16 more)

### Community 33 - "Codable"
Cohesion: 0.11
Nodes (25): Codable, JSONEncoder, LyricStyleProfile, Decoder, LinkSectionCommand, LyricPlaySync, LyricPlaySyncCodec, LyricPlaySyncMessage (+17 more)

### Community 34 - "MetalTextEffectRenderer"
Cohesion: 0.07
Nodes (32): MetalTextEffectParameters, .isActive, MetalTextEffectRenderer, MetalTextEffectSupport, Bool, CGImage, CGSize, Double (+24 more)

### Community 35 - "LibraryMorphSearchHeader"
Cohesion: 0.15
Nodes (15): Layout, LibraryMorphSearchHeader, .body, .collapsedSearchButton, .controlSize, .isSearchActive, .resolvedHorizontalPadding, .searchSlot (+7 more)

### Community 36 - "PlaylistEditorSheet"
Cohesion: 0.17
Nodes (10): PlaylistEditorSheet, .allItemIDs, .availableItems, .availableSearchPlaceholder, .filteredAvailableItems, .resolvedPlaylist, .showsMediaPreview, Set (+2 more)

### Community 37 - ".transitionTransform"
Cohesion: 0.25
Nodes (11): AnimatableModifier, SequentialWordTransitionModifier, .animatableData, .layoutSegmentIndex, .layoutTotalWords, SlideTransitionModifier, .animatableData, Bool (+3 more)

### Community 38 - "SwiftUI"
Cohesion: 0.22
Nodes (5): AppKit, AVFoundation, AVKit, SwiftUI, UIKit

### Community 39 - "lyricTextFragment"
Cohesion: 0.13
Nodes (17): constant, float2, float4, fragment, lyricTextFragment(), lyricTextVertex(), TextEffectUniforms, chromaticStrength (+9 more)

### Community 40 - "Equatable"
Cohesion: 0.22
Nodes (11): Equatable, SlideTransitionState, .showsPersistentEffects, SlideTransitionTiming, Bool, Decoder, Double, TimeInterval (+3 more)

### Community 41 - "SettingsRepository"
Cohesion: 0.32
Nodes (4): SettingsRepository, SettingsRepositoryProtocol, FileManager, URL

### Community 42 - "AppViewModel"
Cohesion: 0.06
Nodes (30): LyricRepositoryProtocol, AppViewModel, .hasCustomBackgroundSelected, .hasVideoBackgroundSelected, .isSimplePlayConnected, .selectedBackgroundAsset, .selectedLyric, .selectedLyricSlides (+22 more)

### Community 43 - "ProTextSegmentView"
Cohesion: 0.25
Nodes (10): ProTextSegmentView, .body, Bool, CGSize, Color, Double, Font, Int (+2 more)

### Community 44 - "LyricDocument"
Cohesion: 0.18
Nodes (11): LyricDocument, .previewSnippet, CGSize, Date, Decoder, SlideTextStyle, String, UInt64 (+3 more)

### Community 45 - "LyricLanguage"
Cohesion: 0.12
Nodes (16): LyricLanguage, .displayName, english, .id, spanish, unknown, tagStyles, LyricEditorSlideCard (+8 more)

### Community 46 - "TypewriterRevealText"
Cohesion: 0.21
Nodes (14): Bool, Color, Content, Double, Font, Int, String, TypewriterRevealText (+6 more)

### Community 47 - "LyricSlideTag"
Cohesion: 0.12
Nodes (16): LyricSlideTag, bridge, chorus, .displayName, .id, instrumental, intro, outro (+8 more)

### Community 48 - "View"
Cohesion: 0.36
Nodes (4): GlassControlBorderModifier, Content, View, S

### Community 49 - "PlaylistPickerSheet"
Cohesion: 0.32
Nodes (6): PlaylistPickerSheet, .createPlaylistCard, .isSearching, .totalItemCount, Bool, Int

### Community 50 - "LyricSlideLayoutEngine"
Cohesion: 0.38
Nodes (6): LyricSlideLayoutEngine, CGFloat, CGSize, Int, SlideTextStyle, String

### Community 51 - ".measureSingleLine"
Cohesion: 0.27
Nodes (10): PresentationTextMeasurer, Any, Bool, CGFloat, CGSize, String, .lines, .body (+2 more)

### Community 52 - "VideoPlaybackMode"
Cohesion: 0.12
Nodes (14): Bool, VideoPlaybackMode, loop, .loopsVideo, playOnce, .toggled, Constants, PresentationActionsToolbar (+6 more)

### Community 53 - "BackgroundFitToolbar"
Cohesion: 0.22
Nodes (12): BackgroundFitBadgeLabel, .body, BackgroundFitToggleLabel, BackgroundFitToolbar, .body, .expandedOptions, .toggleButton, Constants (+4 more)

### Community 54 - "MainView"
Cohesion: 0.18
Nodes (10): ContentView, .body, MainView, .adaptiveWorkspace, .iPadPortraitWorkspace, .iPhoneLandscapeWorkspace, .iPhonePortraitPrompt, CGFloat (+2 more)

### Community 55 - "LyrioraUITests"
Cohesion: 0.15
Nodes (6): LyrioraUITests, LyrioraUITestsLaunchTests, .runsForEachTargetApplicationUIConfiguration, Bool, XCTest, XCTestCase

### Community 56 - "CodingKeys"
Cohesion: 0.17
Nodes (12): CodingKeys, effectAssignments, effectFallback, effectIntensity, effectSpeed, fallbackAnimation, transitionAssignments, transitionIntensity (+4 more)

### Community 57 - "Foundation"
Cohesion: 0.18
Nodes (3): CoreGraphics, Foundation, LyricClipboardImporter

### Community 58 - "LocalFileImageBackground"
Cohesion: 0.18
Nodes (16): ResolvedBackgroundContentMode, fill, fit, CGSize, Entry, LocalImageCache, CGSize, Image (+8 more)

### Community 59 - "Identifiable"
Cohesion: 0.09
Nodes (19): CaseIterable, Hashable, Identifiable, AnimationApplyScope, allSlides, currentSlide, .id, .label (+11 more)

### Community 60 - "SlideTextStyle"
Cohesion: 0.23
Nodes (10): SlideTextStyle, .fontSize, Bool, Double, Encoder, Int, CodableColor, .color (+2 more)

### Community 61 - "PresentationLayout"
Cohesion: 0.26
Nodes (7): PresentationLayout, CGFloat, CGSize, .presentationLayoutCanvasSize, .canvasAspectRatio, .canvasSize, .previewSection

### Community 62 - "PresentationState"
Cohesion: 0.17
Nodes (11): .presentationState, PresentationState, Bool, Int, SlideTextStyle, String, UUID, PresentationContentView (+3 more)

### Community 63 - "DefaultBackgroundPreset"
Cohesion: 0.08
Nodes (25): DefaultBackgroundMeshStyle, .colors, daylightWaves, morningHaze, twilightWaves, violetDusk, .wavePoints, DefaultBackgroundMeshView (+17 more)

### Community 64 - ".matches"
Cohesion: 0.30
Nodes (6): Bool, LibrarySearch, LyricDocument, .searchableText, Bool, String

### Community 65 - "DefaultBackgroundPresetPreview"
Cohesion: 0.29
Nodes (7): EdgeInsets, .sidebarSections, DefaultBackgroundPresetPreview, .body, DefaultBackgroundPreviewCard, .body, .defaultBackgroundSection

### Community 66 - "TextAnimationTransform"
Cohesion: 0.29
Nodes (8): Angle, AnimatedTextSegmentModifier, CGFloat, CGSize, TimeInterval, TextAnimationTransform, View, ViewModifier

### Community 67 - "GlassCircleIcon"
Cohesion: 0.24
Nodes (10): GlassCircleIcon, .body, GlassPanel, .panelShape, GlassToolbarIconStyle, GlassToolbarMetrics, .controlHeight, CGFloat (+2 more)

### Community 68 - "GlassIconButton"
Cohesion: 0.24
Nodes (9): ButtonRole, .body, Action, GlassIconButton, .body, .foregroundColor, Bool, String (+1 more)

### Community 69 - "PresentationTextConfiguration"
Cohesion: 0.27
Nodes (9): PresentationTextConfiguration, SlideTextStyle, Bool, CGFloat, Color, Double, Font, SlideTextStyle (+1 more)

### Community 70 - "AdaptivePresentationText"
Cohesion: 0.20
Nodes (7): CGSize, AdaptivePresentationText, .body, Bool, Int, String, UUID

### Community 71 - ".shadowColor"
Cohesion: 0.33
Nodes (7): .body, GlassControlChrome, Color, ColorScheme, LinearGradient, .expandedSearchField, .body

### Community 72 - "SlideThumbnailView"
Cohesion: 0.25
Nodes (8): SlideThumbnailView, .textConfiguration, .thumbnailCanvasSize, .thumbnailStyle, .usesDefaultGradientBackground, Bool, CGSize, SlideTextStyle

### Community 73 - "SlideGridView"
Cohesion: 0.42
Nodes (6): SlideGridView, .body, .thumbnailWidth, CGFloat, Int, Void

### Community 74 - "StickyPreviewEditorLayout"
Cohesion: 0.33
Nodes (5): StickyPreviewEditorLayout, .stickyBackground, CGFloat, Content, Preview

### Community 75 - "content"
Cohesion: 0.25
Nodes (8): content, .body, .body, .body, .body, PlaylistModalScrim, .body, .body

### Community 76 - "LyricRepository"
Cohesion: 0.33
Nodes (5): LyricRepository, FileManager, LyricDocument, URL, UUID

### Community 78 - "BlurredBackgroundLayer"
Cohesion: 0.33
Nodes (8): BlurredBackgroundLayer, .body, BlurredBackgroundModifier, CGFloat, Content, Double, View, View

### Community 79 - "LyricsLibraryPanelView"
Cohesion: 0.10
Nodes (22): LyricGradient, Color, LinearGradient, UInt64, Layout, .trailingControlInset, LyricCardView, .body (+14 more)

### Community 80 - "TransitionSpeedControl"
Cohesion: 0.18
Nodes (10): .defaultTransitionControls, .transitionAssignmentControls, Bool, Double, Int, String, Void, TransitionSpeedControl (+2 more)

### Community 81 - "PlaylistMediaPreview"
Cohesion: 0.36
Nodes (9): PlaylistImagePreview, .body, PlaylistMediaPreview, .body, PlaylistVideoPreview, .body, CGFloat, Image (+1 more)

### Community 83 - "MacWindowConfigurator"
Cohesion: 0.33
Nodes (5): MacWindowConfigurator, Context, NSView, View, NSViewRepresentable

### Community 84 - ".parse"
Cohesion: 0.22
Nodes (6): .parsed, .wordCount, .parsedSampleText, .scopeTargets, Int, Int

### Community 85 - "GlassToolbarIconSize"
Cohesion: 0.33
Nodes (6): GlassToolbarIconSize, .frameSize, .iconFont, prominent, regular, Font

### Community 86 - "AppViewModel.swift"
Cohesion: 0.25
Nodes (5): VideoControlsReveal, Observation, Photos, PhotosUI, UniformTypeIdentifiers

### Community 88 - "CenterPanelView"
Cohesion: 0.18
Nodes (10): CenterPanelView, .presentationToolbar, String, WorkspaceDisplayToolbar, .body, .displayButtonAccessibilityLabel, GlassCapsuleToolbar, .body (+2 more)

### Community 92 - "WorkspaceCompactLayout.swift"
Cohesion: 0.33
Nodes (6): EnvironmentValues, .workspaceCompactLayout, Bool, WorkspaceDevice, .isPad, .isPhone

### Community 93 - "DisplayInfoSheet"
Cohesion: 0.29
Nodes (6): DisplayInfoSheet, .body, .statusDescription, Bool, String, Void

### Community 95 - "LyricImportError"
Cohesion: 0.33
Nodes (6): LocalizedError, LyricImportError, empty, .errorDescription, notText, unsupportedContent

### Community 97 - ".saveLyric"
Cohesion: 0.24
Nodes (7): PickedImageFile, .transferRepresentation, PickedVideoFile, .transferRepresentation, String, Transferable, TransferRepresentation

### Community 98 - "LyrioraApp"
Cohesion: 0.40
Nodes (4): App, LyrioraApp, .body, Scene

## Knowledge Gaps
- **391 isolated node(s):** `Usage`, `What graphify is for`, `Step 0 - GitHub repos and multi-path merge (only if a URL or several paths)`, `Step 1 - Ensure graphify is installed`, `Step 2 - Detect files` (+386 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **3 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AppViewModel` connect `AppViewModel` to `ExternalDisplayManager`, `PresentationPreviewView`, `LibraryPlaylist`, `LyricEditorView`, `LyricTheme`, `SimplePlaySyncDisplayState`, `MediaAsset`, `GlobalStyleEditorContent`, `LyricImportParser`, `SlideDetailEditorView`, `MediaThumbnailView`, `VideoPlaybackController`, `LyricSectionSource`, `LyricSlide`, `PresentationBackgroundLayer`, `Codable`, `PlaylistEditorSheet`, `SettingsRepository`, `PlaylistPickerSheet`, `VideoPlaybackMode`, `MainView`, `Identifiable`, `PresentationLayout`, `PresentationState`, `SlideGridView`, `LyricsLibraryPanelView`, `AppViewModel.swift`, `CenterPanelView`, `.saveLyric`, `LyrioraApp`?**
  _High betweenness centrality (0.199) - this node is a cross-community bridge._
- **Why does `SwiftUI` connect `SwiftUI` to `LyricEditorView`, `LyricTheme`, `SimplePlaySyncDisplayState`, `GlobalStyleEditorContent`, `TextAnimationEditorSection`, `SlideDetailEditorView`, `LyricSlideLivePreview`, `MediaThumbnailView`, `SlideTransitionTextContainer`, `View`, `ExplicitLinePresentationText`, `LyricSlide`, `PresentationBackgroundLayer`, `PlayerLayerView`, `MetalTextEffectRenderer`, `LibraryMorphSearchHeader`, `ProTextSegmentView`, `LyricLanguage`, `TypewriterRevealText`, `VideoPlaybackMode`, `BackgroundFitToolbar`, `MainView`, `Foundation`, `DefaultBackgroundPreset`, `DefaultBackgroundPresetPreview`, `TextAnimationTransform`, `GlassCircleIcon`, `AdaptivePresentationText`, `SlideThumbnailView`, `StickyPreviewEditorLayout`, `BlurredBackgroundLayer`, `LyricsLibraryPanelView`, `TransitionSpeedControl`, `PlaylistMediaPreview`, `MacWindowConfigurator`, `AppViewModel.swift`, `CenterPanelView`, `WorkspaceCompactLayout.swift`, `DisplayInfoSheet`, `LyrioraApp`, `GlassMorphAnimation.swift`?**
  _High betweenness centrality (0.113) - this node is a cross-community bridge._
- **Why does `TextAnimationKind` connect `TextAnimationKind` to `Codable`, `MetalTextEffectRenderer`, `TextAnimationTransform`, `.transitionTransform`, `Equatable`, `Sendable`, `ProTextSegmentView`, `TextAnimationEditorSection`, `TextAnimationTarget`, `Foundation`, `Identifiable`, `SlideAnimationProfile`, `AnimatedPresentationText`?**
  _High betweenness centrality (0.083) - this node is a cross-community bridge._
- **Are the 16 inferred relationships involving `AppViewModel` (e.g. with `.body` and `LyrioraApp`) actually correct?**
  _`AppViewModel` has 16 INFERRED edges - model-reasoned connections that need verification._
- **Are the 12 inferred relationships involving `SlideAnimationProfile` (e.g. with `.body` and `.previewStageContent()`) actually correct?**
  _`SlideAnimationProfile` has 12 INFERRED edges - model-reasoned connections that need verification._
- **What connects `Usage`, `What graphify is for`, `Step 0 - GitHub repos and multi-path merge (only if a URL or several paths)` to the rest of the system?**
  _391 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `ExternalDisplayManager` be split into smaller, more focused modules?**
  _Cohesion score 0.05284831846259437 - nodes in this community are weakly interconnected._