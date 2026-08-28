# Graph Report - Lyriora  (2026-08-28)

## Corpus Check
- 138 files · ~73,292 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 2277 nodes · 5058 edges · 134 communities (120 shown, 14 thin omitted)
- Extraction: 92% EXTRACTED · 8% INFERRED · 0% AMBIGUOUS · INFERRED: 406 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `0f886e7f`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- ExternalDisplayManager
- PresentationPreviewView
- LibraryPlaylist
- .configure
- TextAnimationKind
- LyricEditorView
- ThemeMiniPreview
- SlideDetailEditorView
- What You Must Do When Invoked
- MediaAsset
- GlobalStyleEditorContent
- PresentationFontWeight
- TextAnimationEditorSection
- ParsedSlideText
- LyricImportParser
- PresentationFontFamily
- LyricSlideLivePreview
- MediaThumbnailView
- VideoPlaybackController
- TypewriterRevealText
- .resolvedMetrics
- LyricDocument
- MediaAssetKind
- CodingKeys
- PlaylistGlassModal.swift
- Image
- ExplicitLinePresentationText
- TextAnimationAssignment
- LyricSlide
- PresentationBackground
- LyricsLibraryPanelView
- AnimatedPresentationText
- BackgroundFitToolbar
- Codable
- MetalTextEffectRepresentable
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
- Sendable
- GlassIconButton
- LyricSlideTag
- GlassPanel.swift
- GlobalStyleEditorView
- LyricSlideLayoutEngine
- .measureSingleLine
- PresentationActionsToolbar
- LyricEditorHeaderBar
- ExternalDisplaySceneCoordinator
- LyrioraUITests
- BackgroundContentMode
- CodingKeys
- Foundation
- View
- SlideTextStyle
- .matches
- PresentationLayout
- DefaultBackgroundPreset
- DefaultBackgroundPresetPreview
- AdaptivePresentationText
- WordFontSizeOverride
- PickedImageFile
- SlideGridView
- PresentationTextConfiguration
- LyricSectionSource
- .shadowColor
- PresentationAnimationQuality
- ExternalPresentationContainerViewController
- Int
- LyricTheme
- View
- PresentationVideoControls
- PresentationState
- .displayName
- TransitionSpeedControl
- LyricEditorNavigationOption
- PlaylistEditorSheet
- MacWindowConfigurator
- DefaultBackgroundMeshStyle
- StickyPreviewEditorLayout
- content
- ThemeRepository
- MetalTextEffectRenderer
- .refreshDisplayInfo
- ThemeSavePromptSheet
- ExternalDisplayInfo
- WorkspaceCompactLayout.swift
- DisplayInfoSheet
- LyrioraTests.swift
- graphify reference: extra exports and benchmark
- graphify reference: extra exports and benchmark
- LyricRepository
- PlayerLayerView
- ClearerAnchorView
- .loadThumbnail
- PresentationBackgroundView
- SettingsRepository
- .transform
- AVPlayerLayerView
- PlaylistMediaPreview
- .linearGradient
- AVPlayerViewRepresentable
- graphify reference: query, path, explain
- graphify reference: query, path, explain
- LyricEditorLaunch
- VideoPlaybackMode
- graphify reference: add a URL and watch a folder
- graphify reference: commit hook and native AGENTS.md integration
- graphify reference: incremental update and cluster-only
- graphify reference: add a URL and watch a folder
- graphify reference: commit hook and native CLAUDE.md integration
- graphify reference: incremental update and cluster-only
- TextAnimationTarget
- .registerScreenObservers
- graphify reference: GitHub clone and cross-repo merge
- graphify reference: transcribe video and audio
- graphify reference: GitHub clone and cross-repo merge
- graphify reference: transcribe video and audio
- AppViewModel.swift
- .agents/skills/graphify/references/extraction-spec.md
- CLAUDE.md
- .claude/CLAUDE.md
- .claude/skills/graphify/references/extraction-spec.md
- MetalTextEffectRenderer.swift
- .body
- .body
- GlassMorphAnimation.swift
- .dismissIfNeeded

## God Nodes (most connected - your core abstractions)
1. `AppViewModel` - 166 edges
2. `TextAnimationKind` - 75 edges
3. `LyricEditorView` - 65 edges
4. `SlideAnimationProfile` - 62 edges
5. `LyricSlide` - 56 edges
6. `MediaAsset` - 54 edges
7. `ExternalDisplayManager` - 51 edges
8. `Image` - 47 edges
9. `TextAnimationEditorSection` - 46 edges
10. `PresentationTextConfiguration` - 41 edges

## Surprising Connections (you probably didn't know these)
- `.body` --calls--> `content`  [INFERRED]
  Lyriora/Views/Components/GlassPanel.swift → Lyriora/Models/LyricDocument.swift
- `.body` --calls--> `content`  [INFERRED]
  Lyriora/Views/Components/GlassPanel.swift → Lyriora/Models/LyricDocument.swift
- `.body` --calls--> `content`  [INFERRED]
  Lyriora/Views/Components/StickyPreviewEditorLayout.swift → Lyriora/Models/LyricDocument.swift
- `.body` --calls--> `content`  [INFERRED]
  Lyriora/Views/Modals/PlaylistGlassModal.swift → Lyriora/Models/LyricDocument.swift
- `.headerRow` --references--> `LyricSlide`  [INFERRED]
  Lyriora/Views/Components/LyricSlideLivePreview.swift → Lyriora/Models/LyricSlide.swift

## Import Cycles
- None detected.

## Communities (134 total, 14 thin omitted)

### Community 0 - "ExternalDisplayManager"
Cohesion: 0.12
Nodes (19): ExternalDisplayManager, .displayMonitorInterval, .isExternalDisplayConnected, ExternalPresentationWindow, .canBecomeKey, .canBecomeMain, Bool, CGSize (+11 more)

### Community 1 - "PresentationPreviewView"
Cohesion: 0.16
Nodes (15): PresentationContentView, .body, .textConfiguration, PresentationPreviewView, .isVideoBackground, .previewMetadataBar, .previewStage, .showsSlidePlaceholder (+7 more)

### Community 2 - "LibraryPlaylist"
Cohesion: 0.07
Nodes (28): LibraryPlaylist, LibraryPlaylistKind, image, lyric, .systemImage, .title, video, Date (+20 more)

### Community 3 - ".configure"
Cohesion: 0.11
Nodes (29): TimeInterval, UUID, VideoSeekRequest, TimeInterval, Void, VideoProgressReporter, Coordinator, LoopingVideoBackground (+21 more)

### Community 4 - "TextAnimationKind"
Cohesion: 0.04
Nodes (47): Bool, TextAnimationKind, .basicCases, blink, blinkSemiRotate, bounce, chromaticShift, .displayName (+39 more)

### Community 5 - "LyricEditorView"
Cohesion: 0.05
Nodes (41): EditorCard, .cardBackground, LyricEditorLifecycleModifier, .importErrorPresented, LyricEditorView, .activeTheme, .activeThemeName, .body (+33 more)

### Community 6 - "ThemeMiniPreview"
Cohesion: 0.14
Nodes (21): Bool, CGFloat, SlideTextStyle, String, UUID, Void, ThemeGalleryView, .body (+13 more)

### Community 7 - "SlideDetailEditorView"
Cohesion: 0.06
Nodes (38): LocalizedError, LyricImportError, empty, .errorDescription, notText, unsupportedContent, LyricPlaySyncServer, LyricPlaySyncTransportError (+30 more)

### Community 8 - "What You Must Do When Invoked"
Cohesion: 0.08
Nodes (24): For /graphify add and --watch, For /graphify query, For the commit hook and native AGENTS.md integration, For --update and --cluster-only, /graphify, Honesty Rules, Interpreter guard for subcommands, Part A - Structural extraction for code files (+16 more)

### Community 9 - "MediaAsset"
Cohesion: 0.10
Nodes (20): MediaAsset, .listLabel, Date, UUID, MediaRepositoryProtocol, .isYouTubeLink, .activePresentationBackground, .selectedBackgroundAsset (+12 more)

### Community 10 - "GlobalStyleEditorContent"
Cohesion: 0.14
Nodes (17): GlobalStyleEditorContent, .animationProfileBinding, .body, .currentSlide, .lyricDefaultAnimationBinding, .lyricSlides, .previewAnimationProfile, .previewSlideForDisplay (+9 more)

### Community 11 - "PresentationFontWeight"
Cohesion: 0.13
Nodes (15): PresentationFontWeight, bold, .id, .label, medium, regular, semibold, CGFloat (+7 more)

### Community 12 - "TextAnimationEditorSection"
Cohesion: 0.12
Nodes (19): Binding, Bool, Int, String, Void, TextAnimationEditorSection, .activeTransitionKind, .animationResetToolbar (+11 more)

### Community 13 - "ParsedSlideText"
Cohesion: 0.12
Nodes (14): ParsedSlideText, .isEmpty, .totalWordCount, SlideTextTokenizer, Bool, Int, Range, String (+6 more)

### Community 14 - "LyricImportParser"
Cohesion: 0.18
Nodes (9): String, LyricImportParser, LyricImportResult, LyricSectionParseResult, ParsedSections, Bool, Int, String (+1 more)

### Community 15 - "PresentationFontFamily"
Cohesion: 0.08
Nodes (29): PresentationFontFamily, americanTypewriter, arial, avenirNext, baskerville, courierNew, didot, futura (+21 more)

### Community 16 - "LyricSlideLivePreview"
Cohesion: 0.10
Nodes (24): LyricPreviewBackgroundStyle, borderOnly, settingsDefault, LyricSlideLivePreview, .body, .compactCanvasPreview, .compactHeight, .cornerRadius (+16 more)

### Community 17 - "MediaThumbnailView"
Cohesion: 0.09
Nodes (31): GlassOverflowMenu, ClipboardLinkReader, .string, ImageLibrarySection, .isPlaylistFiltered, LocalFileThumbnailImage, LocalFileVideoThumbnail, MediaImportContentTypes (+23 more)

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

### Community 22 - "MediaAssetKind"
Cohesion: 0.08
Nodes (27): Error, .index, MediaAssetKind, image, video, MediaIndexEntry, MediaRepository, MediaRepositoryError (+19 more)

### Community 23 - "CodingKeys"
Cohesion: 0.05
Nodes (39): CodingKey, CodingKeys, animationProfile, id, order, simplePlaySectionID, sourceSectionID, style (+31 more)

### Community 24 - "PlaylistGlassModal.swift"
Cohesion: 0.09
Nodes (31): .body, PlaylistGlassColumn, .body, PlaylistGlassEmptyState, .body, PlaylistGlassNameField, .body, PlaylistGlassRowButton (+23 more)

### Community 25 - "Image"
Cohesion: 0.22
Nodes (16): Entry, LocalImageCache, CGSize, URL, .body, LocalFileImageBackground, .body, CGSize (+8 more)

### Community 26 - "ExplicitLinePresentationText"
Cohesion: 0.13
Nodes (20): EnvironmentKey, .body, EditorAdaptivePresentationText, .body, .lines, .resolvedConfiguration, EditorPreviewSizing, exact (+12 more)

### Community 27 - "TextAnimationAssignment"
Cohesion: 0.11
Nodes (17): CaseIterable, Identifiable, AnimationApplyScope, allSlides, currentSlide, .id, .label, UUID (+9 more)

### Community 28 - "LyricSlide"
Cohesion: 0.11
Nodes (17): .slides, CGSize, SlideTextStyle, LyricSlide, Decoder, Encoder, Int, SlideTextStyle (+9 more)

### Community 29 - "PresentationBackground"
Cohesion: 0.12
Nodes (20): PresentationBackground, .isYouTube, Bool, String, URL, .body, AppBackgroundAnimation, AppBackgroundView (+12 more)

### Community 30 - "LyricsLibraryPanelView"
Cohesion: 0.06
Nodes (38): App, ContentView, .body, LyrioraApp, .body, CenterPanelView, String, WorkspaceDisplayToolbar (+30 more)

### Community 31 - "AnimatedPresentationText"
Cohesion: 0.22
Nodes (13): AnimatedPresentationText, .allowsEffectTimelineUpdates, .animatedBody, .proRenderQuality, .shouldRenderAnimatedContent, .shouldRunEffectTimeline, CGSize, Double (+5 more)

### Community 32 - "BackgroundFitToolbar"
Cohesion: 0.20
Nodes (13): BackgroundFitBadgeLabel, .body, BackgroundFitToggleLabel, .body, BackgroundFitToolbar, .body, .expandedOptions, .toggleButton (+5 more)

### Community 33 - "Codable"
Cohesion: 0.11
Nodes (26): Codable, JSONEncoder, LinkSectionCommand, LyricPlaySync, LyricPlaySyncCodec, LyricPlaySyncMessage, LyricPlaySyncMessageKind, catalogRequest (+18 more)

### Community 34 - "MetalTextEffectRepresentable"
Cohesion: 0.17
Nodes (14): MetalTextEffectParameters, .isActive, CGImage, Double, Float, TimeInterval, TextEffectUniformsMetal, ContainerView (+6 more)

### Community 35 - "LibraryMorphSearchHeader"
Cohesion: 0.13
Nodes (20): LyricDocument, GlassCircleIcon, .body, Layout, LibraryMorphSearchHeader, .body, .collapsedSearchButton, .controlSize (+12 more)

### Community 36 - "ScaledToFitWidthModifier"
Cohesion: 0.26
Nodes (8): NaturalWidthPreferenceKey, ScaledToFitWidthModifier, .scaleAmount, Bool, CGFloat, Content, View, PreferenceKey

### Community 37 - ".transitionTransform"
Cohesion: 0.25
Nodes (11): AnimatableModifier, SequentialWordTransitionModifier, .animatableData, .layoutSegmentIndex, .layoutTotalWords, SlideTransitionModifier, .animatableData, Bool (+3 more)

### Community 38 - "SwiftUI"
Cohesion: 0.23
Nodes (5): AppKit, AVFoundation, LyricClipboardImporter, SwiftUI, UIKit

### Community 39 - "lyricTextFragment"
Cohesion: 0.13
Nodes (17): constant, float2, float4, fragment, lyricTextFragment(), lyricTextVertex(), TextEffectUniforms, chromaticStrength (+9 more)

### Community 40 - "SlideAnimationProfile"
Cohesion: 0.11
Nodes (12): assignments, SlideAnimationProfile, .hasAnimations, .hasPersistentEffects, .hasProPersistentEffects, .hasTransition, .preferredEffectSelectionTarget, .preferredTransitionSelectionTarget (+4 more)

### Community 41 - "What You Must Do When Invoked"
Cohesion: 0.08
Nodes (24): For /graphify add and --watch, For /graphify query, For the commit hook and native CLAUDE.md integration, For --update and --cluster-only, /graphify, Honesty Rules, Interpreter guard for subcommands, Part A - Structural extraction for code files (+16 more)

### Community 42 - "AppViewModel"
Cohesion: 0.06
Nodes (28): LyricRepositoryProtocol, SettingsRepositoryProtocol, AppViewModel, .hasControllableVideoBackgroundSelected, .hasCustomBackgroundSelected, .hasVideoBackgroundSelected, .hasYouTubeBackgroundSelected, .isSimplePlayConnected (+20 more)

### Community 43 - "SlideTransitionTextContainer"
Cohesion: 0.16
Nodes (17): SlideTransitionTextContainer, .body, .effectiveWordCount, .enterAnimation, .enterDuration, .exitDuration, Animation, Bool (+9 more)

### Community 44 - "YouTubePlaybackController"
Cohesion: 0.08
Nodes (32): Decodable, OEmbedResponse, String, URL, YouTubeMetadataLoader, TimeInterval, Void, YouTubePlaybackController (+24 more)

### Community 45 - "Sendable"
Cohesion: 0.14
Nodes (20): Equatable, AppSettings, PresentationTextSettings, Bool, Decoder, Double, tagStyles, LyricStyleProfile (+12 more)

### Community 46 - "GlassIconButton"
Cohesion: 0.22
Nodes (10): ButtonRole, Action, GlassIconButton, .body, .foregroundColor, GlassToolbarIconStyle, Bool, String (+2 more)

### Community 47 - "LyricSlideTag"
Cohesion: 0.09
Nodes (22): LyricLanguage, .displayName, english, .id, spanish, unknown, LyricSlideTag, bridge (+14 more)

### Community 48 - "GlassPanel.swift"
Cohesion: 0.17
Nodes (14): GlassControlChrome, GlassPanel, .body, .panelShape, GlassToolbarIconSize, .frameSize, .iconFont, prominent (+6 more)

### Community 49 - "GlobalStyleEditorView"
Cohesion: 0.27
Nodes (7): GlobalStyleEditorView, .body, .hasStyleChanges, Bool, SlideTextStyle, String, UUID

### Community 50 - "LyricSlideLayoutEngine"
Cohesion: 0.38
Nodes (6): LyricSlideLayoutEngine, CGFloat, CGSize, Int, SlideTextStyle, String

### Community 51 - ".measureSingleLine"
Cohesion: 0.37
Nodes (7): PresentationTextMeasurer, Any, Bool, CGFloat, CGSize, String, NSAttributedString

### Community 52 - "PresentationActionsToolbar"
Cohesion: 0.22
Nodes (8): .presentationToolbar, Constants, PresentationActionsToolbar, .body, .videoControlsCapsule, Bool, CGFloat, Void

### Community 53 - "LyricEditorHeaderBar"
Cohesion: 0.24
Nodes (14): LyricEditorChrome, LyricEditorHeaderBar, .body, LyricEditorHeaderButton, LyricEditorNavRow, .body, MacLyricEditorHeaderChrome, .body (+6 more)

### Community 54 - "ExternalDisplaySceneCoordinator"
Cohesion: 0.13
Nodes (10): ExternalDisplaySceneCoordinator, UIWindowScene, ExternalDisplaySceneDelegate, UICoordinateSpace, UIInterfaceOrientation, UIResponder, UIScene, UISceneSession (+2 more)

### Community 55 - "LyrioraUITests"
Cohesion: 0.15
Nodes (6): LyrioraUITests, LyrioraUITestsLaunchTests, .runsForEachTargetApplicationUIConfiguration, Bool, XCTest, XCTestCase

### Community 56 - "BackgroundContentMode"
Cohesion: 0.18
Nodes (11): BackgroundContentMode, auto, fill, fit, .id, .label, landscape, portrait (+3 more)

### Community 57 - "CodingKeys"
Cohesion: 0.17
Nodes (12): CodingKeys, effectAssignments, effectFallback, effectIntensity, effectSpeed, fallbackAnimation, transitionAssignments, transitionIntensity (+4 more)

### Community 58 - "Foundation"
Cohesion: 0.13
Nodes (6): CoreGraphics, Foundation, ResolvedBackgroundContentMode, fill, fit, Observation

### Community 59 - "View"
Cohesion: 0.27
Nodes (11): ProTextSegmentView, .body, Bool, CGSize, Color, Double, Font, Int (+3 more)

### Community 60 - "SlideTextStyle"
Cohesion: 0.20
Nodes (11): SlideTextStyle, .fontSize, Bool, Decoder, Double, Encoder, Int, CodableColor (+3 more)

### Community 61 - ".matches"
Cohesion: 0.30
Nodes (6): Bool, LibrarySearch, LyricDocument, .searchableText, Bool, String

### Community 62 - "PresentationLayout"
Cohesion: 0.29
Nodes (7): PresentationLayout, CGFloat, CGSize, .presentationLayoutCanvasSize, .canvasAspectRatio, .canvasSize, .previewSection

### Community 63 - "DefaultBackgroundPreset"
Cohesion: 0.17
Nodes (11): DefaultBackgroundPreset, daylightWaves, .id, .isAdaptive, .label, meshWaves, morningHaze, twilightWaves (+3 more)

### Community 64 - "DefaultBackgroundPresetPreview"
Cohesion: 0.33
Nodes (6): EdgeInsets, DefaultBackgroundPresetPreview, .body, DefaultBackgroundPreviewCard, .body, .defaultBackgroundSection

### Community 65 - "AdaptivePresentationText"
Cohesion: 0.18
Nodes (8): CGSize, AdaptivePresentationText, .body, .lines, Bool, Int, String, UUID

### Community 66 - "WordFontSizeOverride"
Cohesion: 0.14
Nodes (19): CGFloat, Double, Int, UUID, WordFontSizeOverride, WordFontSizeResolver, SlideStyleControlsView, .body (+11 more)

### Community 67 - "PickedImageFile"
Cohesion: 0.40
Nodes (6): PickedImageFile, .transferRepresentation, PickedVideoFile, .transferRepresentation, Transferable, TransferRepresentation

### Community 68 - "SlideGridView"
Cohesion: 0.07
Nodes (37): SlideGridView, .body, .slideGridHeader, .thumbnailWidth, SlideThumbnailView, .textConfiguration, .thumbnailCanvasSize, .thumbnailStyle (+29 more)

### Community 69 - "PresentationTextConfiguration"
Cohesion: 0.27
Nodes (9): PresentationTextConfiguration, SlideTextStyle, Bool, CGFloat, Color, Double, Font, SlideTextStyle (+1 more)

### Community 70 - "LyricSectionSource"
Cohesion: 0.24
Nodes (5): sourceSections, LyricSectionSource, String, UUID, UUID

### Community 71 - ".shadowColor"
Cohesion: 0.27
Nodes (7): .body, Color, ColorScheme, LinearGradient, .expandedSearchField, .themeNameField, .body

### Community 72 - "PresentationAnimationQuality"
Cohesion: 0.22
Nodes (8): PresentationAnimationQuality, .effectFrameInterval, live, preview, ProTextRenderQuality, live, preview, TimeInterval

### Community 73 - "ExternalPresentationContainerViewController"
Cohesion: 0.21
Nodes (8): ExternalPresentationContainerViewController, AnyView, Bool, CGSize, View, Void, UIHostingController, UIViewController

### Community 74 - "Int"
Cohesion: 0.19
Nodes (9): SlideTransitionState, .showsPersistentEffects, SlideTransitionTiming, Bool, Decoder, Double, Int, TimeInterval (+1 more)

### Community 75 - "LyricTheme"
Cohesion: 0.27
Nodes (7): LyricTheme, Date, Int, SlideTextStyle, String, UUID, .previewText

### Community 76 - "View"
Cohesion: 0.36
Nodes (4): GlassControlBorderModifier, Content, View, S

### Community 77 - "PresentationVideoControls"
Cohesion: 0.31
Nodes (8): .body, PresentationVideoControls, .activeDuration, .displayedCurrentTime, .sliderBinding, .usesYouTubePlayback, Binding, TimeInterval

### Community 78 - "PresentationState"
Cohesion: 0.25
Nodes (7): .presentationState, PresentationState, Bool, Int, SlideTextStyle, String, UUID

### Community 79 - ".displayName"
Cohesion: 0.50
Nodes (3): PhotosPickerDisplayNameResolver, PhotosPickerItem, String

### Community 80 - "TransitionSpeedControl"
Cohesion: 0.20
Nodes (9): .defaultTransitionControls, Bool, Double, Int, String, Void, TransitionSpeedControl, .body (+1 more)

### Community 81 - "LyricEditorNavigationOption"
Cohesion: 0.20
Nodes (9): Hashable, LyricEditorNavigationOption, .id, lyrics, .systemImage, .title, typography, String (+1 more)

### Community 82 - "PlaylistEditorSheet"
Cohesion: 0.18
Nodes (11): PlaylistEditorSheet, .allItemIDs, .availableItems, .availableSearchPlaceholder, .body, .filteredAvailableItems, .resolvedPlaylist, .showsMediaPreview (+3 more)

### Community 83 - "MacWindowConfigurator"
Cohesion: 0.36
Nodes (5): MacWindowConfigurator, Bool, Context, NSView, View

### Community 84 - "DefaultBackgroundMeshStyle"
Cohesion: 0.14
Nodes (15): .body, DefaultBackgroundMeshStyle, .colors, daylightWaves, morningHaze, twilightWaves, violetDusk, .wavePoints (+7 more)

### Community 85 - "StickyPreviewEditorLayout"
Cohesion: 0.29
Nodes (6): StickyPreviewEditorLayout, .body, .stickyBackground, CGFloat, Content, Preview

### Community 86 - "content"
Cohesion: 0.23
Nodes (11): content, .body, BlurredBackgroundLayer, .body, BlurredBackgroundModifier, CGFloat, Content, Double (+3 more)

### Community 87 - "ThemeRepository"
Cohesion: 0.23
Nodes (5): FileManager, URL, ThemeRepository, ThemeRepositoryProtocol, SlideTextStyle

### Community 88 - "MetalTextEffectRenderer"
Cohesion: 0.15
Nodes (13): MetalTextEffectRenderer, CGSize, CGRect, NSCoder, NSRect, MTKView, MTKViewDelegate, MTLCommandQueue (+5 more)

### Community 90 - "ThemeSavePromptSheet"
Cohesion: 0.25
Nodes (6): Bool, String, Void, ThemeSavePromptSheet, .header, .trimmedThemeName

### Community 91 - "ExternalDisplayInfo"
Cohesion: 0.29
Nodes (6): ExternalDisplayInfo, .resolutionDescription, Bool, CGFloat, CGSize, String

### Community 92 - "WorkspaceCompactLayout.swift"
Cohesion: 0.33
Nodes (6): EnvironmentValues, .workspaceCompactLayout, Bool, WorkspaceDevice, .isPad, .isPhone

### Community 93 - "DisplayInfoSheet"
Cohesion: 0.29
Nodes (6): DisplayInfoSheet, .body, .statusDescription, Bool, String, Void

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
Cohesion: 0.18
Nodes (11): AnyClass, AVPlayerLayerRepresentable, PlayerLayerView, .layerClass, .playerLayer, AVLayerVideoGravity, AVPlayer, AVPlayerLayer (+3 more)

### Community 99 - "ClearerAnchorView"
Cohesion: 0.22
Nodes (7): ClearerAnchorView, NavigationSplitViewBackgroundClearer, Context, UIView, UIViewController, View, UIViewRepresentable

### Community 100 - ".loadThumbnail"
Cohesion: 0.19
Nodes (12): AVAssetImageGenerator, Metadata, CGImage, CGSize, CMTime, String, TimeInterval, URL (+4 more)

### Community 101 - "PresentationBackgroundView"
Cohesion: 0.24
Nodes (11): ConfigurableDefaultGradientView, .layerIdentity, .transition, .body, .body, PresentationBackgroundView, .backgroundContent, .body (+3 more)

### Community 102 - "SettingsRepository"
Cohesion: 0.33
Nodes (3): SettingsRepository, FileManager, URL

### Community 103 - ".transform"
Cohesion: 0.29
Nodes (8): Angle, AnimatedTextSegmentModifier, CGFloat, CGSize, TimeInterval, TextAnimationTransform, View, ViewModifier

### Community 104 - "AVPlayerLayerView"
Cohesion: 0.24
Nodes (7): AVKit, CGSize, AVPlayerLayerView, .body, CGSize, .resolvedMode, .resolvedContentMode

### Community 105 - "PlaylistMediaPreview"
Cohesion: 0.33
Nodes (8): PlaylistImagePreview, .body, PlaylistMediaPreview, .body, PlaylistVideoPreview, .body, CGFloat, URL

### Community 106 - ".linearGradient"
Cohesion: 0.32
Nodes (5): LyricGradient, Color, LinearGradient, UInt64, .body

### Community 107 - "AVPlayerViewRepresentable"
Cohesion: 0.43
Nodes (4): AVPlayerView, AVPlayerViewRepresentable, Context, NSViewRepresentable

### Community 108 - "graphify reference: query, path, explain"
Cohesion: 0.33
Nodes (5): For /graphify explain, For /graphify path, graphify reference: query, path, explain, Step 0 — Constrained query expansion (REQUIRED before traversal), Step 1 — Traversal

### Community 109 - "graphify reference: query, path, explain"
Cohesion: 0.33
Nodes (5): For /graphify explain, For /graphify path, graphify reference: query, path, explain, Step 0 — Constrained query expansion (REQUIRED before traversal), Step 1 — Traversal

### Community 110 - "LyricEditorLaunch"
Cohesion: 0.43
Nodes (3): LyricEditorLaunch, UUID, UUID

### Community 111 - "VideoPlaybackMode"
Cohesion: 0.29
Nodes (6): Bool, VideoPlaybackMode, loop, .loopsVideo, playOnce, .toggled

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

### Community 118 - "TextAnimationTarget"
Cohesion: 0.33
Nodes (6): TextAnimationTarget, all, .label, line, paragraph, word

### Community 124 - "AppViewModel.swift"
Cohesion: 0.33
Nodes (4): VideoControlsReveal, Photos, PhotosUI, UniformTypeIdentifiers

### Community 130 - "MetalTextEffectRenderer.swift"
Cohesion: 0.40
Nodes (4): MetalTextEffectSupport, Bool, Metal, MetalKit

### Community 132 - ".body"
Cohesion: 0.50
Nodes (3): .body, GlassCapsuleToolbar, .body

## Knowledge Gaps
- **504 isolated node(s):** `regular`, `medium`, `semibold`, `bold`, `.id` (+499 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **14 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AppViewModel` connect `AppViewModel` to `ExternalDisplayManager`, `PresentationPreviewView`, `LibraryPlaylist`, `.body`, `LyricEditorView`, `SlideDetailEditorView`, `MediaAsset`, `GlobalStyleEditorContent`, `LyricImportParser`, `MediaThumbnailView`, `VideoPlaybackController`, `LyricSlide`, `PresentationBackground`, `LyricsLibraryPanelView`, `Codable`, `LibraryMorphSearchHeader`, `YouTubePlaybackController`, `GlobalStyleEditorView`, `PresentationLayout`, `SlideGridView`, `LyricSectionSource`, `LyricTheme`, `PresentationVideoControls`, `PresentationState`, `PlaylistEditorSheet`, `ThemeRepository`, `.refreshDisplayInfo`, `LyricEditorLaunch`, `VideoPlaybackMode`, `AppViewModel.swift`?**
  _High betweenness centrality (0.189) - this node is a cross-community bridge._
- **Why does `SwiftUI` connect `SwiftUI` to `MetalTextEffectRenderer.swift`, `GlassMorphAnimation.swift`, `ThemeMiniPreview`, `LyricEditorView`, `SlideDetailEditorView`, `TextAnimationEditorSection`, `PresentationFontFamily`, `LyricSlideLivePreview`, `MediaThumbnailView`, `TypewriterRevealText`, `PlaylistGlassModal.swift`, `ExplicitLinePresentationText`, `LyricSlide`, `PresentationBackground`, `LyricsLibraryPanelView`, `BackgroundFitToolbar`, `LibraryMorphSearchHeader`, `ScaledToFitWidthModifier`, `SlideTransitionTextContainer`, `YouTubePlaybackController`, `Sendable`, `GlassPanel.swift`, `GlobalStyleEditorView`, `PresentationActionsToolbar`, `LyricEditorHeaderBar`, `Foundation`, `View`, `DefaultBackgroundPresetPreview`, `AdaptivePresentationText`, `WordFontSizeOverride`, `SlideGridView`, `TransitionSpeedControl`, `LyricEditorNavigationOption`, `MacWindowConfigurator`, `DefaultBackgroundMeshStyle`, `StickyPreviewEditorLayout`, `content`, `ThemeSavePromptSheet`, `WorkspaceCompactLayout.swift`, `DisplayInfoSheet`, `ClearerAnchorView`, `.transform`, `AVPlayerLayerView`, `PlaylistMediaPreview`, `.linearGradient`, `AppViewModel.swift`?**
  _High betweenness centrality (0.100) - this node is a cross-community bridge._
- **Why does `LyricSlide` connect `LyricSlide` to `LibraryPlaylist`, `LyricEditorView`, `SlideDetailEditorView`, `GlobalStyleEditorContent`, `LyricImportParser`, `LyricSlideLivePreview`, `LyricDocument`, `MediaAssetKind`, `CodingKeys`, `ExplicitLinePresentationText`, `TextAnimationAssignment`, `PresentationBackground`, `Codable`, `SlideAnimationProfile`, `AppViewModel`, `Sendable`, `LyricSlideTag`, `LyricSlideLayoutEngine`, `Foundation`, `WordFontSizeOverride`, `SlideGridView`, `LyricSectionSource`, `PresentationState`?**
  _High betweenness centrality (0.067) - this node is a cross-community bridge._
- **Are the 17 inferred relationships involving `AppViewModel` (e.g. with `.body` and `LyrioraApp`) actually correct?**
  _`AppViewModel` has 17 INFERRED edges - model-reasoned connections that need verification._
- **Are the 2 inferred relationships involving `LyricEditorView` (e.g. with `.body` and `.body`) actually correct?**
  _`LyricEditorView` has 2 INFERRED edges - model-reasoned connections that need verification._
- **What connects `regular`, `medium`, `semibold` to the rest of the system?**
  _504 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `ExternalDisplayManager` be split into smaller, more focused modules?**
  _Cohesion score 0.1164021164021164 - nodes in this community are weakly interconnected._