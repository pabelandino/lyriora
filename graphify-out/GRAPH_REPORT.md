# Graph Report - Lyriora  (2026-11-16)

## Corpus Check
- 154 files · ~82,102 words
- Verdict: corpus is large enough that graph structure adds value.
- Unclassified: 11 file(s) not represented in the graph (top: (none) 4, .xcstrings 2, .mdc 1)

## Summary
- 2561 nodes · 5936 edges · 136 communities (125 shown, 11 thin omitted)
- Extraction: 92% EXTRACTED · 8% INFERRED · 0% AMBIGUOUS · INFERRED: 485 edges (avg confidence: 0.82)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `365b584d`
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
- LyricLanguage
- What You Must Do When Invoked
- MediaThumbnailView
- AnimatedPresentationText
- SlideTextStyle
- TextAnimationEditorSection
- ParsedSlideText
- LyricImportParser
- PresentationFontFamily
- LyricSlideLivePreview
- SlideTransitionTextContainer
- VideoPlaybackController
- SwiftUI
- .resolvedMetrics
- BibleReadingSession
- MediaAssetKind
- CodingKeys
- PlaylistGlassModal.swift
- SlideGridView
- ExplicitLinePresentationText
- Identifiable
- LyricDocument
- PresentationBackground
- MainView
- EditorCard
- BiblePresentationSheet
- String
- MetalTextEffectRenderer
- LibraryMorphSearchHeader
- .init
- .transitionTransform
- Foundation
- lyricTextFragment
- BackgroundFitToolbar
- What You Must Do When Invoked
- AppViewModel
- Image
- YouTubePlaybackController
- LyricSlide
- .matches
- LyricSlideTag
- Sendable
- content
- LyricSlideLayoutEngine
- .measureSingleLine
- GlassIconButton
- BibleXMLDocumentPicker
- ExternalDisplaySceneCoordinator
- LyrioraUITests
- BibleChapterIndex
- CodingKeys
- PresentationBackgroundView
- View
- .loadThumbnail
- ClearerAnchorView
- LyricEditorHeaderBar
- LyricSectionSource
- MacWindowConfigurator
- BibleBookInfo
- DefaultBackgroundPreset
- BackgroundContentMode
- BibleVersionManifest
- PresentationTextConfiguration
- BibleSearchIndex
- .shadowColor
- ThemeSavePromptSheet
- ExternalPresentationContainerViewController
- SlideAnimationProfile
- CenterPanelView
- GlassCircleIcon
- LyrioraTests.swift
- BibleVersionIndex
- BibleSlideGridView
- TransitionSpeedControl
- PresentationAnimationQuality
- PlaylistEditorSheet
- WorkspaceCompactLayout.swift
- DefaultBackgroundMeshStyle
- GlassPanel
- LyricPlaySyncMessage
- PresentationContentView
- StickyPreviewEditorLayout
- .refreshDisplayInfo
- GlassMorphAnimation.swift
- LyricEditorNavigationOption
- MediaAsset
- DisplayInfoSheet
- .resolved
- graphify reference: extra exports and benchmark
- graphify reference: extra exports and benchmark
- LyricRepository
- PlayerLayerView
- BibleSearchEngine
- PresentationState
- .pickFiles
- LyricCardView
- GlassToolbarIconSize
- ContentView
- LyricPlaySyncMessageKind
- .linearGradient
- graphify reference: query, path, explain
- graphify reference: query, path, explain
- BibleThemeQuickPicker
- PresentationVideoControls
- graphify reference: add a URL and watch a folder
- graphify reference: commit hook and native AGENTS.md integration
- graphify reference: incremental update and cluster-only
- graphify reference: add a URL and watch a folder
- graphify reference: commit hook and native CLAUDE.md integration
- graphify reference: incremental update and cluster-only
- GlobalStyleEditorContent
- PresentationFontWeight
- graphify reference: GitHub clone and cross-repo merge
- graphify reference: transcribe video and audio
- graphify reference: GitHub clone and cross-repo merge
- graphify reference: transcribe video and audio
- DefaultBackgroundPresetPreview
- .agents/skills/graphify/references/extraction-spec.md
- CLAUDE.md
- .claude/CLAUDE.md
- .claude/skills/graphify/references/extraction-spec.md
- AppViewModel.swift
- PlaylistPickerSheet
- ExternalDisplayInfo
- PlaylistMediaPreview
- LyricsLibraryPanelView
- LyrioraApp
- AdaptivePresentationText
- LyricImportError

## God Nodes (most connected - your core abstractions)
1. `AppViewModel` - 206 edges
2. `TextAnimationKind` - 76 edges
3. `SlideAnimationProfile` - 67 edges
4. `LyricEditorView` - 67 edges
5. `LyricSlide` - 62 edges
6. `MediaAsset` - 54 edges
7. `Image` - 53 edges
8. `ExternalDisplayManager` - 51 edges
9. `TextAnimationEditorSection` - 46 edges
10. `PresentationTextConfiguration` - 44 edges

## Surprising Connections (you probably didn't know these)
- `.body` --calls--> `content`  [INFERRED]
  Lyriora/Views/Components/GlassPanel.swift → Lyriora/Models/LyricDocument.swift
- `.body` --calls--> `content`  [INFERRED]
  Lyriora/Views/Components/GlassPanel.swift → Lyriora/Models/LyricDocument.swift
- `.body` --calls--> `content`  [INFERRED]
  Lyriora/Views/Modals/PlaylistGlassModal.swift → Lyriora/Models/LyricDocument.swift
- `.slidesRefreshID` --references--> `LyricSlide`  [INFERRED]
  Lyriora/Views/Components/LyricEditorSlideHorizontalListView.swift → Lyriora/Models/LyricSlide.swift
- `.activeThemeName` --references--> `LyricStyleProfile`  [INFERRED]
  Lyriora/Views/Modals/LyricEditorView.swift → Lyriora/Models/SlideTextStyle.swift

## Import Cycles
- None detected.

## Communities (136 total, 11 thin omitted)

### Community 0 - "ExternalDisplayManager"
Cohesion: 0.12
Nodes (18): ExternalDisplayManager, .displayMonitorInterval, .isExternalDisplayConnected, ExternalPresentationWindow, .canBecomeKey, .canBecomeMain, Bool, CGSize (+10 more)

### Community 1 - "PresentationPreviewView"
Cohesion: 0.23
Nodes (10): PresentationPreviewView, .isVideoBackground, .previewMetadataBar, .previewStage, .showsSlidePlaceholder, .showsVideoControls, .textConfiguration, .usesLocalVideoPlayerStage (+2 more)

### Community 2 - "LibraryPlaylist"
Cohesion: 0.10
Nodes (19): LibraryPlaylist, LibraryPlaylistKind, image, lyric, .systemImage, .title, video, Date (+11 more)

### Community 3 - ".configure"
Cohesion: 0.10
Nodes (29): TimeInterval, UUID, VideoSeekRequest, TimeInterval, Void, VideoProgressReporter, Coordinator, LoopingVideoBackground (+21 more)

### Community 4 - "TextAnimationKind"
Cohesion: 0.04
Nodes (47): Bool, TextAnimationKind, .basicCases, blink, blinkSemiRotate, bounce, chromaticShift, .displayName (+39 more)

### Community 5 - "LyricEditorView"
Cohesion: 0.08
Nodes (27): LyricEditorView, .activeTheme, .activeThemeName, .body, .canSave, .compactSplitLayout, .editorBackground, .editorBackgroundColor (+19 more)

### Community 6 - "LyricTheme"
Cohesion: 0.08
Nodes (31): LyricTheme, Date, Int, SlideTextStyle, String, UUID, FileManager, URL (+23 more)

### Community 7 - "LyricLanguage"
Cohesion: 0.12
Nodes (15): LyricLanguage, .displayName, english, .id, spanish, unknown, LyricEditorSlideCard, .body (+7 more)

### Community 8 - "What You Must Do When Invoked"
Cohesion: 0.08
Nodes (24): For /graphify add and --watch, For /graphify query, For the commit hook and native AGENTS.md integration, For --update and --cluster-only, /graphify, Honesty Rules, Interpreter guard for subcommands, Part A - Structural extraction for code files (+16 more)

### Community 9 - "MediaThumbnailView"
Cohesion: 0.10
Nodes (28): GlassOverflowMenu, ClipboardLinkReader, .string, ImageLibrarySection, .filteredAssets, .isPlaylistFiltered, MediaImportContentTypes, MediaLibraryPanelView (+20 more)

### Community 10 - "AnimatedPresentationText"
Cohesion: 0.12
Nodes (23): Font, AnimatedPresentationText, .allowsEffectTimelineUpdates, .animatedBody, .emptyLinePlaceholder, .proRenderQuality, .shouldRenderAnimatedContent, .shouldRunEffectTimeline (+15 more)

### Community 11 - "SlideTextStyle"
Cohesion: 0.23
Nodes (11): SlideTextStyle, .fontSize, Bool, Decoder, Double, Encoder, Int, CodableColor (+3 more)

### Community 12 - "TextAnimationEditorSection"
Cohesion: 0.11
Nodes (24): TextAnimationTarget, all, .label, line, paragraph, word, Binding, Bool (+16 more)

### Community 13 - "ParsedSlideText"
Cohesion: 0.12
Nodes (15): Int, ParsedSlideText, .isEmpty, .totalWordCount, SlideTextTokenizer, Bool, Int, Range (+7 more)

### Community 14 - "LyricImportParser"
Cohesion: 0.16
Nodes (9): String, LyricImportParser, LyricImportResult, LyricSectionParseResult, ParsedSections, Bool, Int, String (+1 more)

### Community 15 - "PresentationFontFamily"
Cohesion: 0.07
Nodes (30): PresentationFontFamily, americanTypewriter, arial, avenirNext, baskerville, courierNew, didot, futura (+22 more)

### Community 16 - "LyricSlideLivePreview"
Cohesion: 0.11
Nodes (23): LyricPreviewBackgroundStyle, borderOnly, settingsDefault, LyricSlideLivePreview, .body, .compactCanvasPreview, .compactHeight, .cornerRadius (+15 more)

### Community 17 - "SlideTransitionTextContainer"
Cohesion: 0.06
Nodes (43): LyricPlaySyncTransportError, emptyResponse, .errorDescription, noLyrioraHost, unexpectedResponse, State, failed, ready (+35 more)

### Community 18 - "VideoPlaybackController"
Cohesion: 0.19
Nodes (10): AVPlayerLooper, Any, AVPlayer, AVPlayerItem, CMTime, NSObjectProtocol, TimeInterval, URL (+2 more)

### Community 19 - "SwiftUI"
Cohesion: 0.18
Nodes (6): AppKit, AVFoundation, AVKit, LyricClipboardImporter, SwiftUI, UIKit

### Community 20 - ".resolvedMetrics"
Cohesion: 0.19
Nodes (13): ExternalDisplayDiscovery, ExternalDisplayMetrics, Source, liveContainer, liveWindow, sceneCoordinateSpace, screenBounds, Bool (+5 more)

### Community 21 - "BibleReadingSession"
Cohesion: 0.15
Nodes (17): BiblePresentationSlide, BibleReadingSession, .canGoPreviousInStrip, BibleSearchHint, BibleSearchHintKind, reference, textMatch, BibleVerseLocation (+9 more)

### Community 22 - "MediaAssetKind"
Cohesion: 0.08
Nodes (28): Error, .index, MediaAssetKind, image, video, MediaIndexEntry, MediaRepository, MediaRepositoryError (+20 more)

### Community 23 - "CodingKeys"
Cohesion: 0.09
Nodes (22): CodingKeys, defaultAnimationProfile, defaultStyle, fontDesign, fontFamily, fontWeight, horizontalPaddingRatio, isAdaptiveScalingEnabled (+14 more)

### Community 24 - "PlaylistGlassModal.swift"
Cohesion: 0.09
Nodes (31): .body, PlaylistGlassColumn, .body, PlaylistGlassEmptyState, .body, PlaylistGlassNameField, .body, PlaylistGlassRowButton (+23 more)

### Community 25 - "SlideGridView"
Cohesion: 0.07
Nodes (37): SlideGridView, .body, .slideGridHeader, .thumbnailWidth, SlideThumbnailView, .textConfiguration, .thumbnailCanvasSize, .thumbnailStyle (+29 more)

### Community 26 - "ExplicitLinePresentationText"
Cohesion: 0.12
Nodes (21): EnvironmentKey, .body, .body, EditorAdaptivePresentationText, .body, .lines, .resolvedConfiguration, EditorPreviewSizing (+13 more)

### Community 27 - "Identifiable"
Cohesion: 0.08
Nodes (26): ButtonRole, CaseIterable, Hashable, Identifiable, AppLocale, english, .id, .languageCode (+18 more)

### Community 28 - "LyricDocument"
Cohesion: 0.10
Nodes (21): .previewSlide, CodingKeys, colorSeed, createdAt, id, language, simplePlayProjectID, simplePlayProjectName (+13 more)

### Community 29 - "PresentationBackground"
Cohesion: 0.11
Nodes (21): PresentationBackground, .isYouTube, Bool, String, URL, .body, AppBackgroundAnimation, AppBackgroundView (+13 more)

### Community 30 - "MainView"
Cohesion: 0.24
Nodes (8): MainView, .adaptiveWorkspace, .iPadPortraitWorkspace, .iPhoneLandscapeWorkspace, .iPhonePortraitPrompt, CGFloat, WorkspaceLayout, .iPhoneLyricsPanelWidth

### Community 31 - "EditorCard"
Cohesion: 0.14
Nodes (15): EditorCard, .cardBackground, LyricEditorLifecycleModifier, .importErrorPresented, .iosEditorRoot, .lyricsInfoSection, .macEditorRoot, .rawLyricsSection (+7 more)

### Community 32 - "BiblePresentationSheet"
Cohesion: 0.14
Nodes (17): BiblePresentationSheet, .availableVerseCount, .bibleAnimationBinding, .bibleStyleBinding, .body, .filteredBooks, .hintsSection, .manualPassageCard (+9 more)

### Community 33 - "String"
Cohesion: 0.12
Nodes (21): CodingKey, CodingKeys, linkedSectionID, order, preview, slideID, tag, text (+13 more)

### Community 34 - "MetalTextEffectRenderer"
Cohesion: 0.08
Nodes (31): MetalTextEffectParameters, .isActive, MetalTextEffectRenderer, MetalTextEffectSupport, Bool, CGImage, CGSize, Double (+23 more)

### Community 35 - "LibraryMorphSearchHeader"
Cohesion: 0.10
Nodes (21): LyricRepositoryProtocol, seedSampleLyricsIfNeeded(), LyricDocument, Layout, LibraryMorphSearchHeader, .body, .collapsedSearchButton, .controlSize (+13 more)

### Community 36 - ".init"
Cohesion: 0.18
Nodes (6): SettingsRepository, SettingsRepositoryProtocol, FileManager, URL, ThemeRepositoryProtocol, SlideTextStyle

### Community 37 - ".transitionTransform"
Cohesion: 0.09
Nodes (34): Angle, AnimatableModifier, AnimatedTextSegmentModifier, SequentialWordTransitionModifier, .animatableData, .layoutSegmentIndex, .layoutTotalWords, SlideTransitionModifier (+26 more)

### Community 38 - "Foundation"
Cohesion: 0.09
Nodes (12): CoreGraphics, Foundation, AppBranding, .displayName, String, Bool, VideoPlaybackMode, loop (+4 more)

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
Cohesion: 0.06
Nodes (30): BibleVersionRepositoryProtocol, AppViewModel, .airSignature, .bibleSlides, .hasControllableVideoBackgroundSelected, .hasCustomBackgroundSelected, .hasVideoBackgroundSelected, .hasYouTubeBackgroundSelected (+22 more)

### Community 43 - "Image"
Cohesion: 0.17
Nodes (22): Entry, LocalImageCache, CGSize, URL, .body, LocalFileImageBackground, .body, CGSize (+14 more)

### Community 44 - "YouTubePlaybackController"
Cohesion: 0.08
Nodes (32): Decodable, OEmbedResponse, String, URL, YouTubeMetadataLoader, TimeInterval, Void, YouTubePlaybackController (+24 more)

### Community 45 - "LyricSlide"
Cohesion: 0.11
Nodes (21): CodingKeys, animationProfile, id, order, simplePlaySectionID, sourceSectionID, style, tag (+13 more)

### Community 46 - ".matches"
Cohesion: 0.30
Nodes (6): Bool, LibrarySearch, LyricDocument, .searchableText, Bool, String

### Community 47 - "LyricSlideTag"
Cohesion: 0.12
Nodes (16): LyricSlideTag, bridge, chorus, .displayName, .id, instrumental, intro, outro (+8 more)

### Community 48 - "Sendable"
Cohesion: 0.33
Nodes (14): Codable, Equatable, AppSettings, PresentationTextSettings, Bool, Decoder, Double, BiblePresentationSettings (+6 more)

### Community 49 - "content"
Cohesion: 0.23
Nodes (11): content, BlurredBackgroundLayer, .body, BlurredBackgroundModifier, CGFloat, Content, Double, View (+3 more)

### Community 50 - "LyricSlideLayoutEngine"
Cohesion: 0.40
Nodes (6): LyricSlideLayoutEngine, CGFloat, CGSize, Int, SlideTextStyle, String

### Community 51 - ".measureSingleLine"
Cohesion: 0.38
Nodes (7): PresentationTextMeasurer, Any, Bool, CGFloat, CGSize, String, NSAttributedString

### Community 52 - "GlassIconButton"
Cohesion: 0.14
Nodes (15): .presentationToolbar, GlassIconButton, .body, .foregroundColor, GlassToolbarIconStyle, Bool, Void, Constants (+7 more)

### Community 53 - "BibleXMLDocumentPicker"
Cohesion: 0.13
Nodes (17): BibleImportPresentation, BibleImportRootModifier, BibleXMLDocumentPicker, Coordinator, Binding, Bool, Content, Context (+9 more)

### Community 54 - "ExternalDisplaySceneCoordinator"
Cohesion: 0.15
Nodes (10): ExternalDisplaySceneCoordinator, UIWindowScene, ExternalDisplaySceneDelegate, UICoordinateSpace, UIInterfaceOrientation, UIResponder, UIScene, UISceneSession (+2 more)

### Community 55 - "LyrioraUITests"
Cohesion: 0.15
Nodes (6): LyrioraUITests, LyrioraUITestsLaunchTests, .runsForEachTargetApplicationUIConfiguration, Bool, XCTest, XCTestCase

### Community 56 - "BibleChapterIndex"
Cohesion: 0.16
Nodes (16): LocalizedError, BibleBookIndex, BibleChapterIndex, .verseCount, BibleVerseIndex, BibleXMLParser, BibleXMLParserError, .errorDescription (+8 more)

### Community 57 - "CodingKeys"
Cohesion: 0.17
Nodes (12): CodingKeys, effectAssignments, effectFallback, effectIntensity, effectSpeed, fallbackAnimation, transitionAssignments, transitionIntensity (+4 more)

### Community 58 - "PresentationBackgroundView"
Cohesion: 0.24
Nodes (11): ConfigurableDefaultGradientView, .layerIdentity, .transition, .body, .body, PresentationBackgroundView, .backgroundContent, .body (+3 more)

### Community 59 - "View"
Cohesion: 0.29
Nodes (11): ProTextSegmentView, .body, Bool, CGSize, Color, Double, Font, Int (+3 more)

### Community 60 - ".loadThumbnail"
Cohesion: 0.20
Nodes (11): AVAssetImageGenerator, Metadata, CGImage, CGSize, CMTime, String, TimeInterval, URL (+3 more)

### Community 61 - "ClearerAnchorView"
Cohesion: 0.27
Nodes (6): ClearerAnchorView, NavigationSplitViewBackgroundClearer, Context, UIView, View, UIViewRepresentable

### Community 62 - "LyricEditorHeaderBar"
Cohesion: 0.24
Nodes (14): LyricEditorChrome, LyricEditorHeaderBar, .body, LyricEditorHeaderButton, LyricEditorNavRow, .body, MacLyricEditorHeaderChrome, .body (+6 more)

### Community 63 - "LyricSectionSource"
Cohesion: 0.16
Nodes (10): CGSize, SlideTextStyle, LyricSectionSource, String, UUID, CGSize, SlideTextStyle, LyricSlideMetadataPreservation (+2 more)

### Community 64 - "MacWindowConfigurator"
Cohesion: 0.39
Nodes (5): MacWindowConfigurator, Bool, Context, NSView, View

### Community 65 - "BibleBookInfo"
Cohesion: 0.36
Nodes (6): BibleBookCatalog, BibleBookInfo, .id, Bool, Int, String

### Community 66 - "DefaultBackgroundPreset"
Cohesion: 0.17
Nodes (11): DefaultBackgroundPreset, daylightWaves, .id, .isAdaptive, .label, meshWaves, morningHaze, twilightWaves (+3 more)

### Community 67 - "BackgroundContentMode"
Cohesion: 0.18
Nodes (11): BackgroundContentMode, auto, fill, fit, .id, .label, landscape, portrait (+3 more)

### Community 68 - "BibleVersionManifest"
Cohesion: 0.12
Nodes (16): BibleVersionManifest, Date, name, BibleVersionRepository, .importableContentTypes, Data, FileManager, String (+8 more)

### Community 69 - "PresentationTextConfiguration"
Cohesion: 0.21
Nodes (11): EdgeInsets, PresentationTextConfiguration, SlideTextStyle, Bool, CGFloat, CGSize, Color, Double (+3 more)

### Community 70 - "BibleSearchIndex"
Cohesion: 0.42
Nodes (4): BibleSearchIndex, BibleSearchIndexEntry, Int, String

### Community 71 - ".shadowColor"
Cohesion: 0.27
Nodes (8): .body, GlassControlChrome, Color, ColorScheme, LinearGradient, .expandedSearchField, .themeNameField, .body

### Community 72 - "ThemeSavePromptSheet"
Cohesion: 0.25
Nodes (6): Bool, String, Void, ThemeSavePromptSheet, .header, .trimmedThemeName

### Community 73 - "ExternalPresentationContainerViewController"
Cohesion: 0.26
Nodes (7): ExternalPresentationContainerViewController, AnyView, Bool, CGSize, View, Void, UIHostingController

### Community 74 - "SlideAnimationProfile"
Cohesion: 0.10
Nodes (24): assignments, SlideAnimationProfile, .hasAnimations, .hasPersistentEffects, .hasProPersistentEffects, .hasTransition, .preferredEffectSelectionTarget, .preferredTransitionSelectionTarget (+16 more)

### Community 75 - "CenterPanelView"
Cohesion: 0.25
Nodes (8): CenterPanelView, .slideGridSection, String, WorkspaceDisplayToolbar, .displayButtonAccessibilityLabel, .iPadPortraitDetailWorkspace, .iPhoneLandscapeDetailWorkspace, .landscapeWorkspace

### Community 76 - "GlassCircleIcon"
Cohesion: 0.19
Nodes (10): GlassCapsuleToolbar, .body, GlassCircleIcon, GlassControlBorderModifier, .body, Content, String, View (+2 more)

### Community 78 - "BibleVersionIndex"
Cohesion: 0.42
Nodes (7): BibleVersionIndex, BibleSlideBuilder, Bool, CGSize, Int, SlideTextStyle, String

### Community 79 - "BibleSlideGridView"
Cohesion: 0.13
Nodes (16): BibleSlideGridView, .header, .slideCounterLabel, .thumbnailWidth, BibleSlideThumbnailView, .borderColor, .borderWidth, .textConfiguration (+8 more)

### Community 80 - "TransitionSpeedControl"
Cohesion: 0.20
Nodes (9): .defaultTransitionControls, Bool, Double, Int, String, Void, TransitionSpeedControl, .body (+1 more)

### Community 81 - "PresentationAnimationQuality"
Cohesion: 0.22
Nodes (8): PresentationAnimationQuality, .effectFrameInterval, live, preview, ProTextRenderQuality, live, preview, TimeInterval

### Community 82 - "PlaylistEditorSheet"
Cohesion: 0.18
Nodes (11): PlaylistEditorSheet, .allItemIDs, .availableItems, .availableSearchPlaceholder, .body, .filteredAvailableItems, .resolvedPlaylist, .showsMediaPreview (+3 more)

### Community 83 - "WorkspaceCompactLayout.swift"
Cohesion: 0.33
Nodes (6): EnvironmentValues, .workspaceCompactLayout, Bool, WorkspaceDevice, .isPad, .isPhone

### Community 84 - "DefaultBackgroundMeshStyle"
Cohesion: 0.14
Nodes (15): .body, DefaultBackgroundMeshStyle, .colors, daylightWaves, morningHaze, twilightWaves, violetDusk, .wavePoints (+7 more)

### Community 85 - "GlassPanel"
Cohesion: 0.33
Nodes (7): GlassPanel, .body, .panelShape, GlassToolbarMetrics, .controlHeight, CGFloat, RoundedRectangle

### Community 86 - "LyricPlaySyncMessage"
Cohesion: 0.17
Nodes (12): JSONEncoder, LyricPlaySyncCodec, LyricPlaySyncMessage, Data, LyricPlaySyncServer, Date, Error, Void (+4 more)

### Community 87 - "PresentationContentView"
Cohesion: 0.25
Nodes (8): BiblePresentationFooterView, .body, PresentationContentView, .body, .textConfiguration, AVPlayer, Bool, String

### Community 88 - "StickyPreviewEditorLayout"
Cohesion: 0.14
Nodes (13): PresentationLayout, CGFloat, CGSize, .presentationLayoutCanvasSize, .body, .canvasAspectRatio, .canvasSize, StickyPreviewEditorLayout (+5 more)

### Community 89 - ".refreshDisplayInfo"
Cohesion: 0.25
Nodes (3): Int, Task, UIWindowScene

### Community 91 - "LyricEditorNavigationOption"
Cohesion: 0.25
Nodes (7): LyricEditorNavigationOption, .id, .systemImage, .title, typography, String, Self

### Community 92 - "MediaAsset"
Cohesion: 0.10
Nodes (19): MediaAsset, .listLabel, Date, UUID, MediaRepositoryProtocol, .isYouTubeLink, .activePresentationBackground, .selectedBackgroundAsset (+11 more)

### Community 93 - "DisplayInfoSheet"
Cohesion: 0.29
Nodes (6): DisplayInfoSheet, .body, .statusDescription, Bool, String, Void

### Community 94 - ".resolved"
Cohesion: 0.25
Nodes (6): ResolvedBackgroundContentMode, fill, fit, CGSize, .resolvedMode, .resolvedContentMode

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

### Community 99 - "BibleSearchEngine"
Cohesion: 0.46
Nodes (3): BibleSearchEngine, Int, String

### Community 100 - "PresentationState"
Cohesion: 0.29
Nodes (7): .presentationState, PresentationState, Bool, Int, SlideTextStyle, String, UUID

### Community 101 - ".pickFiles"
Cohesion: 0.33
Nodes (4): MacFileImportPanel, Bool, URL, UTType

### Community 102 - "LyricCardView"
Cohesion: 0.20
Nodes (11): Layout, .trailingControlInset, LyricCardView, .footerShape, .overflowActions, Bool, CGFloat, LyricDocument (+3 more)

### Community 103 - "GlassToolbarIconSize"
Cohesion: 0.33
Nodes (6): GlassToolbarIconSize, .frameSize, .iconFont, prominent, regular, Font

### Community 105 - "LyricPlaySyncMessageKind"
Cohesion: 0.18
Nodes (11): LyricPlaySyncMessageKind, airFrame, catalogRequest, catalogResponse, error, linkSection, linkSectionAck, presence (+3 more)

### Community 106 - ".linearGradient"
Cohesion: 0.32
Nodes (5): LyricGradient, Color, LinearGradient, UInt64, .body

### Community 108 - "graphify reference: query, path, explain"
Cohesion: 0.33
Nodes (5): For /graphify explain, For /graphify path, graphify reference: query, path, explain, Step 0 — Constrained query expansion (REQUIRED before traversal), Step 1 — Traversal

### Community 109 - "graphify reference: query, path, explain"
Cohesion: 0.33
Nodes (5): For /graphify explain, For /graphify path, graphify reference: query, path, explain, Step 0 — Constrained query expansion (REQUIRED before traversal), Step 1 — Traversal

### Community 110 - "BibleThemeQuickPicker"
Cohesion: 0.28
Nodes (7): BibleThemeQuickPicker, .body, BibleTransitionStyleSection, .body, Bool, UUID, Void

### Community 111 - "PresentationVideoControls"
Cohesion: 0.31
Nodes (8): .body, PresentationVideoControls, .activeDuration, .displayedCurrentTime, .sliderBinding, .usesYouTubePlayback, Binding, TimeInterval

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

### Community 118 - "GlobalStyleEditorContent"
Cohesion: 0.06
Nodes (43): CGFloat, Double, Int, UUID, WordFontSizeOverride, WordFontSizeResolver, KeyboardDismissal, SlideStyleControlsView (+35 more)

### Community 119 - "PresentationFontWeight"
Cohesion: 0.13
Nodes (15): PresentationFontWeight, bold, .id, .label, medium, regular, semibold, CGFloat (+7 more)

### Community 124 - "DefaultBackgroundPresetPreview"
Cohesion: 0.40
Nodes (4): DefaultBackgroundPresetPreview, .body, DefaultBackgroundPreviewCard, .body

### Community 129 - "AppViewModel.swift"
Cohesion: 0.10
Nodes (16): String, .nilIfEmpty, PhotosPickerDisplayNameResolver, PhotosPickerItem, String, .selectedPhotoItems, PickedImageFile, .transferRepresentation (+8 more)

### Community 131 - "PlaylistPickerSheet"
Cohesion: 0.31
Nodes (7): PlaylistPickerSheet, .createPlaylistCard, .filteredPlaylists, .isSearching, .totalItemCount, Bool, Int

### Community 132 - "ExternalDisplayInfo"
Cohesion: 0.33
Nodes (6): ExternalDisplayInfo, .resolutionDescription, Bool, CGFloat, CGSize, String

### Community 134 - "PlaylistMediaPreview"
Cohesion: 0.33
Nodes (8): PlaylistImagePreview, .body, PlaylistMediaPreview, .body, PlaylistVideoPreview, .body, CGFloat, URL

### Community 136 - "LyricsLibraryPanelView"
Cohesion: 0.47
Nodes (6): LyricsLibraryPanelView, .deleteAlertBinding, .filteredLyrics, .isPlaylistFiltered, .isSearching, Binding

### Community 137 - "LyrioraApp"
Cohesion: 0.18
Nodes (10): App, .displayName, L10n, Main, .rotateIPhoneBody, .rotateIPhoneTitle, String, LyrioraApp (+2 more)

### Community 139 - "AdaptivePresentationText"
Cohesion: 0.29
Nodes (6): AdaptivePresentationText, .lines, Bool, Int, String, UUID

### Community 141 - "LyricImportError"
Cohesion: 0.40
Nodes (5): LyricImportError, empty, .errorDescription, notText, unsupportedContent

## Knowledge Gaps
- **526 isolated node(s):** `.displayName`, `english`, `spanish`, `portuguese`, `.id` (+521 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 804 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **11 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AppViewModel` connect `AppViewModel` to `ExternalDisplayManager`, `AppViewModel.swift`, `LibraryPlaylist`, `PresentationPreviewView`, `PlaylistPickerSheet`, `LyricEditorView`, `LyricTheme`, `LyricsLibraryPanelView`, `LyrioraApp`, `MediaThumbnailView`, `LyricImportParser`, `VideoPlaybackController`, `BibleReadingSession`, `SlideGridView`, `Identifiable`, `PresentationBackground`, `MainView`, `BiblePresentationSheet`, `String`, `LibraryMorphSearchHeader`, `.init`, `Foundation`, `YouTubePlaybackController`, `LyricSlide`, `BibleXMLDocumentPicker`, `LyricSectionSource`, `BibleVersionManifest`, `BibleSearchIndex`, `CenterPanelView`, `BibleVersionIndex`, `BibleSlideGridView`, `PlaylistEditorSheet`, `LyricPlaySyncMessage`, `StickyPreviewEditorLayout`, `.refreshDisplayInfo`, `MediaAsset`, `PresentationState`, `ContentView`, `PresentationVideoControls`, `GlobalStyleEditorContent`?**
  _High betweenness centrality (0.231) - this node is a cross-community bridge._
- **Why does `SwiftUI` connect `SwiftUI` to `AppViewModel.swift`, `LyricTheme`, `LyricLanguage`, `PlaylistMediaPreview`, `LyrioraApp`, `AnimatedPresentationText`, `AdaptivePresentationText`, `MediaThumbnailView`, `PresentationFontFamily`, `LyricSlideLivePreview`, `SlideTransitionTextContainer`, `PlaylistGlassModal.swift`, `SlideGridView`, `ExplicitLinePresentationText`, `PresentationBackground`, `MainView`, `EditorCard`, `BiblePresentationSheet`, `MetalTextEffectRenderer`, `LibraryMorphSearchHeader`, `.transitionTransform`, `Foundation`, `BackgroundFitToolbar`, `YouTubePlaybackController`, `LyricSlide`, `content`, `GlassIconButton`, `BibleXMLDocumentPicker`, `ClearerAnchorView`, `LyricEditorHeaderBar`, `ThemeSavePromptSheet`, `CenterPanelView`, `GlassCircleIcon`, `BibleSlideGridView`, `TransitionSpeedControl`, `WorkspaceCompactLayout.swift`, `DefaultBackgroundMeshStyle`, `PresentationContentView`, `StickyPreviewEditorLayout`, `GlassMorphAnimation.swift`, `LyricEditorNavigationOption`, `DisplayInfoSheet`, `LyricCardView`, `ContentView`, `.linearGradient`, `BibleThemeQuickPicker`, `GlobalStyleEditorContent`, `DefaultBackgroundPresetPreview`?**
  _High betweenness centrality (0.091) - this node is a cross-community bridge._
- **Why does `TextAnimationKind` connect `TextAnimationKind` to `String`, `MetalTextEffectRenderer`, `.transitionTransform`, `Foundation`, `View`, `SlideAnimationProfile`, `AnimatedPresentationText`, `TextAnimationEditorSection`, `ParsedSlideText`, `BibleThemeQuickPicker`, `Sendable`, `Identifiable`?**
  _High betweenness centrality (0.075) - this node is a cross-community bridge._
- **Are the 19 inferred relationships involving `AppViewModel` (e.g. with `.body` and `LyrioraApp`) actually correct?**
  _`AppViewModel` has 19 INFERRED edges - model-reasoned connections that need verification._
- **Are the 12 inferred relationships involving `SlideAnimationProfile` (e.g. with `.body` and `.previewStageContent()`) actually correct?**
  _`SlideAnimationProfile` has 12 INFERRED edges - model-reasoned connections that need verification._
- **What connects `.displayName`, `english`, `spanish` to the rest of the system?**
  _526 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `ExternalDisplayManager` be split into smaller, more focused modules?**
  _Cohesion score 0.1206896551724138 - nodes in this community are weakly interconnected._