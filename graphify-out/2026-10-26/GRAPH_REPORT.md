# Graph Report - Lyriora  (2026-10-26)

## Corpus Check
- 138 files · ~73,700 words
- Verdict: corpus is large enough that graph structure adds value.
- Unclassified: 9 file(s) not represented in the graph (top: (none) 4, .mdc 1, .plist 1)

## Summary
- 2282 nodes · 5147 edges · 118 communities (107 shown, 11 thin omitted)
- Extraction: 92% EXTRACTED · 8% INFERRED · 0% AMBIGUOUS · INFERRED: 415 edges (avg confidence: 0.82)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `4f34840d`
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
- AnimatedPresentationText
- PresentationFontWeight
- TextAnimationEditorSection
- ParsedSlideText
- LyricImportParser
- PresentationFontFamily
- LyricSlideLivePreview
- MediaThumbnailView
- VideoPlaybackController
- SwiftUI
- .resolvedMetrics
- LyricPlaySyncServer
- MediaAssetKind
- CodingKeys
- PlaylistGlassModal.swift
- Image
- ExplicitLinePresentationText
- Identifiable
- LyricDocument
- PresentationBackground
- LyricsLibraryPanelView
- SlideGridView
- TypewriterRevealText
- Sendable
- MetalTextEffectRenderer
- LibraryMorphSearchHeader
- AppSettings
- .transitionTransform
- Foundation
- lyricTextFragment
- BackgroundFitToolbar
- What You Must Do When Invoked
- AppViewModel
- DefaultBackgroundSettings
- YouTubePlaybackController
- LyricLanguage
- GlassIconButton
- LyricSlideTag
- GlassPanel
- PlaylistPickerSheet
- LyricSlideLayoutEngine
- .measureSingleLine
- PresentationActionsToolbar
- State
- ExternalDisplaySceneCoordinator
- LyrioraUITests
- SettingsSheet
- CodingKeys
- BackgroundContentMode
- View
- SlideTextStyle
- .matches
- LyricEditorHeaderBar
- LyricSlide
- MacWindowConfigurator
- AdaptivePresentationText
- GlobalStyleEditorContent
- CodingKeys
- SimplePlaySyncDisplayState
- PresentationTextConfiguration
- LyricSectionSource
- .shadowColor
- ThemeSavePromptSheet
- ExternalPresentationContainerViewController
- SlideAnimationProfile
- ClearerAnchorView
- GlassCircleIcon
- Equatable
- Source
- .encode
- TransitionSpeedControl
- LyricSlideMetadataPreservation
- PlaylistEditorSheet
- WorkspaceCompactLayout.swift
- DefaultBackgroundPreset
- GlassToolbarIconSize
- SlideTransitionTextContainer
- StickyPreviewEditorLayout
- PresentationLayout
- .refreshDisplayInfo
- GlassMorphAnimation.swift
- LyricEditorNavigationOption
- ExternalDisplayInfo
- graphify reference: extra exports and benchmark
- graphify reference: extra exports and benchmark
- LyricRepository
- PlayerLayerView
- PresentationState
- .linearGradient
- graphify reference: query, path, explain
- graphify reference: query, path, explain
- VideoPlaybackMode
- graphify reference: add a URL and watch a folder
- graphify reference: commit hook and native AGENTS.md integration
- graphify reference: incremental update and cluster-only
- graphify reference: add a URL and watch a folder
- graphify reference: commit hook and native CLAUDE.md integration
- graphify reference: incremental update and cluster-only
- TextAnimationTarget
- graphify reference: GitHub clone and cross-repo merge
- graphify reference: transcribe video and audio
- graphify reference: GitHub clone and cross-repo merge
- graphify reference: transcribe video and audio
- .agents/skills/graphify/references/extraction-spec.md
- CLAUDE.md
- .claude/CLAUDE.md
- .claude/skills/graphify/references/extraction-spec.md
- .saveLyric

## God Nodes (most connected - your core abstractions)
1. `AppViewModel` - 167 edges
2. `TextAnimationKind` - 75 edges
3. `LyricEditorView` - 67 edges
4. `LyricSlide` - 62 edges
5. `SlideAnimationProfile` - 62 edges
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
  Lyriora/Views/Modals/PlaylistGlassModal.swift → Lyriora/Models/LyricDocument.swift
- `.slidesRefreshID` --references--> `LyricSlide`  [INFERRED]
  Lyriora/Views/Components/LyricEditorSlideHorizontalListView.swift → Lyriora/Models/LyricSlide.swift
- `.headerRow` --references--> `LyricSlide`  [INFERRED]
  Lyriora/Views/Components/LyricSlideLivePreview.swift → Lyriora/Models/LyricSlide.swift

## Import Cycles
- None detected.

## Communities (118 total, 11 thin omitted)

### Community 0 - "ExternalDisplayManager"
Cohesion: 0.12
Nodes (17): ExternalDisplayManager, .displayMonitorInterval, .isExternalDisplayConnected, ExternalPresentationWindow, .canBecomeKey, .canBecomeMain, Bool, CGSize (+9 more)

### Community 1 - "PresentationPreviewView"
Cohesion: 0.10
Nodes (26): ExternalPresentationView, .body, PresentationContentView, .body, .textConfiguration, PresentationPreviewView, .body, .isVideoBackground (+18 more)

### Community 2 - "LibraryPlaylist"
Cohesion: 0.11
Nodes (16): LibraryPlaylist, LibraryPlaylistKind, image, lyric, .systemImage, .title, video, Date (+8 more)

### Community 3 - ".configure"
Cohesion: 0.10
Nodes (30): TimeInterval, UUID, VideoSeekRequest, TimeInterval, Void, VideoProgressReporter, Coordinator, LoopingVideoBackground (+22 more)

### Community 4 - "TextAnimationKind"
Cohesion: 0.04
Nodes (47): Bool, TextAnimationKind, .basicCases, blink, blinkSemiRotate, bounce, chromaticShift, .displayName (+39 more)

### Community 5 - "LyricEditorView"
Cohesion: 0.06
Nodes (41): EditorCard, .cardBackground, LyricEditorLifecycleModifier, .importErrorPresented, LyricEditorView, .activeTheme, .activeThemeName, .body (+33 more)

### Community 6 - "LyricTheme"
Cohesion: 0.09
Nodes (30): LyricTheme, Date, Int, SlideTextStyle, String, UUID, FileManager, URL (+22 more)

### Community 7 - "SlideDetailEditorView"
Cohesion: 0.19
Nodes (12): SlideDetailEditorView, .activeStyle, .animationProfileBinding, .body, .previewAnimationProfile, .resolvedStyleForWordSizing, Binding, Bool (+4 more)

### Community 8 - "What You Must Do When Invoked"
Cohesion: 0.08
Nodes (24): For /graphify add and --watch, For /graphify query, For the commit hook and native AGENTS.md integration, For --update and --cluster-only, /graphify, Honesty Rules, Interpreter guard for subcommands, Part A - Structural extraction for code files (+16 more)

### Community 9 - "MediaAsset"
Cohesion: 0.10
Nodes (18): MediaAsset, .listLabel, Date, UUID, MediaRepositoryProtocol, PhotosPickerDisplayNameResolver, PhotosPickerItem, String (+10 more)

### Community 10 - "AnimatedPresentationText"
Cohesion: 0.09
Nodes (31): PresentationAnimationQuality, .effectFrameInterval, live, preview, ProTextRenderQuality, live, preview, TimeInterval (+23 more)

### Community 11 - "PresentationFontWeight"
Cohesion: 0.17
Nodes (12): PresentationFontWeight, bold, .id, .label, medium, regular, semibold, .nsWeight (+4 more)

### Community 12 - "TextAnimationEditorSection"
Cohesion: 0.14
Nodes (18): Binding, Bool, Int, String, Void, TextAnimationEditorSection, .animationResetToolbar, .animationStatusSummary (+10 more)

### Community 13 - "ParsedSlideText"
Cohesion: 0.12
Nodes (14): ParsedSlideText, .isEmpty, .totalWordCount, SlideTextTokenizer, Bool, Int, Range, String (+6 more)

### Community 14 - "LyricImportParser"
Cohesion: 0.22
Nodes (6): String, LyricImportParser, ParsedSections, Bool, Int, String

### Community 15 - "PresentationFontFamily"
Cohesion: 0.07
Nodes (33): PresentationFontFamily, americanTypewriter, arial, avenirNext, baskerville, courierNew, didot, futura (+25 more)

### Community 16 - "LyricSlideLivePreview"
Cohesion: 0.10
Nodes (26): EditorPreviewSizing, exact, LyricPreviewBackgroundStyle, borderOnly, settingsDefault, LyricSlideLivePreview, .body, .compactCanvasPreview (+18 more)

### Community 17 - "MediaThumbnailView"
Cohesion: 0.08
Nodes (36): GlassOverflowMenu, PlaylistFilterBar, .selectedPlaylist, ClipboardLinkReader, .string, ImageLibrarySection, .body, .filteredAssets (+28 more)

### Community 18 - "VideoPlaybackController"
Cohesion: 0.19
Nodes (10): AVPlayerLooper, Any, AVPlayer, AVPlayerItem, CMTime, NSObjectProtocol, TimeInterval, URL (+2 more)

### Community 19 - "SwiftUI"
Cohesion: 0.21
Nodes (6): AppKit, AVFoundation, AVKit, LyricClipboardImporter, SwiftUI, UIKit

### Community 20 - ".resolvedMetrics"
Cohesion: 0.25
Nodes (8): ExternalDisplayDiscovery, ExternalDisplayMetrics, Bool, CGFloat, CGSize, UIWindow, UIWindowScene, UIScreen

### Community 21 - "LyricPlaySyncServer"
Cohesion: 0.27
Nodes (8): LyricPlaySyncServer, Date, Error, Void, MessageHandler, NWConnection, NWListener, Result

### Community 22 - "MediaAssetKind"
Cohesion: 0.08
Nodes (28): Error, .index, MediaAssetKind, image, video, MediaIndexEntry, MediaRepository, MediaRepositoryError (+20 more)

### Community 23 - "CodingKeys"
Cohesion: 0.08
Nodes (23): CodingKeys, defaultAnimationProfile, defaultStyle, fontDesign, fontFamily, fontWeight, horizontalPaddingRatio, isAdaptiveScalingEnabled (+15 more)

### Community 24 - "PlaylistGlassModal.swift"
Cohesion: 0.09
Nodes (31): .body, PlaylistGlassColumn, .body, PlaylistGlassEmptyState, .body, PlaylistGlassNameField, .body, PlaylistGlassRowButton (+23 more)

### Community 25 - "Image"
Cohesion: 0.08
Nodes (41): AVAssetImageGenerator, Entry, LocalImageCache, CGSize, URL, Metadata, CGImage, CGSize (+33 more)

### Community 26 - "ExplicitLinePresentationText"
Cohesion: 0.14
Nodes (18): EnvironmentKey, .body, EditorAdaptivePresentationText, .body, .lines, .resolvedConfiguration, scaledApproximation, EnvironmentValues (+10 more)

### Community 27 - "Identifiable"
Cohesion: 0.11
Nodes (16): ButtonRole, CaseIterable, Hashable, Identifiable, LyricEditorLaunch, PresentationFontDesign, `default`, .id (+8 more)

### Community 28 - "LyricDocument"
Cohesion: 0.17
Nodes (11): LyricDocument, .previewSnippet, CGSize, Date, Decoder, SlideTextStyle, String, UInt64 (+3 more)

### Community 29 - "PresentationBackground"
Cohesion: 0.11
Nodes (21): PresentationBackground, .isYouTube, Bool, String, URL, .body, AppBackgroundAnimation, AppBackgroundView (+13 more)

### Community 30 - "LyricsLibraryPanelView"
Cohesion: 0.06
Nodes (39): App, ContentView, .body, LyrioraApp, .body, CenterPanelView, .presentationToolbar, String (+31 more)

### Community 31 - "SlideGridView"
Cohesion: 0.18
Nodes (14): SlideGridView, .body, .thumbnailWidth, SlideThumbnailView, .textConfiguration, .thumbnailCanvasSize, .thumbnailStyle, .usesDefaultGradientBackground (+6 more)

### Community 32 - "TypewriterRevealText"
Cohesion: 0.21
Nodes (14): Bool, Color, Content, Double, Font, Int, String, TypewriterRevealText (+6 more)

### Community 33 - "Sendable"
Cohesion: 0.13
Nodes (25): Codable, LyricStyleProfile, Decoder, LinkSectionCommand, LyricPlaySync, LyricPlaySyncMessage, LyricPlaySyncMessageKind, catalogRequest (+17 more)

### Community 34 - "MetalTextEffectRenderer"
Cohesion: 0.08
Nodes (31): MetalTextEffectParameters, .isActive, MetalTextEffectRenderer, MetalTextEffectSupport, Bool, CGImage, CGSize, Double (+23 more)

### Community 35 - "LibraryMorphSearchHeader"
Cohesion: 0.11
Nodes (19): LyricDocument, Layout, LibraryMorphSearchHeader, .body, .collapsedSearchButton, .controlSize, .isSearchActive, .resolvedHorizontalPadding (+11 more)

### Community 36 - "AppSettings"
Cohesion: 0.23
Nodes (8): AppSettings, PresentationTextSettings, Bool, Decoder, Double, SettingsRepository, FileManager, URL

### Community 37 - ".transitionTransform"
Cohesion: 0.15
Nodes (20): Angle, AnimatableModifier, AnimatedTextSegmentModifier, SequentialWordTransitionModifier, .animatableData, .layoutSegmentIndex, .layoutTotalWords, SlideTransitionModifier (+12 more)

### Community 38 - "Foundation"
Cohesion: 0.12
Nodes (7): CoreGraphics, Foundation, VideoControlsReveal, Observation, Photos, PhotosUI, UniformTypeIdentifiers

### Community 39 - "lyricTextFragment"
Cohesion: 0.13
Nodes (17): constant, float2, float4, fragment, lyricTextFragment(), lyricTextVertex(), TextEffectUniforms, chromaticStrength (+9 more)

### Community 40 - "BackgroundFitToolbar"
Cohesion: 0.20
Nodes (13): BackgroundFitBadgeLabel, .body, BackgroundFitToggleLabel, .body, BackgroundFitToolbar, .body, .expandedOptions, .toggleButton (+5 more)

### Community 41 - "What You Must Do When Invoked"
Cohesion: 0.08
Nodes (24): For /graphify add and --watch, For /graphify query, For the commit hook and native CLAUDE.md integration, For --update and --cluster-only, /graphify, Honesty Rules, Interpreter guard for subcommands, Part A - Structural extraction for code files (+16 more)

### Community 42 - "AppViewModel"
Cohesion: 0.07
Nodes (24): LyricRepositoryProtocol, SettingsRepositoryProtocol, ThemeRepositoryProtocol, AppViewModel, .hasControllableVideoBackgroundSelected, .hasCustomBackgroundSelected, .hasVideoBackgroundSelected, .hasYouTubeBackgroundSelected (+16 more)

### Community 43 - "DefaultBackgroundSettings"
Cohesion: 0.20
Nodes (14): ConfigurableDefaultGradientView, .body, .layerIdentity, DefaultBackgroundSettings, Double, .transition, .body, .body (+6 more)

### Community 44 - "YouTubePlaybackController"
Cohesion: 0.07
Nodes (38): Decodable, ResolvedBackgroundContentMode, fill, fit, CGSize, OEmbedResponse, String, URL (+30 more)

### Community 45 - "LyricLanguage"
Cohesion: 0.13
Nodes (14): LyricLanguage, .displayName, english, .id, spanish, unknown, LyricEditorSlideCard, .textConfiguration (+6 more)

### Community 46 - "GlassIconButton"
Cohesion: 0.25
Nodes (7): .body, GlassIconButton, .body, .foregroundColor, GlassToolbarIconStyle, Bool, Void

### Community 47 - "LyricSlideTag"
Cohesion: 0.12
Nodes (16): LyricSlideTag, bridge, chorus, .displayName, .id, instrumental, intro, outro (+8 more)

### Community 48 - "GlassPanel"
Cohesion: 0.33
Nodes (7): GlassPanel, .body, .panelShape, GlassToolbarMetrics, .controlHeight, CGFloat, RoundedRectangle

### Community 49 - "PlaylistPickerSheet"
Cohesion: 0.31
Nodes (7): PlaylistPickerSheet, .createPlaylistCard, .filteredPlaylists, .isSearching, .totalItemCount, Bool, Int

### Community 50 - "LyricSlideLayoutEngine"
Cohesion: 0.38
Nodes (6): LyricSlideLayoutEngine, CGFloat, CGSize, Int, SlideTextStyle, String

### Community 51 - ".measureSingleLine"
Cohesion: 0.38
Nodes (7): PresentationTextMeasurer, Any, Bool, CGFloat, CGSize, String, NSAttributedString

### Community 52 - "PresentationActionsToolbar"
Cohesion: 0.22
Nodes (8): Constants, PresentationActionsToolbar, .body, .clearActionsCapsule, .videoControlsCapsule, Bool, CGFloat, Void

### Community 53 - "State"
Cohesion: 0.15
Nodes (12): LyricPlaySyncTransportError, emptyResponse, .errorDescription, noLyrioraHost, unexpectedResponse, State, failed, ready (+4 more)

### Community 54 - "ExternalDisplaySceneCoordinator"
Cohesion: 0.14
Nodes (10): ExternalDisplaySceneCoordinator, UIWindowScene, ExternalDisplaySceneDelegate, UICoordinateSpace, UIInterfaceOrientation, UIResponder, UIScene, UISceneSession (+2 more)

### Community 55 - "LyrioraUITests"
Cohesion: 0.15
Nodes (6): LyrioraUITests, LyrioraUITestsLaunchTests, .runsForEachTargetApplicationUIConfiguration, Bool, XCTest, XCTestCase

### Community 56 - "SettingsSheet"
Cohesion: 0.24
Nodes (9): DefaultBackgroundPresetPreview, .body, DefaultBackgroundPreviewCard, .body, SettingsSheet, .body, .defaultBackgroundSection, Binding (+1 more)

### Community 57 - "CodingKeys"
Cohesion: 0.17
Nodes (12): CodingKeys, assignments, effectAssignments, effectFallback, effectIntensity, effectSpeed, fallbackAnimation, transitionAssignments (+4 more)

### Community 58 - "BackgroundContentMode"
Cohesion: 0.18
Nodes (11): BackgroundContentMode, auto, fill, fit, .id, .label, landscape, portrait (+3 more)

### Community 59 - "View"
Cohesion: 0.29
Nodes (11): ProTextSegmentView, .body, Bool, CGSize, Color, Double, Font, Int (+3 more)

### Community 60 - "SlideTextStyle"
Cohesion: 0.27
Nodes (10): SlideTextStyle, .fontSize, Bool, Double, Encoder, Int, CodableColor, .color (+2 more)

### Community 61 - ".matches"
Cohesion: 0.30
Nodes (6): Bool, LibrarySearch, LyricDocument, .searchableText, Bool, String

### Community 62 - "LyricEditorHeaderBar"
Cohesion: 0.22
Nodes (15): LyricEditorChrome, LyricEditorHeaderBar, .body, LyricEditorHeaderButton, .body, LyricEditorNavRow, .body, MacLyricEditorHeaderChrome (+7 more)

### Community 63 - "LyricSlide"
Cohesion: 0.11
Nodes (21): .slides, CodingKeys, animationProfile, id, order, simplePlaySectionID, sourceSectionID, style (+13 more)

### Community 64 - "MacWindowConfigurator"
Cohesion: 0.36
Nodes (5): MacWindowConfigurator, Bool, Context, NSView, View

### Community 65 - "AdaptivePresentationText"
Cohesion: 0.29
Nodes (6): AdaptivePresentationText, .lines, Bool, Int, String, UUID

### Community 66 - "GlobalStyleEditorContent"
Cohesion: 0.06
Nodes (43): CGFloat, Double, Int, UUID, WordFontSizeOverride, WordFontSizeResolver, KeyboardDismissal, SlideStyleControlsView (+35 more)

### Community 67 - "CodingKeys"
Cohesion: 0.25
Nodes (8): CodingKey, CodingKeys, linkedSectionID, order, preview, slideID, tag, text

### Community 68 - "SimplePlaySyncDisplayState"
Cohesion: 0.11
Nodes (23): .slideGridHeader, SimplePlayConnectionIndicator, .body, .shouldAnimateGlow, SimplePlayConnectionInfoSheet, .body, .manualModeBinding, .state (+15 more)

### Community 69 - "PresentationTextConfiguration"
Cohesion: 0.23
Nodes (10): EdgeInsets, PresentationTextConfiguration, SlideTextStyle, Bool, CGFloat, CGSize, Color, Double (+2 more)

### Community 70 - "LyricSectionSource"
Cohesion: 0.24
Nodes (4): LyricSectionSource, String, UUID, UUID

### Community 71 - ".shadowColor"
Cohesion: 0.33
Nodes (6): GlassControlChrome, Color, ColorScheme, LinearGradient, .expandedSearchField, .themeNameField

### Community 72 - "ThemeSavePromptSheet"
Cohesion: 0.25
Nodes (6): Bool, String, Void, ThemeSavePromptSheet, .header, .trimmedThemeName

### Community 73 - "ExternalPresentationContainerViewController"
Cohesion: 0.23
Nodes (8): ExternalPresentationContainerViewController, AnyView, Bool, CGSize, View, Void, UIHostingController, UIViewController

### Community 74 - "SlideAnimationProfile"
Cohesion: 0.15
Nodes (15): SlideAnimationProfile, .hasAnimations, .hasPersistentEffects, .hasProPersistentEffects, .hasTransition, .preferredEffectSelectionTarget, .preferredTransitionSelectionTarget, Decoder (+7 more)

### Community 75 - "ClearerAnchorView"
Cohesion: 0.25
Nodes (7): ClearerAnchorView, NavigationSplitViewBackgroundClearer, Context, UIView, UIViewController, View, UIViewRepresentable

### Community 76 - "GlassCircleIcon"
Cohesion: 0.18
Nodes (11): GlassCapsuleToolbar, .body, GlassCircleIcon, .body, GlassControlBorderModifier, .body, Content, String (+3 more)

### Community 77 - "Equatable"
Cohesion: 0.15
Nodes (12): Equatable, LocalizedError, Lyriora, LyricImportError, empty, .errorDescription, notText, unsupportedContent (+4 more)

### Community 78 - "Source"
Cohesion: 0.40
Nodes (5): Source, liveContainer, liveWindow, sceneCoordinateSpace, screenBounds

### Community 79 - ".encode"
Cohesion: 0.43
Nodes (4): JSONEncoder, LyricPlaySyncCodec, Data, Encoder

### Community 80 - "TransitionSpeedControl"
Cohesion: 0.20
Nodes (9): .defaultTransitionControls, Bool, Double, Int, String, Void, TransitionSpeedControl, .body (+1 more)

### Community 82 - "PlaylistEditorSheet"
Cohesion: 0.18
Nodes (11): PlaylistEditorSheet, .allItemIDs, .availableItems, .availableSearchPlaceholder, .body, .filteredAvailableItems, .resolvedPlaylist, .showsMediaPreview (+3 more)

### Community 83 - "WorkspaceCompactLayout.swift"
Cohesion: 0.33
Nodes (6): EnvironmentValues, .workspaceCompactLayout, Bool, WorkspaceDevice, .isPad, .isPhone

### Community 84 - "DefaultBackgroundPreset"
Cohesion: 0.08
Nodes (25): DefaultBackgroundMeshStyle, .colors, daylightWaves, morningHaze, twilightWaves, violetDusk, .wavePoints, DefaultBackgroundMeshView (+17 more)

### Community 85 - "GlassToolbarIconSize"
Cohesion: 0.33
Nodes (6): GlassToolbarIconSize, .frameSize, .iconFont, prominent, regular, Font

### Community 86 - "SlideTransitionTextContainer"
Cohesion: 0.06
Nodes (43): CodingKeys, colorSeed, content, createdAt, id, language, simplePlayProjectID, simplePlayProjectName (+35 more)

### Community 87 - "StickyPreviewEditorLayout"
Cohesion: 0.33
Nodes (5): StickyPreviewEditorLayout, .stickyBackground, CGFloat, Content, Preview

### Community 88 - "PresentationLayout"
Cohesion: 0.26
Nodes (7): PresentationLayout, CGFloat, CGSize, .presentationLayoutCanvasSize, .canvasAspectRatio, .canvasSize, .previewSection

### Community 91 - "LyricEditorNavigationOption"
Cohesion: 0.22
Nodes (8): LyricEditorNavigationOption, .id, lyrics, .systemImage, .title, typography, String, Self

### Community 93 - "ExternalDisplayInfo"
Cohesion: 0.17
Nodes (12): ExternalDisplayInfo, .resolutionDescription, Bool, CGFloat, CGSize, String, DisplayInfoSheet, .body (+4 more)

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
Cohesion: 0.13
Nodes (18): AnyClass, AVPlayerView, AVPlayerLayerRepresentable, AVPlayerLayerView, .body, AVPlayerViewRepresentable, PlayerLayerView, .layerClass (+10 more)

### Community 105 - "PresentationState"
Cohesion: 0.29
Nodes (7): .presentationState, PresentationState, Bool, Int, SlideTextStyle, String, UUID

### Community 106 - ".linearGradient"
Cohesion: 0.32
Nodes (5): LyricGradient, Color, LinearGradient, UInt64, .body

### Community 108 - "graphify reference: query, path, explain"
Cohesion: 0.33
Nodes (5): For /graphify explain, For /graphify path, graphify reference: query, path, explain, Step 0 — Constrained query expansion (REQUIRED before traversal), Step 1 — Traversal

### Community 109 - "graphify reference: query, path, explain"
Cohesion: 0.33
Nodes (5): For /graphify explain, For /graphify path, graphify reference: query, path, explain, Step 0 — Constrained query expansion (REQUIRED before traversal), Step 1 — Traversal

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
Cohesion: 0.12
Nodes (16): AnimationApplyScope, allSlides, currentSlide, .id, .label, SlideTransitionTiming, Bool, Int (+8 more)

### Community 129 - ".saveLyric"
Cohesion: 0.24
Nodes (7): PickedImageFile, .transferRepresentation, PickedVideoFile, .transferRepresentation, String, Transferable, TransferRepresentation

## Knowledge Gaps
- **497 isolated node(s):** `regular`, `medium`, `semibold`, `bold`, `.id` (+492 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 759 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **11 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AppViewModel` connect `AppViewModel` to `ExternalDisplayManager`, `.saveLyric`, `LibraryPlaylist`, `PresentationPreviewView`, `LyricEditorView`, `LyricTheme`, `MediaAsset`, `LyricImportParser`, `MediaThumbnailView`, `VideoPlaybackController`, `LyricPlaySyncServer`, `Identifiable`, `PresentationBackground`, `LyricsLibraryPanelView`, `SlideGridView`, `Sendable`, `LibraryMorphSearchHeader`, `Foundation`, `YouTubePlaybackController`, `GlassIconButton`, `PlaylistPickerSheet`, `SettingsSheet`, `LyricSlide`, `GlobalStyleEditorContent`, `SimplePlaySyncDisplayState`, `LyricSectionSource`, `ExternalPresentationContainerViewController`, `PlaylistEditorSheet`, `PresentationLayout`, `.refreshDisplayInfo`, `PresentationState`, `VideoPlaybackMode`?**
  _High betweenness centrality (0.183) - this node is a cross-community bridge._
- **Why does `SwiftUI` connect `SwiftUI` to `PresentationPreviewView`, `LyricEditorView`, `LyricTheme`, `SlideDetailEditorView`, `AnimatedPresentationText`, `PresentationFontFamily`, `LyricSlideLivePreview`, `MediaThumbnailView`, `PlaylistGlassModal.swift`, `Image`, `ExplicitLinePresentationText`, `PresentationBackground`, `LyricsLibraryPanelView`, `SlideGridView`, `TypewriterRevealText`, `MetalTextEffectRenderer`, `LibraryMorphSearchHeader`, `.transitionTransform`, `Foundation`, `BackgroundFitToolbar`, `YouTubePlaybackController`, `LyricLanguage`, `PresentationActionsToolbar`, `SettingsSheet`, `LyricEditorHeaderBar`, `LyricSlide`, `MacWindowConfigurator`, `AdaptivePresentationText`, `GlobalStyleEditorContent`, `SimplePlaySyncDisplayState`, `ThemeSavePromptSheet`, `ClearerAnchorView`, `GlassCircleIcon`, `TransitionSpeedControl`, `WorkspaceCompactLayout.swift`, `DefaultBackgroundPreset`, `SlideTransitionTextContainer`, `StickyPreviewEditorLayout`, `GlassMorphAnimation.swift`, `LyricEditorNavigationOption`, `ExternalDisplayInfo`, `.linearGradient`?**
  _High betweenness centrality (0.112) - this node is a cross-community bridge._
- **Why does `LyricSlide` connect `LyricSlide` to `.saveLyric`, `LyricEditorView`, `SlideDetailEditorView`, `LyricImportParser`, `LyricSlideLivePreview`, `MediaAssetKind`, `CodingKeys`, `ExplicitLinePresentationText`, `Identifiable`, `LyricDocument`, `PresentationBackground`, `SlideGridView`, `Sendable`, `Foundation`, `AppViewModel`, `LyricLanguage`, `LyricSlideTag`, `LyricSlideLayoutEngine`, `GlobalStyleEditorContent`, `LyricSectionSource`, `SlideAnimationProfile`, `Equatable`, `LyricSlideMetadataPreservation`, `PresentationState`, `TextAnimationTarget`?**
  _High betweenness centrality (0.066) - this node is a cross-community bridge._
- **Are the 18 inferred relationships involving `AppViewModel` (e.g. with `.body` and `LyrioraApp`) actually correct?**
  _`AppViewModel` has 18 INFERRED edges - model-reasoned connections that need verification._
- **Are the 2 inferred relationships involving `LyricEditorView` (e.g. with `.body` and `.body`) actually correct?**
  _`LyricEditorView` has 2 INFERRED edges - model-reasoned connections that need verification._
- **What connects `regular`, `medium`, `semibold` to the rest of the system?**
  _497 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `ExternalDisplayManager` be split into smaller, more focused modules?**
  _Cohesion score 0.11822660098522167 - nodes in this community are weakly interconnected._