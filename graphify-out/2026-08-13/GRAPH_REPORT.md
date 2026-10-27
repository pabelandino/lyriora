# Graph Report - Lyriora  (2026-08-13)

## Corpus Check
- 120 files · ~61,151 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1837 nodes · 3883 edges · 121 communities (105 shown, 16 thin omitted)
- Extraction: 93% EXTRACTED · 7% INFERRED · 0% AMBIGUOUS · INFERRED: 265 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `4a7bd8de`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- ExternalDisplayManager
- ExplicitLinePresentationText
- LyricEditorView
- GlobalStyleEditorContent
- SwiftUI
- PresentationFontFamily
- View
- .configure
- CodingKeys
- LyricSectionSource
- .resolvedMetrics
- MediaThumbnailView
- AppViewModel
- .loadThumbnail
- LyricSlideLivePreview
- LyricSlide
- Identifiable
- PlayerLayerView
- LyricImportError
- BackgroundContentMode
- LocalFileImageBackground
- LyricImportParser
- View
- VideoPlaybackController
- GlassPanel.swift
- .store
- BlurredBackgroundLayer
- PresentationPreviewView
- LyrioraUITests
- TextAnimationKind
- MediaRepository
- LyricSlideTag
- SlideGridView
- MediaRepositoryProtocol
- TextAnimationEditorSection
- LyricsLibraryPanelView
- PresentationBackgroundView
- BackgroundFitToolbar
- LyricEditorNavigationOption
- .body
- Sendable
- LibraryMorphSearchHeader
- .body
- ParsedSlideText
- .matches
- PresentationBackgroundLayer
- DisplayInfoSheet
- DefaultBackgroundPreset
- LyricRepository
- LyrioraTests.swift
- ThemeSavePromptSheet
- GlassControlChrome
- MetalTextEffectRenderer
- .deleteSlide
- SlideTransitionTextContainer
- PresentationState
- What You Must Do When Invoked
- What You Must Do When Invoked
- DefaultBackgroundMeshStyle
- GlassOverflowMenu
- SlideAnimationProfile
- SlideDetailEditorView
- .transitionTransform
- lyricTextFragment
- TextAnimationAssignment
- DefaultBackgroundSettings
- PresentationTextConfiguration
- AppViewModel.swift
- MainView
- ClearerAnchorView
- LyricSlideLayoutEngine
- PresentationActionsToolbar
- PresentationFontWeight
- .measureSingleLine
- .body
- CodingKeys
- TextAnimationTransform
- PresentationLayout
- Foundation
- SlideTextStyle
- SlideStyleControlsView
- .postScriptName
- CodingKeys
- MacWindowConfigurator
- SlideThumbnailView
- TransitionSpeedControl
- graphify reference: extra exports and benchmark
- graphify reference: extra exports and benchmark
- EditorCard
- AnimationApplyScope
- .parse
- DefaultBackgroundPresetPreview
- SettingsRepository
- GlassToolbarIconSize
- GlassPanel
- AdaptivePresentationText
- graphify reference: query, path, explain
- graphify reference: query, path, explain
- .apply
- StickyPreviewEditorLayout
- CoreGraphics
- CodableColor
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
- .init
- .agents/skills/graphify/references/extraction-spec.md
- CLAUDE.md
- .claude/CLAUDE.md
- .claude/skills/graphify/references/extraction-spec.md
- WorkspaceCompactLayout.swift
- GlassMorphAnimation.swift
- LyricEditorLaunch

## God Nodes (most connected - your core abstractions)
1. `AppViewModel` - 110 edges
2. `TextAnimationKind` - 75 edges
3. `SlideAnimationProfile` - 60 edges
4. `LyricSlide` - 52 edges
5. `ExternalDisplayManager` - 51 edges
6. `LyricEditorView` - 51 edges
7. `TextAnimationEditorSection` - 46 edges
8. `PresentationTextConfiguration` - 40 edges
9. `BackgroundContentMode` - 36 edges
10. `GlobalStyleEditorContent` - 36 edges

## Surprising Connections (you probably didn't know these)
- `.body` --calls--> `content`  [INFERRED]
  Lyriora/Views/Components/GlassPanel.swift → Lyriora/Models/LyricDocument.swift
- `.headerRow` --references--> `LyricSlide`  [INFERRED]
  Lyriora/Views/Components/LyricSlideLivePreview.swift → Lyriora/Models/LyricSlide.swift
- `.activeEffectKind` --references--> `SlideAnimationProfile`  [INFERRED]
  Lyriora/Views/Components/TextAnimationEditorSection.swift → Lyriora/Models/SlideAnimationProfile.swift
- `.activeTransitionKind` --references--> `SlideAnimationProfile`  [INFERRED]
  Lyriora/Views/Components/TextAnimationEditorSection.swift → Lyriora/Models/SlideAnimationProfile.swift
- `.activeThemeName` --references--> `LyricStyleProfile`  [INFERRED]
  Lyriora/Views/Modals/LyricEditorView.swift → Lyriora/Models/SlideTextStyle.swift

## Import Cycles
- None detected.

## Communities (121 total, 16 thin omitted)

### Community 0 - "ExternalDisplayManager"
Cohesion: 0.05
Nodes (46): AnyView, ExternalDisplayInfo, .resolutionDescription, Bool, CGFloat, CGSize, String, ExternalDisplayManager (+38 more)

### Community 1 - "ExplicitLinePresentationText"
Cohesion: 0.13
Nodes (20): EnvironmentKey, .body, EditorAdaptivePresentationText, .body, .lines, .resolvedConfiguration, EditorPreviewSizing, exact (+12 more)

### Community 2 - "LyricEditorView"
Cohesion: 0.12
Nodes (17): LyricEditorView, .activeTheme, .activeThemeName, .editorBackground, .hasStyleChanges, .importErrorBinding, .isEditing, .lyricsSectionContent (+9 more)

### Community 3 - "GlobalStyleEditorContent"
Cohesion: 0.05
Nodes (51): LyricTheme, Date, Int, SlideTextStyle, String, UUID, FileManager, URL (+43 more)

### Community 4 - "SwiftUI"
Cohesion: 0.21
Nodes (5): AppKit, AVFoundation, AVKit, SwiftUI, UIKit

### Community 5 - "PresentationFontFamily"
Cohesion: 0.13
Nodes (15): PresentationFontFamily, arial, avenirNext, courierNew, futura, georgia, helveticaNeue, .id (+7 more)

### Community 6 - "View"
Cohesion: 0.36
Nodes (4): GlassControlBorderModifier, Content, View, S

### Community 7 - ".configure"
Cohesion: 0.11
Nodes (28): TimeInterval, UUID, VideoSeekRequest, TimeInterval, Void, VideoProgressReporter, Coordinator, LoopingVideoBackground (+20 more)

### Community 8 - "CodingKeys"
Cohesion: 0.10
Nodes (21): CodingKeys, defaultAnimationProfile, defaultStyle, fontDesign, fontFamily, fontWeight, horizontalPaddingRatio, isAdaptiveScalingEnabled (+13 more)

### Community 9 - "LyricSectionSource"
Cohesion: 0.15
Nodes (14): LyricDocument, .previewSnippet, CGSize, Date, Decoder, SlideTextStyle, String, UInt64 (+6 more)

### Community 10 - ".resolvedMetrics"
Cohesion: 0.19
Nodes (13): ExternalDisplayDiscovery, ExternalDisplayMetrics, Source, liveContainer, liveWindow, sceneCoordinateSpace, screenBounds, Bool (+5 more)

### Community 11 - "MediaThumbnailView"
Cohesion: 0.11
Nodes (24): ImageLibrarySection, .filteredAssets, MediaImportContentTypes, MediaImportToolbarButton, .photoPickerSelection, MediaLibraryPanelView, .body, MediaThumbnailView (+16 more)

### Community 12 - "AppViewModel"
Cohesion: 0.10
Nodes (18): ThemeRepositoryProtocol, AppViewModel, .hasCustomBackgroundSelected, .hasVideoBackgroundSelected, .selectedBackgroundAsset, .selectedLyric, .selectedLyricSlides, .selectedSlide (+10 more)

### Community 13 - ".loadThumbnail"
Cohesion: 0.15
Nodes (16): AVAssetImageGenerator, Error, Metadata, MetadataError, cancelled, thumbnailFailed, CGImage, CGSize (+8 more)

### Community 14 - "LyricSlideLivePreview"
Cohesion: 0.11
Nodes (23): LyricPreviewBackgroundStyle, borderOnly, settingsDefault, LyricSlideLivePreview, .body, .compactHeight, .cornerRadius, .displayText (+15 more)

### Community 15 - "LyricSlide"
Cohesion: 0.12
Nodes (19): .slides, LyricSlide, Int, SlideTextStyle, String, UUID, tagStyles, LyricEditorSlideCard (+11 more)

### Community 16 - "Identifiable"
Cohesion: 0.09
Nodes (23): CaseIterable, Identifiable, PresentationFontWeight, bold, .id, .label, medium, regular (+15 more)

### Community 17 - "PlayerLayerView"
Cohesion: 0.16
Nodes (15): AnyClass, AVPlayerView, AVPlayerLayerRepresentable, AVPlayerLayerView, .body, AVPlayerViewRepresentable, PlayerLayerView, .layerClass (+7 more)

### Community 18 - "LyricImportError"
Cohesion: 0.33
Nodes (6): LocalizedError, LyricImportError, empty, .errorDescription, notText, unsupportedContent

### Community 19 - "BackgroundContentMode"
Cohesion: 0.18
Nodes (11): BackgroundContentMode, auto, fill, fit, .id, .label, landscape, portrait (+3 more)

### Community 20 - "LocalFileImageBackground"
Cohesion: 0.22
Nodes (10): ResolvedBackgroundContentMode, fill, fit, CGSize, LocalFileImageBackground, .body, .resolvedMode, CGSize (+2 more)

### Community 21 - "LyricImportParser"
Cohesion: 0.22
Nodes (7): LyricClipboardImporter, String, LyricImportParser, ParsedSections, Bool, Int, String

### Community 22 - "View"
Cohesion: 0.08
Nodes (38): AnimatedPresentationText, .animatedBody, .shouldRenderAnimatedContent, .shouldRunEffectTimeline, Bool, CGFloat, CGSize, Double (+30 more)

### Community 23 - "VideoPlaybackController"
Cohesion: 0.16
Nodes (11): AVPlayerLooper, Any, AVPlayer, AVPlayerItem, CMTime, NSObjectProtocol, TimeInterval, URL (+3 more)

### Community 24 - "GlassPanel.swift"
Cohesion: 0.17
Nodes (12): ButtonRole, .body, Action, GlassCapsuleToolbar, .body, GlassIconButton, .body, .foregroundColor (+4 more)

### Community 25 - ".store"
Cohesion: 0.26
Nodes (12): Entry, LocalImageCache, CGSize, Image, URL, LocalFileThumbnailImage, .body, LocalFileVideoThumbnail (+4 more)

### Community 26 - "BlurredBackgroundLayer"
Cohesion: 0.33
Nodes (8): BlurredBackgroundLayer, .body, BlurredBackgroundModifier, CGFloat, Content, Double, View, View

### Community 27 - "PresentationPreviewView"
Cohesion: 0.15
Nodes (15): PresentationPreviewView, .body, .displayedCurrentTime, .isVideoBackground, .previewMetadataBar, .previewStage, .showsSlidePlaceholder, .showsVideoControls (+7 more)

### Community 28 - "LyrioraUITests"
Cohesion: 0.15
Nodes (6): LyrioraUITests, LyrioraUITestsLaunchTests, .runsForEachTargetApplicationUIConfiguration, Bool, XCTest, XCTestCase

### Community 29 - "TextAnimationKind"
Cohesion: 0.04
Nodes (47): Bool, TextAnimationKind, .basicCases, blink, blinkSemiRotate, bounce, chromaticShift, .displayName (+39 more)

### Community 30 - "MediaRepository"
Cohesion: 0.14
Nodes (15): Data, .index, MediaAssetKind, image, video, MediaRepository, FileManager, MediaAsset (+7 more)

### Community 31 - "LyricSlideTag"
Cohesion: 0.12
Nodes (16): LyricSlideTag, bridge, chorus, .displayName, .id, instrumental, intro, outro (+8 more)

### Community 32 - "SlideGridView"
Cohesion: 0.39
Nodes (5): SlideGridView, .thumbnailWidth, CGFloat, Int, Void

### Community 33 - "MediaRepositoryProtocol"
Cohesion: 0.20
Nodes (9): MediaRepositoryProtocol, .activePresentationBackground, MediaAsset, URL, LibrarySearchEmptyState, .body, String, .body (+1 more)

### Community 34 - "TextAnimationEditorSection"
Cohesion: 0.11
Nodes (20): Binding, Bool, Int, String, Void, TextAnimationEditorSection, .activeEffectKind, .activeTransitionKind (+12 more)

### Community 35 - "LyricsLibraryPanelView"
Cohesion: 0.11
Nodes (22): CenterPanelView, .body, String, WorkspaceDisplayToolbar, .displayButtonAccessibilityLabel, .iPadPortraitDetailWorkspace, .iPhoneLandscapeDetailWorkspace, Layout (+14 more)

### Community 36 - "PresentationBackgroundView"
Cohesion: 0.27
Nodes (10): ConfigurableDefaultGradientView, .body, .layerIdentity, .transition, .body, .body, PresentationBackgroundView, .backgroundContent (+2 more)

### Community 37 - "BackgroundFitToolbar"
Cohesion: 0.20
Nodes (13): BackgroundFitBadgeLabel, .body, BackgroundFitToggleLabel, .body, BackgroundFitToolbar, .body, .expandedOptions, .toggleButton (+5 more)

### Community 38 - "LyricEditorNavigationOption"
Cohesion: 0.22
Nodes (8): LyricEditorNavigationOption, .id, lyrics, .systemImage, .title, typography, String, Self

### Community 39 - ".body"
Cohesion: 0.32
Nodes (5): .body, SettingsSheet, .body, Binding, String

### Community 40 - "Sendable"
Cohesion: 0.24
Nodes (9): LyricLanguage, .displayName, english, .id, spanish, unknown, LyricImportResult, LyricSectionParseResult (+1 more)

### Community 41 - "LibraryMorphSearchHeader"
Cohesion: 0.17
Nodes (14): GlassCircleIcon, Layout, LibraryMorphSearchHeader, .body, .collapsedSearchButton, .controlSize, .isSearchActive, .resolvedHorizontalPadding (+6 more)

### Community 42 - ".body"
Cohesion: 0.33
Nodes (5): LyricRepositoryProtocol, SettingsRepositoryProtocol, seedSampleLyricsIfNeeded(), LyricDocument, .body

### Community 43 - "ParsedSlideText"
Cohesion: 0.15
Nodes (10): Int, ParsedSlideText, .isEmpty, .totalWordCount, SlideTextTokenizer, Bool, Int, Range (+2 more)

### Community 44 - ".matches"
Cohesion: 0.36
Nodes (6): LibrarySearch, LyricDocument, .searchableText, MediaAsset, Bool, String

### Community 45 - "PresentationBackgroundLayer"
Cohesion: 0.14
Nodes (18): PresentationBackground, URL, .body, AppBackgroundAnimation, AppBackgroundView, .layerIdentity, .shellBackground, PresentationBackgroundLayer (+10 more)

### Community 46 - "DisplayInfoSheet"
Cohesion: 0.29
Nodes (6): DisplayInfoSheet, .body, .statusDescription, Bool, String, Void

### Community 47 - "DefaultBackgroundPreset"
Cohesion: 0.17
Nodes (11): DefaultBackgroundPreset, daylightWaves, .id, .isAdaptive, .label, meshWaves, morningHaze, twilightWaves (+3 more)

### Community 48 - "LyricRepository"
Cohesion: 0.29
Nodes (5): LyricRepository, FileManager, LyricDocument, URL, UUID

### Community 50 - "ThemeSavePromptSheet"
Cohesion: 0.29
Nodes (6): Bool, String, Void, ThemeSavePromptSheet, .body, .trimmedThemeName

### Community 51 - "GlassControlChrome"
Cohesion: 0.36
Nodes (6): .body, GlassControlChrome, Color, ColorScheme, LinearGradient, .expandedSearchField

### Community 52 - "MetalTextEffectRenderer"
Cohesion: 0.06
Nodes (36): content, MetalTextEffectParameters, .isActive, MetalTextEffectRenderer, MetalTextEffectSupport, Bool, CGImage, CGSize (+28 more)

### Community 54 - "SlideTransitionTextContainer"
Cohesion: 0.15
Nodes (18): SlideTransitionTextContainer, .body, .effectiveWordCount, .enterAnimation, .enterDuration, .exitDuration, .transitionState, Animation (+10 more)

### Community 55 - "PresentationState"
Cohesion: 0.17
Nodes (11): .presentationState, PresentationState, Bool, Int, SlideTextStyle, String, UUID, PresentationContentView (+3 more)

### Community 56 - "What You Must Do When Invoked"
Cohesion: 0.08
Nodes (24): For /graphify add and --watch, For /graphify query, For the commit hook and native AGENTS.md integration, For --update and --cluster-only, /graphify, Honesty Rules, Interpreter guard for subcommands, Part A - Structural extraction for code files (+16 more)

### Community 57 - "What You Must Do When Invoked"
Cohesion: 0.08
Nodes (24): For /graphify add and --watch, For /graphify query, For the commit hook and native CLAUDE.md integration, For --update and --cluster-only, /graphify, Honesty Rules, Interpreter guard for subcommands, Part A - Structural extraction for code files (+16 more)

### Community 58 - "DefaultBackgroundMeshStyle"
Cohesion: 0.15
Nodes (14): DefaultBackgroundMeshStyle, .colors, daylightWaves, morningHaze, twilightWaves, violetDusk, .wavePoints, DefaultBackgroundMeshView (+6 more)

### Community 59 - "GlassOverflowMenu"
Cohesion: 0.22
Nodes (8): LyricGradient, Color, LinearGradient, UInt64, GlassOverflowMenu, .body, .body, .body

### Community 60 - "SlideAnimationProfile"
Cohesion: 0.13
Nodes (16): Codable, Equatable, SlideAnimationProfile, .hasAnimations, .hasPersistentEffects, .hasTransition, .preferredEffectSelectionTarget, .preferredTransitionSelectionTarget (+8 more)

### Community 61 - "SlideDetailEditorView"
Cohesion: 0.20
Nodes (11): SlideDetailEditorView, .activeStyle, .animationProfileBinding, .body, .previewAnimationProfile, Binding, Bool, Never (+3 more)

### Community 62 - ".transitionTransform"
Cohesion: 0.25
Nodes (11): AnimatableModifier, SequentialWordTransitionModifier, .animatableData, .layoutSegmentIndex, .layoutTotalWords, SlideTransitionModifier, .animatableData, Bool (+3 more)

### Community 63 - "lyricTextFragment"
Cohesion: 0.13
Nodes (17): constant, float2, float4, fragment, lyricTextFragment(), lyricTextVertex(), TextEffectUniforms, chromaticStrength (+9 more)

### Community 64 - "TextAnimationAssignment"
Cohesion: 0.24
Nodes (10): SlideTransitionState, .showsPersistentEffects, SlideTransitionTiming, Bool, Decoder, Double, TimeInterval, UUID (+2 more)

### Community 65 - "DefaultBackgroundSettings"
Cohesion: 0.24
Nodes (8): AppSettings, PresentationTextSettings, Bool, Decoder, Double, PresentationFontWeight, DefaultBackgroundSettings, Double

### Community 66 - "PresentationTextConfiguration"
Cohesion: 0.20
Nodes (11): PresentationTextConfiguration, SlideTextStyle, Bool, CGFloat, CGSize, Color, Double, PresentationFontWeight (+3 more)

### Community 67 - "AppViewModel.swift"
Cohesion: 0.11
Nodes (17): PhotosPickerDisplayNameResolver, PhotosPickerItem, String, .selectedPhotoItems, .selectedVideoItems, importSelectedVideos(), PickedImageFile, .transferRepresentation (+9 more)

### Community 68 - "MainView"
Cohesion: 0.12
Nodes (14): App, ContentView, .body, LyrioraApp, .body, MainView, .adaptiveWorkspace, .iPadPortraitWorkspace (+6 more)

### Community 69 - "ClearerAnchorView"
Cohesion: 0.22
Nodes (7): ClearerAnchorView, NavigationSplitViewBackgroundClearer, Context, UIView, UIViewController, View, UIViewRepresentable

### Community 70 - "LyricSlideLayoutEngine"
Cohesion: 0.38
Nodes (6): LyricSlideLayoutEngine, CGFloat, CGSize, Int, SlideTextStyle, String

### Community 71 - "PresentationActionsToolbar"
Cohesion: 0.20
Nodes (9): .presentationToolbar, Constants, PresentationActionsToolbar, .body, .clearActionsCapsule, .videoControlsCapsule, Bool, CGFloat (+1 more)

### Community 72 - "PresentationFontWeight"
Cohesion: 0.29
Nodes (7): PresentationFontWeight, .nsWeight, .swiftUIWeight, .uiWeight, Font, NSFont, UIFont

### Community 73 - ".measureSingleLine"
Cohesion: 0.37
Nodes (7): PresentationTextMeasurer, Any, Bool, CGFloat, CGSize, String, NSAttributedString

### Community 75 - "CodingKeys"
Cohesion: 0.17
Nodes (12): CodingKeys, assignments, effectAssignments, effectFallback, effectIntensity, effectSpeed, fallbackAnimation, transitionAssignments (+4 more)

### Community 76 - "TextAnimationTransform"
Cohesion: 0.29
Nodes (8): Angle, AnimatedTextSegmentModifier, CGFloat, CGSize, TimeInterval, TextAnimationTransform, View, ViewModifier

### Community 77 - "PresentationLayout"
Cohesion: 0.29
Nodes (7): PresentationLayout, CGFloat, CGSize, .presentationLayoutCanvasSize, .canvasAspectRatio, .canvasSize, .previewSection

### Community 78 - "Foundation"
Cohesion: 0.12
Nodes (7): Foundation, Bool, VideoPlaybackMode, loop, .loopsVideo, playOnce, .toggled

### Community 79 - "SlideTextStyle"
Cohesion: 0.27
Nodes (8): SlideTextStyle, .fontSize, Bool, Decoder, Double, Encoder, Int, PresentationFontWeight

### Community 80 - "SlideStyleControlsView"
Cohesion: 0.29
Nodes (9): SlideStyleControlsView, .body, .fontSizeBinding, .horizontalMarginBinding, .verticalMarginBinding, Binding, Double, SlideTextStyle (+1 more)

### Community 81 - ".postScriptName"
Cohesion: 0.36
Nodes (5): CGFloat, Font, NSFont, PresentationFontWeight, UIFont

### Community 82 - "CodingKeys"
Cohesion: 0.20
Nodes (10): CodingKey, CodingKeys, colorSeed, createdAt, id, language, storedSlides, styleProfile (+2 more)

### Community 83 - "MacWindowConfigurator"
Cohesion: 0.33
Nodes (5): MacWindowConfigurator, Context, NSView, View, NSViewRepresentable

### Community 84 - "SlideThumbnailView"
Cohesion: 0.29
Nodes (8): SlideThumbnailView, .textConfiguration, .thumbnailCanvasSize, .thumbnailStyle, .usesDefaultGradientBackground, Bool, CGSize, SlideTextStyle

### Community 85 - "TransitionSpeedControl"
Cohesion: 0.20
Nodes (9): .defaultTransitionControls, Bool, Double, Int, String, Void, TransitionSpeedControl, .body (+1 more)

### Community 86 - "graphify reference: extra exports and benchmark"
Cohesion: 0.22
Nodes (8): graphify reference: extra exports and benchmark, Step 6b - Wiki (only if --wiki flag), Step 7 - Neo4j export (only if --neo4j or --neo4j-push flag), Step 7a - FalkorDB export (only if --falkordb or --falkordb-push flag), Step 7b - SVG export (only if --svg flag), Step 7c - GraphML export (only if --graphml flag), Step 7d - MCP server (only if --mcp flag), Step 8 - Token reduction benchmark (only if total_words > 5000)

### Community 87 - "graphify reference: extra exports and benchmark"
Cohesion: 0.22
Nodes (8): graphify reference: extra exports and benchmark, Step 6b - Wiki (only if --wiki flag), Step 7 - Neo4j export (only if --neo4j or --neo4j-push flag), Step 7a - FalkorDB export (only if --falkordb or --falkordb-push flag), Step 7b - SVG export (only if --svg flag), Step 7c - GraphML export (only if --graphml flag), Step 7d - MCP server (only if --mcp flag), Step 8 - Token reduction benchmark (only if total_words > 5000)

### Community 88 - "EditorCard"
Cohesion: 0.20
Nodes (8): EditorCard, .cardBackground, .importSection, .lyricsInfoSection, .rawLyricsSection, Color, Content, String

### Community 89 - "AnimationApplyScope"
Cohesion: 0.29
Nodes (6): AnimationApplyScope, allSlides, currentSlide, .id, .label, String

### Community 90 - ".parse"
Cohesion: 0.22
Nodes (6): .parsed, .wordCount, .parsedSampleText, .scopeTargets, Int, Int

### Community 91 - "DefaultBackgroundPresetPreview"
Cohesion: 0.29
Nodes (7): EdgeInsets, .sidebarSections, DefaultBackgroundPresetPreview, .body, DefaultBackgroundPreviewCard, .body, .defaultBackgroundSection

### Community 92 - "SettingsRepository"
Cohesion: 0.40
Nodes (3): SettingsRepository, FileManager, URL

### Community 93 - "GlassToolbarIconSize"
Cohesion: 0.33
Nodes (6): GlassToolbarIconSize, .frameSize, .iconFont, prominent, regular, Font

### Community 94 - "GlassPanel"
Cohesion: 0.33
Nodes (7): .body, GlassPanel, .panelShape, GlassToolbarMetrics, .controlHeight, CGFloat, RoundedRectangle

### Community 95 - "AdaptivePresentationText"
Cohesion: 0.29
Nodes (6): AdaptivePresentationText, .lines, Bool, Int, String, UUID

### Community 96 - "graphify reference: query, path, explain"
Cohesion: 0.33
Nodes (5): For /graphify explain, For /graphify path, graphify reference: query, path, explain, Step 0 — Constrained query expansion (REQUIRED before traversal), Step 1 — Traversal

### Community 97 - "graphify reference: query, path, explain"
Cohesion: 0.33
Nodes (5): For /graphify explain, For /graphify path, graphify reference: query, path, explain, Step 0 — Constrained query expansion (REQUIRED before traversal), Step 1 — Traversal

### Community 99 - "StickyPreviewEditorLayout"
Cohesion: 0.33
Nodes (5): StickyPreviewEditorLayout, .stickyBackground, CGFloat, Content, Preview

### Community 101 - "CodableColor"
Cohesion: 0.60
Nodes (4): CodableColor, .color, Color, Double

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

### Community 132 - "LyricEditorLaunch"
Cohesion: 0.31
Nodes (4): Hashable, LyricEditorLaunch, UUID, UUID

## Knowledge Gaps
- **402 isolated node(s):** `regular`, `medium`, `semibold`, `bold`, `.id` (+397 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **16 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AppViewModel` connect `AppViewModel` to `ExternalDisplayManager`, `LyricEditorView`, `GlobalStyleEditorContent`, `LyricEditorLaunch`, `MediaThumbnailView`, `LyricSlide`, `LyricImportParser`, `VideoPlaybackController`, `GlassPanel.swift`, `PresentationPreviewView`, `MediaRepositoryProtocol`, `LyricsLibraryPanelView`, `.body`, `.body`, `PresentationBackgroundLayer`, `.deleteSlide`, `PresentationState`, `AppViewModel.swift`, `MainView`, `.body`, `PresentationLayout`, `Foundation`?**
  _High betweenness centrality (0.127) - this node is a cross-community bridge._
- **Why does `SwiftUI` connect `SwiftUI` to `ExplicitLinePresentationText`, `GlobalStyleEditorContent`, `MediaThumbnailView`, `LyricSlideLivePreview`, `LyricSlide`, `View`, `GlassPanel.swift`, `BlurredBackgroundLayer`, `SlideGridView`, `LyricsLibraryPanelView`, `BackgroundFitToolbar`, `LyricEditorNavigationOption`, `LibraryMorphSearchHeader`, `PresentationBackgroundLayer`, `DisplayInfoSheet`, `ThemeSavePromptSheet`, `MetalTextEffectRenderer`, `SlideTransitionTextContainer`, `DefaultBackgroundMeshStyle`, `GlassOverflowMenu`, `SlideDetailEditorView`, `AppViewModel.swift`, `MainView`, `ClearerAnchorView`, `PresentationActionsToolbar`, `TextAnimationTransform`, `SlideStyleControlsView`, `MacWindowConfigurator`, `TransitionSpeedControl`, `EditorCard`, `DefaultBackgroundPresetPreview`, `AdaptivePresentationText`, `StickyPreviewEditorLayout`, `CoreGraphics`, `WorkspaceCompactLayout.swift`, `GlassMorphAnimation.swift`?**
  _High betweenness centrality (0.093) - this node is a cross-community bridge._
- **Why does `TextAnimationKind` connect `TextAnimationKind` to `TextAnimationAssignment`, `TextAnimationEditorSection`, `Sendable`, `ParsedSlideText`, `TextAnimationTransform`, `Foundation`, `Identifiable`, `MetalTextEffectRenderer`, `View`, `SlideAnimationProfile`, `.transitionTransform`?**
  _High betweenness centrality (0.083) - this node is a cross-community bridge._
- **Are the 12 inferred relationships involving `AppViewModel` (e.g. with `.body` and `LyrioraApp`) actually correct?**
  _`AppViewModel` has 12 INFERRED edges - model-reasoned connections that need verification._
- **Are the 12 inferred relationships involving `SlideAnimationProfile` (e.g. with `.body` and `.previewStageContent()`) actually correct?**
  _`SlideAnimationProfile` has 12 INFERRED edges - model-reasoned connections that need verification._
- **What connects `regular`, `medium`, `semibold` to the rest of the system?**
  _402 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `ExternalDisplayManager` be split into smaller, more focused modules?**
  _Cohesion score 0.05284831846259437 - nodes in this community are weakly interconnected._