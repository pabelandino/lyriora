# Graph Report - Lyriora  (2026-08-14)

## Corpus Check
- 130 files · ~67,422 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 2100 nodes · 4493 edges · 129 communities (104 shown, 25 thin omitted)
- Extraction: 92% EXTRACTED · 8% INFERRED · 0% AMBIGUOUS · INFERRED: 353 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `93751d12`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- .handleExternalSceneConnected
- ExplicitLinePresentationText
- LyricEditorView
- ThemeMiniPreview
- SwiftUI
- PresentationFontFamily
- GlassCircleIcon
- .configure
- CodingKeys
- Sendable
- .resolvedMetrics
- MediaLibraryPanelView.swift
- AppViewModel
- .loadThumbnail
- LyricSlideLivePreview
- LyricSlide
- PresentationFontWeight
- BackgroundContentMode
- LibraryPlaylist
- AppSettings
- LocalFileImageBackground
- LyricImportParser
- AnimatedPresentationText
- VideoPlaybackController
- SlideDetailEditorView
- .body
- ExternalDisplayManager
- PresentationPreviewView
- LyrioraUITests
- TextAnimationKind
- MediaRepository
- LyricSlideTag
- SlideGridView
- MediaAsset
- TextAnimationEditorSection
- LyricCardView
- .showPresentation
- TextAnimationTarget
- String
- .body
- LyricLanguage
- LibraryMorphSearchHeader
- LyricDocument
- ParsedSlideText
- LyricDocument
- PresentationBackgroundLayer
- DisplayInfoSheet
- LyricPlaySyncMessageKind
- LyricRepository
- LyrioraTests.swift
- LyricsLibraryPanelView
- View
- MetalTextEffectRenderer
- Identifiable
- SlideTransitionTextContainer
- PlaylistEditorSheet
- What You Must Do When Invoked
- What You Must Do When Invoked
- DefaultBackgroundPreset
- .refreshDisplayInfo
- SlideAnimationProfile
- LyricPlaySyncServer
- .transitionTransform
- lyricTextFragment
- TextAnimationAssignment
- .make
- PresentationTextConfiguration
- .saveLyric
- MainView
- ExternalPresentationContainerViewController
- LyricSlideLayoutEngine
- VideoPlaybackMode
- GlobalStyleEditorView
- .measureSingleLine
- LyricTheme
- CodingKeys
- TextAnimationTransform
- .resolve
- Foundation
- LyricStyleProfile
- GlobalStyleEditorContent
- .parse
- CodingKeys
- MacWindowConfigurator
- PlaylistMediaPreview
- TransitionSpeedControl
- graphify reference: extra exports and benchmark
- graphify reference: extra exports and benchmark
- LyricEditorNavigationOption
- PlaylistPickerSheet
- ThemeRepository
- ThemeSavePromptSheet
- MediaThumbnailView
- .displayName
- .importLyricsFromClipboard
- AdaptivePresentationText
- graphify reference: query, path, explain
- graphify reference: query, path, explain
- Decoder
- content
- Double
- PresentationFontWeight
- .body
- graphify reference: add a URL and watch a folder
- graphify reference: commit hook and native AGENTS.md integration
- graphify reference: incremental update and cluster-only
- graphify reference: add a URL and watch a folder
- graphify reference: commit hook and native CLAUDE.md integration
- graphify reference: incremental update and cluster-only
- graphify reference: GitHub clone and cross-repo merge
- graphify reference: transcribe video and audio
- graphify reference: GitHub clone and cross-repo merge
- graphify reference: transcribe video and audio
- Data
- .agents/skills/graphify/references/extraction-spec.md
- CLAUDE.md
- .claude/CLAUDE.md
- .claude/skills/graphify/references/extraction-spec.md
- WorkspaceCompactLayout.swift
- MediaAsset
- MediaAsset
- Never
- Task
- TimeInterval
- Color
- GlassMorphAnimation.swift
- MediaAsset
- RoundedRectangle
- LyricDocument

## God Nodes (most connected - your core abstractions)
1. `AppViewModel` - 156 edges
2. `TextAnimationKind` - 75 edges
3. `SlideAnimationProfile` - 60 edges
4. `LyricEditorView` - 51 edges
5. `ExternalDisplayManager` - 50 edges
6. `LyricSlide` - 47 edges
7. `TextAnimationEditorSection` - 46 edges
8. `PresentationTextConfiguration` - 37 edges
9. `GlobalStyleEditorContent` - 36 edges
10. `LibraryPlaylist` - 34 edges

## Surprising Connections (you probably didn't know these)
- `.activeTheme` --references--> `AppViewModel`  [INFERRED]
  Lyriora/Views/Modals/LyricEditorView.swift → Lyriora/ViewModels/AppViewModel.swift
- `.resolvedPlaylist` --references--> `AppViewModel`  [INFERRED]
  Lyriora/Views/Modals/PlaylistSheets.swift → Lyriora/ViewModels/AppViewModel.swift
- `.body` --calls--> `content`  [INFERRED]
  Lyriora/Views/Components/GlassPanel.swift → Lyriora/Models/LyricDocument.swift
- `.headerRow` --references--> `LyricSlide`  [INFERRED]
  Lyriora/Views/Components/LyricSlideLivePreview.swift → Lyriora/Models/LyricSlide.swift
- `.selectedTheme` --references--> `LyricTheme`  [INFERRED]
  Lyriora/Views/Components/ThemePreviewCard.swift → Lyriora/Models/LyricTheme.swift

## Import Cycles
- None detected.

## Communities (129 total, 25 thin omitted)

### Community 0 - ".handleExternalSceneConnected"
Cohesion: 0.13
Nodes (10): ExternalDisplaySceneCoordinator, UIWindowScene, ExternalDisplaySceneDelegate, UICoordinateSpace, UIInterfaceOrientation, UIResponder, UIScene, UISceneSession (+2 more)

### Community 1 - "ExplicitLinePresentationText"
Cohesion: 0.13
Nodes (20): EnvironmentKey, .body, EditorAdaptivePresentationText, .body, .lines, .resolvedConfiguration, EditorPreviewSizing, exact (+12 more)

### Community 2 - "LyricEditorView"
Cohesion: 0.08
Nodes (26): sourceSections, EditorCard, .cardBackground, LyricEditorView, .activeTheme, .body, .editorBackground, .hasStyleChanges (+18 more)

### Community 3 - "ThemeMiniPreview"
Cohesion: 0.14
Nodes (21): Bool, CGFloat, SlideTextStyle, String, UUID, Void, ThemeGalleryView, .body (+13 more)

### Community 4 - "SwiftUI"
Cohesion: 0.28
Nodes (4): AppKit, AVFoundation, SwiftUI, UIKit

### Community 5 - "PresentationFontFamily"
Cohesion: 0.12
Nodes (20): PresentationFontFamily, arial, avenirNext, courierNew, futura, georgia, helveticaNeue, .id (+12 more)

### Community 6 - "GlassCircleIcon"
Cohesion: 0.06
Nodes (46): .presentationToolbar, GlassCapsuleToolbar, .body, GlassCircleIcon, .body, GlassControlBorderModifier, GlassControlChrome, GlassIconButton (+38 more)

### Community 7 - ".configure"
Cohesion: 0.11
Nodes (25): TimeInterval, Void, VideoProgressReporter, Coordinator, LoopingVideoBackground, .body, LoopingVideoBackgroundRepresentable, LoopingVideoPlayerView (+17 more)

### Community 8 - "CodingKeys"
Cohesion: 0.10
Nodes (21): CodingKeys, defaultAnimationProfile, defaultStyle, fontDesign, fontFamily, fontWeight, horizontalPaddingRatio, isAdaptiveScalingEnabled (+13 more)

### Community 9 - "Sendable"
Cohesion: 0.17
Nodes (19): Codable, Hashable, JSONEncoder, LyricEditorLaunch, UUID, LinkSectionCommand, LyricPlaySync, LyricPlaySyncCodec (+11 more)

### Community 10 - ".resolvedMetrics"
Cohesion: 0.19
Nodes (13): ExternalDisplayDiscovery, ExternalDisplayMetrics, Source, liveContainer, liveWindow, sceneCoordinateSpace, screenBounds, Bool (+5 more)

### Community 11 - "MediaLibraryPanelView.swift"
Cohesion: 0.27
Nodes (10): LocalFileThumbnailImage, LocalFileVideoThumbnail, MediaImportContentTypes, MediaLibraryPlaylistActions, .thumbnailContent, Image, URL, View (+2 more)

### Community 12 - "AppViewModel"
Cohesion: 0.06
Nodes (31): ExternalDisplayManager, LyricEditorLaunch, LyricPlaySyncMessage, LyricRepositoryProtocol, LyricSlideCatalog, AppViewModel, .activePresentationBackground, .hasCustomBackgroundSelected (+23 more)

### Community 13 - ".loadThumbnail"
Cohesion: 0.15
Nodes (16): AVAssetImageGenerator, Error, Metadata, MetadataError, cancelled, thumbnailFailed, CGImage, CGSize (+8 more)

### Community 14 - "LyricSlideLivePreview"
Cohesion: 0.11
Nodes (23): LyricPreviewBackgroundStyle, borderOnly, settingsDefault, LyricSlideLivePreview, .body, .compactHeight, .cornerRadius, .displayText (+15 more)

### Community 15 - "LyricSlide"
Cohesion: 0.13
Nodes (15): .slides, CGSize, SlideTextStyle, LyricSlide, Int, SlideTextStyle, String, UUID (+7 more)

### Community 16 - "PresentationFontWeight"
Cohesion: 0.12
Nodes (15): CaseIterable, PresentationFontWeight, bold, .id, .label, medium, regular, semibold (+7 more)

### Community 17 - "BackgroundContentMode"
Cohesion: 0.05
Nodes (47): AnyClass, AVKit, AVPlayerView, BackgroundContentMode, auto, fill, fit, .id (+39 more)

### Community 18 - "LibraryPlaylist"
Cohesion: 0.11
Nodes (15): Date, LibraryPlaylist, LibraryPlaylistKind, image, lyric, .systemImage, .title, video (+7 more)

### Community 19 - "AppSettings"
Cohesion: 0.18
Nodes (11): Decoder, Double, AppSettings, PresentationTextSettings, BackgroundContentMode, Bool, DefaultBackgroundSettings, SettingsRepository (+3 more)

### Community 20 - "LocalFileImageBackground"
Cohesion: 0.30
Nodes (11): Entry, LocalImageCache, CGSize, Image, URL, LocalFileImageBackground, .body, CGSize (+3 more)

### Community 21 - "LyricImportParser"
Cohesion: 0.25
Nodes (7): LyricImportParser, LyricImportResult, LyricSectionParseResult, ParsedSections, Bool, Int, String

### Community 22 - "AnimatedPresentationText"
Cohesion: 0.07
Nodes (35): PresentationFontWeight, .nsWeight, .swiftUIWeight, .uiWeight, Font, NSFont, UIFont, AnimatedPresentationText (+27 more)

### Community 23 - "VideoPlaybackController"
Cohesion: 0.15
Nodes (10): AVPlayerLooper, Any, AVPlayer, AVPlayerItem, CMTime, NSObjectProtocol, TimeInterval, URL (+2 more)

### Community 24 - "SlideDetailEditorView"
Cohesion: 0.12
Nodes (20): SlideStyleControlsView, .body, .fontSizeBinding, .horizontalMarginBinding, .verticalMarginBinding, Binding, Double, SlideTextStyle (+12 more)

### Community 25 - ".body"
Cohesion: 0.15
Nodes (21): LinearGradient, PlaylistGlassEmptyState, .body, PlaylistGlassNameField, PlaylistGlassRowButton, .body, PlaylistGlassSearchField, PlaylistGlassSectionLabel (+13 more)

### Community 26 - "ExternalDisplayManager"
Cohesion: 0.14
Nodes (13): ExternalDisplayManager, .displayMonitorInterval, .isExternalDisplayConnected, ExternalPresentationWindow, .canBecomeKey, .canBecomeMain, Bool, Never (+5 more)

### Community 27 - "PresentationPreviewView"
Cohesion: 0.07
Nodes (33): PresentationLayout, CGFloat, CGSize, .presentationLayoutCanvasSize, PresentationState, Bool, Int, SlideTextStyle (+25 more)

### Community 28 - "LyrioraUITests"
Cohesion: 0.15
Nodes (6): LyrioraUITests, LyrioraUITestsLaunchTests, .runsForEachTargetApplicationUIConfiguration, Bool, XCTest, XCTestCase

### Community 29 - "TextAnimationKind"
Cohesion: 0.04
Nodes (47): Bool, TextAnimationKind, .basicCases, blink, blinkSemiRotate, bounce, chromaticShift, .displayName (+39 more)

### Community 30 - "MediaRepository"
Cohesion: 0.24
Nodes (9): Data, .index, MediaIndexEntry, MediaRepository, FileManager, MediaAssetKind, String, URL (+1 more)

### Community 31 - "LyricSlideTag"
Cohesion: 0.12
Nodes (16): LyricSlideTag, bridge, chorus, .displayName, .id, instrumental, intro, outro (+8 more)

### Community 32 - "SlideGridView"
Cohesion: 0.06
Nodes (43): Color, SlideGridView, .body, .slideGridHeader, .thumbnailWidth, SlideThumbnailView, .textConfiguration, .thumbnailCanvasSize (+35 more)

### Community 33 - "MediaAsset"
Cohesion: 0.12
Nodes (19): MediaRepositoryProtocol, MediaAsset, .selectedPhotoItems, .selectedVideoItems, importSelectedVideos(), URL, PlaylistFilterBar, .selectedPlaylist (+11 more)

### Community 34 - "TextAnimationEditorSection"
Cohesion: 0.11
Nodes (19): Binding, Bool, Int, String, Void, TextAnimationEditorSection, .activeTransitionKind, .animationResetToolbar (+11 more)

### Community 35 - "LyricCardView"
Cohesion: 0.13
Nodes (15): LyricGradient, Color, LinearGradient, UInt64, Layout, .trailingControlInset, LyricCardView, .body (+7 more)

### Community 36 - ".showPresentation"
Cohesion: 0.13
Nodes (12): ExternalDisplayInfo, .resolutionDescription, Bool, CGFloat, CGSize, String, CGSize, UIWindow (+4 more)

### Community 37 - "TextAnimationTarget"
Cohesion: 0.20
Nodes (10): Equatable, TextAnimationTarget, all, .label, line, paragraph, word, TimeInterval (+2 more)

### Community 38 - "String"
Cohesion: 0.33
Nodes (8): MediaAsset, .listLabel, MediaAssetKind, image, video, Date, UUID, String

### Community 39 - ".body"
Cohesion: 0.22
Nodes (6): Bool, .body, SettingsSheet, .body, Binding, String

### Community 40 - "LyricLanguage"
Cohesion: 0.13
Nodes (14): LyricLanguage, .displayName, english, .id, spanish, unknown, LyricEditorSlideCard, .textConfiguration (+6 more)

### Community 41 - "LibraryMorphSearchHeader"
Cohesion: 0.14
Nodes (16): Layout, LibraryMorphSearchHeader, .body, .collapsedSearchButton, .controlSize, .isSearchActive, .resolvedHorizontalPadding, .searchSlot (+8 more)

### Community 43 - "ParsedSlideText"
Cohesion: 0.17
Nodes (9): Int, ParsedSlideText, .isEmpty, .totalWordCount, Bool, Int, Range, String (+1 more)

### Community 44 - "LyricDocument"
Cohesion: 0.30
Nodes (6): Bool, LibrarySearch, LyricDocument, .searchableText, Bool, String

### Community 45 - "PresentationBackgroundLayer"
Cohesion: 0.07
Nodes (40): EdgeInsets, PresentationBackground, URL, ConfigurableDefaultGradientView, .layerIdentity, .body, AppBackgroundAnimation, .transition (+32 more)

### Community 46 - "DisplayInfoSheet"
Cohesion: 0.29
Nodes (6): DisplayInfoSheet, .body, .statusDescription, Bool, String, Void

### Community 47 - "LyricPlaySyncMessageKind"
Cohesion: 0.22
Nodes (9): LyricPlaySyncMessageKind, catalogRequest, catalogResponse, error, linkSection, linkSectionAck, presence, presenceAck (+1 more)

### Community 48 - "LyricRepository"
Cohesion: 0.29
Nodes (5): LyricRepository, FileManager, LyricDocument, URL, UUID

### Community 49 - "LyrioraTests.swift"
Cohesion: 0.33
Nodes (3): Lyriora, LyrioraTests, Testing

### Community 50 - "LyricsLibraryPanelView"
Cohesion: 0.13
Nodes (17): CenterPanelView, .body, String, WorkspaceDisplayToolbar, .displayButtonAccessibilityLabel, MediaLibraryPanelView, .body, .iPadPortraitDetailWorkspace (+9 more)

### Community 51 - "View"
Cohesion: 0.27
Nodes (11): ProTextSegmentView, .body, Bool, CGSize, Color, Double, Font, Int (+3 more)

### Community 52 - "MetalTextEffectRenderer"
Cohesion: 0.05
Nodes (39): MetalTextEffectParameters, .isActive, MetalTextEffectRenderer, MetalTextEffectSupport, Bool, CGImage, CGSize, Double (+31 more)

### Community 53 - "Identifiable"
Cohesion: 0.17
Nodes (13): ButtonRole, Identifiable, LyricDocument, .previewSnippet, Date, Decoder, String, UInt64 (+5 more)

### Community 54 - "SlideTransitionTextContainer"
Cohesion: 0.15
Nodes (18): SlideTransitionTextContainer, .body, .effectiveWordCount, .enterAnimation, .enterDuration, .exitDuration, .transitionState, Animation (+10 more)

### Community 55 - "PlaylistEditorSheet"
Cohesion: 0.19
Nodes (10): PlaylistEditorSheet, .allItemIDs, .availableItems, .availableSearchPlaceholder, .body, .filteredAvailableItems, .resolvedPlaylist, .showsMediaPreview (+2 more)

### Community 56 - "What You Must Do When Invoked"
Cohesion: 0.08
Nodes (24): For /graphify add and --watch, For /graphify query, For the commit hook and native AGENTS.md integration, For --update and --cluster-only, /graphify, Honesty Rules, Interpreter guard for subcommands, Part A - Structural extraction for code files (+16 more)

### Community 57 - "What You Must Do When Invoked"
Cohesion: 0.08
Nodes (24): For /graphify add and --watch, For /graphify query, For the commit hook and native CLAUDE.md integration, For --update and --cluster-only, /graphify, Honesty Rules, Interpreter guard for subcommands, Part A - Structural extraction for code files (+16 more)

### Community 58 - "DefaultBackgroundPreset"
Cohesion: 0.08
Nodes (27): .body, DefaultBackgroundMeshStyle, .colors, daylightWaves, morningHaze, twilightWaves, violetDusk, .wavePoints (+19 more)

### Community 60 - "SlideAnimationProfile"
Cohesion: 0.15
Nodes (11): assignments, SlideAnimationProfile, .hasAnimations, .hasPersistentEffects, .hasTransition, .preferredEffectSelectionTarget, .preferredTransitionSelectionTarget, Encoder (+3 more)

### Community 61 - "LyricPlaySyncServer"
Cohesion: 0.08
Nodes (26): LocalizedError, LyricImportError, empty, .errorDescription, notText, unsupportedContent, LyricPlaySyncServer, LyricPlaySyncTransportError (+18 more)

### Community 62 - ".transitionTransform"
Cohesion: 0.25
Nodes (11): AnimatableModifier, SequentialWordTransitionModifier, .animatableData, .layoutSegmentIndex, .layoutTotalWords, SlideTransitionModifier, .animatableData, Bool (+3 more)

### Community 63 - "lyricTextFragment"
Cohesion: 0.13
Nodes (17): constant, float2, float4, fragment, lyricTextFragment(), lyricTextVertex(), TextEffectUniforms, chromaticStrength (+9 more)

### Community 64 - "TextAnimationAssignment"
Cohesion: 0.24
Nodes (10): SlideTransitionState, .showsPersistentEffects, SlideTransitionTiming, Bool, Decoder, Double, TimeInterval, UUID (+2 more)

### Community 65 - ".make"
Cohesion: 0.21
Nodes (10): MediaAssetKind, ImageLibrarySection, .filteredAssets, .isPlaylistFiltered, Bool, GlassOverflowMenu, UUID, VideoLibrarySection (+2 more)

### Community 66 - "PresentationTextConfiguration"
Cohesion: 0.36
Nodes (8): PresentationTextConfiguration, SlideTextStyle, Bool, CGFloat, Color, Double, PresentationFontWeight, SlideTextStyle

### Community 67 - ".saveLyric"
Cohesion: 0.11
Nodes (17): LinkSectionCommand, LyricSectionSource, LyricTheme, LyricRepositoryProtocol, ThemeRepositoryProtocol, PickedImageFile, .transferRepresentation, PickedVideoFile (+9 more)

### Community 68 - "MainView"
Cohesion: 0.12
Nodes (14): App, ContentView, .body, LyrioraApp, .body, MainView, .adaptiveWorkspace, .iPadPortraitWorkspace (+6 more)

### Community 69 - "ExternalPresentationContainerViewController"
Cohesion: 0.21
Nodes (8): AnyView, ExternalPresentationContainerViewController, Bool, CGSize, View, Void, UIHostingController, UIViewController

### Community 70 - "LyricSlideLayoutEngine"
Cohesion: 0.38
Nodes (6): LyricSlideLayoutEngine, CGFloat, CGSize, Int, SlideTextStyle, String

### Community 71 - "VideoPlaybackMode"
Cohesion: 0.29
Nodes (6): Bool, VideoPlaybackMode, loop, .loopsVideo, playOnce, .toggled

### Community 72 - "GlobalStyleEditorView"
Cohesion: 0.21
Nodes (8): KeyboardDismissal, GlobalStyleEditorView, .body, .hasStyleChanges, Bool, SlideTextStyle, String, UUID

### Community 73 - ".measureSingleLine"
Cohesion: 0.37
Nodes (7): PresentationTextMeasurer, Any, Bool, CGFloat, CGSize, String, NSAttributedString

### Community 74 - "LyricTheme"
Cohesion: 0.27
Nodes (7): LyricTheme, Date, Int, SlideTextStyle, String, UUID, .previewText

### Community 75 - "CodingKeys"
Cohesion: 0.11
Nodes (17): AnimationApplyScope, allSlides, currentSlide, .id, .label, CodingKeys, effectAssignments, effectFallback (+9 more)

### Community 76 - "TextAnimationTransform"
Cohesion: 0.29
Nodes (8): Angle, AnimatedTextSegmentModifier, CGFloat, CGSize, TimeInterval, TextAnimationTransform, View, ViewModifier

### Community 77 - ".resolve"
Cohesion: 0.36
Nodes (5): CharacterSet, MediaDisplayName, Bool, String, Set

### Community 78 - "Foundation"
Cohesion: 0.14
Nodes (3): CoreGraphics, Foundation, Observation

### Community 79 - "LyricStyleProfile"
Cohesion: 0.14
Nodes (16): tagStyles, LyricStyleProfile, SlideTextStyle, .fontSize, Bool, Decoder, Double, Encoder (+8 more)

### Community 80 - "GlobalStyleEditorContent"
Cohesion: 0.18
Nodes (14): GlobalStyleEditorContent, .animationProfileBinding, .body, .currentSlide, .lyricDefaultAnimationBinding, .lyricSlides, .previewAnimationProfile, .previewSlideForDisplay (+6 more)

### Community 81 - ".parse"
Cohesion: 0.18
Nodes (7): SlideTextTokenizer, .parsed, .wordCount, .parsedSampleText, .scopeTargets, Int, Int

### Community 82 - "CodingKeys"
Cohesion: 0.17
Nodes (12): CodingKey, CodingKeys, colorSeed, createdAt, id, language, simplePlayProjectID, simplePlayProjectName (+4 more)

### Community 83 - "MacWindowConfigurator"
Cohesion: 0.33
Nodes (5): MacWindowConfigurator, Context, NSView, View, NSViewRepresentable

### Community 84 - "PlaylistMediaPreview"
Cohesion: 0.31
Nodes (10): PlaylistImagePreview, .body, PlaylistMediaPreview, .body, PlaylistVideoPreview, .body, CGFloat, Image (+2 more)

### Community 85 - "TransitionSpeedControl"
Cohesion: 0.20
Nodes (9): .defaultTransitionControls, Bool, Double, Int, String, Void, TransitionSpeedControl, .body (+1 more)

### Community 86 - "graphify reference: extra exports and benchmark"
Cohesion: 0.22
Nodes (8): graphify reference: extra exports and benchmark, Step 6b - Wiki (only if --wiki flag), Step 7 - Neo4j export (only if --neo4j or --neo4j-push flag), Step 7a - FalkorDB export (only if --falkordb or --falkordb-push flag), Step 7b - SVG export (only if --svg flag), Step 7c - GraphML export (only if --graphml flag), Step 7d - MCP server (only if --mcp flag), Step 8 - Token reduction benchmark (only if total_words > 5000)

### Community 87 - "graphify reference: extra exports and benchmark"
Cohesion: 0.22
Nodes (8): graphify reference: extra exports and benchmark, Step 6b - Wiki (only if --wiki flag), Step 7 - Neo4j export (only if --neo4j or --neo4j-push flag), Step 7a - FalkorDB export (only if --falkordb or --falkordb-push flag), Step 7b - SVG export (only if --svg flag), Step 7c - GraphML export (only if --graphml flag), Step 7d - MCP server (only if --mcp flag), Step 8 - Token reduction benchmark (only if total_words > 5000)

### Community 88 - "LyricEditorNavigationOption"
Cohesion: 0.22
Nodes (8): LyricEditorNavigationOption, .id, .systemImage, .title, typography, String, .sidebarActiveTheme, Self

### Community 89 - "PlaylistPickerSheet"
Cohesion: 0.28
Nodes (7): PlaylistPickerSheet, .createPlaylistCard, .filteredPlaylists, .isSearching, .totalItemCount, Bool, Int

### Community 90 - "ThemeRepository"
Cohesion: 0.36
Nodes (3): FileManager, URL, ThemeRepository

### Community 91 - "ThemeSavePromptSheet"
Cohesion: 0.29
Nodes (6): Bool, String, Void, ThemeSavePromptSheet, .body, .trimmedThemeName

### Community 92 - "MediaThumbnailView"
Cohesion: 0.29
Nodes (8): MediaThumbnailView, .body, .menuIconSize, .overflowActions, .resolvedDurationLabel, .shape, CGFloat, RoundedRectangle

### Community 93 - ".displayName"
Cohesion: 0.29
Nodes (5): PhotosPickerDisplayNameResolver, PhotosPickerItem, String, Photos, PhotosUI

### Community 94 - ".importLyricsFromClipboard"
Cohesion: 0.33
Nodes (4): LyricImportResult, LyricClipboardImporter, String, LyricStyleProfile

### Community 95 - "AdaptivePresentationText"
Cohesion: 0.18
Nodes (8): CGSize, AdaptivePresentationText, .body, .lines, Bool, Int, String, UUID

### Community 96 - "graphify reference: query, path, explain"
Cohesion: 0.33
Nodes (5): For /graphify explain, For /graphify path, graphify reference: query, path, explain, Step 0 — Constrained query expansion (REQUIRED before traversal), Step 1 — Traversal

### Community 97 - "graphify reference: query, path, explain"
Cohesion: 0.33
Nodes (5): For /graphify explain, For /graphify path, graphify reference: query, path, explain, Step 0 — Constrained query expansion (REQUIRED before traversal), Step 1 — Traversal

### Community 99 - "content"
Cohesion: 0.12
Nodes (16): Content, content, .body, StickyPreviewEditorLayout, .body, .stickyBackground, CGFloat, Content (+8 more)

### Community 103 - "graphify reference: add a URL and watch a folder"
Cohesion: 0.50
Nodes (3): For /graphify add, For --watch, graphify reference: add a URL and watch a folder

### Community 104 - "graphify reference: commit hook and native AGENTS.md integration"
Cohesion: 0.50
Nodes (3): For git commit hook, For native AGENTS.md integration, graphify reference: commit hook and native AGENTS.md integration

### Community 105 - "graphify reference: incremental update and cluster-only"
Cohesion: 0.50
Nodes (3): For --cluster-only, For --update (incremental re-extraction), graphify reference: incremental update and cluster-only

### Community 106 - "graphify reference: add a URL and watch a folder"
Cohesion: 0.50
Nodes (3): For /graphify add, For --watch, graphify reference: add a URL and watch a folder

### Community 107 - "graphify reference: commit hook and native CLAUDE.md integration"
Cohesion: 0.50
Nodes (3): For git commit hook, For native CLAUDE.md integration, graphify reference: commit hook and native CLAUDE.md integration

### Community 108 - "graphify reference: incremental update and cluster-only"
Cohesion: 0.50
Nodes (3): For --cluster-only, For --update (incremental re-extraction), graphify reference: incremental update and cluster-only

### Community 118 - "WorkspaceCompactLayout.swift"
Cohesion: 0.33
Nodes (6): EnvironmentValues, .workspaceCompactLayout, Bool, WorkspaceDevice, .isPad, .isPhone

## Knowledge Gaps
- **454 isolated node(s):** `regular`, `medium`, `semibold`, `bold`, `.id` (+449 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **25 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AppViewModel` connect `AppViewModel` to `LyricEditorView`, `LibraryPlaylist`, `VideoPlaybackController`, `ExternalDisplayManager`, `PresentationPreviewView`, `SlideGridView`, `MediaAsset`, `.showPresentation`, `.body`, `LibraryMorphSearchHeader`, `LyricDocument`, `LyricsLibraryPanelView`, `PlaylistEditorSheet`, `.refreshDisplayInfo`, `LyricPlaySyncServer`, `.make`, `.saveLyric`, `MainView`, `GlobalStyleEditorView`, `GlobalStyleEditorContent`, `PlaylistPickerSheet`, `.importLyricsFromClipboard`?**
  _High betweenness centrality (0.237) - this node is a cross-community bridge._
- **Why does `SwiftUI` connect `SwiftUI` to `ExplicitLinePresentationText`, `LyricEditorView`, `ThemeMiniPreview`, `GlassCircleIcon`, `MediaLibraryPanelView.swift`, `LyricSlideLivePreview`, `LyricSlide`, `BackgroundContentMode`, `AnimatedPresentationText`, `SlideDetailEditorView`, `.body`, `SlideGridView`, `TextAnimationEditorSection`, `LyricCardView`, `LyricLanguage`, `LibraryMorphSearchHeader`, `PresentationBackgroundLayer`, `DisplayInfoSheet`, `LyricsLibraryPanelView`, `View`, `MetalTextEffectRenderer`, `SlideTransitionTextContainer`, `DefaultBackgroundPreset`, `.saveLyric`, `MainView`, `GlobalStyleEditorView`, `TextAnimationTransform`, `Foundation`, `MacWindowConfigurator`, `PlaylistMediaPreview`, `TransitionSpeedControl`, `ThemeSavePromptSheet`, `.displayName`, `AdaptivePresentationText`, `content`, `WorkspaceCompactLayout.swift`, `GlassMorphAnimation.swift`?**
  _High betweenness centrality (0.097) - this node is a cross-community bridge._
- **Why does `ExternalDisplayManager` connect `ExternalDisplayManager` to `.handleExternalSceneConnected`, `SwiftUI`, `ExternalPresentationContainerViewController`, `.showPresentation`, `AppViewModel`, `.refreshDisplayInfo`?**
  _High betweenness centrality (0.089) - this node is a cross-community bridge._
- **Are the 16 inferred relationships involving `AppViewModel` (e.g. with `.body` and `LyrioraApp`) actually correct?**
  _`AppViewModel` has 16 INFERRED edges - model-reasoned connections that need verification._
- **Are the 12 inferred relationships involving `SlideAnimationProfile` (e.g. with `.body` and `.previewStageContent()`) actually correct?**
  _`SlideAnimationProfile` has 12 INFERRED edges - model-reasoned connections that need verification._
- **What connects `regular`, `medium`, `semibold` to the rest of the system?**
  _454 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `.handleExternalSceneConnected` be split into smaller, more focused modules?**
  _Cohesion score 0.13438735177865613 - nodes in this community are weakly interconnected._