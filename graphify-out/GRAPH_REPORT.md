# Graph Report - Lyriora  (2026-08-28)

## Corpus Check
- 138 files · ~73,292 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 2365 nodes · 5073 edges · 140 communities (117 shown, 23 thin omitted)
- Extraction: 92% EXTRACTED · 8% INFERRED · 0% AMBIGUOUS · INFERRED: 420 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `7f310010`
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
- SlideDetailEditorView
- What You Must Do When Invoked
- MediaAsset
- GlobalStyleEditorContent
- .font
- TextAnimationEditorSection
- ParsedSlideText
- LyricImportParser
- PresentationFontFamily
- LyricSlideLivePreview
- LibraryPlaylistKind
- VideoPlaybackController
- TypewriterRevealText
- .resolvedMetrics
- LyricDocument
- MediaRepository
- CodingKeys
- PlaylistGlassModal.swift
- Image
- ExplicitLinePresentationText
- Identifiable
- LyricSlide
- PresentationBackgroundLayer
- MainView
- AnimatedPresentationText
- BackgroundContentMode
- String
- MetalTextEffectRenderer
- LibraryMorphSearchHeader
- ScaledToFitWidthModifier
- .transitionTransform
- SwiftUI
- lyricTextFragment
- SlideAnimationProfile
- What You Must Do When Invoked
- AppViewModel
- SlideTransitionTextContainer
- YouTubePlaybackController
- LyricLanguage
- GlassIconButton
- LyricSlideTag
- GlassPanel.swift
- PlaylistPickerSheet
- LyricSlideLayoutEngine
- .measureSingleLine
- VideoPlaybackMode
- .selectBackgroundMedia
- ExternalDisplaySceneCoordinator
- LyrioraUITests
- LoopingVideoBackgroundRepresentable
- CodingKeys
- Foundation
- View
- Sendable
- .matches
- LyricPlaySyncServer
- DefaultBackgroundPreset
- DefaultBackgroundPresetPreview
- AdaptivePresentationText
- SlideStyleControlsView
- MediaLibraryPanelView.swift
- SlideGridView
- PresentationTextConfiguration
- LyricSectionSource
- .shadowColor
- PresentationAnimationQuality
- ExternalPresentationContainerViewController
- TextAnimationTarget
- LoopingVideoPlayerView
- GlassCircleIcon
- State
- WordFontSizeOverride
- LyricCardView
- TransitionSpeedControl
- .resolvedSlides
- PlaylistEditorSheet
- MacWindowConfigurator
- DefaultBackgroundMeshStyle
- content
- BlurredBackgroundLayer
- LyricPlaySyncMessageKind
- CenterPanelView
- .refreshDisplayInfo
- ThemeSavePromptSheet
- ExternalDisplayInfo
- WorkspaceCompactLayout.swift
- DisplayInfoSheet
- LyricImportResult
- graphify reference: extra exports and benchmark
- graphify reference: extra exports and benchmark
- LyricRepository
- PlayerLayerView
- CodingKeys
- PresentationFontPickerSheet
- PresentationBackgroundView
- SettingsRepository
- LyricsLibraryPanelView
- .resolved
- LyrioraApp
- .linearGradient
- AppBackgroundAnimation
- graphify reference: query, path, explain
- graphify reference: query, path, explain
- .saveLyric
- .init
- graphify reference: add a URL and watch a folder
- graphify reference: commit hook and native AGENTS.md integration
- graphify reference: incremental update and cluster-only
- graphify reference: add a URL and watch a folder
- graphify reference: commit hook and native CLAUDE.md integration
- graphify reference: incremental update and cluster-only
- Decoder
- Encoder
- graphify reference: GitHub clone and cross-repo merge
- graphify reference: transcribe video and audio
- graphify reference: GitHub clone and cross-repo merge
- graphify reference: transcribe video and audio
- Font
- .agents/skills/graphify/references/extraction-spec.md
- CLAUDE.md
- .claude/CLAUDE.md
- .claude/skills/graphify/references/extraction-spec.md
- NSFont
- UIFont
- Context
- NSView
- GlassMorphAnimation.swift
- LyricDocument
- PhotosPickerItem
- URL
- AVPlayer
- Range
- RoundedRectangle

## God Nodes (most connected - your core abstractions)
1. `AppViewModel` - 165 edges
2. `TextAnimationKind` - 73 edges
3. `LyricEditorView` - 65 edges
4. `LyricSlide` - 56 edges
5. `ExternalDisplayManager` - 50 edges
6. `SlideAnimationProfile` - 50 edges
7. `Image` - 47 edges
8. `TextAnimationEditorSection` - 46 edges
9. `MediaAsset` - 42 edges
10. `PresentationFontFamily` - 40 edges

## Surprising Connections (you probably didn't know these)
- `.headerRow` --references--> `LyricSlide`  [INFERRED]
  Lyriora/Views/Components/LyricSlideLivePreview.swift → Lyriora/Models/LyricSlide.swift
- `.activeTheme` --references--> `AppViewModel`  [INFERRED]
  Lyriora/Views/Modals/LyricEditorView.swift → Lyriora/ViewModels/AppViewModel.swift
- `.resolvedPlaylist` --references--> `AppViewModel`  [INFERRED]
  Lyriora/Views/Modals/PlaylistSheets.swift → Lyriora/ViewModels/AppViewModel.swift
- `.selectedBackgroundAsset` --references--> `MediaAsset`  [INFERRED]
  Lyriora/ViewModels/AppViewModel.swift → Lyriora/Models/MediaAsset.swift
- `.header` --calls--> `Image`  [INFERRED]
  Lyriora/Views/Components/ThemeSavePromptSheet.swift → Lyriora/Views/Components/YouTubeEmbedBackgroundView.swift

## Import Cycles
- None detected.

## Communities (140 total, 23 thin omitted)

### Community 0 - "ExternalDisplayManager"
Cohesion: 0.12
Nodes (18): ExternalDisplayManager, .displayMonitorInterval, .isExternalDisplayConnected, ExternalPresentationWindow, .canBecomeKey, .canBecomeMain, Bool, CGSize (+10 more)

### Community 1 - "PresentationPreviewView"
Cohesion: 0.06
Nodes (45): AVPlayer, ExternalDisplayInfo, PresentationLayout, CGFloat, CGSize, .presentationLayoutCanvasSize, .presentationState, PresentationState (+37 more)

### Community 2 - "LibraryPlaylist"
Cohesion: 0.12
Nodes (14): LibraryPlaylist, LibraryPlaylistKind, LibraryPlaylist, Date, UUID, PlaylistRepository, PlaylistRepositoryProtocol, FileManager (+6 more)

### Community 3 - ".configure"
Cohesion: 0.26
Nodes (11): TimeInterval, Void, VideoProgressReporter, Any, AVPlayer, AVPlayerItem, AVPlayerLayer, Bool (+3 more)

### Community 4 - "TextAnimationKind"
Cohesion: 0.04
Nodes (47): Bool, TextAnimationKind, .basicCases, blink, blinkSemiRotate, bounce, chromaticShift, .displayName (+39 more)

### Community 5 - "LyricEditorView"
Cohesion: 0.05
Nodes (48): LyricEditorNavigationOption, .body, .shape, EditorCard, .cardBackground, LyricEditorLifecycleModifier, .importErrorPresented, LyricEditorView (+40 more)

### Community 6 - "LyricTheme"
Cohesion: 0.08
Nodes (31): LyricTheme, Date, Int, SlideTextStyle, String, UUID, FileManager, URL (+23 more)

### Community 7 - "SlideDetailEditorView"
Cohesion: 0.15
Nodes (17): SlideDetailEditorView, .activeStyle, .animationProfileBinding, .body, .previewAnimationProfile, .resolvedStyleForWordSizing, Binding, Bool (+9 more)

### Community 8 - "What You Must Do When Invoked"
Cohesion: 0.08
Nodes (24): For /graphify add and --watch, For /graphify query, For the commit hook and native AGENTS.md integration, For --update and --cluster-only, /graphify, Honesty Rules, Interpreter guard for subcommands, Part A - Structural extraction for code files (+16 more)

### Community 9 - "MediaAsset"
Cohesion: 0.09
Nodes (27): MediaAsset, .listLabel, Date, UUID, MediaRepositoryProtocol, .isYouTubeLink, importSelectedVideos(), Bool (+19 more)

### Community 10 - "GlobalStyleEditorContent"
Cohesion: 0.07
Nodes (32): AnimationApplyScope, KeyboardDismissal, GlobalStyleEditorContent, .animationProfileBinding, .body, .currentSlide, .lyricDefaultAnimationBinding, .lyricSlides (+24 more)

### Community 11 - ".font"
Cohesion: 0.36
Nodes (5): Font, CGFloat, NSFont, PresentationFontWeight, UIFont

### Community 12 - "TextAnimationEditorSection"
Cohesion: 0.11
Nodes (20): Binding, Bool, Int, String, Void, TextAnimationEditorSection, .activeEffectKind, .activeTransitionKind (+12 more)

### Community 13 - "ParsedSlideText"
Cohesion: 0.11
Nodes (15): Int, ParsedSlideText, .isEmpty, .totalWordCount, SlideTextTokenizer, Bool, Int, Range (+7 more)

### Community 14 - "LyricImportParser"
Cohesion: 0.17
Nodes (11): LyricClipboardImporter, String, LyricImportParser, ParsedSections, Bool, CGSize, Int, SlideTextStyle (+3 more)

### Community 15 - "PresentationFontFamily"
Cohesion: 0.08
Nodes (23): PresentationFontFamily, americanTypewriter, arial, avenirNext, baskerville, courierNew, didot, futura (+15 more)

### Community 16 - "LyricSlideLivePreview"
Cohesion: 0.09
Nodes (28): EditorPreviewSizing, LyricPreviewBackgroundStyle, borderOnly, settingsDefault, LyricSlideLivePreview, .body, .compactCanvasPreview, .compactHeight (+20 more)

### Community 17 - "LibraryPlaylistKind"
Cohesion: 0.12
Nodes (18): LibraryPlaylistKind, image, lyric, .systemImage, .title, video, GlassOverflowMenu, .body (+10 more)

### Community 18 - "VideoPlaybackController"
Cohesion: 0.19
Nodes (10): AVPlayerLooper, Any, AVPlayer, AVPlayerItem, CMTime, NSObjectProtocol, TimeInterval, URL (+2 more)

### Community 19 - "TypewriterRevealText"
Cohesion: 0.21
Nodes (14): Bool, Color, Content, Double, Font, Int, String, TypewriterRevealText (+6 more)

### Community 20 - ".resolvedMetrics"
Cohesion: 0.19
Nodes (13): ExternalDisplayDiscovery, ExternalDisplayMetrics, Source, liveContainer, liveWindow, sceneCoordinateSpace, screenBounds, Bool (+5 more)

### Community 21 - "LyricDocument"
Cohesion: 0.13
Nodes (18): CodingKeys, colorSeed, createdAt, id, language, simplePlayProjectID, simplePlayProjectName, storedSlides (+10 more)

### Community 22 - "MediaRepository"
Cohesion: 0.09
Nodes (25): Error, .index, MediaAssetKind, image, video, MediaIndexEntry, MediaRepository, MediaRepositoryError (+17 more)

### Community 23 - "CodingKeys"
Cohesion: 0.10
Nodes (21): CodingKeys, defaultAnimationProfile, defaultStyle, fontDesign, fontFamily, fontWeight, horizontalPaddingRatio, isAdaptiveScalingEnabled (+13 more)

### Community 24 - "PlaylistGlassModal.swift"
Cohesion: 0.09
Nodes (29): .body, PlaylistGlassColumn, .body, PlaylistGlassEmptyState, .body, PlaylistGlassNameField, .body, PlaylistGlassRowButton (+21 more)

### Community 25 - "Image"
Cohesion: 0.06
Nodes (58): AVAssetImageGenerator, Entry, LocalImageCache, CGSize, URL, Metadata, MetadataError, cancelled (+50 more)

### Community 26 - "ExplicitLinePresentationText"
Cohesion: 0.14
Nodes (19): EnvironmentKey, .body, EditorAdaptivePresentationText, .body, .lines, .resolvedConfiguration, EditorPreviewSizing, exact (+11 more)

### Community 27 - "Identifiable"
Cohesion: 0.09
Nodes (21): ButtonRole, CaseIterable, Hashable, Identifiable, LyricEditorLaunch, PresentationFontDesign, `default`, .id (+13 more)

### Community 28 - "LyricSlide"
Cohesion: 0.10
Nodes (23): Decoder, Encoder, LyricSlideTag, .slides, CodingKeys, animationProfile, id, order (+15 more)

### Community 29 - "PresentationBackgroundLayer"
Cohesion: 0.14
Nodes (18): PresentationBackground, .isYouTube, Bool, String, URL, .body, AppBackgroundView, .layerIdentity (+10 more)

### Community 30 - "MainView"
Cohesion: 0.18
Nodes (10): ContentView, .body, MainView, .adaptiveWorkspace, .iPadPortraitWorkspace, .iPhoneLandscapeWorkspace, .iPhonePortraitPrompt, CGFloat (+2 more)

### Community 31 - "AnimatedPresentationText"
Cohesion: 0.14
Nodes (22): AnimatedPresentationText, .allowsEffectTimelineUpdates, .animatedBody, .proRenderQuality, .shouldRenderAnimatedContent, .shouldRunEffectTimeline, Bool, CGSize (+14 more)

### Community 32 - "BackgroundContentMode"
Cohesion: 0.10
Nodes (24): BackgroundContentMode, auto, fill, fit, .id, .label, landscape, portrait (+16 more)

### Community 33 - "String"
Cohesion: 0.18
Nodes (16): JSONEncoder, LinkSectionCommand, LyricPlaySync, LyricPlaySyncCodec, LyricPlaySyncMessage, LyricSlideCatalog, LyricSlideCatalogItem, .displayText (+8 more)

### Community 34 - "MetalTextEffectRenderer"
Cohesion: 0.05
Nodes (38): MetalTextEffectParameters, .isActive, MetalTextEffectRenderer, MetalTextEffectSupport, Bool, CGImage, CGSize, Double (+30 more)

### Community 35 - "LibraryMorphSearchHeader"
Cohesion: 0.16
Nodes (14): Layout, LibraryMorphSearchHeader, .body, .collapsedSearchButton, .controlSize, .isSearchActive, .resolvedHorizontalPadding, .searchSlot (+6 more)

### Community 36 - "ScaledToFitWidthModifier"
Cohesion: 0.27
Nodes (7): NaturalWidthPreferenceKey, ScaledToFitWidthModifier, .scaleAmount, CGFloat, Content, View, PreferenceKey

### Community 37 - ".transitionTransform"
Cohesion: 0.14
Nodes (21): Angle, AnimatableModifier, AnimatedTextSegmentModifier, SequentialWordTransitionModifier, .animatableData, .layoutSegmentIndex, .layoutTotalWords, SlideTransitionModifier (+13 more)

### Community 38 - "SwiftUI"
Cohesion: 0.21
Nodes (5): AppKit, AVFoundation, AVKit, SwiftUI, UIKit

### Community 39 - "lyricTextFragment"
Cohesion: 0.13
Nodes (17): constant, float2, float4, fragment, lyricTextFragment(), lyricTextVertex(), TextEffectUniforms, chromaticStrength (+9 more)

### Community 40 - "SlideAnimationProfile"
Cohesion: 0.14
Nodes (10): SlideAnimationProfile, .hasAnimations, .hasPersistentEffects, .hasProPersistentEffects, .hasTransition, .preferredEffectSelectionTarget, .preferredTransitionSelectionTarget, Encoder (+2 more)

### Community 41 - "What You Must Do When Invoked"
Cohesion: 0.08
Nodes (24): For /graphify add and --watch, For /graphify query, For the commit hook and native CLAUDE.md integration, For --update and --cluster-only, /graphify, Honesty Rules, Interpreter guard for subcommands, Part A - Structural extraction for code files (+16 more)

### Community 42 - "AppViewModel"
Cohesion: 0.06
Nodes (33): ExternalDisplayManager, LyricRepositoryProtocol, ThemeRepositoryProtocol, AppViewModel, .activePresentationBackground, .hasControllableVideoBackgroundSelected, .hasCustomBackgroundSelected, .hasVideoBackgroundSelected (+25 more)

### Community 43 - "SlideTransitionTextContainer"
Cohesion: 0.14
Nodes (20): SlideTransitionState, .showsPersistentEffects, SlideTransitionTextContainer, .body, .effectiveWordCount, .enterAnimation, .enterDuration, .exitDuration (+12 more)

### Community 44 - "YouTubePlaybackController"
Cohesion: 0.08
Nodes (32): Decodable, OEmbedResponse, String, URL, YouTubeMetadataLoader, TimeInterval, Void, YouTubePlaybackController (+24 more)

### Community 45 - "LyricLanguage"
Cohesion: 0.12
Nodes (16): LyricLanguage, .displayName, english, .id, spanish, unknown, tagStyles, LyricEditorSlideCard (+8 more)

### Community 46 - "GlassIconButton"
Cohesion: 0.25
Nodes (7): .body, GlassIconButton, .body, .foregroundColor, GlassToolbarIconStyle, Bool, Void

### Community 47 - "LyricSlideTag"
Cohesion: 0.12
Nodes (16): LyricSlideTag, bridge, chorus, .displayName, .id, instrumental, intro, outro (+8 more)

### Community 48 - "GlassPanel.swift"
Cohesion: 0.16
Nodes (15): GlassCapsuleToolbar, .body, GlassPanel, .panelShape, GlassToolbarIconSize, .frameSize, .iconFont, prominent (+7 more)

### Community 49 - "PlaylistPickerSheet"
Cohesion: 0.14
Nodes (12): .body, PlaylistPickerSheet, .createPlaylistCard, .filteredPlaylists, .isSearching, .totalItemCount, Bool, Int (+4 more)

### Community 50 - "LyricSlideLayoutEngine"
Cohesion: 0.38
Nodes (6): LyricSlideLayoutEngine, CGFloat, CGSize, Int, SlideTextStyle, String

### Community 51 - ".measureSingleLine"
Cohesion: 0.37
Nodes (7): PresentationTextMeasurer, Any, Bool, CGFloat, CGSize, String, NSAttributedString

### Community 52 - "VideoPlaybackMode"
Cohesion: 0.12
Nodes (14): Bool, VideoPlaybackMode, loop, .loopsVideo, playOnce, .toggled, Constants, PresentationActionsToolbar (+6 more)

### Community 53 - ".selectBackgroundMedia"
Cohesion: 0.17
Nodes (5): LyricPlaySyncMessage, LyricSlideCatalog, .selectedPhotoItems, .selectedVideoItems, Task

### Community 54 - "ExternalDisplaySceneCoordinator"
Cohesion: 0.14
Nodes (10): ExternalDisplaySceneCoordinator, UIWindowScene, ExternalDisplaySceneDelegate, UICoordinateSpace, UIInterfaceOrientation, UIResponder, UIScene, UISceneSession (+2 more)

### Community 55 - "LyrioraUITests"
Cohesion: 0.15
Nodes (6): LyrioraUITests, LyrioraUITestsLaunchTests, .runsForEachTargetApplicationUIConfiguration, Bool, XCTest, XCTestCase

### Community 56 - "LoopingVideoBackgroundRepresentable"
Cohesion: 0.22
Nodes (13): TimeInterval, UUID, VideoSeekRequest, Coordinator, LoopingVideoBackground, .body, LoopingVideoBackgroundRepresentable, AVLayerVideoGravity (+5 more)

### Community 57 - "CodingKeys"
Cohesion: 0.17
Nodes (12): CodingKeys, assignments, effectAssignments, effectFallback, effectIntensity, effectSpeed, fallbackAnimation, transitionAssignments (+4 more)

### Community 58 - "Foundation"
Cohesion: 0.21
Nodes (3): CoreGraphics, Foundation, Observation

### Community 59 - "View"
Cohesion: 0.29
Nodes (11): ProTextSegmentView, .body, Bool, CGSize, Color, Double, Font, Int (+3 more)

### Community 60 - "Sendable"
Cohesion: 0.09
Nodes (34): Codable, Equatable, AppSettings, PresentationFontWeight, bold, .id, .label, medium (+26 more)

### Community 61 - ".matches"
Cohesion: 0.30
Nodes (6): Bool, LibrarySearch, LyricDocument, .searchableText, Bool, String

### Community 62 - "LyricPlaySyncServer"
Cohesion: 0.25
Nodes (8): LyricPlaySyncServer, Date, Error, Void, MessageHandler, NWConnection, NWListener, Result

### Community 63 - "DefaultBackgroundPreset"
Cohesion: 0.12
Nodes (15): DefaultBackgroundMeshView, .body, .style, DefaultBackgroundPreset, daylightWaves, .id, .isAdaptive, .label (+7 more)

### Community 64 - "DefaultBackgroundPresetPreview"
Cohesion: 0.33
Nodes (6): EdgeInsets, DefaultBackgroundPresetPreview, .body, DefaultBackgroundPreviewCard, .body, .defaultBackgroundSection

### Community 65 - "AdaptivePresentationText"
Cohesion: 0.20
Nodes (9): AdaptivePresentationText, .lines, Bool, Int, PresentationAnimationQuality, PresentationTextConfiguration, SlideAnimationProfile, String (+1 more)

### Community 66 - "SlideStyleControlsView"
Cohesion: 0.18
Nodes (14): SlideStyleControlsView, .body, .fontSizeBinding, .horizontalMarginBinding, .layoutControls, .shadowControls, .verticalMarginBinding, .wordSizeSection (+6 more)

### Community 67 - "MediaLibraryPanelView.swift"
Cohesion: 0.09
Nodes (23): PhotosPickerDisplayNameResolver, PhotosPickerItem, String, PickedImageFile, .transferRepresentation, PickedVideoFile, .transferRepresentation, VideoControlsReveal (+15 more)

### Community 68 - "SlideGridView"
Cohesion: 0.06
Nodes (42): SlideGridView, .body, .slideGridHeader, .thumbnailWidth, SlideThumbnailView, .textConfiguration, .thumbnailCanvasSize, .thumbnailStyle (+34 more)

### Community 69 - "PresentationTextConfiguration"
Cohesion: 0.19
Nodes (11): PresentationTextConfiguration, SlideTextStyle, Bool, CGFloat, CGSize, Color, Double, Font (+3 more)

### Community 70 - "LyricSectionSource"
Cohesion: 0.20
Nodes (6): sourceSections, LyricSectionSource, String, UUID, LyricImportResult, UUID

### Community 71 - ".shadowColor"
Cohesion: 0.22
Nodes (9): GlassControlChrome, Color, ColorScheme, LinearGradient, .expandedSearchField, .themeNameField, .body, PlaylistGlassSearchField (+1 more)

### Community 72 - "PresentationAnimationQuality"
Cohesion: 0.22
Nodes (8): PresentationAnimationQuality, .effectFrameInterval, live, preview, ProTextRenderQuality, live, preview, TimeInterval

### Community 73 - "ExternalPresentationContainerViewController"
Cohesion: 0.21
Nodes (8): ExternalPresentationContainerViewController, AnyView, Bool, CGSize, View, Void, UIHostingController, UIViewController

### Community 74 - "TextAnimationTarget"
Cohesion: 0.13
Nodes (20): AnimationApplyScope, allSlides, currentSlide, .id, .label, SlideTransitionTiming, Bool, Decoder (+12 more)

### Community 75 - "LoopingVideoPlayerView"
Cohesion: 0.18
Nodes (6): LoopingVideoPlayerView, CGRect, Context, NSCoder, NSRect, UIView

### Community 76 - "GlassCircleIcon"
Cohesion: 0.27
Nodes (7): GlassCircleIcon, .body, GlassControlBorderModifier, .body, String, View, S

### Community 77 - "State"
Cohesion: 0.15
Nodes (12): LyricPlaySyncTransportError, emptyResponse, .errorDescription, noLyrioraHost, unexpectedResponse, State, failed, ready (+4 more)

### Community 78 - "WordFontSizeOverride"
Cohesion: 0.35
Nodes (6): CGFloat, Double, Int, UUID, WordFontSizeOverride, WordFontSizeResolver

### Community 79 - "LyricCardView"
Cohesion: 0.22
Nodes (10): Layout, .trailingControlInset, LyricCardView, .footerShape, .overflowActions, Bool, CGFloat, String (+2 more)

### Community 80 - "TransitionSpeedControl"
Cohesion: 0.20
Nodes (9): .defaultTransitionControls, Bool, Double, Int, String, Void, TransitionSpeedControl, .body (+1 more)

### Community 81 - ".resolvedSlides"
Cohesion: 0.33
Nodes (4): CGSize, SlideTextStyle, LyricSlideMetadataPreservation, String

### Community 82 - "PlaylistEditorSheet"
Cohesion: 0.18
Nodes (11): PlaylistEditorSheet, .allItemIDs, .availableItems, .availableSearchPlaceholder, .body, .filteredAvailableItems, .resolvedPlaylist, .showsMediaPreview (+3 more)

### Community 83 - "MacWindowConfigurator"
Cohesion: 0.36
Nodes (5): Context, MacWindowConfigurator, Bool, View, NSView

### Community 84 - "DefaultBackgroundMeshStyle"
Cohesion: 0.22
Nodes (10): DefaultBackgroundMeshStyle, .colors, daylightWaves, morningHaze, twilightWaves, violetDusk, .wavePoints, Color (+2 more)

### Community 85 - "content"
Cohesion: 0.20
Nodes (9): content, .body, StickyPreviewEditorLayout, .body, .stickyBackground, CGFloat, Content, .body (+1 more)

### Community 86 - "BlurredBackgroundLayer"
Cohesion: 0.33
Nodes (8): BlurredBackgroundLayer, .body, BlurredBackgroundModifier, CGFloat, Content, Double, View, View

### Community 87 - "LyricPlaySyncMessageKind"
Cohesion: 0.22
Nodes (9): LyricPlaySyncMessageKind, catalogRequest, catalogResponse, error, linkSection, linkSectionAck, presence, presenceAck (+1 more)

### Community 88 - "CenterPanelView"
Cohesion: 0.25
Nodes (8): CenterPanelView, .presentationToolbar, String, WorkspaceDisplayToolbar, .displayButtonAccessibilityLabel, .iPadPortraitDetailWorkspace, .iPhoneLandscapeDetailWorkspace, .landscapeWorkspace

### Community 89 - ".refreshDisplayInfo"
Cohesion: 0.26
Nodes (3): Int, Task, UIWindowScene

### Community 90 - "ThemeSavePromptSheet"
Cohesion: 0.25
Nodes (6): Bool, String, Void, ThemeSavePromptSheet, .header, .trimmedThemeName

### Community 91 - "ExternalDisplayInfo"
Cohesion: 0.33
Nodes (6): ExternalDisplayInfo, .resolutionDescription, Bool, CGFloat, CGSize, String

### Community 92 - "WorkspaceCompactLayout.swift"
Cohesion: 0.33
Nodes (6): EnvironmentValues, .workspaceCompactLayout, Bool, WorkspaceDevice, .isPad, .isPhone

### Community 93 - "DisplayInfoSheet"
Cohesion: 0.29
Nodes (6): DisplayInfoSheet, .body, .statusDescription, Bool, String, Void

### Community 94 - "LyricImportResult"
Cohesion: 0.14
Nodes (11): LocalizedError, Lyriora, LyricImportError, empty, .errorDescription, notText, unsupportedContent, LyricImportResult (+3 more)

### Community 95 - "graphify reference: extra exports and benchmark"
Cohesion: 0.22
Nodes (8): graphify reference: extra exports and benchmark, Step 6b - Wiki (only if --wiki flag), Step 7 - Neo4j export (only if --neo4j or --neo4j-push flag), Step 7a - FalkorDB export (only if --falkordb or --falkordb-push flag), Step 7b - SVG export (only if --svg flag), Step 7c - GraphML export (only if --graphml flag), Step 7d - MCP server (only if --mcp flag), Step 8 - Token reduction benchmark (only if total_words > 5000)

### Community 96 - "graphify reference: extra exports and benchmark"
Cohesion: 0.22
Nodes (8): graphify reference: extra exports and benchmark, Step 6b - Wiki (only if --wiki flag), Step 7 - Neo4j export (only if --neo4j or --neo4j-push flag), Step 7a - FalkorDB export (only if --falkordb or --falkordb-push flag), Step 7b - SVG export (only if --svg flag), Step 7c - GraphML export (only if --graphml flag), Step 7d - MCP server (only if --mcp flag), Step 8 - Token reduction benchmark (only if total_words > 5000)

### Community 97 - "LyricRepository"
Cohesion: 0.29
Nodes (5): LyricRepository, FileManager, LyricDocument, URL, UUID

### Community 98 - "PlayerLayerView"
Cohesion: 0.16
Nodes (15): AnyClass, AVPlayerView, AVPlayerLayerRepresentable, AVPlayerLayerView, .body, AVPlayerViewRepresentable, PlayerLayerView, .layerClass (+7 more)

### Community 99 - "CodingKeys"
Cohesion: 0.25
Nodes (8): CodingKey, CodingKeys, linkedSectionID, order, preview, slideID, tag, text

### Community 100 - "PresentationFontPickerSheet"
Cohesion: 0.32
Nodes (6): PresentationFontPicker, .body, PresentationFontPickerMetrics, PresentationFontPickerSheet, .body, CGFloat

### Community 101 - "PresentationBackgroundView"
Cohesion: 0.19
Nodes (13): ConfigurableDefaultGradientView, .body, .layerIdentity, .body, .transition, .body, .body, PresentationBackgroundView (+5 more)

### Community 102 - "SettingsRepository"
Cohesion: 0.32
Nodes (4): SettingsRepository, SettingsRepositoryProtocol, FileManager, URL

### Community 103 - "LyricsLibraryPanelView"
Cohesion: 0.33
Nodes (7): LyricsLibraryPanelView, .deleteAlertBinding, .filteredLyrics, .isPlaylistFiltered, .isSearching, Binding, LyricDocument

### Community 104 - ".resolved"
Cohesion: 0.29
Nodes (6): ResolvedBackgroundContentMode, fill, fit, CGSize, .resolvedMode, .resolvedContentMode

### Community 105 - "LyrioraApp"
Cohesion: 0.40
Nodes (4): App, LyrioraApp, .body, Scene

### Community 106 - ".linearGradient"
Cohesion: 0.32
Nodes (5): LyricGradient, Color, LinearGradient, UInt64, .body

### Community 107 - "AppBackgroundAnimation"
Cohesion: 0.67
Nodes (3): AppBackgroundAnimation, Animation, Double

### Community 108 - "graphify reference: query, path, explain"
Cohesion: 0.33
Nodes (5): For /graphify explain, For /graphify path, graphify reference: query, path, explain, Step 0 — Constrained query expansion (REQUIRED before traversal), Step 1 — Traversal

### Community 109 - "graphify reference: query, path, explain"
Cohesion: 0.33
Nodes (5): For /graphify explain, For /graphify path, graphify reference: query, path, explain, Step 0 — Constrained query expansion (REQUIRED before traversal), Step 1 — Traversal

### Community 110 - ".saveLyric"
Cohesion: 0.14
Nodes (10): LinkSectionCommand, LyricDocument, LyricEditorLaunch, LyricRepositoryProtocol, seedSampleLyricsIfNeeded(), LyricLanguage, LyricSectionSource, lyrics (+2 more)

### Community 112 - "graphify reference: add a URL and watch a folder"
Cohesion: 0.50
Nodes (3): For /graphify add, For --watch, graphify reference: add a URL and watch a folder

### Community 113 - "graphify reference: commit hook and native AGENTS.md integration"
Cohesion: 0.50
Nodes (3): For git commit hook, For native AGENTS.md integration, graphify reference: commit hook and native AGENTS.md integration

### Community 114 - "graphify reference: incremental update and cluster-only"
Cohesion: 0.50
Nodes (3): For --cluster-only, For --update (incremental re-extraction), graphify reference: incremental update and cluster-only

### Community 115 - "graphify reference: add a URL and watch a folder"
Cohesion: 0.50
Nodes (3): For /graphify add, For --watch, graphify reference: add a URL and watch a folder

### Community 116 - "graphify reference: commit hook and native CLAUDE.md integration"
Cohesion: 0.50
Nodes (3): For git commit hook, For native CLAUDE.md integration, graphify reference: commit hook and native CLAUDE.md integration

### Community 117 - "graphify reference: incremental update and cluster-only"
Cohesion: 0.50
Nodes (3): For --cluster-only, For --update (incremental re-extraction), graphify reference: incremental update and cluster-only

## Knowledge Gaps
- **504 isolated node(s):** `id`, `order`, `text`, `tag`, `style` (+499 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **23 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AppViewModel` connect `AppViewModel` to `ExternalDisplayManager`, `PresentationPreviewView`, `LibraryPlaylist`, `LyricEditorView`, `MediaAsset`, `GlobalStyleEditorContent`, `LyricImportParser`, `LibraryPlaylistKind`, `LyricSlide`, `MainView`, `GlassIconButton`, `PlaylistPickerSheet`, `.selectBackgroundMedia`, `LyricPlaySyncServer`, `MediaLibraryPanelView.swift`, `SlideGridView`, `LyricSectionSource`, `PlaylistEditorSheet`, `CenterPanelView`, `.refreshDisplayInfo`, `LyricsLibraryPanelView`, `LyrioraApp`, `.saveLyric`?**
  _High betweenness centrality (0.189) - this node is a cross-community bridge._
- **Why does `SwiftUI` connect `SwiftUI` to `GlassMorphAnimation.swift`, `LyricTheme`, `LyricEditorView`, `SlideDetailEditorView`, `GlobalStyleEditorContent`, `TextAnimationEditorSection`, `LyricSlideLivePreview`, `TypewriterRevealText`, `PlaylistGlassModal.swift`, `Image`, `ExplicitLinePresentationText`, `Identifiable`, `LyricSlide`, `PresentationBackgroundLayer`, `MainView`, `BackgroundContentMode`, `MetalTextEffectRenderer`, `LibraryMorphSearchHeader`, `ScaledToFitWidthModifier`, `.transitionTransform`, `SlideTransitionTextContainer`, `YouTubePlaybackController`, `LyricLanguage`, `GlassPanel.swift`, `VideoPlaybackMode`, `Foundation`, `DefaultBackgroundPreset`, `DefaultBackgroundPresetPreview`, `AdaptivePresentationText`, `SlideStyleControlsView`, `MediaLibraryPanelView.swift`, `SlideGridView`, `LyricCardView`, `TransitionSpeedControl`, `MacWindowConfigurator`, `content`, `BlurredBackgroundLayer`, `CenterPanelView`, `ThemeSavePromptSheet`, `WorkspaceCompactLayout.swift`, `DisplayInfoSheet`, `PresentationFontPickerSheet`, `LyrioraApp`, `.linearGradient`?**
  _High betweenness centrality (0.084) - this node is a cross-community bridge._
- **Why does `LyricSlide` connect `LyricSlide` to `PresentationPreviewView`, `LyricEditorView`, `SlideDetailEditorView`, `GlobalStyleEditorContent`, `LyricImportParser`, `LyricSlideLivePreview`, `LyricDocument`, `MediaRepository`, `Identifiable`, `PresentationBackgroundLayer`, `SlideAnimationProfile`, `AppViewModel`, `LyricLanguage`, `LyricSlideLayoutEngine`, `.selectBackgroundMedia`, `Foundation`, `Sendable`, `SlideGridView`, `LyricSectionSource`, `WordFontSizeOverride`, `.resolvedSlides`, `LyricImportResult`, `.saveLyric`?**
  _High betweenness centrality (0.068) - this node is a cross-community bridge._
- **Are the 15 inferred relationships involving `AppViewModel` (e.g. with `.body` and `LyrioraApp`) actually correct?**
  _`AppViewModel` has 15 INFERRED edges - model-reasoned connections that need verification._
- **Are the 2 inferred relationships involving `LyricEditorView` (e.g. with `.body` and `.body`) actually correct?**
  _`LyricEditorView` has 2 INFERRED edges - model-reasoned connections that need verification._
- **What connects `id`, `order`, `text` to the rest of the system?**
  _504 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `ExternalDisplayManager` be split into smaller, more focused modules?**
  _Cohesion score 0.11724137931034483 - nodes in this community are weakly interconnected._