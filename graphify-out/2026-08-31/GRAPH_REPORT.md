# Graph Report - Lyriora  (2026-08-31)

## Corpus Check
- 138 files · ~73,413 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 2278 nodes · 5066 edges · 124 communities (113 shown, 11 thin omitted)
- Extraction: 92% EXTRACTED · 8% INFERRED · 0% AMBIGUOUS · INFERRED: 407 edges (avg confidence: 0.8)
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
- ThemeMiniPreview
- SlideTransitionTextContainer
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
- SlideDetailEditorView
- .resolvedMetrics
- LyricDocument
- MediaAssetKind
- CodingKeys
- PlaylistGlassModal.swift
- Image
- ExplicitLinePresentationText
- PresentationFontDesign
- LyricSlide
- PresentationBackgroundLayer
- LyricsLibraryPanelView
- LyricPlaySyncMessageKind
- PlaylistGlassColumn
- Sendable
- MetalTextEffectRepresentable
- LibraryMorphSearchHeader
- PresentationBackground
- .transitionTransform
- SwiftUI
- lyricTextFragment
- SlideAnimationProfile
- What You Must Do When Invoked
- AppViewModel
- PresentationContentView
- YouTubePlaybackController
- LyricLanguage
- GlassCircleIcon
- LyricSlideTag
- GlassPanel.swift
- PlaylistPickerSheet
- LyricSlideLayoutEngine
- .measureSingleLine
- GlassIconButton
- .selectBackgroundMedia
- ExternalDisplaySceneCoordinator
- LyrioraUITests
- MetalTextEffectRenderer
- CodingKeys
- Foundation
- View
- LyricStyleProfile
- .matches
- LyricEditorHeaderBar
- DefaultBackgroundPreset
- DefaultBackgroundPresetPreview
- AdaptivePresentationText
- AnimatedPresentationText
- SlideGridView
- PresentationTextConfiguration
- .rechunkSlides
- .shadowColor
- ExternalPresentationContainerViewController
- TextAnimationAssignment
- ClearerAnchorView
- View
- ThemeRepository
- TransitionSpeedControl
- PlaylistEditorSheet
- MacWindowConfigurator
- DefaultBackgroundMeshStyle
- StickyPreviewEditorLayout
- content
- LyricTheme
- PresentationLayout
- .refreshDisplayInfo
- ThemeSavePromptSheet
- LyricEditorNavigationOption
- WorkspaceDevice
- ExternalDisplayInfo
- LyrioraTests.swift
- graphify reference: extra exports and benchmark
- graphify reference: extra exports and benchmark
- LyricRepository
- BackgroundContentMode
- GlobalStyleEditorView
- PresentationVideoControls
- PresentationBackgroundView
- Equatable
- PlaylistMediaPreview
- PresentationState
- .linearGradient
- graphify reference: query, path, explain
- graphify reference: query, path, explain
- .body
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
- String
- MetalTextEffectRenderer.swift
- .body
- GlassMorphAnimation.swift

## God Nodes (most connected - your core abstractions)
1. `AppViewModel` - 166 edges
2. `TextAnimationKind` - 75 edges
3. `LyricEditorView` - 65 edges
4. `SlideAnimationProfile` - 62 edges
5. `LyricSlide` - 57 edges
6. `MediaAsset` - 54 edges
7. `ExternalDisplayManager` - 51 edges
8. `Image` - 47 edges
9. `TextAnimationEditorSection` - 46 edges
10. `PresentationTextConfiguration` - 41 edges

## Surprising Connections (you probably didn't know these)
- `.body` --calls--> `content`  [INFERRED]
  Lyriora/Views/Components/GlassPanel.swift → Lyriora/Models/LyricDocument.swift
- `.body` --calls--> `content`  [INFERRED]
  Lyriora/Views/Components/StickyPreviewEditorLayout.swift → Lyriora/Models/LyricDocument.swift
- `.body` --calls--> `content`  [INFERRED]
  Lyriora/Views/Modals/PlaylistGlassModal.swift → Lyriora/Models/LyricDocument.swift
- `.selectedTheme` --references--> `LyricTheme`  [INFERRED]
  Lyriora/Views/Components/ThemePreviewCard.swift → Lyriora/Models/LyricTheme.swift
- `.activeEffectKind` --references--> `SlideAnimationProfile`  [INFERRED]
  Lyriora/Views/Components/TextAnimationEditorSection.swift → Lyriora/Models/SlideAnimationProfile.swift

## Import Cycles
- None detected.

## Communities (124 total, 11 thin omitted)

### Community 0 - "ExternalDisplayManager"
Cohesion: 0.12
Nodes (18): ExternalDisplayManager, .displayMonitorInterval, .isExternalDisplayConnected, ExternalPresentationWindow, .canBecomeKey, .canBecomeMain, Bool, CGSize (+10 more)

### Community 1 - "PresentationPreviewView"
Cohesion: 0.23
Nodes (10): PresentationPreviewView, .isVideoBackground, .previewMetadataBar, .previewStage, .showsSlidePlaceholder, .showsVideoControls, .textConfiguration, .usesLocalVideoPlayerStage (+2 more)

### Community 2 - "LibraryPlaylist"
Cohesion: 0.11
Nodes (16): LibraryPlaylist, LibraryPlaylistKind, image, lyric, .systemImage, .title, video, Date (+8 more)

### Community 3 - ".configure"
Cohesion: 0.09
Nodes (31): TimeInterval, UUID, VideoSeekRequest, TimeInterval, Void, VideoProgressReporter, Coordinator, LoopingVideoBackground (+23 more)

### Community 4 - "TextAnimationKind"
Cohesion: 0.04
Nodes (47): Bool, TextAnimationKind, .basicCases, blink, blinkSemiRotate, bounce, chromaticShift, .displayName (+39 more)

### Community 5 - "LyricEditorView"
Cohesion: 0.05
Nodes (42): EditorCard, .cardBackground, LyricEditorLifecycleModifier, .importErrorPresented, LyricEditorView, .activeTheme, .activeThemeName, .body (+34 more)

### Community 6 - "ThemeMiniPreview"
Cohesion: 0.14
Nodes (21): Bool, CGFloat, SlideTextStyle, String, UUID, Void, ThemeGalleryView, .body (+13 more)

### Community 7 - "SlideTransitionTextContainer"
Cohesion: 0.05
Nodes (47): LocalizedError, SlideTransitionState, .showsPersistentEffects, LyricImportError, empty, .errorDescription, notText, unsupportedContent (+39 more)

### Community 8 - "What You Must Do When Invoked"
Cohesion: 0.08
Nodes (24): For /graphify add and --watch, For /graphify query, For the commit hook and native AGENTS.md integration, For --update and --cluster-only, /graphify, Honesty Rules, Interpreter guard for subcommands, Part A - Structural extraction for code files (+16 more)

### Community 9 - "MediaAsset"
Cohesion: 0.11
Nodes (17): MediaAsset, .listLabel, Date, UUID, MediaRepositoryProtocol, PhotosPickerDisplayNameResolver, PhotosPickerItem, String (+9 more)

### Community 10 - "GlobalStyleEditorContent"
Cohesion: 0.15
Nodes (17): GlobalStyleEditorContent, .animationProfileBinding, .body, .currentSlide, .lyricDefaultAnimationBinding, .lyricSlides, .previewAnimationProfile, .previewSlideForDisplay (+9 more)

### Community 11 - "PresentationFontWeight"
Cohesion: 0.12
Nodes (16): PresentationFontWeight, bold, .id, .label, medium, regular, semibold, CGFloat (+8 more)

### Community 12 - "TextAnimationEditorSection"
Cohesion: 0.11
Nodes (20): Binding, Bool, Int, String, Void, TextAnimationEditorSection, .activeEffectKind, .activeTransitionKind (+12 more)

### Community 13 - "ParsedSlideText"
Cohesion: 0.13
Nodes (13): ParsedSlideText, .isEmpty, .totalWordCount, SlideTextTokenizer, Bool, Int, Range, String (+5 more)

### Community 14 - "LyricImportParser"
Cohesion: 0.18
Nodes (9): String, LyricImportParser, LyricImportResult, LyricSectionParseResult, ParsedSections, Bool, Int, String (+1 more)

### Community 15 - "PresentationFontFamily"
Cohesion: 0.07
Nodes (30): PresentationFontFamily, americanTypewriter, arial, avenirNext, baskerville, courierNew, didot, futura (+22 more)

### Community 16 - "LyricSlideLivePreview"
Cohesion: 0.11
Nodes (23): LyricPreviewBackgroundStyle, borderOnly, settingsDefault, LyricSlideLivePreview, .body, .compactCanvasPreview, .compactHeight, .cornerRadius (+15 more)

### Community 17 - "MediaThumbnailView"
Cohesion: 0.09
Nodes (29): GlassOverflowMenu, ClipboardLinkReader, .string, ImageLibrarySection, .filteredAssets, .isPlaylistFiltered, MediaImportContentTypes, MediaLibraryPanelView (+21 more)

### Community 18 - "VideoPlaybackController"
Cohesion: 0.19
Nodes (10): AVPlayerLooper, Any, AVPlayer, AVPlayerItem, CMTime, NSObjectProtocol, TimeInterval, URL (+2 more)

### Community 19 - "SlideDetailEditorView"
Cohesion: 0.19
Nodes (12): SlideDetailEditorView, .activeStyle, .animationProfileBinding, .body, .previewAnimationProfile, .resolvedStyleForWordSizing, Binding, Bool (+4 more)

### Community 20 - ".resolvedMetrics"
Cohesion: 0.19
Nodes (13): ExternalDisplayDiscovery, ExternalDisplayMetrics, Source, liveContainer, liveWindow, sceneCoordinateSpace, screenBounds, Bool (+5 more)

### Community 21 - "LyricDocument"
Cohesion: 0.13
Nodes (18): CodingKeys, colorSeed, createdAt, id, language, simplePlayProjectID, simplePlayProjectName, storedSlides (+10 more)

### Community 22 - "MediaAssetKind"
Cohesion: 0.08
Nodes (28): Error, .index, MediaAssetKind, image, video, MediaIndexEntry, MediaRepository, MediaRepositoryError (+20 more)

### Community 23 - "CodingKeys"
Cohesion: 0.05
Nodes (39): CodingKey, CodingKeys, animationProfile, id, order, simplePlaySectionID, sourceSectionID, style (+31 more)

### Community 24 - "PlaylistGlassModal.swift"
Cohesion: 0.12
Nodes (23): .body, PlaylistGlassEmptyState, .body, PlaylistGlassNameField, .body, PlaylistGlassRowButton, .body, PlaylistGlassSearchField (+15 more)

### Community 25 - "Image"
Cohesion: 0.09
Nodes (35): AVAssetImageGenerator, Entry, LocalImageCache, CGSize, URL, Metadata, CGImage, CGSize (+27 more)

### Community 26 - "ExplicitLinePresentationText"
Cohesion: 0.13
Nodes (20): EnvironmentKey, .body, EditorAdaptivePresentationText, .body, .lines, .resolvedConfiguration, EditorPreviewSizing, exact (+12 more)

### Community 27 - "PresentationFontDesign"
Cohesion: 0.25
Nodes (7): PresentationFontDesign, `default`, .id, .label, monospaced, rounded, serif

### Community 28 - "LyricSlide"
Cohesion: 0.10
Nodes (18): .slides, CGSize, SlideTextStyle, LyricSlide, Decoder, Encoder, Int, SlideTextStyle (+10 more)

### Community 29 - "PresentationBackgroundLayer"
Cohesion: 0.15
Nodes (17): .body, AppBackgroundAnimation, .transition, AppBackgroundView, .layerIdentity, .shellBackground, PresentationBackgroundLayer, .body (+9 more)

### Community 30 - "LyricsLibraryPanelView"
Cohesion: 0.06
Nodes (39): App, ContentView, .body, LyrioraApp, .body, CenterPanelView, .presentationToolbar, String (+31 more)

### Community 31 - "LyricPlaySyncMessageKind"
Cohesion: 0.22
Nodes (9): LyricPlaySyncMessageKind, catalogRequest, catalogResponse, error, linkSection, linkSectionAck, presence, presenceAck (+1 more)

### Community 32 - "PlaylistGlassColumn"
Cohesion: 0.29
Nodes (7): PlaylistGlassColumn, .body, PlaylistModalScrim, .body, PlaylistModalShell, .body, Content

### Community 33 - "Sendable"
Cohesion: 0.17
Nodes (18): Codable, JSONEncoder, LinkSectionCommand, LyricPlaySync, LyricPlaySyncCodec, LyricPlaySyncMessage, LyricSlideCatalog, LyricSlideCatalogItem (+10 more)

### Community 34 - "MetalTextEffectRepresentable"
Cohesion: 0.17
Nodes (14): MetalTextEffectParameters, .isActive, CGImage, Double, Float, TimeInterval, TextEffectUniformsMetal, ContainerView (+6 more)

### Community 35 - "LibraryMorphSearchHeader"
Cohesion: 0.16
Nodes (14): Layout, LibraryMorphSearchHeader, .body, .collapsedSearchButton, .controlSize, .isSearchActive, .resolvedHorizontalPadding, .searchSlot (+6 more)

### Community 36 - "PresentationBackground"
Cohesion: 0.33
Nodes (5): PresentationBackground, .isYouTube, Bool, String, URL

### Community 37 - ".transitionTransform"
Cohesion: 0.09
Nodes (34): Angle, AnimatableModifier, AnimatedTextSegmentModifier, SequentialWordTransitionModifier, .animatableData, .layoutSegmentIndex, .layoutTotalWords, SlideTransitionModifier (+26 more)

### Community 38 - "SwiftUI"
Cohesion: 0.18
Nodes (5): AppKit, AVFoundation, LyricClipboardImporter, SwiftUI, UIKit

### Community 39 - "lyricTextFragment"
Cohesion: 0.13
Nodes (17): constant, float2, float4, fragment, lyricTextFragment(), lyricTextVertex(), TextEffectUniforms, chromaticStrength (+9 more)

### Community 40 - "SlideAnimationProfile"
Cohesion: 0.14
Nodes (11): assignments, SlideAnimationProfile, .hasAnimations, .hasPersistentEffects, .hasProPersistentEffects, .hasTransition, .preferredEffectSelectionTarget, .preferredTransitionSelectionTarget (+3 more)

### Community 41 - "What You Must Do When Invoked"
Cohesion: 0.08
Nodes (24): For /graphify add and --watch, For /graphify query, For the commit hook and native CLAUDE.md integration, For --update and --cluster-only, /graphify, Honesty Rules, Interpreter guard for subcommands, Part A - Structural extraction for code files (+16 more)

### Community 42 - "AppViewModel"
Cohesion: 0.07
Nodes (24): AppViewModel, .hasControllableVideoBackgroundSelected, .hasCustomBackgroundSelected, .hasVideoBackgroundSelected, .hasYouTubeBackgroundSelected, .isSimplePlayConnected, .resolvedVideoLoops, .selectedLyric (+16 more)

### Community 43 - "PresentationContentView"
Cohesion: 0.40
Nodes (5): PresentationContentView, .body, .textConfiguration, AVPlayer, Bool

### Community 44 - "YouTubePlaybackController"
Cohesion: 0.08
Nodes (32): Decodable, OEmbedResponse, String, URL, YouTubeMetadataLoader, TimeInterval, Void, YouTubePlaybackController (+24 more)

### Community 45 - "LyricLanguage"
Cohesion: 0.12
Nodes (15): LyricLanguage, .displayName, english, .id, spanish, unknown, tagStyles, LyricEditorSlideCard (+7 more)

### Community 46 - "GlassCircleIcon"
Cohesion: 0.67
Nodes (3): GlassCircleIcon, .body, String

### Community 47 - "LyricSlideTag"
Cohesion: 0.10
Nodes (23): ButtonRole, Identifiable, LyricSectionSource, String, UUID, LyricSlideTag, bridge, chorus (+15 more)

### Community 48 - "GlassPanel.swift"
Cohesion: 0.18
Nodes (13): GlassPanel, .panelShape, GlassToolbarIconSize, .frameSize, .iconFont, prominent, regular, GlassToolbarIconStyle (+5 more)

### Community 49 - "PlaylistPickerSheet"
Cohesion: 0.28
Nodes (7): PlaylistPickerSheet, .createPlaylistCard, .filteredPlaylists, .isSearching, .totalItemCount, Bool, Int

### Community 50 - "LyricSlideLayoutEngine"
Cohesion: 0.38
Nodes (6): LyricSlideLayoutEngine, CGFloat, CGSize, Int, SlideTextStyle, String

### Community 51 - ".measureSingleLine"
Cohesion: 0.37
Nodes (7): PresentationTextMeasurer, Any, Bool, CGFloat, CGSize, String, NSAttributedString

### Community 52 - "GlassIconButton"
Cohesion: 0.16
Nodes (13): GlassIconButton, .body, .foregroundColor, Bool, Color, Constants, PresentationActionsToolbar, .body (+5 more)

### Community 53 - ".selectBackgroundMedia"
Cohesion: 0.16
Nodes (9): LibrarySearchEmptyState, PlaylistFilterBar, .selectedPlaylist, .body, MediaImportToolbarButton, .photoPickerSelection, Binding, PhotosPickerItem (+1 more)

### Community 54 - "ExternalDisplaySceneCoordinator"
Cohesion: 0.14
Nodes (10): ExternalDisplaySceneCoordinator, UIWindowScene, ExternalDisplaySceneDelegate, UICoordinateSpace, UIInterfaceOrientation, UIResponder, UIScene, UISceneSession (+2 more)

### Community 55 - "LyrioraUITests"
Cohesion: 0.15
Nodes (6): LyrioraUITests, LyrioraUITestsLaunchTests, .runsForEachTargetApplicationUIConfiguration, Bool, XCTest, XCTestCase

### Community 56 - "MetalTextEffectRenderer"
Cohesion: 0.15
Nodes (13): MetalTextEffectRenderer, CGSize, CGRect, NSCoder, NSRect, MTKView, MTKViewDelegate, MTLCommandQueue (+5 more)

### Community 57 - "CodingKeys"
Cohesion: 0.18
Nodes (11): CodingKeys, effectAssignments, effectFallback, effectIntensity, effectSpeed, fallbackAnimation, transitionAssignments, transitionIntensity (+3 more)

### Community 58 - "Foundation"
Cohesion: 0.12
Nodes (7): CoreGraphics, Foundation, VideoControlsReveal, Observation, Photos, PhotosUI, UniformTypeIdentifiers

### Community 59 - "View"
Cohesion: 0.29
Nodes (11): ProTextSegmentView, .body, Bool, CGSize, Color, Double, Font, Int (+3 more)

### Community 60 - "LyricStyleProfile"
Cohesion: 0.18
Nodes (12): LyricStyleProfile, SlideTextStyle, .fontSize, Bool, Decoder, Double, Encoder, Int (+4 more)

### Community 61 - ".matches"
Cohesion: 0.30
Nodes (6): Bool, LibrarySearch, LyricDocument, .searchableText, Bool, String

### Community 62 - "LyricEditorHeaderBar"
Cohesion: 0.22
Nodes (15): LyricEditorChrome, LyricEditorHeaderBar, .body, LyricEditorHeaderButton, .body, LyricEditorNavRow, .body, MacLyricEditorHeaderChrome (+7 more)

### Community 63 - "DefaultBackgroundPreset"
Cohesion: 0.17
Nodes (11): DefaultBackgroundPreset, daylightWaves, .id, .isAdaptive, .label, meshWaves, morningHaze, twilightWaves (+3 more)

### Community 64 - "DefaultBackgroundPresetPreview"
Cohesion: 0.33
Nodes (6): EdgeInsets, DefaultBackgroundPresetPreview, .body, DefaultBackgroundPreviewCard, .body, .defaultBackgroundSection

### Community 65 - "AdaptivePresentationText"
Cohesion: 0.18
Nodes (8): CGSize, AdaptivePresentationText, .body, .lines, Bool, Int, String, UUID

### Community 66 - "AnimatedPresentationText"
Cohesion: 0.06
Nodes (47): CGFloat, Double, Int, UUID, WordFontSizeOverride, WordFontSizeResolver, PresentationAnimationQuality, .effectFrameInterval (+39 more)

### Community 68 - "SlideGridView"
Cohesion: 0.07
Nodes (37): SlideGridView, .body, .slideGridHeader, .thumbnailWidth, SlideThumbnailView, .textConfiguration, .thumbnailCanvasSize, .thumbnailStyle (+29 more)

### Community 69 - "PresentationTextConfiguration"
Cohesion: 0.31
Nodes (8): PresentationTextConfiguration, SlideTextStyle, Bool, CGFloat, Color, Double, SlideTextStyle, .emptyLinePlaceholder

### Community 71 - ".shadowColor"
Cohesion: 0.36
Nodes (6): .body, GlassControlChrome, ColorScheme, LinearGradient, .expandedSearchField, .body

### Community 73 - "ExternalPresentationContainerViewController"
Cohesion: 0.21
Nodes (8): ExternalPresentationContainerViewController, AnyView, Bool, CGSize, View, Void, UIHostingController, UIViewController

### Community 74 - "TextAnimationAssignment"
Cohesion: 0.29
Nodes (8): SlideTransitionTiming, Bool, Decoder, Double, TimeInterval, UUID, TextAnimationAssignment, .appliesToGroup

### Community 75 - "ClearerAnchorView"
Cohesion: 0.22
Nodes (7): ClearerAnchorView, NavigationSplitViewBackgroundClearer, Context, UIView, UIViewController, View, UIViewRepresentable

### Community 76 - "View"
Cohesion: 0.31
Nodes (5): GlassControlBorderModifier, Content, View, S, ViewModifier

### Community 77 - "ThemeRepository"
Cohesion: 0.36
Nodes (3): FileManager, URL, ThemeRepository

### Community 80 - "TransitionSpeedControl"
Cohesion: 0.20
Nodes (9): .defaultTransitionControls, Bool, Double, Int, String, Void, TransitionSpeedControl, .body (+1 more)

### Community 82 - "PlaylistEditorSheet"
Cohesion: 0.18
Nodes (11): PlaylistEditorSheet, .allItemIDs, .availableItems, .availableSearchPlaceholder, .body, .filteredAvailableItems, .resolvedPlaylist, .showsMediaPreview (+3 more)

### Community 83 - "MacWindowConfigurator"
Cohesion: 0.33
Nodes (6): MacWindowConfigurator, Bool, Context, NSView, View, NSViewRepresentable

### Community 84 - "DefaultBackgroundMeshStyle"
Cohesion: 0.14
Nodes (15): .body, DefaultBackgroundMeshStyle, .colors, daylightWaves, morningHaze, twilightWaves, violetDusk, .wavePoints (+7 more)

### Community 85 - "StickyPreviewEditorLayout"
Cohesion: 0.29
Nodes (6): StickyPreviewEditorLayout, .body, .stickyBackground, CGFloat, Content, Preview

### Community 86 - "content"
Cohesion: 0.23
Nodes (11): content, BlurredBackgroundLayer, .body, BlurredBackgroundModifier, CGFloat, Content, Double, View (+3 more)

### Community 87 - "LyricTheme"
Cohesion: 0.27
Nodes (7): LyricTheme, Date, Int, SlideTextStyle, String, UUID, .previewText

### Community 88 - "PresentationLayout"
Cohesion: 0.26
Nodes (8): PresentationLayout, CGFloat, CGSize, .presentationLayoutCanvasSize, .body, .canvasAspectRatio, .canvasSize, .previewSection

### Community 89 - ".refreshDisplayInfo"
Cohesion: 0.23
Nodes (3): Int, Task, UIWindowScene

### Community 90 - "ThemeSavePromptSheet"
Cohesion: 0.22
Nodes (7): Bool, String, Void, ThemeSavePromptSheet, .header, .themeNameField, .trimmedThemeName

### Community 91 - "LyricEditorNavigationOption"
Cohesion: 0.22
Nodes (8): LyricEditorNavigationOption, .id, lyrics, .systemImage, .title, typography, String, Self

### Community 92 - "WorkspaceDevice"
Cohesion: 0.33
Nodes (6): EnvironmentValues, .workspaceCompactLayout, Bool, WorkspaceDevice, .isPad, .isPhone

### Community 93 - "ExternalDisplayInfo"
Cohesion: 0.15
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

### Community 98 - "BackgroundContentMode"
Cohesion: 0.05
Nodes (47): AnyClass, AVKit, AVPlayerView, BackgroundContentMode, auto, fill, fit, .id (+39 more)

### Community 99 - "GlobalStyleEditorView"
Cohesion: 0.21
Nodes (8): KeyboardDismissal, GlobalStyleEditorView, .body, .hasStyleChanges, Bool, SlideTextStyle, String, UUID

### Community 100 - "PresentationVideoControls"
Cohesion: 0.31
Nodes (8): .body, PresentationVideoControls, .activeDuration, .displayedCurrentTime, .sliderBinding, .usesYouTubePlayback, Binding, TimeInterval

### Community 101 - "PresentationBackgroundView"
Cohesion: 0.25
Nodes (9): ConfigurableDefaultGradientView, .layerIdentity, .body, PresentationBackgroundView, .backgroundContent, .body, AVPlayer, Bool (+1 more)

### Community 102 - "Equatable"
Cohesion: 0.18
Nodes (11): Equatable, AppSettings, PresentationTextSettings, Bool, Decoder, Double, SettingsRepository, FileManager (+3 more)

### Community 103 - "PlaylistMediaPreview"
Cohesion: 0.48
Nodes (6): PlaylistImagePreview, PlaylistMediaPreview, .body, PlaylistVideoPreview, CGFloat, URL

### Community 105 - "PresentationState"
Cohesion: 0.25
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

### Community 110 - ".body"
Cohesion: 0.15
Nodes (11): Hashable, LyricEditorLaunch, UUID, LyricRepositoryProtocol, SettingsRepositoryProtocol, ThemeRepositoryProtocol, seedSampleLyricsIfNeeded(), LyricDocument (+3 more)

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
Cohesion: 0.13
Nodes (14): CaseIterable, AnimationApplyScope, allSlides, currentSlide, .id, .label, Int, String (+6 more)

### Community 129 - "String"
Cohesion: 0.27
Nodes (7): PickedImageFile, .transferRepresentation, PickedVideoFile, .transferRepresentation, String, Transferable, TransferRepresentation

### Community 130 - "MetalTextEffectRenderer.swift"
Cohesion: 0.40
Nodes (4): MetalTextEffectSupport, Bool, Metal, MetalKit

### Community 132 - ".body"
Cohesion: 0.50
Nodes (3): .body, GlassCapsuleToolbar, .body

## Knowledge Gaps
- **504 isolated node(s):** `regular`, `medium`, `semibold`, `bold`, `.id` (+499 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **11 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AppViewModel` connect `AppViewModel` to `ExternalDisplayManager`, `String`, `LibraryPlaylist`, `PresentationPreviewView`, `.body`, `LyricEditorView`, `SlideTransitionTextContainer`, `MediaAsset`, `GlobalStyleEditorContent`, `LyricImportParser`, `MediaThumbnailView`, `VideoPlaybackController`, `LyricSlide`, `LyricsLibraryPanelView`, `Sendable`, `PresentationBackground`, `YouTubePlaybackController`, `PlaylistPickerSheet`, `.selectBackgroundMedia`, `Foundation`, `SlideGridView`, `.rechunkSlides`, `PlaylistEditorSheet`, `LyricTheme`, `PresentationLayout`, `.refreshDisplayInfo`, `GlobalStyleEditorView`, `PresentationVideoControls`, `PresentationState`, `.body`, `VideoPlaybackMode`?**
  _High betweenness centrality (0.189) - this node is a cross-community bridge._
- **Why does `SwiftUI` connect `SwiftUI` to `MetalTextEffectRenderer.swift`, `GlassMorphAnimation.swift`, `ThemeMiniPreview`, `SlideTransitionTextContainer`, `LyricEditorView`, `PresentationFontFamily`, `LyricSlideLivePreview`, `MediaThumbnailView`, `SlideDetailEditorView`, `PlaylistGlassModal.swift`, `ExplicitLinePresentationText`, `LyricSlide`, `PresentationBackgroundLayer`, `LyricsLibraryPanelView`, `LibraryMorphSearchHeader`, `.transitionTransform`, `YouTubePlaybackController`, `LyricLanguage`, `GlassPanel.swift`, `GlassIconButton`, `Foundation`, `LyricEditorHeaderBar`, `DefaultBackgroundPresetPreview`, `AdaptivePresentationText`, `AnimatedPresentationText`, `SlideGridView`, `ClearerAnchorView`, `TransitionSpeedControl`, `DefaultBackgroundMeshStyle`, `StickyPreviewEditorLayout`, `content`, `ThemeSavePromptSheet`, `LyricEditorNavigationOption`, `ExternalDisplayInfo`, `BackgroundContentMode`, `GlobalStyleEditorView`, `PlaylistMediaPreview`, `.linearGradient`?**
  _High betweenness centrality (0.103) - this node is a cross-community bridge._
- **Why does `LyricSlide` connect `LyricSlide` to `String`, `LyricEditorView`, `GlobalStyleEditorContent`, `LyricImportParser`, `LyricSlideLivePreview`, `SlideDetailEditorView`, `LyricDocument`, `MediaAssetKind`, `CodingKeys`, `ExplicitLinePresentationText`, `PresentationBackgroundLayer`, `Sendable`, `SlideAnimationProfile`, `AppViewModel`, `LyricLanguage`, `LyricSlideTag`, `LyricSlideLayoutEngine`, `Foundation`, `AnimatedPresentationText`, `SlideGridView`, `.rechunkSlides`, `Equatable`, `PresentationState`, `TextAnimationTarget`?**
  _High betweenness centrality (0.068) - this node is a cross-community bridge._
- **Are the 17 inferred relationships involving `AppViewModel` (e.g. with `.body` and `LyrioraApp`) actually correct?**
  _`AppViewModel` has 17 INFERRED edges - model-reasoned connections that need verification._
- **Are the 2 inferred relationships involving `LyricEditorView` (e.g. with `.body` and `.body`) actually correct?**
  _`LyricEditorView` has 2 INFERRED edges - model-reasoned connections that need verification._
- **What connects `regular`, `medium`, `semibold` to the rest of the system?**
  _504 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `ExternalDisplayManager` be split into smaller, more focused modules?**
  _Cohesion score 0.1225071225071225 - nodes in this community are weakly interconnected._