# Graph Report - Lyriora  (2026-08-14)

## Corpus Check
- 130 files · ~67,832 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 2009 nodes · 4440 edges · 113 communities (97 shown, 16 thin omitted)
- Extraction: 92% EXTRACTED · 8% INFERRED · 0% AMBIGUOUS · INFERRED: 357 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `40f7c11e`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- ExternalDisplayManager
- PresentationPreviewView
- UUID
- .configure
- TextAnimationKind
- LyricEditorView
- ThemeMiniPreview
- SimplePlaySyncDisplayState
- What You Must Do When Invoked
- MediaAsset
- GlobalStyleEditorContent
- PresentationFontFamily
- TextAnimationEditorSection
- ParsedSlideText
- LyricImportParser
- LyricPlaySyncServer
- LyricSlideLivePreview
- MediaThumbnailView
- Foundation
- LyricSectionSource
- .resolvedMetrics
- SlideTransitionTextContainer
- MediaAssetKind
- CodingKeys
- .body
- .loadThumbnail
- ExplicitLinePresentationText
- BackgroundContentMode
- LyricSlide
- DefaultBackgroundSettings
- SlideAnimationProfile
- AnimatedPresentationText
- PlayerLayerView
- Sendable
- MetalTextEffectRenderer
- LibraryMorphSearchHeader
- PlaylistEditorSheet
- .transitionTransform
- SwiftUI
- lyricTextFragment
- TextAnimationAssignment
- LibraryPlaylist
- AppViewModel
- View
- LyricLanguage
- LyricEditorSlideCard
- TypewriterRevealText
- LyricSlideTag
- View
- PlaylistPickerSheet
- LyricSlideLayoutEngine
- .measureSingleLine
- PresentationActionsToolbar
- BackgroundFitToolbar
- ExternalDisplaySceneCoordinator
- LyrioraUITests
- CodingKeys
- .refreshDisplayInfo
- LocalFileImageBackground
- Identifiable
- LyricStyleProfile
- SlideDetailEditorView
- ClearerAnchorView
- DefaultBackgroundMeshStyle
- .matches
- .store
- TextAnimationTransform
- GlassPanel.swift
- GlassIconButton
- PresentationTextConfiguration
- AdaptivePresentationText
- GlassCircleIcon
- SlideGridView
- ExternalPresentationContainerViewController
- GlobalStyleEditorView
- DefaultBackgroundPreset
- CodingKeys
- .body
- BlurredBackgroundLayer
- LyricsLibraryPanelView
- TransitionSpeedControl
- PlaylistMediaPreview
- LyricTheme
- MacWindowConfigurator
- .parse
- CodingKeys
- AppViewModel.swift
- ThemeRepository
- .linearGradient
- ThemeSavePromptSheet
- LyricEditorNavigationOption
- AVPlayerViewRepresentable
- WorkspaceCompactLayout.swift
- DisplayInfoSheet
- VideoPlaybackMode
- Equatable
- PlaylistFilterBar
- .saveLyric
- .registerScreenObservers
- LyricEditorLaunch
- LyrioraTests.swift
- Data
- GlassMorphAnimation.swift
- CGSize
- LyricDocument
- Never
- PhotosPickerItem
- Task
- TimeInterval
- URL
- Binding
- Color
- Content

## God Nodes (most connected - your core abstractions)
1. `AppViewModel` - 156 edges
2. `TextAnimationKind` - 75 edges
3. `SlideAnimationProfile` - 60 edges
4. `LyricEditorView` - 54 edges
5. `ExternalDisplayManager` - 50 edges
6. `LyricSlide` - 49 edges
7. `TextAnimationEditorSection` - 46 edges
8. `PresentationTextConfiguration` - 40 edges
9. `GlobalStyleEditorContent` - 36 edges
10. `BackgroundContentMode` - 36 edges

## Surprising Connections (you probably didn't know these)
- `.activeTheme` --references--> `AppViewModel`  [INFERRED]
  Lyriora/Views/Modals/LyricEditorView.swift → Lyriora/ViewModels/AppViewModel.swift
- `.resolvedPlaylist` --references--> `AppViewModel`  [INFERRED]
  Lyriora/Views/Modals/PlaylistSheets.swift → Lyriora/ViewModels/AppViewModel.swift
- `.presentationToolbar` --calls--> `PresentationActionsToolbar`  [INFERRED]
  Lyriora/Views/CenterPanel/CenterPanelView.swift → Lyriora/Views/Components/PresentationActionsToolbar.swift
- `.activeThemeName` --references--> `LyricStyleProfile`  [INFERRED]
  Lyriora/Views/Modals/LyricEditorView.swift → Lyriora/Models/SlideTextStyle.swift
- `.headerRow` --references--> `LyricSlide`  [INFERRED]
  Lyriora/Views/Components/LyricSlideLivePreview.swift → Lyriora/Models/LyricSlide.swift

## Import Cycles
- None detected.

## Communities (113 total, 16 thin omitted)

### Community 0 - "ExternalDisplayManager"
Cohesion: 0.09
Nodes (25): ExternalDisplayInfo, .resolutionDescription, Bool, CGFloat, CGSize, String, ExternalDisplayManager, .displayMonitorInterval (+17 more)

### Community 1 - "PresentationPreviewView"
Cohesion: 0.09
Nodes (25): PresentationState, Bool, Int, SlideTextStyle, String, UUID, PresentationContentView, .body (+17 more)

### Community 2 - "UUID"
Cohesion: 0.19
Nodes (5): PlaylistRepositoryProtocol, LibraryPlaylist, LibraryPlaylistKind, String, UUID

### Community 3 - ".configure"
Cohesion: 0.10
Nodes (28): TimeInterval, UUID, VideoSeekRequest, TimeInterval, Void, VideoProgressReporter, Coordinator, LoopingVideoBackground (+20 more)

### Community 4 - "TextAnimationKind"
Cohesion: 0.04
Nodes (47): Bool, TextAnimationKind, .basicCases, blink, blinkSemiRotate, bounce, chromaticShift, .displayName (+39 more)

### Community 5 - "LyricEditorView"
Cohesion: 0.06
Nodes (35): Binding, Color, Content, LyricEditorNavigationOption, EditorCard, .cardBackground, LyricEditorView, .activeTheme (+27 more)

### Community 6 - "ThemeMiniPreview"
Cohesion: 0.14
Nodes (21): Bool, CGFloat, SlideTextStyle, String, UUID, Void, ThemeGalleryView, .body (+13 more)

### Community 7 - "SimplePlaySyncDisplayState"
Cohesion: 0.11
Nodes (22): .slideGridHeader, SimplePlayConnectionIndicator, .body, SimplePlayConnectionInfoSheet, .body, .manualModeBinding, .state, .statusFooter (+14 more)

### Community 8 - "What You Must Do When Invoked"
Cohesion: 0.08
Nodes (24): For /graphify add and --watch, For /graphify query, For the commit hook and native AGENTS.md integration, For --update and --cluster-only, /graphify, Honesty Rules, Interpreter guard for subcommands, Part A - Structural extraction for code files (+16 more)

### Community 9 - "MediaAsset"
Cohesion: 0.17
Nodes (13): MediaAsset, .listLabel, Date, UUID, MediaRepositoryProtocol, .selectedBackgroundAsset, .selectedVideoItems, importSelectedVideos() (+5 more)

### Community 10 - "GlobalStyleEditorContent"
Cohesion: 0.15
Nodes (15): GlobalStyleEditorContent, .animationProfileBinding, .body, .currentSlide, .lyricDefaultAnimationBinding, .lyricSlides, .previewAnimationProfile, .previewSlideForDisplay (+7 more)

### Community 11 - "PresentationFontFamily"
Cohesion: 0.07
Nodes (31): PresentationFontWeight, bold, .id, .label, medium, regular, semibold, PresentationFontFamily (+23 more)

### Community 12 - "TextAnimationEditorSection"
Cohesion: 0.13
Nodes (18): Binding, Bool, Int, String, Void, TextAnimationEditorSection, .animationResetToolbar, .animationStatusSummary (+10 more)

### Community 13 - "ParsedSlideText"
Cohesion: 0.15
Nodes (10): Int, ParsedSlideText, .isEmpty, .totalWordCount, SlideTextTokenizer, Bool, Int, Range (+2 more)

### Community 14 - "LyricImportParser"
Cohesion: 0.16
Nodes (11): LyricStyleProfile, String, LyricImportParser, LyricImportResult, LyricSectionParseResult, ParsedSections, Bool, Int (+3 more)

### Community 15 - "LyricPlaySyncServer"
Cohesion: 0.11
Nodes (20): LyricPlaySyncServer, LyricPlaySyncTransportError, emptyResponse, .errorDescription, noLyrioraHost, unexpectedResponse, State, failed (+12 more)

### Community 16 - "LyricSlideLivePreview"
Cohesion: 0.10
Nodes (23): LyricPreviewBackgroundStyle, borderOnly, settingsDefault, LyricSlideLivePreview, .body, .compactHeight, .cornerRadius, .displayText (+15 more)

### Community 17 - "MediaThumbnailView"
Cohesion: 0.08
Nodes (29): ImageLibrarySection, .filteredAssets, .isPlaylistFiltered, MediaImportContentTypes, MediaImportToolbarButton, .photoPickerSelection, MediaLibraryPanelView, .body (+21 more)

### Community 18 - "Foundation"
Cohesion: 0.06
Nodes (22): AVPlayerLooper, CoreGraphics, Foundation, LyricRepository, FileManager, LyricDocument, URL, UUID (+14 more)

### Community 19 - "LyricSectionSource"
Cohesion: 0.22
Nodes (6): sourceSections, LyricSectionSource, String, UUID, LyricImportResult, UUID

### Community 20 - ".resolvedMetrics"
Cohesion: 0.19
Nodes (13): ExternalDisplayDiscovery, ExternalDisplayMetrics, Source, liveContainer, liveWindow, sceneCoordinateSpace, screenBounds, Bool (+5 more)

### Community 21 - "SlideTransitionTextContainer"
Cohesion: 0.16
Nodes (17): SlideTransitionTextContainer, .body, .effectiveWordCount, .enterAnimation, .enterDuration, .exitDuration, Animation, Bool (+9 more)

### Community 22 - "MediaAssetKind"
Cohesion: 0.13
Nodes (16): .index, MediaAssetKind, image, video, MediaIndexEntry, MediaRepository, Data, FileManager (+8 more)

### Community 23 - "CodingKeys"
Cohesion: 0.10
Nodes (21): CodingKeys, defaultAnimationProfile, defaultStyle, fontDesign, fontFamily, fontWeight, horizontalPaddingRatio, isAdaptiveScalingEnabled (+13 more)

### Community 24 - ".body"
Cohesion: 0.11
Nodes (28): PlaylistGlassColumn, PlaylistGlassEmptyState, .body, PlaylistGlassNameField, PlaylistGlassRowButton, .body, PlaylistGlassSearchField, PlaylistGlassSectionLabel (+20 more)

### Community 25 - ".loadThumbnail"
Cohesion: 0.15
Nodes (16): AVAssetImageGenerator, Error, Metadata, MetadataError, cancelled, thumbnailFailed, CGImage, CGSize (+8 more)

### Community 26 - "ExplicitLinePresentationText"
Cohesion: 0.13
Nodes (20): EnvironmentKey, .body, .body, EditorAdaptivePresentationText, .body, .lines, .resolvedConfiguration, EditorPreviewSizing (+12 more)

### Community 27 - "BackgroundContentMode"
Cohesion: 0.14
Nodes (16): AppSettings, PresentationTextSettings, Bool, Decoder, Double, BackgroundContentMode, auto, fill (+8 more)

### Community 28 - "LyricSlide"
Cohesion: 0.17
Nodes (11): CGSize, SlideTextStyle, LyricSlide, Int, SlideTextStyle, String, UUID, CGSize (+3 more)

### Community 29 - "DefaultBackgroundSettings"
Cohesion: 0.12
Nodes (24): PresentationBackground, URL, DefaultBackgroundSettings, Double, AppBackgroundAnimation, .transition, AppBackgroundView, .body (+16 more)

### Community 30 - "SlideAnimationProfile"
Cohesion: 0.11
Nodes (16): assignments, SlideAnimationProfile, .hasAnimations, .hasPersistentEffects, .hasTransition, .preferredEffectSelectionTarget, .preferredTransitionSelectionTarget, Encoder (+8 more)

### Community 31 - "AnimatedPresentationText"
Cohesion: 0.21
Nodes (13): AnimatedPresentationText, .animatedBody, .shouldRenderAnimatedContent, .shouldRunEffectTimeline, Bool, CGFloat, CGSize, Double (+5 more)

### Community 32 - "PlayerLayerView"
Cohesion: 0.16
Nodes (14): AnyClass, AVPlayerLayerRepresentable, AVPlayerLayerView, .body, PlayerLayerView, .layerClass, .playerLayer, AVLayerVideoGravity (+6 more)

### Community 33 - "Sendable"
Cohesion: 0.12
Nodes (27): Codable, Data, Decoder, Encoder, JSONEncoder, LinkSectionCommand, LyricPlaySync, LyricPlaySyncCodec (+19 more)

### Community 34 - "MetalTextEffectRenderer"
Cohesion: 0.07
Nodes (35): content, MetalTextEffectParameters, .isActive, MetalTextEffectRenderer, MetalTextEffectSupport, Bool, CGImage, CGSize (+27 more)

### Community 35 - "LibraryMorphSearchHeader"
Cohesion: 0.15
Nodes (15): Layout, LibraryMorphSearchHeader, .body, .collapsedSearchButton, .controlSize, .isSearchActive, .resolvedHorizontalPadding, .searchSlot (+7 more)

### Community 36 - "PlaylistEditorSheet"
Cohesion: 0.18
Nodes (11): PlaylistEditorSheet, .allItemIDs, .availableItems, .availableSearchPlaceholder, .body, .filteredAvailableItems, .resolvedPlaylist, .showsMediaPreview (+3 more)

### Community 37 - ".transitionTransform"
Cohesion: 0.25
Nodes (11): AnimatableModifier, SequentialWordTransitionModifier, .animatableData, .layoutSegmentIndex, .layoutTotalWords, SlideTransitionModifier, .animatableData, Bool (+3 more)

### Community 38 - "SwiftUI"
Cohesion: 0.23
Nodes (6): AppKit, AVFoundation, AVKit, LyricClipboardImporter, SwiftUI, UIKit

### Community 39 - "lyricTextFragment"
Cohesion: 0.13
Nodes (17): constant, float2, float4, fragment, lyricTextFragment(), lyricTextVertex(), TextEffectUniforms, chromaticStrength (+9 more)

### Community 40 - "TextAnimationAssignment"
Cohesion: 0.23
Nodes (11): SlideTransitionState, .showsPersistentEffects, SlideTransitionTiming, Bool, Decoder, Double, TimeInterval, UUID (+3 more)

### Community 41 - "LibraryPlaylist"
Cohesion: 0.12
Nodes (15): LibraryPlaylist, LibraryPlaylistKind, image, lyric, .systemImage, .title, video, Bool (+7 more)

### Community 42 - "AppViewModel"
Cohesion: 0.05
Nodes (38): CGSize, ExternalDisplayManager, LyricRepositoryProtocol, ThemeRepositoryProtocol, AppViewModel, .activePresentationBackground, .hasCustomBackgroundSelected, .hasVideoBackgroundSelected (+30 more)

### Community 43 - "View"
Cohesion: 0.27
Nodes (11): ProTextSegmentView, .body, Bool, CGSize, Color, Double, Font, Int (+3 more)

### Community 44 - "LyricLanguage"
Cohesion: 0.13
Nodes (17): LyricDocument, .previewSnippet, .slides, Date, Decoder, String, UInt64, UUID (+9 more)

### Community 45 - "LyricEditorSlideCard"
Cohesion: 0.22
Nodes (9): LyricEditorSlideCard, .body, .textConfiguration, LyricEditorSlideHorizontalListView, .slidesRefreshID, CGFloat, SlideTextStyle, String (+1 more)

### Community 46 - "TypewriterRevealText"
Cohesion: 0.21
Nodes (14): Bool, Color, Content, Double, Font, Int, String, TypewriterRevealText (+6 more)

### Community 47 - "LyricSlideTag"
Cohesion: 0.11
Nodes (16): LyricSlideTag, bridge, chorus, .displayName, .id, instrumental, intro, outro (+8 more)

### Community 48 - "View"
Cohesion: 0.21
Nodes (7): .body, GlassCapsuleToolbar, .body, GlassControlBorderModifier, Content, View, S

### Community 49 - "PlaylistPickerSheet"
Cohesion: 0.28
Nodes (7): PlaylistPickerSheet, .createPlaylistCard, .filteredPlaylists, .isSearching, .totalItemCount, Bool, Int

### Community 50 - "LyricSlideLayoutEngine"
Cohesion: 0.38
Nodes (6): LyricSlideLayoutEngine, CGFloat, CGSize, Int, SlideTextStyle, String

### Community 51 - ".measureSingleLine"
Cohesion: 0.37
Nodes (7): PresentationTextMeasurer, Any, Bool, CGFloat, CGSize, String, NSAttributedString

### Community 52 - "PresentationActionsToolbar"
Cohesion: 0.22
Nodes (8): Constants, PresentationActionsToolbar, .body, .clearActionsCapsule, .videoControlsCapsule, Bool, CGFloat, Void

### Community 53 - "BackgroundFitToolbar"
Cohesion: 0.20
Nodes (13): BackgroundFitBadgeLabel, .body, BackgroundFitToggleLabel, .body, BackgroundFitToolbar, .body, .expandedOptions, .toggleButton (+5 more)

### Community 54 - "ExternalDisplaySceneCoordinator"
Cohesion: 0.13
Nodes (10): ExternalDisplaySceneCoordinator, UIWindowScene, ExternalDisplaySceneDelegate, UICoordinateSpace, UIInterfaceOrientation, UIResponder, UIScene, UISceneSession (+2 more)

### Community 55 - "LyrioraUITests"
Cohesion: 0.15
Nodes (6): LyrioraUITests, LyrioraUITestsLaunchTests, .runsForEachTargetApplicationUIConfiguration, Bool, XCTest, XCTestCase

### Community 56 - "CodingKeys"
Cohesion: 0.17
Nodes (12): CodingKeys, effectAssignments, effectFallback, effectIntensity, effectSpeed, fallbackAnimation, transitionAssignments, transitionIntensity (+4 more)

### Community 58 - "LocalFileImageBackground"
Cohesion: 0.22
Nodes (10): ResolvedBackgroundContentMode, fill, fit, CGSize, LocalFileImageBackground, .body, .resolvedMode, CGSize (+2 more)

### Community 59 - "Identifiable"
Cohesion: 0.11
Nodes (16): CaseIterable, Identifiable, AnimationApplyScope, allSlides, currentSlide, .id, .label, PresentationFontDesign (+8 more)

### Community 60 - "LyricStyleProfile"
Cohesion: 0.15
Nodes (14): tagStyles, LyricStyleProfile, SlideTextStyle, .fontSize, Bool, Decoder, Double, Encoder (+6 more)

### Community 61 - "SlideDetailEditorView"
Cohesion: 0.06
Nodes (34): PresentationLayout, CGFloat, CGSize, .presentationLayoutCanvasSize, .canvasAspectRatio, .canvasSize, SlideStyleControlsView, .body (+26 more)

### Community 62 - "ClearerAnchorView"
Cohesion: 0.22
Nodes (7): ClearerAnchorView, NavigationSplitViewBackgroundClearer, Context, UIView, UIViewController, View, UIViewRepresentable

### Community 63 - "DefaultBackgroundMeshStyle"
Cohesion: 0.09
Nodes (24): EdgeInsets, ConfigurableDefaultGradientView, .body, .layerIdentity, DefaultBackgroundMeshStyle, .colors, daylightWaves, morningHaze (+16 more)

### Community 64 - ".matches"
Cohesion: 0.38
Nodes (5): LibrarySearch, LyricDocument, .searchableText, Bool, String

### Community 65 - ".store"
Cohesion: 0.26
Nodes (12): Entry, LocalImageCache, CGSize, Image, URL, LocalFileThumbnailImage, .body, LocalFileVideoThumbnail (+4 more)

### Community 66 - "TextAnimationTransform"
Cohesion: 0.29
Nodes (8): Angle, AnimatedTextSegmentModifier, CGFloat, CGSize, TimeInterval, TextAnimationTransform, View, ViewModifier

### Community 67 - "GlassPanel.swift"
Cohesion: 0.17
Nodes (14): GlassControlChrome, GlassPanel, .body, .panelShape, GlassToolbarIconSize, .frameSize, .iconFont, prominent (+6 more)

### Community 68 - "GlassIconButton"
Cohesion: 0.24
Nodes (9): ButtonRole, Action, GlassIconButton, .body, .foregroundColor, GlassToolbarIconStyle, Bool, String (+1 more)

### Community 69 - "PresentationTextConfiguration"
Cohesion: 0.19
Nodes (11): PresentationTextConfiguration, SlideTextStyle, Bool, CGFloat, CGSize, Color, Double, Font (+3 more)

### Community 70 - "AdaptivePresentationText"
Cohesion: 0.29
Nodes (6): AdaptivePresentationText, .lines, Bool, Int, String, UUID

### Community 71 - "GlassCircleIcon"
Cohesion: 0.23
Nodes (9): GlassCircleIcon, .body, .body, Color, ColorScheme, LinearGradient, .expandedSearchField, .body (+1 more)

### Community 72 - "SlideGridView"
Cohesion: 0.18
Nodes (14): SlideGridView, .body, .thumbnailWidth, SlideThumbnailView, .textConfiguration, .thumbnailCanvasSize, .thumbnailStyle, .usesDefaultGradientBackground (+6 more)

### Community 73 - "ExternalPresentationContainerViewController"
Cohesion: 0.21
Nodes (8): ExternalPresentationContainerViewController, AnyView, Bool, CGSize, View, Void, UIHostingController, UIViewController

### Community 74 - "GlobalStyleEditorView"
Cohesion: 0.21
Nodes (8): KeyboardDismissal, GlobalStyleEditorView, .body, .hasStyleChanges, Bool, SlideTextStyle, String, UUID

### Community 75 - "DefaultBackgroundPreset"
Cohesion: 0.17
Nodes (11): DefaultBackgroundPreset, daylightWaves, .id, .isAdaptive, .label, meshWaves, morningHaze, twilightWaves (+3 more)

### Community 76 - "CodingKeys"
Cohesion: 0.18
Nodes (11): CodingKeys, colorSeed, createdAt, id, language, simplePlayProjectID, simplePlayProjectName, storedSlides (+3 more)

### Community 78 - "BlurredBackgroundLayer"
Cohesion: 0.33
Nodes (8): BlurredBackgroundLayer, .body, BlurredBackgroundModifier, CGFloat, Content, Double, View, View

### Community 79 - "LyricsLibraryPanelView"
Cohesion: 0.05
Nodes (39): App, ContentView, .body, LyrioraApp, .body, CenterPanelView, .body, .presentationToolbar (+31 more)

### Community 80 - "TransitionSpeedControl"
Cohesion: 0.20
Nodes (9): .defaultTransitionControls, Bool, Double, Int, String, Void, TransitionSpeedControl, .body (+1 more)

### Community 81 - "PlaylistMediaPreview"
Cohesion: 0.36
Nodes (9): PlaylistImagePreview, .body, PlaylistMediaPreview, .body, PlaylistVideoPreview, .body, CGFloat, Image (+1 more)

### Community 82 - "LyricTheme"
Cohesion: 0.27
Nodes (7): LyricTheme, Date, Int, SlideTextStyle, String, UUID, .previewText

### Community 83 - "MacWindowConfigurator"
Cohesion: 0.39
Nodes (4): MacWindowConfigurator, Context, NSView, View

### Community 84 - ".parse"
Cohesion: 0.40
Nodes (4): .parsed, .wordCount, .parsedSampleText, .scopeTargets

### Community 85 - "CodingKeys"
Cohesion: 0.25
Nodes (8): CodingKey, CodingKeys, linkedSectionID, order, preview, slideID, tag, text

### Community 86 - "AppViewModel.swift"
Cohesion: 0.14
Nodes (13): PhotosPickerDisplayNameResolver, PhotosPickerItem, String, PickedImageFile, .transferRepresentation, PickedVideoFile, .transferRepresentation, VideoControlsReveal (+5 more)

### Community 87 - "ThemeRepository"
Cohesion: 0.36
Nodes (3): FileManager, URL, ThemeRepository

### Community 88 - ".linearGradient"
Cohesion: 0.32
Nodes (5): LyricGradient, Color, LinearGradient, UInt64, .body

### Community 89 - "ThemeSavePromptSheet"
Cohesion: 0.29
Nodes (6): Bool, String, Void, ThemeSavePromptSheet, .body, .trimmedThemeName

### Community 90 - "LyricEditorNavigationOption"
Cohesion: 0.25
Nodes (7): LyricEditorNavigationOption, .id, .systemImage, .title, typography, String, Self

### Community 91 - "AVPlayerViewRepresentable"
Cohesion: 0.43
Nodes (4): AVPlayerView, AVPlayerViewRepresentable, Context, NSViewRepresentable

### Community 92 - "WorkspaceCompactLayout.swift"
Cohesion: 0.33
Nodes (6): EnvironmentValues, .workspaceCompactLayout, Bool, WorkspaceDevice, .isPad, .isPhone

### Community 93 - "DisplayInfoSheet"
Cohesion: 0.29
Nodes (6): DisplayInfoSheet, .body, .statusDescription, Bool, String, Void

### Community 94 - "VideoPlaybackMode"
Cohesion: 0.29
Nodes (6): Bool, VideoPlaybackMode, loop, .loopsVideo, playOnce, .toggled

### Community 95 - "Equatable"
Cohesion: 0.29
Nodes (7): Equatable, LocalizedError, LyricImportError, empty, .errorDescription, notText, unsupportedContent

### Community 96 - "PlaylistFilterBar"
Cohesion: 0.29
Nodes (5): PlaylistFilterBar, .body, .selectedPlaylist, LibraryPlaylist, LibraryPlaylistKind

### Community 97 - ".saveLyric"
Cohesion: 0.16
Nodes (9): LyricDocument, LyricEditorLaunch, LyricRepositoryProtocol, seedSampleLyricsIfNeeded(), LyricLanguage, LyricSectionSource, lyrics, .body (+1 more)

### Community 99 - "LyricEditorLaunch"
Cohesion: 0.67
Nodes (3): Hashable, LyricEditorLaunch, UUID

## Knowledge Gaps
- **400 isolated node(s):** `LyricPlaySync`, `catalogRequest`, `catalogResponse`, `showSlide`, `linkSection` (+395 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **16 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AppViewModel` connect `AppViewModel` to `ExternalDisplayManager`, `PresentationPreviewView`, `UUID`, `LyricEditorView`, `SimplePlaySyncDisplayState`, `MediaAsset`, `GlobalStyleEditorContent`, `LyricImportParser`, `LyricPlaySyncServer`, `MediaThumbnailView`, `Foundation`, `LyricSectionSource`, `Sendable`, `PlaylistEditorSheet`, `LibraryPlaylist`, `View`, `PlaylistPickerSheet`, `.refreshDisplayInfo`, `SlideDetailEditorView`, `SlideGridView`, `GlobalStyleEditorView`, `LyricsLibraryPanelView`, `AppViewModel.swift`, `PlaylistFilterBar`, `.saveLyric`?**
  _High betweenness centrality (0.196) - this node is a cross-community bridge._
- **Why does `SwiftUI` connect `SwiftUI` to `LyricEditorView`, `ThemeMiniPreview`, `SimplePlaySyncDisplayState`, `TextAnimationEditorSection`, `LyricSlideLivePreview`, `MediaThumbnailView`, `Foundation`, `SlideTransitionTextContainer`, `.body`, `ExplicitLinePresentationText`, `DefaultBackgroundSettings`, `AnimatedPresentationText`, `MetalTextEffectRenderer`, `LibraryMorphSearchHeader`, `View`, `LyricLanguage`, `LyricEditorSlideCard`, `TypewriterRevealText`, `PresentationActionsToolbar`, `BackgroundFitToolbar`, `SlideDetailEditorView`, `ClearerAnchorView`, `DefaultBackgroundMeshStyle`, `TextAnimationTransform`, `GlassPanel.swift`, `AdaptivePresentationText`, `SlideGridView`, `GlobalStyleEditorView`, `BlurredBackgroundLayer`, `LyricsLibraryPanelView`, `TransitionSpeedControl`, `PlaylistMediaPreview`, `MacWindowConfigurator`, `AppViewModel.swift`, `.linearGradient`, `ThemeSavePromptSheet`, `LyricEditorNavigationOption`, `WorkspaceCompactLayout.swift`, `DisplayInfoSheet`, `PlaylistFilterBar`, `GlassMorphAnimation.swift`?**
  _High betweenness centrality (0.104) - this node is a cross-community bridge._
- **Why does `TextAnimationKind` connect `TextAnimationKind` to `Sendable`, `MetalTextEffectRenderer`, `TextAnimationTransform`, `.transitionTransform`, `TextAnimationAssignment`, `View`, `TextAnimationEditorSection`, `ParsedSlideText`, `Foundation`, `Identifiable`, `SlideAnimationProfile`, `AnimatedPresentationText`?**
  _High betweenness centrality (0.082) - this node is a cross-community bridge._
- **Are the 16 inferred relationships involving `AppViewModel` (e.g. with `.body` and `LyrioraApp`) actually correct?**
  _`AppViewModel` has 16 INFERRED edges - model-reasoned connections that need verification._
- **Are the 12 inferred relationships involving `SlideAnimationProfile` (e.g. with `.body` and `.previewStageContent()`) actually correct?**
  _`SlideAnimationProfile` has 12 INFERRED edges - model-reasoned connections that need verification._
- **What connects `LyricPlaySync`, `catalogRequest`, `catalogResponse` to the rest of the system?**
  _400 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `ExternalDisplayManager` be split into smaller, more focused modules?**
  _Cohesion score 0.0907563025210084 - nodes in this community are weakly interconnected._