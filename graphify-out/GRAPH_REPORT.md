# Graph Report - Lyriora  (2026-10-26)

## Corpus Check
- 151 files · ~81,410 words
- Verdict: corpus is large enough that graph structure adds value.
- Unclassified: 9 file(s) not represented in the graph (top: (none) 4, .mdc 1, .plist 1)

## Summary
- 2530 nodes · 5874 edges · 146 communities (130 shown, 16 thin omitted)
- Extraction: 92% EXTRACTED · 8% INFERRED · 0% AMBIGUOUS · INFERRED: 481 edges (avg confidence: 0.82)
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
- Equatable
- MediaAssetKind
- CodingKeys
- PlaylistGlassModal.swift
- Image
- ExplicitLinePresentationText
- Identifiable
- LyricDocument
- PresentationBackgroundView
- MainView
- SlideGridView
- BiblePresentationSheet
- Codable
- MetalTextEffectRenderer
- LibraryMorphSearchHeader
- .init
- .transitionTransform
- Foundation
- lyricTextFragment
- BackgroundFitToolbar
- What You Must Do When Invoked
- AppViewModel
- Sendable
- YouTubePlaybackController
- LyricStyleProfile
- GlassIconButton
- LyricSlideTag
- GlassCircleIcon
- PlaylistPickerSheet
- LyricSlideLayoutEngine
- .measureSingleLine
- VideoPlaybackMode
- BibleXMLDocumentPicker
- ExternalDisplaySceneCoordinator
- LyrioraUITests
- BibleChapterIndex
- CodingKeys
- BackgroundContentMode
- View
- SlideTextStyle
- .matches
- LyricEditorHeaderBar
- LyricSlide
- MacWindowConfigurator
- BibleBookInfo
- WordFontSizeOverride
- CodingKeys
- BibleVersionManifest
- PresentationTextConfiguration
- LyricTheme
- .shadowColor
- ThemeSavePromptSheet
- ExternalPresentationContainerViewController
- SlideAnimationProfile
- ClearerAnchorView
- GlassPanel.swift
- LyrioraTests.swift
- BibleVersionIndex
- BibleSlideGridView
- TransitionSpeedControl
- MetalTextEffectRepresentable
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
- .body
- DisplayInfoSheet
- GlobalStyleEditorView
- graphify reference: extra exports and benchmark
- graphify reference: extra exports and benchmark
- LyricRepository
- PlayerLayerView
- BibleSearchEngine
- .body
- MetalTextEffectParameters
- LyricCardView
- CodingKeys
- BibleVersionDisplayFormatter
- PresentationState
- .linearGradient
- PresentationAnimationQuality
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
- .resolved
- graphify reference: GitHub clone and cross-repo merge
- graphify reference: transcribe video and audio
- graphify reference: GitHub clone and cross-repo merge
- graphify reference: transcribe video and audio
- .font
- .agents/skills/graphify/references/extraction-spec.md
- CLAUDE.md
- .claude/CLAUDE.md
- .claude/skills/graphify/references/extraction-spec.md
- AppViewModel.swift
- SlideThumbnailView
- PresentationFontPickerSheet
- ExternalDisplayInfo
- PlaylistGlassColumn
- PlaylistMediaPreview
- .pickFiles
- LyricsLibraryPanelView
- LyrioraApp
- CodableColor
- UIViewController
- TextAnimationStylePreset
- AVPlayerLayerView
- BibleVersionDisplayFormatter.swift
- .init
- .encode
- LyricClipboardImporter.swift

## God Nodes (most connected - your core abstractions)
1. `AppViewModel` - 203 edges
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
  Lyriora/Views/Components/StickyPreviewEditorLayout.swift → Lyriora/Models/LyricDocument.swift
- `.body` --calls--> `content`  [INFERRED]
  Lyriora/Views/Modals/PlaylistGlassModal.swift → Lyriora/Models/LyricDocument.swift
- `.slidesRefreshID` --references--> `LyricSlide`  [INFERRED]
  Lyriora/Views/Components/LyricEditorSlideHorizontalListView.swift → Lyriora/Models/LyricSlide.swift
- `.headerRow` --references--> `LyricSlide`  [INFERRED]
  Lyriora/Views/Components/LyricSlideLivePreview.swift → Lyriora/Models/LyricSlide.swift

## Import Cycles
- None detected.

## Communities (146 total, 16 thin omitted)

### Community 0 - "ExternalDisplayManager"
Cohesion: 0.11
Nodes (19): ExternalDisplayManager, .displayMonitorInterval, .isExternalDisplayConnected, ExternalPresentationWindow, .canBecomeKey, .canBecomeMain, Bool, CGSize (+11 more)

### Community 1 - "PresentationPreviewView"
Cohesion: 0.15
Nodes (16): PresentationContentView, .textConfiguration, PresentationPreviewView, .canvasAspectRatio, .canvasSize, .isVideoBackground, .previewMetadataBar, .previewStage (+8 more)

### Community 2 - "LibraryPlaylist"
Cohesion: 0.09
Nodes (22): LibraryPlaylist, LibraryPlaylistKind, image, lyric, .systemImage, .title, video, Date (+14 more)

### Community 3 - ".configure"
Cohesion: 0.11
Nodes (29): TimeInterval, UUID, VideoSeekRequest, TimeInterval, Void, VideoProgressReporter, Coordinator, LoopingVideoBackground (+21 more)

### Community 4 - "TextAnimationKind"
Cohesion: 0.04
Nodes (47): Bool, TextAnimationKind, .basicCases, blink, blinkSemiRotate, bounce, chromaticShift, .displayName (+39 more)

### Community 5 - "LyricEditorView"
Cohesion: 0.06
Nodes (41): EditorCard, .cardBackground, LyricEditorLifecycleModifier, .importErrorPresented, LyricEditorView, .activeTheme, .body, .canSave (+33 more)

### Community 6 - "ThemeMiniPreview"
Cohesion: 0.14
Nodes (21): Bool, CGFloat, SlideTextStyle, String, UUID, Void, ThemeGalleryView, .body (+13 more)

### Community 7 - "SlideDetailEditorView"
Cohesion: 0.19
Nodes (12): SlideDetailEditorView, .activeStyle, .animationProfileBinding, .body, .previewAnimationProfile, .resolvedStyleForWordSizing, Binding, Bool (+4 more)

### Community 8 - "What You Must Do When Invoked"
Cohesion: 0.08
Nodes (24): For /graphify add and --watch, For /graphify query, For the commit hook and native AGENTS.md integration, For --update and --cluster-only, /graphify, Honesty Rules, Interpreter guard for subcommands, Part A - Structural extraction for code files (+16 more)

### Community 9 - "MediaAsset"
Cohesion: 0.08
Nodes (32): MediaAsset, .listLabel, Date, UUID, MediaRepositoryProtocol, .isYouTubeLink, importSelectedVideos(), URL (+24 more)

### Community 10 - "AnimatedPresentationText"
Cohesion: 0.12
Nodes (23): Font, AnimatedPresentationText, .allowsEffectTimelineUpdates, .animatedBody, .emptyLinePlaceholder, .proRenderQuality, .shouldRenderAnimatedContent, .shouldRunEffectTimeline (+15 more)

### Community 11 - "PresentationFontWeight"
Cohesion: 0.17
Nodes (12): PresentationFontWeight, bold, .id, .label, medium, regular, semibold, .nsWeight (+4 more)

### Community 12 - "TextAnimationEditorSection"
Cohesion: 0.13
Nodes (20): Binding, Bool, Int, String, Void, TextAnimationEditorSection, .activeEffectKind, .activeTransitionKind (+12 more)

### Community 13 - "ParsedSlideText"
Cohesion: 0.12
Nodes (14): Int, ParsedSlideText, .isEmpty, .totalWordCount, SlideTextTokenizer, Bool, Int, Range (+6 more)

### Community 14 - "LyricImportParser"
Cohesion: 0.14
Nodes (14): String, LyricImportError, empty, .errorDescription, notText, unsupportedContent, LyricImportParser, LyricImportResult (+6 more)

### Community 15 - "PresentationFontFamily"
Cohesion: 0.09
Nodes (22): PresentationFontFamily, americanTypewriter, arial, avenirNext, baskerville, courierNew, didot, futura (+14 more)

### Community 16 - "LyricSlideLivePreview"
Cohesion: 0.11
Nodes (24): LyricPreviewBackgroundStyle, borderOnly, settingsDefault, LyricSlideLivePreview, .body, .compactCanvasPreview, .compactHeight, .cornerRadius (+16 more)

### Community 17 - "MediaThumbnailView"
Cohesion: 0.21
Nodes (11): GlassOverflowMenu, MediaThumbnailView, .body, .menuIconSize, .overflowActions, .resolvedDurationLabel, .shape, .youtubeLinkString (+3 more)

### Community 18 - "VideoPlaybackController"
Cohesion: 0.19
Nodes (10): AVPlayerLooper, Any, AVPlayer, AVPlayerItem, CMTime, NSObjectProtocol, TimeInterval, URL (+2 more)

### Community 19 - "SwiftUI"
Cohesion: 0.23
Nodes (5): AppKit, AVFoundation, AVKit, SwiftUI, UIKit

### Community 20 - ".resolvedMetrics"
Cohesion: 0.19
Nodes (13): ExternalDisplayDiscovery, ExternalDisplayMetrics, Source, liveContainer, liveWindow, sceneCoordinateSpace, screenBounds, Bool (+5 more)

### Community 21 - "Equatable"
Cohesion: 0.15
Nodes (18): Equatable, BiblePresentationSlide, BibleReadingSession, .canGoPreviousInStrip, .previewSlide, BibleSearchHint, BibleSearchHintKind, reference (+10 more)

### Community 22 - "MediaAssetKind"
Cohesion: 0.08
Nodes (28): Error, .index, MediaAssetKind, image, video, MediaIndexEntry, MediaRepository, MediaRepositoryError (+20 more)

### Community 23 - "CodingKeys"
Cohesion: 0.10
Nodes (20): CodingKeys, defaultAnimationProfile, defaultStyle, fontDesign, fontFamily, fontWeight, horizontalPaddingRatio, isAdaptiveScalingEnabled (+12 more)

### Community 24 - "PlaylistGlassModal.swift"
Cohesion: 0.12
Nodes (23): .body, PlaylistGlassEmptyState, .body, PlaylistGlassNameField, .body, PlaylistGlassRowButton, .body, PlaylistGlassSearchField (+15 more)

### Community 25 - "Image"
Cohesion: 0.05
Nodes (58): AVAssetImageGenerator, Entry, LocalImageCache, CGSize, URL, Metadata, CGImage, CGSize (+50 more)

### Community 26 - "ExplicitLinePresentationText"
Cohesion: 0.12
Nodes (21): EnvironmentKey, .body, .body, EditorAdaptivePresentationText, .body, .lines, .resolvedConfiguration, EditorPreviewSizing (+13 more)

### Community 27 - "Identifiable"
Cohesion: 0.16
Nodes (11): Hashable, Identifiable, LyricEditorLaunch, PresentationFontDesign, `default`, .id, .label, monospaced (+3 more)

### Community 28 - "LyricDocument"
Cohesion: 0.11
Nodes (20): CodingKeys, colorSeed, createdAt, id, language, simplePlayProjectID, simplePlayProjectName, sourceSections (+12 more)

### Community 29 - "PresentationBackgroundView"
Cohesion: 0.06
Nodes (44): content, PresentationBackground, .isYouTube, Bool, String, URL, BiblePresentationFooterView, .body (+36 more)

### Community 30 - "MainView"
Cohesion: 0.18
Nodes (10): ContentView, .body, MainView, .adaptiveWorkspace, .iPadPortraitWorkspace, .iPhoneLandscapeWorkspace, .iPhonePortraitPrompt, CGFloat (+2 more)

### Community 31 - "SlideGridView"
Cohesion: 0.36
Nodes (6): SlideGridView, .body, .thumbnailWidth, CGFloat, Int, Void

### Community 32 - "BiblePresentationSheet"
Cohesion: 0.14
Nodes (17): BiblePresentationSheet, .availableVerseCount, .bibleAnimationBinding, .bibleStyleBinding, .body, .filteredBooks, .hintsSection, .manualPassageCard (+9 more)

### Community 33 - "Codable"
Cohesion: 0.11
Nodes (26): Codable, JSONEncoder, LinkSectionCommand, LyricPlaySync, LyricPlaySyncCodec, LyricPlaySyncMessage, LyricPlaySyncMessageKind, catalogRequest (+18 more)

### Community 34 - "MetalTextEffectRenderer"
Cohesion: 0.17
Nodes (12): MetalTextEffectRenderer, CGSize, CGRect, NSCoder, NSRect, MTKView, MTKViewDelegate, MTLCommandQueue (+4 more)

### Community 35 - "LibraryMorphSearchHeader"
Cohesion: 0.17
Nodes (13): Layout, LibraryMorphSearchHeader, .body, .controlSize, .isSearchActive, .resolvedHorizontalPadding, .searchSlot, LibraryPanelMetrics (+5 more)

### Community 36 - ".init"
Cohesion: 0.17
Nodes (6): SettingsRepository, SettingsRepositoryProtocol, FileManager, URL, ThemeRepositoryProtocol, SlideTextStyle

### Community 37 - ".transitionTransform"
Cohesion: 0.08
Nodes (35): Angle, AnimatableModifier, AnimatedTextSegmentModifier, SequentialWordTransitionModifier, .animatableData, .layoutSegmentIndex, .layoutTotalWords, SlideTransitionModifier (+27 more)

### Community 38 - "Foundation"
Cohesion: 0.15
Nodes (3): CoreGraphics, Foundation, Observation

### Community 39 - "lyricTextFragment"
Cohesion: 0.13
Nodes (17): constant, float2, float4, fragment, lyricTextFragment(), lyricTextVertex(), TextEffectUniforms, chromaticStrength (+9 more)

### Community 40 - "BackgroundFitToolbar"
Cohesion: 0.22
Nodes (12): BackgroundFitBadgeLabel, BackgroundFitToggleLabel, .body, BackgroundFitToolbar, .body, .expandedOptions, .toggleButton, Constants (+4 more)

### Community 41 - "What You Must Do When Invoked"
Cohesion: 0.08
Nodes (24): For /graphify add and --watch, For /graphify query, For the commit hook and native CLAUDE.md integration, For --update and --cluster-only, /graphify, Honesty Rules, Interpreter guard for subcommands, Part A - Structural extraction for code files (+16 more)

### Community 42 - "AppViewModel"
Cohesion: 0.05
Nodes (33): BibleVersionRepositoryProtocol, AppViewModel, .activePresentationBackground, .bibleSlides, .hasControllableVideoBackgroundSelected, .hasCustomBackgroundSelected, .hasVideoBackgroundSelected, .hasYouTubeBackgroundSelected (+25 more)

### Community 43 - "Sendable"
Cohesion: 0.42
Nodes (9): AppSettings, PresentationTextSettings, Bool, Decoder, Double, BiblePresentationSettings, DefaultBackgroundSettings, Double (+1 more)

### Community 44 - "YouTubePlaybackController"
Cohesion: 0.08
Nodes (32): Decodable, OEmbedResponse, String, URL, YouTubeMetadataLoader, TimeInterval, Void, YouTubePlaybackController (+24 more)

### Community 45 - "LyricStyleProfile"
Cohesion: 0.17
Nodes (12): tagStyles, LyricStyleProfile, LyricEditorSlideCard, .textConfiguration, LyricEditorSlideHorizontalListView, .body, .slidesRefreshID, CGFloat (+4 more)

### Community 46 - "GlassIconButton"
Cohesion: 0.20
Nodes (11): ButtonRole, .presentationToolbar, .body, Action, GlassIconButton, .body, .foregroundColor, GlassToolbarIconStyle (+3 more)

### Community 47 - "LyricSlideTag"
Cohesion: 0.08
Nodes (25): LyricSectionSource, String, UUID, LyricLanguage, .displayName, english, .id, spanish (+17 more)

### Community 48 - "GlassCircleIcon"
Cohesion: 0.33
Nodes (6): GlassCircleIcon, .body, GlassToolbarMetrics, .controlHeight, CGFloat, .collapsedSearchButton

### Community 49 - "PlaylistPickerSheet"
Cohesion: 0.36
Nodes (6): PlaylistPickerSheet, .createPlaylistCard, .isSearching, .totalItemCount, Bool, Int

### Community 50 - "LyricSlideLayoutEngine"
Cohesion: 0.40
Nodes (6): LyricSlideLayoutEngine, CGFloat, CGSize, Int, SlideTextStyle, String

### Community 51 - ".measureSingleLine"
Cohesion: 0.38
Nodes (7): PresentationTextMeasurer, Any, Bool, CGFloat, CGSize, String, NSAttributedString

### Community 52 - "VideoPlaybackMode"
Cohesion: 0.12
Nodes (14): Bool, VideoPlaybackMode, loop, .loopsVideo, playOnce, .toggled, Constants, PresentationActionsToolbar (+6 more)

### Community 53 - "BibleXMLDocumentPicker"
Cohesion: 0.16
Nodes (15): BibleImportPresentation, BibleImportRootModifier, BibleXMLDocumentPicker, Coordinator, Binding, Bool, Content, Coordinator (+7 more)

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
Cohesion: 0.09
Nodes (22): CaseIterable, AnimationApplyScope, allSlides, currentSlide, .id, .label, CodingKeys, assignments (+14 more)

### Community 58 - "BackgroundContentMode"
Cohesion: 0.18
Nodes (11): BackgroundContentMode, auto, fill, fit, .id, .label, landscape, portrait (+3 more)

### Community 59 - "View"
Cohesion: 0.29
Nodes (11): ProTextSegmentView, .body, Bool, CGSize, Color, Double, Font, Int (+3 more)

### Community 60 - "SlideTextStyle"
Cohesion: 0.33
Nodes (7): SlideTextStyle, .fontSize, Bool, Decoder, Double, Encoder, Int

### Community 61 - ".matches"
Cohesion: 0.30
Nodes (6): Bool, LibrarySearch, LyricDocument, .searchableText, Bool, String

### Community 62 - "LyricEditorHeaderBar"
Cohesion: 0.22
Nodes (15): LyricEditorChrome, LyricEditorHeaderBar, .body, LyricEditorHeaderButton, .body, LyricEditorNavRow, .body, MacLyricEditorHeaderChrome (+7 more)

### Community 63 - "LyricSlide"
Cohesion: 0.12
Nodes (16): CGSize, SlideTextStyle, LyricSlide, Decoder, Encoder, Int, SlideTextStyle, String (+8 more)

### Community 64 - "MacWindowConfigurator"
Cohesion: 0.31
Nodes (6): MacWindowConfigurator, Bool, Context, NSView, View, NSViewRepresentable

### Community 65 - "BibleBookInfo"
Cohesion: 0.20
Nodes (10): BibleBookCatalog, BibleBookInfo, .id, Bool, Int, String, BibleSearchIndex, BibleSearchIndexEntry (+2 more)

### Community 66 - "WordFontSizeOverride"
Cohesion: 0.14
Nodes (19): CGFloat, Double, Int, UUID, WordFontSizeOverride, WordFontSizeResolver, SlideStyleControlsView, .body (+11 more)

### Community 67 - "CodingKeys"
Cohesion: 0.25
Nodes (8): CodingKey, CodingKeys, linkedSectionID, order, preview, slideID, tag, text

### Community 68 - "BibleVersionManifest"
Cohesion: 0.19
Nodes (10): BibleVersionManifest, Date, BibleVersionRepository, .importableContentTypes, Data, FileManager, String, URL (+2 more)

### Community 69 - "PresentationTextConfiguration"
Cohesion: 0.15
Nodes (15): PresentationTextConfiguration, SlideTextStyle, Bool, CGFloat, CGSize, Color, Double, SlideTextStyle (+7 more)

### Community 70 - "LyricTheme"
Cohesion: 0.16
Nodes (11): LyricTheme, Date, Int, SlideTextStyle, String, UUID, FileManager, URL (+3 more)

### Community 71 - ".shadowColor"
Cohesion: 0.33
Nodes (7): .body, GlassControlChrome, Color, ColorScheme, LinearGradient, .expandedSearchField, .body

### Community 72 - "ThemeSavePromptSheet"
Cohesion: 0.22
Nodes (7): Bool, String, Void, ThemeSavePromptSheet, .header, .themeNameField, .trimmedThemeName

### Community 73 - "ExternalPresentationContainerViewController"
Cohesion: 0.26
Nodes (7): ExternalPresentationContainerViewController, AnyView, Bool, CGSize, View, Void, UIHostingController

### Community 74 - "SlideAnimationProfile"
Cohesion: 0.12
Nodes (22): SlideAnimationProfile, .hasAnimations, .hasPersistentEffects, .hasProPersistentEffects, .hasTransition, .preferredEffectSelectionTarget, .preferredTransitionSelectionTarget, .transitionsOnly (+14 more)

### Community 75 - "ClearerAnchorView"
Cohesion: 0.27
Nodes (6): ClearerAnchorView, NavigationSplitViewBackgroundClearer, Context, UIView, View, UIViewRepresentable

### Community 76 - "GlassPanel.swift"
Cohesion: 0.22
Nodes (9): GlassCapsuleToolbar, .body, GlassControlBorderModifier, GlassPanel, .panelShape, Content, RoundedRectangle, View (+1 more)

### Community 78 - "BibleVersionIndex"
Cohesion: 0.42
Nodes (7): BibleVersionIndex, BibleSlideBuilder, Bool, CGSize, Int, SlideTextStyle, String

### Community 79 - "BibleSlideGridView"
Cohesion: 0.15
Nodes (15): BibleSlideGridView, .canGoNext, .slideCounterLabel, .thumbnailWidth, BibleSlideThumbnailView, .borderColor, .borderWidth, .textConfiguration (+7 more)

### Community 80 - "TransitionSpeedControl"
Cohesion: 0.22
Nodes (8): .defaultTransitionControls, Bool, Double, Int, String, Void, TransitionSpeedControl, .body

### Community 81 - "MetalTextEffectRepresentable"
Cohesion: 0.25
Nodes (9): CGImage, ContainerView, MetalTextEffectContainer, .body, MetalTextEffectRepresentable, Content, Context, TimeInterval (+1 more)

### Community 82 - "PlaylistEditorSheet"
Cohesion: 0.18
Nodes (11): PlaylistEditorSheet, .allItemIDs, .availableItems, .availableSearchPlaceholder, .body, .filteredAvailableItems, .resolvedPlaylist, .showsMediaPreview (+3 more)

### Community 83 - "WorkspaceCompactLayout.swift"
Cohesion: 0.33
Nodes (6): EnvironmentValues, .workspaceCompactLayout, Bool, WorkspaceDevice, .isPad, .isPhone

### Community 84 - "DefaultBackgroundPreset"
Cohesion: 0.06
Nodes (35): EdgeInsets, ConfigurableDefaultGradientView, .body, .layerIdentity, DefaultBackgroundMeshStyle, .colors, daylightWaves, morningHaze (+27 more)

### Community 85 - "GlassToolbarIconSize"
Cohesion: 0.33
Nodes (6): GlassToolbarIconSize, .frameSize, .iconFont, prominent, regular, Font

### Community 86 - "SlideTransitionTextContainer"
Cohesion: 0.06
Nodes (39): LyricPlaySyncServer, LyricPlaySyncTransportError, emptyResponse, .errorDescription, noLyrioraHost, unexpectedResponse, State, failed (+31 more)

### Community 87 - "StickyPreviewEditorLayout"
Cohesion: 0.25
Nodes (7): StickyPreviewEditorLayout, .body, .previewSection, .stickyBackground, CGFloat, Content, Preview

### Community 88 - "PresentationLayout"
Cohesion: 0.39
Nodes (4): PresentationLayout, CGFloat, CGSize, .presentationLayoutCanvasSize

### Community 89 - ".refreshDisplayInfo"
Cohesion: 0.25
Nodes (3): Int, Task, UIWindowScene

### Community 91 - "LyricEditorNavigationOption"
Cohesion: 0.22
Nodes (8): LyricEditorNavigationOption, .id, lyrics, .systemImage, .title, typography, String, Self

### Community 92 - ".body"
Cohesion: 0.21
Nodes (5): LyricRepositoryProtocol, seedSampleLyricsIfNeeded(), LyricDocument, .body, UUID

### Community 93 - "DisplayInfoSheet"
Cohesion: 0.29
Nodes (6): DisplayInfoSheet, .body, .statusDescription, Bool, String, Void

### Community 94 - "GlobalStyleEditorView"
Cohesion: 0.20
Nodes (8): KeyboardDismissal, GlobalStyleEditorView, .body, .hasStyleChanges, Bool, SlideTextStyle, String, UUID

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
Nodes (12): AnyClass, AVPlayerView, AVPlayerLayerRepresentable, AVPlayerViewRepresentable, PlayerLayerView, .layerClass, .playerLayer, AVLayerVideoGravity (+4 more)

### Community 99 - "BibleSearchEngine"
Cohesion: 0.46
Nodes (3): BibleSearchEngine, Int, String

### Community 100 - ".body"
Cohesion: 0.19
Nodes (10): .header, CenterPanelView, .body, .slideGridSection, String, WorkspaceDisplayToolbar, .displayButtonAccessibilityLabel, .iPadPortraitDetailWorkspace (+2 more)

### Community 101 - "MetalTextEffectParameters"
Cohesion: 0.18
Nodes (10): MetalTextEffectParameters, .isActive, MetalTextEffectSupport, Bool, Double, Float, TimeInterval, TextEffectUniformsMetal (+2 more)

### Community 102 - "LyricCardView"
Cohesion: 0.20
Nodes (11): Layout, .trailingControlInset, LyricCardView, .footerShape, .overflowActions, Bool, CGFloat, LyricDocument (+3 more)

### Community 103 - "CodingKeys"
Cohesion: 0.20
Nodes (10): CodingKeys, animationProfile, id, order, simplePlaySectionID, sourceSectionID, style, tag (+2 more)

### Community 104 - "BibleVersionDisplayFormatter"
Cohesion: 0.47
Nodes (4): name, BibleVersionDisplayFormatter, .prettyDisplayName, String

### Community 105 - "PresentationState"
Cohesion: 0.29
Nodes (7): .presentationState, PresentationState, Bool, Int, SlideTextStyle, String, UUID

### Community 106 - ".linearGradient"
Cohesion: 0.32
Nodes (5): LyricGradient, Color, LinearGradient, UInt64, .body

### Community 107 - "PresentationAnimationQuality"
Cohesion: 0.22
Nodes (8): PresentationAnimationQuality, .effectFrameInterval, live, preview, ProTextRenderQuality, live, preview, TimeInterval

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
Cohesion: 0.14
Nodes (17): GlobalStyleEditorContent, .animationProfileBinding, .body, .currentSlide, .lyricDefaultAnimationBinding, .lyricSlides, .previewAnimationProfile, .previewSlideForDisplay (+9 more)

### Community 119 - ".resolved"
Cohesion: 0.25
Nodes (6): ResolvedBackgroundContentMode, fill, fit, CGSize, .resolvedMode, .resolvedContentMode

### Community 124 - ".font"
Cohesion: 0.32
Nodes (4): CGFloat, Font, NSFont, UIFont

### Community 129 - "AppViewModel.swift"
Cohesion: 0.10
Nodes (16): String, .nilIfEmpty, PhotosPickerDisplayNameResolver, PhotosPickerItem, String, .selectedPhotoItems, PickedImageFile, .transferRepresentation (+8 more)

### Community 130 - "SlideThumbnailView"
Cohesion: 0.29
Nodes (8): SlideThumbnailView, .textConfiguration, .thumbnailCanvasSize, .thumbnailStyle, .usesDefaultGradientBackground, Bool, CGSize, SlideTextStyle

### Community 131 - "PresentationFontPickerSheet"
Cohesion: 0.32
Nodes (6): PresentationFontPicker, .body, PresentationFontPickerMetrics, PresentationFontPickerSheet, .body, CGFloat

### Community 132 - "ExternalDisplayInfo"
Cohesion: 0.33
Nodes (6): ExternalDisplayInfo, .resolutionDescription, Bool, CGFloat, CGSize, String

### Community 133 - "PlaylistGlassColumn"
Cohesion: 0.29
Nodes (7): PlaylistGlassColumn, .body, PlaylistModalScrim, .body, PlaylistModalShell, .body, Content

### Community 134 - "PlaylistMediaPreview"
Cohesion: 0.48
Nodes (6): PlaylistImagePreview, PlaylistMediaPreview, .body, PlaylistVideoPreview, CGFloat, URL

### Community 135 - ".pickFiles"
Cohesion: 0.33
Nodes (4): MacFileImportPanel, Bool, URL, UTType

### Community 136 - "LyricsLibraryPanelView"
Cohesion: 0.47
Nodes (6): LyricsLibraryPanelView, .deleteAlertBinding, .filteredLyrics, .isPlaylistFiltered, .isSearching, Binding

### Community 137 - "LyrioraApp"
Cohesion: 0.40
Nodes (4): App, LyrioraApp, .body, Scene

### Community 138 - "CodableColor"
Cohesion: 0.70
Nodes (4): CodableColor, .color, Color, Double

### Community 141 - "AVPlayerLayerView"
Cohesion: 0.83
Nodes (3): AVPlayerLayerView, .body, CGSize

## Knowledge Gaps
- **514 isolated node(s):** `regular`, `medium`, `semibold`, `bold`, `.id` (+509 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 790 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **16 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AppViewModel` connect `AppViewModel` to `ExternalDisplayManager`, `AppViewModel.swift`, `LibraryPlaylist`, `PresentationPreviewView`, `LyricEditorView`, `LyricsLibraryPanelView`, `LyrioraApp`, `MediaAsset`, `LyricImportParser`, `MediaThumbnailView`, `VideoPlaybackController`, `Equatable`, `Image`, `Identifiable`, `PresentationBackgroundView`, `MainView`, `SlideGridView`, `BiblePresentationSheet`, `Codable`, `.init`, `YouTubePlaybackController`, `LyricSlideTag`, `PlaylistPickerSheet`, `VideoPlaybackMode`, `BibleXMLDocumentPicker`, `LyricSlide`, `BibleBookInfo`, `BibleVersionManifest`, `LyricTheme`, `BibleVersionIndex`, `BibleSlideGridView`, `PlaylistEditorSheet`, `SlideTransitionTextContainer`, `PresentationLayout`, `.refreshDisplayInfo`, `.body`, `GlobalStyleEditorView`, `.body`, `PresentationState`, `PresentationVideoControls`, `GlobalStyleEditorContent`?**
  _High betweenness centrality (0.215) - this node is a cross-community bridge._
- **Why does `SwiftUI` connect `SwiftUI` to `AppViewModel.swift`, `PresentationFontPickerSheet`, `LyricEditorView`, `ThemeMiniPreview`, `PlaylistMediaPreview`, `SlideDetailEditorView`, `LyrioraApp`, `AnimatedPresentationText`, `MediaAsset`, `TextAnimationEditorSection`, `LyricSlideLivePreview`, `PlaylistGlassModal.swift`, `Image`, `ExplicitLinePresentationText`, `PresentationBackgroundView`, `MainView`, `SlideGridView`, `BiblePresentationSheet`, `LibraryMorphSearchHeader`, `.transitionTransform`, `Foundation`, `BackgroundFitToolbar`, `YouTubePlaybackController`, `LyricStyleProfile`, `VideoPlaybackMode`, `BibleXMLDocumentPicker`, `LyricEditorHeaderBar`, `LyricSlide`, `MacWindowConfigurator`, `WordFontSizeOverride`, `PresentationTextConfiguration`, `ThemeSavePromptSheet`, `ClearerAnchorView`, `GlassPanel.swift`, `BibleSlideGridView`, `TransitionSpeedControl`, `WorkspaceCompactLayout.swift`, `DefaultBackgroundPreset`, `SlideTransitionTextContainer`, `StickyPreviewEditorLayout`, `GlassMorphAnimation.swift`, `LyricEditorNavigationOption`, `DisplayInfoSheet`, `GlobalStyleEditorView`, `.body`, `MetalTextEffectParameters`, `LyricCardView`, `.linearGradient`, `BibleThemeQuickPicker`?**
  _High betweenness centrality (0.070) - this node is a cross-community bridge._
- **Why does `SlideAnimationProfile` connect `SlideAnimationProfile` to `PresentationPreviewView`, `TextAnimationKind`, `SlideDetailEditorView`, `AnimatedPresentationText`, `TextAnimationStylePreset`, `ParsedSlideText`, `TextAnimationEditorSection`, `.encode`, `LyricSlideLivePreview`, `Equatable`, `PresentationBackgroundView`, `BiblePresentationSheet`, `Codable`, `AppViewModel`, `Sendable`, `LyricStyleProfile`, `CodingKeys`, `SlideTextStyle`, `LyricSlide`, `PresentationTextConfiguration`, `PresentationState`, `BibleThemeQuickPicker`, `GlobalStyleEditorContent`?**
  _High betweenness centrality (0.062) - this node is a cross-community bridge._
- **Are the 19 inferred relationships involving `AppViewModel` (e.g. with `.body` and `LyrioraApp`) actually correct?**
  _`AppViewModel` has 19 INFERRED edges - model-reasoned connections that need verification._
- **Are the 12 inferred relationships involving `SlideAnimationProfile` (e.g. with `.body` and `.previewStageContent()`) actually correct?**
  _`SlideAnimationProfile` has 12 INFERRED edges - model-reasoned connections that need verification._
- **What connects `regular`, `medium`, `semibold` to the rest of the system?**
  _514 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `ExternalDisplayManager` be split into smaller, more focused modules?**
  _Cohesion score 0.11494252873563218 - nodes in this community are weakly interconnected._