# Graph Report - Lyriora  (2026-11-16)

## Corpus Check
- 151 files · ~81,909 words
- Verdict: corpus is large enough that graph structure adds value.
- Unclassified: 9 file(s) not represented in the graph (top: (none) 4, .mdc 1, .plist 1)

## Summary
- 2542 nodes · 5909 edges · 144 communities (130 shown, 13 thin omitted)
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
- ThemeMiniPreview
- SlideDetailEditorView
- What You Must Do When Invoked
- MediaThumbnailView
- View
- PresentationFontWeight
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
- SimplePlaySyncDisplayState
- ExplicitLinePresentationText
- Identifiable
- LyricDocument
- DefaultBackgroundSettings
- MainView
- SlideGridView
- BiblePresentationSheet
- Sendable
- MetalTextEffectRenderer
- LibraryMorphSearchHeader
- .init
- .transitionTransform
- Foundation
- lyricTextFragment
- BackgroundContentMode
- What You Must Do When Invoked
- AppViewModel
- Image
- YouTubeEmbedWebViewRepresentable
- LyricSlide
- .matches
- LyricSlideTag
- .saveSettings
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
- ProTextSegmentView
- .loadThumbnail
- ThemeRepository
- LyricEditorHeaderBar
- .syncSections
- MacWindowConfigurator
- BibleBookInfo
- SlideStyleControlsView
- CodingKeys
- BibleVersionManifest
- PresentationTextConfiguration
- LyricTheme
- .shadowColor
- ThemeSavePromptSheet
- ExternalPresentationContainerViewController
- SlideAnimationProfile
- .body
- View
- LyrioraTests.swift
- BibleVersionIndex
- BibleSlideGridView
- TransitionSpeedControl
- YouTubeEmbedBackgroundView.swift
- PlaylistEditorSheet
- WorkspaceDevice
- DefaultBackgroundPreset
- GlassPanel.swift
- LyricPlaySyncMessage
- StickyPreviewEditorLayout
- PresentationLayout
- .refreshDisplayInfo
- GlassMorphAnimation.swift
- LyricEditorNavigationOption
- MediaAsset
- DisplayInfoSheet
- GlobalStyleEditorView
- graphify reference: extra exports and benchmark
- graphify reference: extra exports and benchmark
- LyricRepository
- PlayerLayerView
- BibleSearchEngine
- .fetchTitle
- WordFontSizeOverride
- LyricCardView
- CodingKeys
- BibleVersionDisplayFormatter
- LyricPlaySyncMessageKind
- .linearGradient
- MediaLibraryPanelView.swift
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
- .font
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
- PresentationFontPickerSheet
- PlaylistPickerSheet
- ExternalDisplayInfo
- VideoPlaybackMode
- PlaylistMediaPreview
- YouTubePlaybackController
- LyricsLibraryPanelView
- LyrioraApp
- AdaptivePresentationText
- TextAnimationStylePreset
- LyricImportError
- BibleVersionDisplayFormatter.swift
- .encode

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
  Lyriora/Views/Components/StickyPreviewEditorLayout.swift → Lyriora/Models/LyricDocument.swift
- `.body` --calls--> `content`  [INFERRED]
  Lyriora/Views/Modals/PlaylistGlassModal.swift → Lyriora/Models/LyricDocument.swift
- `.headerRow` --references--> `LyricSlide`  [INFERRED]
  Lyriora/Views/Components/LyricSlideLivePreview.swift → Lyriora/Models/LyricSlide.swift
- `.selectedTheme` --references--> `LyricTheme`  [INFERRED]
  Lyriora/Views/Components/ThemePreviewCard.swift → Lyriora/Models/LyricTheme.swift

## Import Cycles
- None detected.

## Communities (144 total, 13 thin omitted)

### Community 0 - "ExternalDisplayManager"
Cohesion: 0.12
Nodes (18): ExternalDisplayManager, .displayMonitorInterval, .isExternalDisplayConnected, ExternalPresentationWindow, .canBecomeKey, .canBecomeMain, Bool, CGSize (+10 more)

### Community 1 - "PresentationPreviewView"
Cohesion: 0.12
Nodes (21): .presentationState, PresentationState, Bool, Int, SlideTextStyle, String, UUID, PresentationContentView (+13 more)

### Community 2 - "LibraryPlaylist"
Cohesion: 0.11
Nodes (19): LibraryPlaylist, LibraryPlaylistKind, image, lyric, .systemImage, .title, video, Date (+11 more)

### Community 3 - ".configure"
Cohesion: 0.10
Nodes (29): TimeInterval, UUID, VideoSeekRequest, TimeInterval, Void, VideoProgressReporter, Coordinator, LoopingVideoBackground (+21 more)

### Community 4 - "TextAnimationKind"
Cohesion: 0.04
Nodes (47): Bool, TextAnimationKind, .basicCases, blink, blinkSemiRotate, bounce, chromaticShift, .displayName (+39 more)

### Community 5 - "LyricEditorView"
Cohesion: 0.06
Nodes (42): EditorCard, .cardBackground, LyricEditorLifecycleModifier, .importErrorPresented, LyricEditorView, .activeTheme, .body, .canSave (+34 more)

### Community 6 - "ThemeMiniPreview"
Cohesion: 0.14
Nodes (21): Bool, CGFloat, SlideTextStyle, String, UUID, Void, ThemeGalleryView, .body (+13 more)

### Community 7 - "SlideDetailEditorView"
Cohesion: 0.19
Nodes (12): SlideDetailEditorView, .activeStyle, .animationProfileBinding, .body, .previewAnimationProfile, .resolvedStyleForWordSizing, Binding, Bool (+4 more)

### Community 8 - "What You Must Do When Invoked"
Cohesion: 0.08
Nodes (24): For /graphify add and --watch, For /graphify query, For the commit hook and native AGENTS.md integration, For --update and --cluster-only, /graphify, Honesty Rules, Interpreter guard for subcommands, Part A - Structural extraction for code files (+16 more)

### Community 9 - "MediaThumbnailView"
Cohesion: 0.09
Nodes (30): GlassOverflowMenu, ImageLibrarySection, .body, .filteredAssets, .isPlaylistFiltered, MediaImportToolbarButton, .photoPickerSelection, MediaLibraryPanelView (+22 more)

### Community 10 - "View"
Cohesion: 0.14
Nodes (22): AnimatedPresentationText, .allowsEffectTimelineUpdates, .animatedBody, .proRenderQuality, .shouldRenderAnimatedContent, .shouldRunEffectTimeline, NaturalWidthPreferenceKey, ScaledToFitWidthModifier (+14 more)

### Community 11 - "PresentationFontWeight"
Cohesion: 0.11
Nodes (23): PresentationFontWeight, bold, .id, .label, medium, regular, semibold, SlideTextStyle (+15 more)

### Community 12 - "TextAnimationEditorSection"
Cohesion: 0.15
Nodes (19): Binding, Bool, String, Void, TextAnimationEditorSection, .activeEffectKind, .activeTransitionKind, .animationResetToolbar (+11 more)

### Community 13 - "ParsedSlideText"
Cohesion: 0.12
Nodes (14): Int, ParsedSlideText, .isEmpty, .totalWordCount, SlideTextTokenizer, Bool, Int, Range (+6 more)

### Community 14 - "LyricImportParser"
Cohesion: 0.16
Nodes (11): String, LyricImportParser, LyricImportResult, LyricSectionParseResult, ParsedSections, Bool, CGSize, Int (+3 more)

### Community 15 - "PresentationFontFamily"
Cohesion: 0.09
Nodes (22): PresentationFontFamily, americanTypewriter, arial, avenirNext, baskerville, courierNew, didot, futura (+14 more)

### Community 16 - "LyricSlideLivePreview"
Cohesion: 0.10
Nodes (25): LyricPreviewBackgroundStyle, borderOnly, settingsDefault, LyricSlideLivePreview, .body, .compactCanvasPreview, .compactHeight, .cornerRadius (+17 more)

### Community 17 - "SlideTransitionTextContainer"
Cohesion: 0.15
Nodes (19): SlideTransitionTextContainer, .body, .effectiveWordCount, .enterAnimation, .enterDuration, .exitDuration, .transitionState, .wordCount (+11 more)

### Community 18 - "VideoPlaybackController"
Cohesion: 0.19
Nodes (10): AVPlayerLooper, Any, AVPlayer, AVPlayerItem, CMTime, NSObjectProtocol, TimeInterval, URL (+2 more)

### Community 19 - "SwiftUI"
Cohesion: 0.19
Nodes (6): AppKit, AVFoundation, AVKit, LyricClipboardImporter, SwiftUI, UIKit

### Community 20 - ".resolvedMetrics"
Cohesion: 0.19
Nodes (13): ExternalDisplayDiscovery, ExternalDisplayMetrics, Source, liveContainer, liveWindow, sceneCoordinateSpace, screenBounds, Bool (+5 more)

### Community 21 - "BibleReadingSession"
Cohesion: 0.18
Nodes (15): BiblePresentationSlide, BibleReadingSession, .canGoPreviousInStrip, .previewSlide, BibleSearchHint, BibleSearchHintKind, reference, textMatch (+7 more)

### Community 22 - "MediaAssetKind"
Cohesion: 0.08
Nodes (28): Error, .index, MediaAssetKind, image, video, MediaIndexEntry, MediaRepository, MediaRepositoryError (+20 more)

### Community 23 - "CodingKeys"
Cohesion: 0.10
Nodes (20): CodingKeys, defaultAnimationProfile, defaultStyle, fontDesign, fontFamily, fontWeight, horizontalPaddingRatio, isAdaptiveScalingEnabled (+12 more)

### Community 24 - "PlaylistGlassModal.swift"
Cohesion: 0.10
Nodes (28): .body, PlaylistGlassColumn, .body, PlaylistGlassEmptyState, .body, PlaylistGlassNameField, PlaylistGlassRowButton, .body (+20 more)

### Community 25 - "SimplePlaySyncDisplayState"
Cohesion: 0.11
Nodes (23): .slideGridHeader, SimplePlayConnectionIndicator, .body, .shouldAnimateGlow, SimplePlayConnectionInfoSheet, .body, .manualModeBinding, .state (+15 more)

### Community 26 - "ExplicitLinePresentationText"
Cohesion: 0.13
Nodes (20): EnvironmentKey, .body, .body, EditorAdaptivePresentationText, .body, .resolvedConfiguration, EditorPreviewSizing, exact (+12 more)

### Community 27 - "Identifiable"
Cohesion: 0.16
Nodes (11): Hashable, Identifiable, LyricEditorLaunch, PresentationFontDesign, `default`, .id, .label, monospaced (+3 more)

### Community 28 - "LyricDocument"
Cohesion: 0.11
Nodes (20): CodingKeys, colorSeed, createdAt, id, language, simplePlayProjectID, simplePlayProjectName, sourceSections (+12 more)

### Community 29 - "DefaultBackgroundSettings"
Cohesion: 0.16
Nodes (17): PresentationBackground, .isYouTube, Bool, String, URL, DefaultBackgroundSettings, Double, AppBackgroundView (+9 more)

### Community 30 - "MainView"
Cohesion: 0.18
Nodes (10): ContentView, .body, MainView, .adaptiveWorkspace, .iPadPortraitWorkspace, .iPhoneLandscapeWorkspace, .iPhonePortraitPrompt, CGFloat (+2 more)

### Community 31 - "SlideGridView"
Cohesion: 0.18
Nodes (14): SlideGridView, .body, .thumbnailWidth, SlideThumbnailView, .textConfiguration, .thumbnailCanvasSize, .thumbnailStyle, .usesDefaultGradientBackground (+6 more)

### Community 32 - "BiblePresentationSheet"
Cohesion: 0.14
Nodes (17): BiblePresentationSheet, .availableVerseCount, .bibleAnimationBinding, .bibleStyleBinding, .body, .filteredBooks, .hintsSection, .manualPassageCard (+9 more)

### Community 33 - "Sendable"
Cohesion: 0.17
Nodes (23): Codable, Equatable, AppSettings, PresentationTextSettings, Bool, Decoder, Double, BiblePresentationSettings (+15 more)

### Community 34 - "MetalTextEffectRenderer"
Cohesion: 0.08
Nodes (31): MetalTextEffectParameters, .isActive, MetalTextEffectRenderer, MetalTextEffectSupport, Bool, CGImage, CGSize, Double (+23 more)

### Community 35 - "LibraryMorphSearchHeader"
Cohesion: 0.14
Nodes (20): GlassCircleIcon, .body, Layout, LibraryMorphSearchHeader, .body, .collapsedSearchButton, .controlSize, .isSearchActive (+12 more)

### Community 36 - ".init"
Cohesion: 0.31
Nodes (4): SettingsRepository, SettingsRepositoryProtocol, FileManager, URL

### Community 37 - ".transitionTransform"
Cohesion: 0.09
Nodes (34): Angle, AnimatableModifier, AnimatedTextSegmentModifier, SequentialWordTransitionModifier, .animatableData, .layoutSegmentIndex, .layoutTotalWords, SlideTransitionModifier (+26 more)

### Community 38 - "Foundation"
Cohesion: 0.11
Nodes (9): CoreGraphics, Foundation, ResolvedBackgroundContentMode, fill, fit, CGSize, .resolvedMode, .resolvedContentMode (+1 more)

### Community 39 - "lyricTextFragment"
Cohesion: 0.13
Nodes (17): constant, float2, float4, fragment, lyricTextFragment(), lyricTextVertex(), TextEffectUniforms, chromaticStrength (+9 more)

### Community 40 - "BackgroundContentMode"
Cohesion: 0.10
Nodes (24): BackgroundContentMode, auto, fill, fit, .id, .label, landscape, portrait (+16 more)

### Community 41 - "What You Must Do When Invoked"
Cohesion: 0.08
Nodes (24): For /graphify add and --watch, For /graphify query, For the commit hook and native CLAUDE.md integration, For --update and --cluster-only, /graphify, Honesty Rules, Interpreter guard for subcommands, Part A - Structural extraction for code files (+16 more)

### Community 42 - "AppViewModel"
Cohesion: 0.07
Nodes (25): LyricRepositoryProtocol, AppViewModel, .airSignature, .bibleSlides, .hasControllableVideoBackgroundSelected, .hasCustomBackgroundSelected, .hasVideoBackgroundSelected, .hasYouTubeBackgroundSelected (+17 more)

### Community 43 - "Image"
Cohesion: 0.23
Nodes (16): Entry, LocalImageCache, CGSize, URL, LocalFileImageBackground, .body, CGSize, URL (+8 more)

### Community 44 - "YouTubeEmbedWebViewRepresentable"
Cohesion: 0.25
Nodes (7): Coordinator, Context, Coordinator, YouTubeEmbedLoader, YouTubeEmbedWebViewRepresentable, Timer, WKWebView

### Community 45 - "LyricSlide"
Cohesion: 0.11
Nodes (22): LyricSlide, Decoder, Encoder, Int, SlideTextStyle, String, UUID, tagStyles (+14 more)

### Community 46 - ".matches"
Cohesion: 0.30
Nodes (6): Bool, LibrarySearch, LyricDocument, .searchableText, Bool, String

### Community 47 - "LyricSlideTag"
Cohesion: 0.08
Nodes (25): LyricSectionSource, String, UUID, LyricLanguage, .displayName, english, .id, spanish (+17 more)

### Community 48 - ".saveSettings"
Cohesion: 0.18
Nodes (7): BibleVersionRepositoryProtocol, Task, .versionHeader, SettingsSheet, .body, Binding, String

### Community 49 - "content"
Cohesion: 0.21
Nodes (12): content, .body, BlurredBackgroundLayer, .body, BlurredBackgroundModifier, CGFloat, Content, Double (+4 more)

### Community 50 - "LyricSlideLayoutEngine"
Cohesion: 0.40
Nodes (6): LyricSlideLayoutEngine, CGFloat, CGSize, Int, SlideTextStyle, String

### Community 51 - ".measureSingleLine"
Cohesion: 0.28
Nodes (10): PresentationTextMeasurer, Any, Bool, CGFloat, CGSize, String, .lines, .body (+2 more)

### Community 52 - "GlassIconButton"
Cohesion: 0.15
Nodes (15): ButtonRole, .presentationToolbar, Action, GlassIconButton, .body, String, Void, Constants (+7 more)

### Community 53 - "BibleXMLDocumentPicker"
Cohesion: 0.09
Nodes (23): String, .nilIfEmpty, MacFileImportPanel, Bool, URL, UTType, BibleImportPresentation, BibleImportRootModifier (+15 more)

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

### Community 58 - "PresentationBackgroundView"
Cohesion: 0.12
Nodes (19): ConfigurableDefaultGradientView, .body, .layerIdentity, BiblePresentationFooterView, .body, .body, String, AppBackgroundAnimation (+11 more)

### Community 59 - "ProTextSegmentView"
Cohesion: 0.14
Nodes (18): PresentationAnimationQuality, .effectFrameInterval, live, preview, ProTextRenderQuality, live, preview, TimeInterval (+10 more)

### Community 60 - ".loadThumbnail"
Cohesion: 0.20
Nodes (11): AVAssetImageGenerator, Metadata, CGImage, CGSize, CMTime, String, TimeInterval, URL (+3 more)

### Community 61 - "ThemeRepository"
Cohesion: 0.21
Nodes (5): FileManager, URL, ThemeRepository, ThemeRepositoryProtocol, SlideTextStyle

### Community 62 - "LyricEditorHeaderBar"
Cohesion: 0.24
Nodes (14): LyricEditorChrome, LyricEditorHeaderBar, .body, LyricEditorHeaderButton, LyricEditorNavRow, .body, MacLyricEditorHeaderChrome, .body (+6 more)

### Community 63 - ".syncSections"
Cohesion: 0.26
Nodes (4): CGSize, SlideTextStyle, LyricSlideMetadataPreservation, String

### Community 64 - "MacWindowConfigurator"
Cohesion: 0.31
Nodes (6): MacWindowConfigurator, Bool, Context, NSView, View, NSViewRepresentable

### Community 65 - "BibleBookInfo"
Cohesion: 0.20
Nodes (10): BibleBookCatalog, BibleBookInfo, .id, Bool, Int, String, BibleSearchIndex, BibleSearchIndexEntry (+2 more)

### Community 66 - "SlideStyleControlsView"
Cohesion: 0.20
Nodes (13): SlideStyleControlsView, .body, .fontSizeBinding, .horizontalMarginBinding, .layoutControls, .shadowControls, .verticalMarginBinding, .wordSizeSection (+5 more)

### Community 67 - "CodingKeys"
Cohesion: 0.25
Nodes (8): CodingKey, CodingKeys, linkedSectionID, order, preview, slideID, tag, text

### Community 68 - "BibleVersionManifest"
Cohesion: 0.19
Nodes (10): BibleVersionManifest, Date, BibleVersionRepository, .importableContentTypes, Data, FileManager, String, URL (+2 more)

### Community 69 - "PresentationTextConfiguration"
Cohesion: 0.21
Nodes (11): PresentationTextConfiguration, SlideTextStyle, Bool, CGFloat, CGSize, Color, Double, Font (+3 more)

### Community 70 - "LyricTheme"
Cohesion: 0.24
Nodes (8): LyricTheme, Date, Int, SlideTextStyle, String, UUID, .recentBibleThemes, .previewText

### Community 71 - ".shadowColor"
Cohesion: 0.17
Nodes (13): .body, GlassControlChrome, .foregroundColor, Bool, Color, ColorScheme, LinearGradient, .expandedSearchField (+5 more)

### Community 72 - "ThemeSavePromptSheet"
Cohesion: 0.25
Nodes (6): Bool, String, Void, ThemeSavePromptSheet, .header, .trimmedThemeName

### Community 73 - "ExternalPresentationContainerViewController"
Cohesion: 0.26
Nodes (7): ExternalPresentationContainerViewController, AnyView, Bool, CGSize, View, Void, UIHostingController

### Community 74 - "SlideAnimationProfile"
Cohesion: 0.11
Nodes (22): SlideAnimationProfile, .hasAnimations, .hasPersistentEffects, .hasProPersistentEffects, .hasTransition, .preferredEffectSelectionTarget, .preferredTransitionSelectionTarget, SlideTransitionState (+14 more)

### Community 75 - ".body"
Cohesion: 0.19
Nodes (10): .header, CenterPanelView, .body, .slideGridSection, String, WorkspaceDisplayToolbar, .displayButtonAccessibilityLabel, .iPadPortraitDetailWorkspace (+2 more)

### Community 76 - "View"
Cohesion: 0.19
Nodes (8): .body, GlassCapsuleToolbar, .body, GlassControlBorderModifier, Content, View, S, ViewModifier

### Community 78 - "BibleVersionIndex"
Cohesion: 0.32
Nodes (9): BibleVersionIndex, CGSize, SlideTextStyle, BibleSlideBuilder, Bool, CGSize, Int, SlideTextStyle (+1 more)

### Community 79 - "BibleSlideGridView"
Cohesion: 0.15
Nodes (15): BibleSlideGridView, .canGoNext, .slideCounterLabel, .thumbnailWidth, BibleSlideThumbnailView, .borderColor, .borderWidth, .textConfiguration (+7 more)

### Community 80 - "TransitionSpeedControl"
Cohesion: 0.22
Nodes (8): .defaultTransitionControls, Bool, Double, Int, String, Void, TransitionSpeedControl, .body

### Community 81 - "YouTubeEmbedBackgroundView.swift"
Cohesion: 0.24
Nodes (13): Bool, CGSize, Int, String, YouTubeEmbedBackgroundView, .body, .playbackRequest, YouTubeEmbedPlaybackRequest (+5 more)

### Community 82 - "PlaylistEditorSheet"
Cohesion: 0.18
Nodes (11): PlaylistEditorSheet, .allItemIDs, .availableItems, .availableSearchPlaceholder, .body, .filteredAvailableItems, .resolvedPlaylist, .showsMediaPreview (+3 more)

### Community 83 - "WorkspaceDevice"
Cohesion: 0.33
Nodes (6): EnvironmentValues, .workspaceCompactLayout, Bool, WorkspaceDevice, .isPad, .isPhone

### Community 84 - "DefaultBackgroundPreset"
Cohesion: 0.08
Nodes (25): DefaultBackgroundMeshStyle, .colors, daylightWaves, morningHaze, twilightWaves, violetDusk, .wavePoints, DefaultBackgroundMeshView (+17 more)

### Community 85 - "GlassPanel.swift"
Cohesion: 0.18
Nodes (13): GlassPanel, .panelShape, GlassToolbarIconSize, .frameSize, .iconFont, prominent, regular, GlassToolbarIconStyle (+5 more)

### Community 86 - "LyricPlaySyncMessage"
Cohesion: 0.09
Nodes (26): JSONEncoder, LyricPlaySyncCodec, LyricPlaySyncMessage, Data, Encoder, LyricPlaySyncServer, LyricPlaySyncTransportError, emptyResponse (+18 more)

### Community 87 - "StickyPreviewEditorLayout"
Cohesion: 0.29
Nodes (6): StickyPreviewEditorLayout, .body, .stickyBackground, CGFloat, Content, Preview

### Community 88 - "PresentationLayout"
Cohesion: 0.23
Nodes (8): PresentationLayout, CGFloat, CGSize, .presentationLayoutCanvasSize, .body, .canvasAspectRatio, .canvasSize, .previewSection

### Community 89 - ".refreshDisplayInfo"
Cohesion: 0.25
Nodes (3): Int, Task, UIWindowScene

### Community 91 - "LyricEditorNavigationOption"
Cohesion: 0.22
Nodes (8): LyricEditorNavigationOption, .id, lyrics, .systemImage, .title, typography, String, Self

### Community 92 - "MediaAsset"
Cohesion: 0.11
Nodes (13): MediaAsset, .listLabel, Date, UUID, MediaRepositoryProtocol, .isYouTubeLink, .activePresentationBackground, .selectedBackgroundAsset (+5 more)

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
Cohesion: 0.29
Nodes (5): LyricRepository, FileManager, LyricDocument, URL, UUID

### Community 98 - "PlayerLayerView"
Cohesion: 0.09
Nodes (23): AnyClass, AVPlayerView, AVPlayerLayerRepresentable, AVPlayerLayerView, .body, AVPlayerViewRepresentable, PlayerLayerView, .layerClass (+15 more)

### Community 99 - "BibleSearchEngine"
Cohesion: 0.46
Nodes (3): BibleSearchEngine, Int, String

### Community 100 - ".fetchTitle"
Cohesion: 0.18
Nodes (9): Decodable, OEmbedResponse, String, URL, YouTubeMetadataLoader, Any, Double, YouTubeProgressParser (+1 more)

### Community 101 - "WordFontSizeOverride"
Cohesion: 0.35
Nodes (6): CGFloat, Double, Int, UUID, WordFontSizeOverride, WordFontSizeResolver

### Community 102 - "LyricCardView"
Cohesion: 0.20
Nodes (11): Layout, .trailingControlInset, LyricCardView, .footerShape, .overflowActions, Bool, CGFloat, LyricDocument (+3 more)

### Community 103 - "CodingKeys"
Cohesion: 0.20
Nodes (10): CodingKeys, animationProfile, id, order, simplePlaySectionID, sourceSectionID, style, tag (+2 more)

### Community 104 - "BibleVersionDisplayFormatter"
Cohesion: 0.47
Nodes (4): name, BibleVersionDisplayFormatter, .prettyDisplayName, String

### Community 105 - "LyricPlaySyncMessageKind"
Cohesion: 0.18
Nodes (11): LyricPlaySyncMessageKind, airFrame, catalogRequest, catalogResponse, error, linkSection, linkSectionAck, presence (+3 more)

### Community 106 - ".linearGradient"
Cohesion: 0.32
Nodes (5): LyricGradient, Color, LinearGradient, UInt64, .body

### Community 107 - "MediaLibraryPanelView.swift"
Cohesion: 0.27
Nodes (10): ClipboardLinkReader, .string, LocalFileThumbnailImage, LocalFileVideoThumbnail, MediaImportContentTypes, MediaLibraryPlaylistActions, .thumbnailContent, URL (+2 more)

### Community 108 - "graphify reference: query, path, explain"
Cohesion: 0.33
Nodes (5): For /graphify explain, For /graphify path, graphify reference: query, path, explain, Step 0 — Constrained query expansion (REQUIRED before traversal), Step 1 — Traversal

### Community 109 - "graphify reference: query, path, explain"
Cohesion: 0.33
Nodes (5): For /graphify explain, For /graphify path, graphify reference: query, path, explain, Step 0 — Constrained query expansion (REQUIRED before traversal), Step 1 — Traversal

### Community 110 - "BibleThemeQuickPicker"
Cohesion: 0.22
Nodes (8): .transitionsOnly, BibleThemeQuickPicker, .body, BibleTransitionStyleSection, .body, Bool, UUID, Void

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

### Community 119 - ".font"
Cohesion: 0.32
Nodes (4): CGFloat, Font, NSFont, UIFont

### Community 124 - "DefaultBackgroundPresetPreview"
Cohesion: 0.33
Nodes (6): EdgeInsets, DefaultBackgroundPresetPreview, .body, DefaultBackgroundPreviewCard, .body, .defaultBackgroundSection

### Community 129 - "AppViewModel.swift"
Cohesion: 0.13
Nodes (13): PhotosPickerDisplayNameResolver, PhotosPickerItem, String, .selectedPhotoItems, PickedImageFile, .transferRepresentation, PickedVideoFile, .transferRepresentation (+5 more)

### Community 130 - "PresentationFontPickerSheet"
Cohesion: 0.32
Nodes (6): PresentationFontPicker, .body, PresentationFontPickerMetrics, PresentationFontPickerSheet, .body, CGFloat

### Community 131 - "PlaylistPickerSheet"
Cohesion: 0.31
Nodes (7): PlaylistPickerSheet, .createPlaylistCard, .filteredPlaylists, .isSearching, .totalItemCount, Bool, Int

### Community 132 - "ExternalDisplayInfo"
Cohesion: 0.33
Nodes (6): ExternalDisplayInfo, .resolutionDescription, Bool, CGFloat, CGSize, String

### Community 133 - "VideoPlaybackMode"
Cohesion: 0.29
Nodes (6): Bool, VideoPlaybackMode, loop, .loopsVideo, playOnce, .toggled

### Community 134 - "PlaylistMediaPreview"
Cohesion: 0.33
Nodes (8): PlaylistImagePreview, .body, PlaylistMediaPreview, .body, PlaylistVideoPreview, .body, CGFloat, URL

### Community 135 - "YouTubePlaybackController"
Cohesion: 0.48
Nodes (3): TimeInterval, Void, YouTubePlaybackController

### Community 136 - "LyricsLibraryPanelView"
Cohesion: 0.47
Nodes (6): LyricsLibraryPanelView, .deleteAlertBinding, .filteredLyrics, .isPlaylistFiltered, .isSearching, Binding

### Community 137 - "LyrioraApp"
Cohesion: 0.40
Nodes (4): App, LyrioraApp, .body, Scene

### Community 139 - "AdaptivePresentationText"
Cohesion: 0.33
Nodes (5): AdaptivePresentationText, Bool, Int, String, UUID

### Community 141 - "LyricImportError"
Cohesion: 0.40
Nodes (5): LyricImportError, empty, .errorDescription, notText, unsupportedContent

## Knowledge Gaps
- **517 isolated node(s):** `regular`, `medium`, `semibold`, `bold`, `.id` (+512 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 795 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **13 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AppViewModel` connect `AppViewModel` to `ExternalDisplayManager`, `AppViewModel.swift`, `LibraryPlaylist`, `PresentationPreviewView`, `PlaylistPickerSheet`, `VideoPlaybackMode`, `LyricEditorView`, `YouTubePlaybackController`, `LyricsLibraryPanelView`, `LyrioraApp`, `.selectBackgroundMedia`, `MediaThumbnailView`, `LyricImportParser`, `VideoPlaybackController`, `BibleReadingSession`, `SimplePlaySyncDisplayState`, `Identifiable`, `DefaultBackgroundSettings`, `MainView`, `SlideGridView`, `BiblePresentationSheet`, `Sendable`, `.init`, `LyricSlide`, `LyricSlideTag`, `.saveSettings`, `BibleXMLDocumentPicker`, `ThemeRepository`, `BibleBookInfo`, `BibleVersionManifest`, `LyricTheme`, `.body`, `View`, `BibleVersionIndex`, `BibleSlideGridView`, `PlaylistEditorSheet`, `LyricPlaySyncMessage`, `PresentationLayout`, `.refreshDisplayInfo`, `MediaAsset`, `GlobalStyleEditorView`, `PresentationVideoControls`, `GlobalStyleEditorContent`?**
  _High betweenness centrality (0.225) - this node is a cross-community bridge._
- **Why does `SlideAnimationProfile` connect `SlideAnimationProfile` to `PresentationPreviewView`, `TextAnimationKind`, `SlideDetailEditorView`, `View`, `PresentationFontWeight`, `TextAnimationStylePreset`, `ParsedSlideText`, `AdaptivePresentationText`, `TextAnimationEditorSection`, `.encode`, `LyricSlideLivePreview`, `BiblePresentationSheet`, `Sendable`, `AppViewModel`, `LyricSlide`, `CodingKeys`, `PresentationBackgroundView`, `BibleThemeQuickPicker`, `GlobalStyleEditorContent`?**
  _High betweenness centrality (0.066) - this node is a cross-community bridge._
- **Why does `TextAnimationKind` connect `TextAnimationKind` to `Sendable`, `MetalTextEffectRenderer`, `.transitionTransform`, `Foundation`, `ProTextSegmentView`, `SlideAnimationProfile`, `View`, `TextAnimationEditorSection`, `ParsedSlideText`, `BibleThemeQuickPicker`, `CodingKeys`, `Identifiable`?**
  _High betweenness centrality (0.057) - this node is a cross-community bridge._
- **Are the 19 inferred relationships involving `AppViewModel` (e.g. with `.body` and `LyrioraApp`) actually correct?**
  _`AppViewModel` has 19 INFERRED edges - model-reasoned connections that need verification._
- **Are the 12 inferred relationships involving `SlideAnimationProfile` (e.g. with `.body` and `.previewStageContent()`) actually correct?**
  _`SlideAnimationProfile` has 12 INFERRED edges - model-reasoned connections that need verification._
- **What connects `regular`, `medium`, `semibold` to the rest of the system?**
  _517 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `ExternalDisplayManager` be split into smaller, more focused modules?**
  _Cohesion score 0.1206896551724138 - nodes in this community are weakly interconnected._