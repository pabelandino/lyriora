# Graph Report - Lyriora  (2026-11-16)

## Corpus Check
- 151 files · ~81,909 words
- Verdict: corpus is large enough that graph structure adds value.
- Unclassified: 9 file(s) not represented in the graph (top: (none) 4, .mdc 1, .plist 1)

## Summary
- 2584 nodes · 5922 edges · 166 communities (140 shown, 26 thin omitted)
- Extraction: 92% EXTRACTED · 8% INFERRED · 0% AMBIGUOUS · INFERRED: 497 edges (avg confidence: 0.82)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `c423c9b3`
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
- String
- What You Must Do When Invoked
- MediaRepositoryProtocol
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
- BiblePresentationSlide
- MediaAsset
- CodingKeys
- PlaylistGlassModal.swift
- SimplePlaySyncDisplayState
- ExplicitLinePresentationText
- PresentationFontDesign
- CodingKeys
- PresentationBackgroundLayer
- MainView
- SlideGridView
- BiblePresentationSheet
- Codable
- MetalTextEffectRenderer
- LibraryMorphSearchHeader
- Task
- .transitionTransform
- Foundation
- lyricTextFragment
- BackgroundFitToolbar
- What You Must Do When Invoked
- AppViewModel
- Sendable
- YouTubeEmbedBackgroundView.swift
- LyricEditorSlideCard
- LyricLanguage
- LyricSlideTag
- GlassPanel
- YouTubeEmbedWebViewRepresentable
- LyricSlideLayoutEngine
- .measureSingleLine
- GlassIconButton
- BibleXMLDocumentPicker
- ExternalDisplaySceneCoordinator
- LyrioraUITests
- BibleVersion.swift
- CodingKeys
- BackgroundContentMode
- View
- String
- EditorCard
- LyricEditorHeaderBar
- LyricSlide
- MacWindowConfigurator
- Identifiable
- SlideDetailEditorView
- CodingKeys
- BibleVersionManifest
- PresentationTextConfiguration
- LyricTheme
- .shadowColor
- ThemeSavePromptSheet
- ExternalPresentationContainerViewController
- SlideAnimationProfile
- LyricPlaySyncServer
- GlassCircleIcon
- LyrioraTests.swift
- BibleVersionIndex
- BibleSlideGridView
- TransitionSpeedControl
- .body
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
- content
- PresentationBackgroundView
- LyricsLibraryPanelView
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
- .loadThumbnail
- graphify reference: GitHub clone and cross-repo merge
- graphify reference: transcribe video and audio
- graphify reference: GitHub clone and cross-repo merge
- graphify reference: transcribe video and audio
- .fetchTitle
- .agents/skills/graphify/references/extraction-spec.md
- CLAUDE.md
- .claude/CLAUDE.md
- .claude/skills/graphify/references/extraction-spec.md
- PickedImageFile
- Image
- SettingsSheet
- ExternalDisplayInfo
- .store
- PlaylistMediaPreview
- BibleVersionRepository.swift
- LyricPlaySyncMessageKind
- BibleVerseLocation
- CodableColor
- DefaultBackgroundMeshStyle
- TextAnimationStylePreset
- VideoPlaybackMode
- AnimationApplyScope
- MetadataError
- .encode
- .saveLyric
- LyricImportError
- YouTubePlaybackController
- ImageLibrarySection
- .playbackTime
- LocalFileThumbnailImage
- BiblePresentationFooterView
- Data
- Decoder
- Encoder
- Date
- Error
- CGSize
- LyricDocument
- Never
- PhotosPickerItem
- SlideTextStyle
- Task
- TimeInterval
- URL
- CGFloat

## God Nodes (most connected - your core abstractions)
1. `AppViewModel` - 207 edges
2. `TextAnimationKind` - 76 edges
3. `LyricEditorView` - 67 edges
4. `SlideAnimationProfile` - 66 edges
5. `LyricSlide` - 59 edges
6. `Image` - 53 edges
7. `ExternalDisplayManager` - 50 edges
8. `TextAnimationEditorSection` - 46 edges
9. `PresentationTextConfiguration` - 44 edges
10. `MediaAsset` - 42 edges

## Surprising Connections (you probably didn't know these)
- `.availableVerseCount` --references--> `AppViewModel`  [INFERRED]
  Lyriora/Views/Bible/BiblePresentationSheet.swift → Lyriora/ViewModels/AppViewModel.swift
- `.activeTheme` --references--> `AppViewModel`  [INFERRED]
  Lyriora/Views/Modals/LyricEditorView.swift → Lyriora/ViewModels/AppViewModel.swift
- `.allItemIDs` --references--> `AppViewModel`  [INFERRED]
  Lyriora/Views/Modals/PlaylistSheets.swift → Lyriora/ViewModels/AppViewModel.swift
- `.resolvedPlaylist` --references--> `AppViewModel`  [INFERRED]
  Lyriora/Views/Modals/PlaylistSheets.swift → Lyriora/ViewModels/AppViewModel.swift
- `.iPhonePortraitPrompt` --calls--> `Image`  [INFERRED]
  Lyriora/Views/Main/MainView.swift → Lyriora/Views/Components/YouTubeEmbedBackgroundView.swift

## Import Cycles
- None detected.

## Communities (166 total, 26 thin omitted)

### Community 0 - "ExternalDisplayManager"
Cohesion: 0.11
Nodes (19): ExternalDisplayManager, .displayMonitorInterval, .isExternalDisplayConnected, ExternalPresentationWindow, .canBecomeKey, .canBecomeMain, Bool, CGSize (+11 more)

### Community 1 - "PresentationPreviewView"
Cohesion: 0.17
Nodes (14): PresentationContentView, .textConfiguration, PresentationPreviewView, .isVideoBackground, .previewMetadataBar, .previewStage, .showsSlidePlaceholder, .showsVideoControls (+6 more)

### Community 2 - "LibraryPlaylist"
Cohesion: 0.08
Nodes (26): LibraryPlaylist, LibraryPlaylistKind, image, lyric, .systemImage, .title, video, Bool (+18 more)

### Community 3 - ".configure"
Cohesion: 0.10
Nodes (29): TimeInterval, UUID, VideoSeekRequest, TimeInterval, Void, VideoProgressReporter, Coordinator, LoopingVideoBackground (+21 more)

### Community 4 - "TextAnimationKind"
Cohesion: 0.04
Nodes (47): Bool, TextAnimationKind, .basicCases, blink, blinkSemiRotate, bounce, chromaticShift, .displayName (+39 more)

### Community 5 - "LyricEditorView"
Cohesion: 0.08
Nodes (26): LyricEditorView, .activeTheme, .body, .canSave, .compactSplitLayout, .editorBackground, .editorBackgroundColor, .editorTitle (+18 more)

### Community 6 - "ThemeMiniPreview"
Cohesion: 0.14
Nodes (21): Bool, CGFloat, SlideTextStyle, String, UUID, Void, ThemeGalleryView, .body (+13 more)

### Community 7 - "String"
Cohesion: 0.22
Nodes (6): LibraryPlaylist, LibraryPlaylistKind, PlaylistRepositoryProtocol, String, UUID, .body

### Community 8 - "What You Must Do When Invoked"
Cohesion: 0.08
Nodes (24): For /graphify add and --watch, For /graphify query, For the commit hook and native AGENTS.md integration, For --update and --cluster-only, /graphify, Honesty Rules, Interpreter guard for subcommands, Part A - Structural extraction for code files (+16 more)

### Community 9 - "MediaRepositoryProtocol"
Cohesion: 0.12
Nodes (12): MediaRepositoryProtocol, Bool, LibrarySearchEmptyState, .body, String, .body, .body, VideoLibrarySection (+4 more)

### Community 10 - "AnimatedPresentationText"
Cohesion: 0.13
Nodes (21): AnimatedPresentationText, .allowsEffectTimelineUpdates, .animatedBody, .proRenderQuality, .shouldRenderAnimatedContent, .shouldRunEffectTimeline, NaturalWidthPreferenceKey, ScaledToFitWidthModifier (+13 more)

### Community 11 - "PresentationFontWeight"
Cohesion: 0.13
Nodes (15): PresentationFontWeight, bold, .id, .label, medium, regular, semibold, CGFloat (+7 more)

### Community 12 - "TextAnimationEditorSection"
Cohesion: 0.12
Nodes (23): .wordCount, Binding, Bool, Int, String, Void, TextAnimationEditorSection, .activeEffectKind (+15 more)

### Community 13 - "ParsedSlideText"
Cohesion: 0.13
Nodes (12): Int, ParsedSlideText, .isEmpty, .totalWordCount, SlideTextTokenizer, Bool, Int, Range (+4 more)

### Community 14 - "LyricImportParser"
Cohesion: 0.17
Nodes (10): LyricImportParser, LyricImportResult, LyricSectionParseResult, ParsedSections, Bool, CGSize, Int, SlideTextStyle (+2 more)

### Community 15 - "PresentationFontFamily"
Cohesion: 0.08
Nodes (26): PresentationFontFamily, americanTypewriter, arial, avenirNext, baskerville, courierNew, didot, futura (+18 more)

### Community 16 - "LyricSlideLivePreview"
Cohesion: 0.11
Nodes (24): LyricPreviewBackgroundStyle, borderOnly, settingsDefault, LyricSlideLivePreview, .body, .compactCanvasPreview, .compactHeight, .cornerRadius (+16 more)

### Community 17 - "MediaThumbnailView"
Cohesion: 0.12
Nodes (20): ClipboardLinkReader, .string, MediaImportToolbarButton, .photoPickerSelection, MediaThumbnailView, .body, .menuIconSize, .overflowActions (+12 more)

### Community 18 - "VideoPlaybackController"
Cohesion: 0.19
Nodes (10): AVPlayerLooper, Any, AVPlayer, AVPlayerItem, CMTime, NSObjectProtocol, TimeInterval, URL (+2 more)

### Community 19 - "SwiftUI"
Cohesion: 0.19
Nodes (7): AppKit, AVFoundation, AVKit, MediaImportContentTypes, UTType, SwiftUI, UIKit

### Community 20 - ".resolvedMetrics"
Cohesion: 0.19
Nodes (13): ExternalDisplayDiscovery, ExternalDisplayMetrics, Source, liveContainer, liveWindow, sceneCoordinateSpace, screenBounds, Bool (+5 more)

### Community 21 - "BiblePresentationSlide"
Cohesion: 0.18
Nodes (14): BiblePresentationSlide, BibleReadingSession, .canGoPreviousInStrip, .previewSlide, BibleSearchHint, BibleSearchHintKind, reference, textMatch (+6 more)

### Community 22 - "MediaAsset"
Cohesion: 0.07
Nodes (32): .index, MediaAsset, .listLabel, MediaAssetKind, image, video, Date, UUID (+24 more)

### Community 23 - "CodingKeys"
Cohesion: 0.10
Nodes (20): CodingKeys, defaultAnimationProfile, defaultStyle, fontDesign, fontFamily, fontWeight, horizontalPaddingRatio, isAdaptiveScalingEnabled (+12 more)

### Community 24 - "PlaylistGlassModal.swift"
Cohesion: 0.09
Nodes (30): .body, PlaylistGlassColumn, .body, PlaylistGlassEmptyState, .body, PlaylistGlassNameField, PlaylistGlassRowButton, .body (+22 more)

### Community 25 - "SimplePlaySyncDisplayState"
Cohesion: 0.12
Nodes (21): .slideGridHeader, SimplePlayConnectionIndicator, .body, .shouldAnimateGlow, SimplePlayConnectionInfoSheet, .body, .state, .statusFooter (+13 more)

### Community 26 - "ExplicitLinePresentationText"
Cohesion: 0.13
Nodes (20): EnvironmentKey, .body, .body, EditorAdaptivePresentationText, .body, .resolvedConfiguration, EditorPreviewSizing, exact (+12 more)

### Community 27 - "PresentationFontDesign"
Cohesion: 0.17
Nodes (10): Hashable, LyricEditorLaunch, PresentationFontDesign, `default`, .id, .label, monospaced, rounded (+2 more)

### Community 28 - "CodingKeys"
Cohesion: 0.17
Nodes (12): CodingKeys, colorSeed, createdAt, id, language, simplePlayProjectID, simplePlayProjectName, sourceSections (+4 more)

### Community 29 - "PresentationBackgroundLayer"
Cohesion: 0.16
Nodes (16): PresentationBackground, .isYouTube, Bool, String, URL, AppBackgroundView, .layerIdentity, .shellBackground (+8 more)

### Community 30 - "MainView"
Cohesion: 0.08
Nodes (25): App, CGFloat, ContentView, .body, LyrioraApp, .body, CenterPanelView, .presentationToolbar (+17 more)

### Community 31 - "SlideGridView"
Cohesion: 0.18
Nodes (14): SlideGridView, .body, .thumbnailWidth, SlideThumbnailView, .textConfiguration, .thumbnailCanvasSize, .thumbnailStyle, .usesDefaultGradientBackground (+6 more)

### Community 32 - "BiblePresentationSheet"
Cohesion: 0.14
Nodes (17): BiblePresentationSheet, .availableVerseCount, .bibleAnimationBinding, .bibleStyleBinding, .body, .filteredBooks, .hintsSection, .manualPassageCard (+9 more)

### Community 33 - "Codable"
Cohesion: 0.14
Nodes (19): Codable, Data, Decoder, Encoder, JSONEncoder, LinkSectionCommand, LyricAirSnapshot, LyricPlaySync (+11 more)

### Community 34 - "MetalTextEffectRenderer"
Cohesion: 0.08
Nodes (31): MetalTextEffectParameters, .isActive, MetalTextEffectRenderer, MetalTextEffectSupport, Bool, CGImage, CGSize, Double (+23 more)

### Community 35 - "LibraryMorphSearchHeader"
Cohesion: 0.16
Nodes (14): Layout, LibraryMorphSearchHeader, .body, .collapsedSearchButton, .controlSize, .isSearchActive, .resolvedHorizontalPadding, .searchSlot (+6 more)

### Community 36 - "Task"
Cohesion: 0.08
Nodes (16): BibleVersionManifest, BibleVersionRepositoryProtocol, PhotosPickerItem, String, SettingsRepository, SettingsRepositoryProtocol, FileManager, URL (+8 more)

### Community 37 - ".transitionTransform"
Cohesion: 0.09
Nodes (34): Angle, AnimatableModifier, AnimatedTextSegmentModifier, SequentialWordTransitionModifier, .animatableData, .layoutSegmentIndex, .layoutTotalWords, SlideTransitionModifier (+26 more)

### Community 38 - "Foundation"
Cohesion: 0.13
Nodes (7): CoreGraphics, Foundation, PhotosPickerDisplayNameResolver, VideoControlsReveal, Observation, Photos, PhotosUI

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
Cohesion: 0.05
Nodes (43): BiblePresentationSlide, BibleReadingSession, BibleSearchHint, BibleSearchIndex, BibleVersionIndex, BibleVersionRepositoryProtocol, CGSize, ExternalDisplayManager (+35 more)

### Community 43 - "Sendable"
Cohesion: 0.41
Nodes (10): Equatable, AppSettings, PresentationTextSettings, Bool, Decoder, Double, BiblePresentationSettings, DefaultBackgroundSettings (+2 more)

### Community 44 - "YouTubeEmbedBackgroundView.swift"
Cohesion: 0.22
Nodes (14): Bool, CGSize, Int, String, YouTubeEmbedBackgroundView, .body, .playbackRequest, YouTubeEmbedLoader (+6 more)

### Community 45 - "LyricEditorSlideCard"
Cohesion: 0.18
Nodes (11): tagStyles, LyricEditorSlideCard, .body, .textConfiguration, LyricEditorSlideHorizontalListView, .body, .slidesRefreshID, CGFloat (+3 more)

### Community 46 - "LyricLanguage"
Cohesion: 0.14
Nodes (14): LyricDocument, .previewSnippet, .slides, Date, Decoder, String, UInt64, UUID (+6 more)

### Community 47 - "LyricSlideTag"
Cohesion: 0.12
Nodes (19): LyricSectionSource, String, UUID, LyricSlideTag, bridge, chorus, .displayName, .id (+11 more)

### Community 48 - "GlassPanel"
Cohesion: 0.33
Nodes (7): GlassPanel, .body, .panelShape, GlassToolbarMetrics, .controlHeight, CGFloat, RoundedRectangle

### Community 49 - "YouTubeEmbedWebViewRepresentable"
Cohesion: 0.28
Nodes (6): Coordinator, Context, Coordinator, YouTubeEmbedWebViewRepresentable, Timer, WKWebView

### Community 50 - "LyricSlideLayoutEngine"
Cohesion: 0.40
Nodes (6): LyricSlideLayoutEngine, CGFloat, CGSize, Int, SlideTextStyle, String

### Community 51 - ".measureSingleLine"
Cohesion: 0.28
Nodes (10): PresentationTextMeasurer, Any, Bool, CGFloat, CGSize, String, .lines, .body (+2 more)

### Community 52 - "GlassIconButton"
Cohesion: 0.15
Nodes (14): ButtonRole, Action, GlassIconButton, .body, String, Void, Constants, PresentationActionsToolbar (+6 more)

### Community 53 - "BibleXMLDocumentPicker"
Cohesion: 0.12
Nodes (18): BibleImportPresentation, BibleImportRootModifier, BibleXMLDocumentPicker, Coordinator, Binding, Bool, Content, Context (+10 more)

### Community 54 - "ExternalDisplaySceneCoordinator"
Cohesion: 0.15
Nodes (10): ExternalDisplaySceneCoordinator, UIWindowScene, ExternalDisplaySceneDelegate, UICoordinateSpace, UIInterfaceOrientation, UIResponder, UIScene, UISceneSession (+2 more)

### Community 55 - "LyrioraUITests"
Cohesion: 0.15
Nodes (6): LyrioraUITests, LyrioraUITestsLaunchTests, .runsForEachTargetApplicationUIConfiguration, Bool, XCTest, XCTestCase

### Community 56 - "BibleVersion.swift"
Cohesion: 0.18
Nodes (15): BibleBookIndex, BibleChapterIndex, .verseCount, BibleVerseIndex, BibleXMLParser, BibleXMLParserError, .errorDescription, invalidFormat (+7 more)

### Community 57 - "CodingKeys"
Cohesion: 0.17
Nodes (12): CodingKeys, assignments, effectAssignments, effectFallback, effectIntensity, effectSpeed, fallbackAnimation, transitionAssignments (+4 more)

### Community 58 - "BackgroundContentMode"
Cohesion: 0.11
Nodes (17): BackgroundContentMode, auto, fill, fit, .id, .label, landscape, portrait (+9 more)

### Community 59 - "View"
Cohesion: 0.27
Nodes (11): ProTextSegmentView, .body, Bool, CGSize, Color, Double, Font, Int (+3 more)

### Community 60 - "String"
Cohesion: 0.24
Nodes (10): LyricStyleProfile, SlideTextStyle, .fontSize, Bool, Decoder, Double, Encoder, Int (+2 more)

### Community 61 - "EditorCard"
Cohesion: 0.14
Nodes (15): EditorCard, .cardBackground, LyricEditorLifecycleModifier, .importErrorPresented, .iosEditorRoot, .lyricsInfoSection, .macEditorRoot, .rawLyricsSection (+7 more)

### Community 62 - "LyricEditorHeaderBar"
Cohesion: 0.22
Nodes (15): LyricEditorChrome, LyricEditorHeaderBar, .body, LyricEditorHeaderButton, .body, LyricEditorNavRow, .body, MacLyricEditorHeaderChrome (+7 more)

### Community 63 - "LyricSlide"
Cohesion: 0.14
Nodes (14): CGSize, SlideTextStyle, LyricSlide, Decoder, Encoder, Int, SlideTextStyle, String (+6 more)

### Community 64 - "MacWindowConfigurator"
Cohesion: 0.31
Nodes (6): MacWindowConfigurator, Bool, Context, NSView, View, NSViewRepresentable

### Community 65 - "Identifiable"
Cohesion: 0.32
Nodes (7): Identifiable, BibleBookCatalog, BibleBookInfo, .id, Bool, Int, String

### Community 66 - "SlideDetailEditorView"
Cohesion: 0.07
Nodes (34): CGFloat, Double, Int, UUID, WordFontSizeOverride, WordFontSizeResolver, PresentationFontPicker, PresentationFontPickerMetrics (+26 more)

### Community 67 - "CodingKeys"
Cohesion: 0.25
Nodes (8): CodingKey, CodingKeys, linkedSectionID, order, preview, slideID, tag, text

### Community 68 - "BibleVersionManifest"
Cohesion: 0.19
Nodes (10): BibleVersionManifest, Date, BibleVersionRepository, .importableContentTypes, Data, FileManager, String, URL (+2 more)

### Community 69 - "PresentationTextConfiguration"
Cohesion: 0.14
Nodes (16): PresentationTextConfiguration, SlideTextStyle, Bool, CGFloat, CGSize, Color, Double, Font (+8 more)

### Community 70 - "LyricTheme"
Cohesion: 0.16
Nodes (11): LyricTheme, Date, Int, SlideTextStyle, String, UUID, FileManager, URL (+3 more)

### Community 71 - ".shadowColor"
Cohesion: 0.20
Nodes (10): GlassControlChrome, .foregroundColor, GlassToolbarIconStyle, Bool, Color, ColorScheme, LinearGradient, .expandedSearchField (+2 more)

### Community 72 - "ThemeSavePromptSheet"
Cohesion: 0.25
Nodes (6): Bool, String, Void, ThemeSavePromptSheet, .header, .trimmedThemeName

### Community 73 - "ExternalPresentationContainerViewController"
Cohesion: 0.26
Nodes (7): ExternalPresentationContainerViewController, AnyView, Bool, CGSize, View, Void, UIHostingController

### Community 74 - "SlideAnimationProfile"
Cohesion: 0.11
Nodes (26): SlideAnimationProfile, .hasAnimations, .hasPersistentEffects, .hasProPersistentEffects, .hasTransition, .preferredEffectSelectionTarget, .preferredTransitionSelectionTarget, .transitionsOnly (+18 more)

### Community 75 - "LyricPlaySyncServer"
Cohesion: 0.30
Nodes (7): Date, LyricPlaySyncServer, Void, MessageHandler, NWConnection, NWListener, Result

### Community 76 - "GlassCircleIcon"
Cohesion: 0.22
Nodes (9): GlassCapsuleToolbar, .body, GlassCircleIcon, .body, GlassControlBorderModifier, .body, Content, View (+1 more)

### Community 78 - "BibleVersionIndex"
Cohesion: 0.49
Nodes (7): BibleVersionIndex, BibleSlideBuilder, Bool, CGSize, Int, SlideTextStyle, String

### Community 79 - "BibleSlideGridView"
Cohesion: 0.14
Nodes (15): BibleSlideGridView, .body, .slideCounterLabel, .thumbnailWidth, BibleSlideThumbnailView, .borderColor, .borderWidth, .textConfiguration (+7 more)

### Community 80 - "TransitionSpeedControl"
Cohesion: 0.22
Nodes (8): .defaultTransitionControls, Bool, Double, Int, String, Void, TransitionSpeedControl, .body

### Community 81 - ".body"
Cohesion: 0.20
Nodes (5): LyricTheme, ThemeRepositoryProtocol, .styleSection, .body, SlideTextStyle

### Community 82 - "PlaylistEditorSheet"
Cohesion: 0.18
Nodes (11): PlaylistEditorSheet, .allItemIDs, .availableItems, .availableSearchPlaceholder, .body, .filteredAvailableItems, .resolvedPlaylist, .showsMediaPreview (+3 more)

### Community 83 - "WorkspaceCompactLayout.swift"
Cohesion: 0.33
Nodes (6): EnvironmentValues, .workspaceCompactLayout, Bool, WorkspaceDevice, .isPad, .isPhone

### Community 84 - "DefaultBackgroundPreset"
Cohesion: 0.12
Nodes (16): .body, DefaultBackgroundMeshView, .body, .style, DefaultBackgroundPreset, daylightWaves, .id, .isAdaptive (+8 more)

### Community 85 - "GlassToolbarIconSize"
Cohesion: 0.33
Nodes (6): GlassToolbarIconSize, .frameSize, .iconFont, prominent, regular, Font

### Community 86 - "SlideTransitionTextContainer"
Cohesion: 0.08
Nodes (31): LyricPlaySyncTransportError, emptyResponse, .errorDescription, noLyrioraHost, unexpectedResponse, State, failed, ready (+23 more)

### Community 87 - "StickyPreviewEditorLayout"
Cohesion: 0.33
Nodes (5): StickyPreviewEditorLayout, .stickyBackground, CGFloat, Content, Preview

### Community 88 - "PresentationLayout"
Cohesion: 0.26
Nodes (7): PresentationLayout, CGFloat, CGSize, .presentationLayoutCanvasSize, .canvasAspectRatio, .canvasSize, .previewSection

### Community 89 - ".refreshDisplayInfo"
Cohesion: 0.25
Nodes (3): Int, Task, UIWindowScene

### Community 91 - "LyricEditorNavigationOption"
Cohesion: 0.22
Nodes (8): LyricEditorNavigationOption, .id, lyrics, .systemImage, .title, typography, String, Self

### Community 92 - ".body"
Cohesion: 0.15
Nodes (8): LyricDocument, LyricEditorLaunch, LyricSlide, .selectedLyricSlides, .selectedSlide, seedSampleLyricsIfNeeded(), .body, UUID

### Community 93 - "DisplayInfoSheet"
Cohesion: 0.29
Nodes (6): DisplayInfoSheet, .body, .statusDescription, Bool, String, Void

### Community 94 - "GlobalStyleEditorView"
Cohesion: 0.22
Nodes (8): KeyboardDismissal, GlobalStyleEditorView, .body, .hasStyleChanges, Bool, SlideTextStyle, String, UUID

### Community 95 - "graphify reference: extra exports and benchmark"
Cohesion: 0.22
Nodes (8): graphify reference: extra exports and benchmark, Step 6b - Wiki (only if --wiki flag), Step 7 - Neo4j export (only if --neo4j or --neo4j-push flag), Step 7a - FalkorDB export (only if --falkordb or --falkordb-push flag), Step 7b - SVG export (only if --svg flag), Step 7c - GraphML export (only if --graphml flag), Step 7d - MCP server (only if --mcp flag), Step 8 - Token reduction benchmark (only if total_words > 5000)

### Community 96 - "graphify reference: extra exports and benchmark"
Cohesion: 0.22
Nodes (8): graphify reference: extra exports and benchmark, Step 6b - Wiki (only if --wiki flag), Step 7 - Neo4j export (only if --neo4j or --neo4j-push flag), Step 7a - FalkorDB export (only if --falkordb or --falkordb-push flag), Step 7b - SVG export (only if --svg flag), Step 7c - GraphML export (only if --graphml flag), Step 7d - MCP server (only if --mcp flag), Step 8 - Token reduction benchmark (only if total_words > 5000)

### Community 97 - "LyricRepository"
Cohesion: 0.27
Nodes (6): LyricRepository, LyricRepositoryProtocol, FileManager, LyricDocument, URL, UUID

### Community 98 - "PlayerLayerView"
Cohesion: 0.09
Nodes (23): AnyClass, AVPlayerView, AVPlayerLayerRepresentable, AVPlayerLayerView, .body, AVPlayerViewRepresentable, PlayerLayerView, .layerClass (+15 more)

### Community 99 - "BibleSearchEngine"
Cohesion: 0.39
Nodes (3): BibleSearchEngine, Int, String

### Community 100 - "content"
Cohesion: 0.23
Nodes (11): content, BlurredBackgroundLayer, .body, BlurredBackgroundModifier, CGFloat, Content, Double, View (+3 more)

### Community 101 - "PresentationBackgroundView"
Cohesion: 0.18
Nodes (14): ConfigurableDefaultGradientView, .layerIdentity, AppBackgroundAnimation, .transition, .body, .body, Animation, Double (+6 more)

### Community 102 - "LyricsLibraryPanelView"
Cohesion: 0.15
Nodes (17): Layout, .trailingControlInset, LyricCardView, .footerShape, .overflowActions, LyricsLibraryPanelView, .deleteAlertBinding, .filteredLyrics (+9 more)

### Community 103 - "CodingKeys"
Cohesion: 0.20
Nodes (10): CodingKeys, animationProfile, id, order, simplePlaySectionID, sourceSectionID, style, tag (+2 more)

### Community 104 - "BibleVersionDisplayFormatter"
Cohesion: 0.30
Nodes (6): name, BibleVersionDisplayFormatter, .prettyDisplayName, String, .nilIfEmpty, String

### Community 105 - "PresentationState"
Cohesion: 0.33
Nodes (6): PresentationState, Bool, Int, SlideTextStyle, String, UUID

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

### Community 119 - ".loadThumbnail"
Cohesion: 0.32
Nodes (7): AVAssetImageGenerator, Metadata, CGImage, CGSize, CMTime, URL, VideoAssetMetadataLoader

### Community 124 - ".fetchTitle"
Cohesion: 0.18
Nodes (9): Decodable, OEmbedResponse, String, URL, YouTubeMetadataLoader, Any, Double, YouTubeProgressParser (+1 more)

### Community 129 - "PickedImageFile"
Cohesion: 0.40
Nodes (6): PickedImageFile, .transferRepresentation, PickedVideoFile, .transferRepresentation, Transferable, TransferRepresentation

### Community 130 - "Image"
Cohesion: 0.39
Nodes (9): LocalFileImageBackground, .body, CGSize, URL, Image, .body, .body, NSImage (+1 more)

### Community 131 - "SettingsSheet"
Cohesion: 0.22
Nodes (9): EdgeInsets, DefaultBackgroundPresetPreview, .body, DefaultBackgroundPreviewCard, .body, SettingsSheet, .defaultBackgroundSection, Binding (+1 more)

### Community 132 - "ExternalDisplayInfo"
Cohesion: 0.33
Nodes (6): ExternalDisplayInfo, .resolutionDescription, Bool, CGFloat, CGSize, String

### Community 133 - ".store"
Cohesion: 0.33
Nodes (8): Entry, LocalImageCache, CGSize, URL, Data, YouTubeThumbnailView, .body, .body

### Community 134 - "PlaylistMediaPreview"
Cohesion: 0.39
Nodes (7): PlaylistImagePreview, PlaylistMediaPreview, .body, PlaylistVideoPreview, .body, CGFloat, URL

### Community 135 - "BibleVersionRepository.swift"
Cohesion: 0.20
Nodes (7): String, .nilIfEmpty, MacFileImportPanel, Bool, URL, UTType, UniformTypeIdentifiers

### Community 136 - "LyricPlaySyncMessageKind"
Cohesion: 0.18
Nodes (11): LyricPlaySyncMessageKind, airFrame, catalogRequest, catalogResponse, error, linkSection, linkSectionAck, presence (+3 more)

### Community 137 - "BibleVerseLocation"
Cohesion: 0.38
Nodes (5): BibleVerseLocation, BibleSearchIndex, BibleSearchIndexEntry, Int, String

### Community 138 - "CodableColor"
Cohesion: 0.70
Nodes (4): CodableColor, .color, Color, Double

### Community 139 - "DefaultBackgroundMeshStyle"
Cohesion: 0.22
Nodes (10): DefaultBackgroundMeshStyle, .colors, daylightWaves, morningHaze, twilightWaves, violetDusk, .wavePoints, Color (+2 more)

### Community 141 - "VideoPlaybackMode"
Cohesion: 0.29
Nodes (6): Bool, VideoPlaybackMode, loop, .loopsVideo, playOnce, .toggled

### Community 142 - "AnimationApplyScope"
Cohesion: 0.33
Nodes (6): CaseIterable, AnimationApplyScope, allSlides, currentSlide, .id, .label

### Community 143 - "MetadataError"
Cohesion: 0.33
Nodes (6): Error, MediaRepositoryError, invalidYouTubeLink, MetadataError, cancelled, thumbnailFailed

### Community 145 - ".saveLyric"
Cohesion: 0.18
Nodes (6): LyricImportResult, LyricLanguage, LyricSectionSource, LyricStyleProfile, LyricClipboardImporter, String

### Community 146 - "LyricImportError"
Cohesion: 0.33
Nodes (6): LocalizedError, LyricImportError, empty, .errorDescription, notText, unsupportedContent

### Community 147 - "YouTubePlaybackController"
Cohesion: 0.53
Nodes (3): TimeInterval, Void, YouTubePlaybackController

### Community 148 - "ImageLibrarySection"
Cohesion: 0.33
Nodes (5): ImageLibrarySection, .filteredAssets, .isPlaylistFiltered, .filteredAssets, MediaAssetKind

### Community 149 - ".playbackTime"
Cohesion: 0.70
Nodes (3): String, TimeInterval, VideoDurationFormatter

### Community 150 - "LocalFileThumbnailImage"
Cohesion: 0.60
Nodes (5): LocalFileThumbnailImage, LocalFileVideoThumbnail, .thumbnailContent, URL, View

### Community 151 - "BiblePresentationFooterView"
Cohesion: 0.50
Nodes (4): BiblePresentationFooterView, .body, .body, String

## Knowledge Gaps
- **517 isolated node(s):** `catalogRequest`, `catalogResponse`, `showSlide`, `linkSection`, `linkSectionAck` (+512 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 817 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **26 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AppViewModel` connect `AppViewModel` to `ExternalDisplayManager`, `PresentationPreviewView`, `LibraryPlaylist`, `SettingsSheet`, `LyricEditorView`, `String`, `MediaRepositoryProtocol`, `.saveLyric`, `VideoPlaybackController`, `YouTubePlaybackController`, `ImageLibrarySection`, `MediaThumbnailView`, `MediaAsset`, `SimplePlaySyncDisplayState`, `MainView`, `SlideGridView`, `BiblePresentationSheet`, `Codable`, `Task`, `Foundation`, `BibleXMLDocumentPicker`, `BibleVersionManifest`, `LyricTheme`, `LyricPlaySyncServer`, `BibleSlideGridView`, `.body`, `PlaylistEditorSheet`, `PresentationLayout`, `.refreshDisplayInfo`, `.body`, `GlobalStyleEditorView`, `BibleSearchEngine`, `LyricsLibraryPanelView`, `PresentationVideoControls`, `GlobalStyleEditorContent`?**
  _High betweenness centrality (0.196) - this node is a cross-community bridge._
- **Why does `SwiftUI` connect `SwiftUI` to `LibraryPlaylist`, `SettingsSheet`, `ThemeMiniPreview`, `PlaylistMediaPreview`, `AnimatedPresentationText`, `LyricSlideLivePreview`, `PlaylistGlassModal.swift`, `SimplePlaySyncDisplayState`, `ExplicitLinePresentationText`, `PresentationBackgroundLayer`, `MainView`, `SlideGridView`, `BiblePresentationSheet`, `MetalTextEffectRenderer`, `LibraryMorphSearchHeader`, `.transitionTransform`, `Foundation`, `BackgroundFitToolbar`, `YouTubeEmbedBackgroundView.swift`, `LyricEditorSlideCard`, `GlassIconButton`, `BibleXMLDocumentPicker`, `View`, `EditorCard`, `LyricEditorHeaderBar`, `LyricSlide`, `MacWindowConfigurator`, `SlideDetailEditorView`, `PresentationTextConfiguration`, `ThemeSavePromptSheet`, `GlassCircleIcon`, `BibleSlideGridView`, `TransitionSpeedControl`, `WorkspaceCompactLayout.swift`, `DefaultBackgroundPreset`, `SlideTransitionTextContainer`, `StickyPreviewEditorLayout`, `GlassMorphAnimation.swift`, `LyricEditorNavigationOption`, `DisplayInfoSheet`, `GlobalStyleEditorView`, `PlayerLayerView`, `content`, `LyricsLibraryPanelView`, `.linearGradient`, `BibleThemeQuickPicker`?**
  _High betweenness centrality (0.096) - this node is a cross-community bridge._
- **Why does `ExternalDisplayManager` connect `ExternalDisplayManager` to `ExternalDisplayInfo`, `ExternalPresentationContainerViewController`, `AppViewModel`, `SwiftUI`, `ExternalDisplaySceneCoordinator`, `.refreshDisplayInfo`?**
  _High betweenness centrality (0.062) - this node is a cross-community bridge._
- **Are the 19 inferred relationships involving `AppViewModel` (e.g. with `.body` and `LyrioraApp`) actually correct?**
  _`AppViewModel` has 19 INFERRED edges - model-reasoned connections that need verification._
- **Are the 2 inferred relationships involving `LyricEditorView` (e.g. with `.body` and `.body`) actually correct?**
  _`LyricEditorView` has 2 INFERRED edges - model-reasoned connections that need verification._
- **What connects `catalogRequest`, `catalogResponse`, `showSlide` to the rest of the system?**
  _517 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `ExternalDisplayManager` be split into smaller, more focused modules?**
  _Cohesion score 0.11494252873563218 - nodes in this community are weakly interconnected._