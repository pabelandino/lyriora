# Graph Report - Lyriora  (2026-08-14)

## Corpus Check
- cluster-only mode — file stats not available

## Summary
- 1928 nodes · 4384 edges · 99 communities (96 shown, 3 thin omitted)
- Extraction: 92% EXTRACTED · 8% INFERRED · 0% AMBIGUOUS · INFERRED: 351 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `93751d12`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- ExternalDisplayManager
- PresentationPreviewView
- AppViewModel
- .configure
- TextAnimationKind
- LyricEditorView
- LyricTheme
- SlideGridView
- LibraryPlaylistKind
- MediaAsset
- GlobalStyleEditorContent
- PresentationFontFamily
- TextAnimationEditorSection
- ParsedSlideText
- LyricImportParser
- LyricPlaySyncServer
- LyricSlideLivePreview
- MediaThumbnailView
- VideoPlaybackController
- SlideDetailEditorView
- .resolvedMetrics
- SlideTransitionTextContainer
- MediaAssetKind
- CodingKeys
- PlaylistGlassModal.swift
- .loadThumbnail
- ExplicitLinePresentationText
- BackgroundContentMode
- LyricSlide
- PresentationBackgroundLayer
- SlideAnimationProfile
- View
- PlayerLayerView
- Sendable
- MetalTextEffectRenderer
- LibraryMorphSearchHeader
- PlaylistEditorSheet
- .transitionTransform
- SwiftUI
- lyricTextFragment
- TextAnimationAssignment
- .init
- .body
- ProTextSegmentView
- LyricSectionSource
- String
- TypewriterRevealText
- LyricSlideTag
- GlassCircleIcon
- PlaylistPickerSheet
- LyricSlideLayoutEngine
- .measureSingleLine
- GlassIconButton
- BackgroundFitToolbar
- MainView
- LyrioraUITests
- CodingKeys
- Foundation
- LocalFileImageBackground
- Identifiable
- SlideTextStyle
- MetalTextEffectRepresentable
- PresentationBackgroundView
- DefaultBackgroundMeshStyle
- .matches
- SettingsSheet
- LyricEditorNavigationOption
- MetalTextEffectParameters
- DefaultBackgroundPreset
- PresentationTextConfiguration
- AdaptivePresentationText
- .shadowColor
- PlaylistRepository
- CodingKeys
- content
- LyricRepository
- .resolve
- BlurredBackgroundLayer
- LyricCardView
- TransitionSpeedControl
- PlaylistMediaPreview
- LyricPlaySyncMessageKind
- MacWindowConfigurator
- .parse
- GlassToolbarIconSize
- AppViewModel.swift
- .linearGradient
- .body
- VideoPlaybackMode
- WorkspaceCompactLayout.swift
- DisplayInfoSheet
- LyricsLibraryPanelView
- LyricImportError
- TextAnimationTarget
- PickedImageFile
- LyrioraApp
- LyrioraTests.swift
- ContentView
- GlassMorphAnimation.swift

## God Nodes (most connected - your core abstractions)
1. `AppViewModel` - 155 edges
2. `TextAnimationKind` - 75 edges
3. `SlideAnimationProfile` - 60 edges
4. `LyricSlide` - 53 edges
5. `ExternalDisplayManager` - 51 edges
6. `LyricEditorView` - 51 edges
7. `TextAnimationEditorSection` - 46 edges
8. `MediaAsset` - 43 edges
9. `PresentationTextConfiguration` - 40 edges
10. `GlobalStyleEditorContent` - 36 edges

## Surprising Connections (you probably didn't know these)
- `.activeTheme` --references--> `AppViewModel`  [INFERRED]
  Lyriora/Views/Modals/LyricEditorView.swift → Lyriora/ViewModels/AppViewModel.swift
- `.resolvedPlaylist` --references--> `AppViewModel`  [INFERRED]
  Lyriora/Views/Modals/PlaylistSheets.swift → Lyriora/ViewModels/AppViewModel.swift
- `.headerRow` --references--> `LyricSlide`  [INFERRED]
  Lyriora/Views/Components/LyricSlideLivePreview.swift → Lyriora/Models/LyricSlide.swift
- `.activeThemeName` --references--> `LyricStyleProfile`  [INFERRED]
  Lyriora/Views/Modals/LyricEditorView.swift → Lyriora/Models/SlideTextStyle.swift
- `.selectedBackgroundAsset` --references--> `MediaAsset`  [INFERRED]
  Lyriora/ViewModels/AppViewModel.swift → Lyriora/Models/MediaAsset.swift

## Import Cycles
- None detected.

## Communities (99 total, 3 thin omitted)

### Community 0 - "ExternalDisplayManager"
Cohesion: 0.05
Nodes (45): ExternalDisplayInfo, .resolutionDescription, Bool, CGFloat, CGSize, String, ExternalDisplayManager, .displayMonitorInterval (+37 more)

### Community 1 - "PresentationPreviewView"
Cohesion: 0.05
Nodes (40): PresentationLayout, CGFloat, CGSize, .presentationLayoutCanvasSize, .presentationState, PresentationState, Bool, Int (+32 more)

### Community 2 - "AppViewModel"
Cohesion: 0.09
Nodes (24): LibraryPlaylist, Bool, Date, UUID, PlaylistRepositoryProtocol, AppViewModel, .hasCustomBackgroundSelected, .hasVideoBackgroundSelected (+16 more)

### Community 3 - ".configure"
Cohesion: 0.10
Nodes (28): TimeInterval, UUID, VideoSeekRequest, TimeInterval, Void, VideoProgressReporter, Coordinator, LoopingVideoBackground (+20 more)

### Community 4 - "TextAnimationKind"
Cohesion: 0.04
Nodes (47): Bool, TextAnimationKind, .basicCases, blink, blinkSemiRotate, bounce, chromaticShift, .displayName (+39 more)

### Community 5 - "LyricEditorView"
Cohesion: 0.07
Nodes (28): sourceSections, KeyboardDismissal, EditorCard, .cardBackground, LyricEditorView, .activeTheme, .activeThemeName, .body (+20 more)

### Community 6 - "LyricTheme"
Cohesion: 0.08
Nodes (32): LyricTheme, Date, Int, SlideTextStyle, String, UUID, FileManager, URL (+24 more)

### Community 7 - "SlideGridView"
Cohesion: 0.06
Nodes (39): SlideGridView, .body, .slideGridHeader, .thumbnailWidth, SlideThumbnailView, .textConfiguration, .thumbnailCanvasSize, .thumbnailStyle (+31 more)

### Community 8 - "LibraryPlaylistKind"
Cohesion: 0.20
Nodes (9): LibraryPlaylistKind, image, lyric, .systemImage, .title, video, GlassOverflowMenu, .body (+1 more)

### Community 9 - "MediaAsset"
Cohesion: 0.10
Nodes (21): MediaAsset, .listLabel, Date, UUID, MediaRepositoryProtocol, .selectedPhotoItems, .selectedVideoItems, importSelectedVideos() (+13 more)

### Community 10 - "GlobalStyleEditorContent"
Cohesion: 0.08
Nodes (27): Bool, String, Void, ThemeSavePromptSheet, .body, .trimmedThemeName, GlobalStyleEditorContent, .animationProfileBinding (+19 more)

### Community 11 - "PresentationFontFamily"
Cohesion: 0.07
Nodes (31): PresentationFontWeight, bold, .id, .label, medium, regular, semibold, PresentationFontFamily (+23 more)

### Community 12 - "TextAnimationEditorSection"
Cohesion: 0.12
Nodes (18): Binding, Bool, Int, String, Void, TextAnimationEditorSection, .animationResetToolbar, .animationStatusSummary (+10 more)

### Community 13 - "ParsedSlideText"
Cohesion: 0.15
Nodes (10): Int, ParsedSlideText, .isEmpty, .totalWordCount, SlideTextTokenizer, Bool, Int, Range (+2 more)

### Community 14 - "LyricImportParser"
Cohesion: 0.18
Nodes (9): String, LyricImportParser, LyricImportResult, LyricSectionParseResult, ParsedSections, Bool, Int, String (+1 more)

### Community 15 - "LyricPlaySyncServer"
Cohesion: 0.11
Nodes (20): LyricPlaySyncServer, LyricPlaySyncTransportError, emptyResponse, .errorDescription, noLyrioraHost, unexpectedResponse, State, failed (+12 more)

### Community 16 - "LyricSlideLivePreview"
Cohesion: 0.10
Nodes (23): LyricPreviewBackgroundStyle, borderOnly, settingsDefault, LyricSlideLivePreview, .body, .compactHeight, .cornerRadius, .displayText (+15 more)

### Community 17 - "MediaThumbnailView"
Cohesion: 0.11
Nodes (22): ImageLibrarySection, .filteredAssets, .isPlaylistFiltered, MediaImportContentTypes, MediaLibraryPanelView, .body, MediaLibraryPlaylistActions, MediaThumbnailView (+14 more)

### Community 18 - "VideoPlaybackController"
Cohesion: 0.15
Nodes (10): AVPlayerLooper, Any, AVPlayer, AVPlayerItem, CMTime, NSObjectProtocol, TimeInterval, URL (+2 more)

### Community 19 - "SlideDetailEditorView"
Cohesion: 0.12
Nodes (20): SlideStyleControlsView, .body, .fontSizeBinding, .horizontalMarginBinding, .verticalMarginBinding, Binding, Double, SlideTextStyle (+12 more)

### Community 20 - ".resolvedMetrics"
Cohesion: 0.19
Nodes (13): ExternalDisplayDiscovery, ExternalDisplayMetrics, Source, liveContainer, liveWindow, sceneCoordinateSpace, screenBounds, Bool (+5 more)

### Community 21 - "SlideTransitionTextContainer"
Cohesion: 0.16
Nodes (17): SlideTransitionTextContainer, .body, .effectiveWordCount, .enterAnimation, .enterDuration, .exitDuration, Animation, Bool (+9 more)

### Community 22 - "MediaAssetKind"
Cohesion: 0.20
Nodes (11): .index, MediaAssetKind, image, video, MediaIndexEntry, MediaRepository, Data, FileManager (+3 more)

### Community 23 - "CodingKeys"
Cohesion: 0.10
Nodes (21): CodingKeys, defaultAnimationProfile, defaultStyle, fontDesign, fontFamily, fontWeight, horizontalPaddingRatio, isAdaptiveScalingEnabled (+13 more)

### Community 24 - "PlaylistGlassModal.swift"
Cohesion: 0.10
Nodes (29): PlaylistGlassColumn, .body, PlaylistGlassEmptyState, .body, PlaylistGlassNameField, PlaylistGlassRowButton, .body, PlaylistGlassSearchField (+21 more)

### Community 25 - ".loadThumbnail"
Cohesion: 0.10
Nodes (27): AVAssetImageGenerator, Error, Entry, LocalImageCache, CGSize, Image, URL, Metadata (+19 more)

### Community 26 - "ExplicitLinePresentationText"
Cohesion: 0.13
Nodes (20): EnvironmentKey, .body, EditorAdaptivePresentationText, .body, .lines, .resolvedConfiguration, EditorPreviewSizing, exact (+12 more)

### Community 27 - "BackgroundContentMode"
Cohesion: 0.13
Nodes (19): Equatable, AppSettings, PresentationTextSettings, Bool, Decoder, Double, BackgroundContentMode, auto (+11 more)

### Community 28 - "LyricSlide"
Cohesion: 0.15
Nodes (13): .slides, CGSize, SlideTextStyle, LyricSlide, Int, SlideTextStyle, String, UUID (+5 more)

### Community 29 - "PresentationBackgroundLayer"
Cohesion: 0.13
Nodes (19): PresentationBackground, URL, .activePresentationBackground, .body, AppBackgroundAnimation, AppBackgroundView, .layerIdentity, .shellBackground (+11 more)

### Community 30 - "SlideAnimationProfile"
Cohesion: 0.17
Nodes (10): assignments, SlideAnimationProfile, .hasAnimations, .hasPersistentEffects, .hasTransition, .preferredEffectSelectionTarget, .preferredTransitionSelectionTarget, Encoder (+2 more)

### Community 31 - "View"
Cohesion: 0.25
Nodes (14): AnimatedPresentationText, .animatedBody, .shouldRenderAnimatedContent, .shouldRunEffectTimeline, Bool, CGFloat, CGSize, Double (+6 more)

### Community 32 - "PlayerLayerView"
Cohesion: 0.08
Nodes (25): AnyClass, AVPlayerView, AVPlayerLayerRepresentable, AVPlayerLayerView, .body, AVPlayerViewRepresentable, PlayerLayerView, .layerClass (+17 more)

### Community 33 - "Sendable"
Cohesion: 0.21
Nodes (14): Codable, JSONEncoder, LinkSectionCommand, LyricPlaySync, LyricPlaySyncCodec, LyricPlaySyncMessage, LyricSlideCatalog, LyricSlideCatalogItem (+6 more)

### Community 34 - "MetalTextEffectRenderer"
Cohesion: 0.15
Nodes (13): MetalTextEffectRenderer, CGSize, CGRect, NSCoder, NSRect, MTKView, MTKViewDelegate, MTLCommandQueue (+5 more)

### Community 35 - "LibraryMorphSearchHeader"
Cohesion: 0.15
Nodes (15): Layout, LibraryMorphSearchHeader, .body, .collapsedSearchButton, .controlSize, .isSearchActive, .resolvedHorizontalPadding, .searchSlot (+7 more)

### Community 36 - "PlaylistEditorSheet"
Cohesion: 0.18
Nodes (11): PlaylistEditorSheet, .allItemIDs, .availableItems, .availableSearchPlaceholder, .body, .filteredAvailableItems, .resolvedPlaylist, .showsMediaPreview (+3 more)

### Community 37 - ".transitionTransform"
Cohesion: 0.14
Nodes (21): Angle, AnimatableModifier, AnimatedTextSegmentModifier, SequentialWordTransitionModifier, .animatableData, .layoutSegmentIndex, .layoutTotalWords, SlideTransitionModifier (+13 more)

### Community 38 - "SwiftUI"
Cohesion: 0.22
Nodes (5): AppKit, AVFoundation, AVKit, SwiftUI, UIKit

### Community 39 - "lyricTextFragment"
Cohesion: 0.13
Nodes (17): constant, float2, float4, fragment, lyricTextFragment(), lyricTextVertex(), TextEffectUniforms, chromaticStrength (+9 more)

### Community 40 - "TextAnimationAssignment"
Cohesion: 0.23
Nodes (11): SlideTransitionState, .showsPersistentEffects, SlideTransitionTiming, Bool, Decoder, Double, TimeInterval, UUID (+3 more)

### Community 41 - ".init"
Cohesion: 0.19
Nodes (6): SettingsRepository, SettingsRepositoryProtocol, FileManager, URL, Bool, .body

### Community 42 - ".body"
Cohesion: 0.22
Nodes (7): LyricEditorLaunch, UUID, LyricRepositoryProtocol, seedSampleLyricsIfNeeded(), LyricDocument, .body, UUID

### Community 43 - "ProTextSegmentView"
Cohesion: 0.25
Nodes (10): ProTextSegmentView, .body, Bool, CGSize, Color, Double, Font, Int (+2 more)

### Community 44 - "LyricSectionSource"
Cohesion: 0.17
Nodes (12): LyricDocument, .previewSnippet, Date, Decoder, String, UInt64, UUID, LyricSectionSource (+4 more)

### Community 45 - "String"
Cohesion: 0.16
Nodes (13): tagStyles, LyricStyleProfile, Decoder, LyricEditorSlideCard, .textConfiguration, LyricEditorSlideHorizontalListView, .body, .slidesRefreshID (+5 more)

### Community 46 - "TypewriterRevealText"
Cohesion: 0.21
Nodes (14): Bool, Color, Content, Double, Font, Int, String, TypewriterRevealText (+6 more)

### Community 47 - "LyricSlideTag"
Cohesion: 0.09
Nodes (22): LyricLanguage, .displayName, english, .id, spanish, unknown, LyricSlideTag, bridge (+14 more)

### Community 48 - "GlassCircleIcon"
Cohesion: 0.18
Nodes (11): GlassCapsuleToolbar, .body, GlassCircleIcon, .body, GlassControlBorderModifier, .body, GlassToolbarIconStyle, Content (+3 more)

### Community 49 - "PlaylistPickerSheet"
Cohesion: 0.20
Nodes (8): .body, PlaylistPickerSheet, .createPlaylistCard, .filteredPlaylists, .isSearching, .totalItemCount, Bool, Int

### Community 50 - "LyricSlideLayoutEngine"
Cohesion: 0.38
Nodes (6): LyricSlideLayoutEngine, CGFloat, CGSize, Int, SlideTextStyle, String

### Community 51 - ".measureSingleLine"
Cohesion: 0.37
Nodes (7): PresentationTextMeasurer, Any, Bool, CGFloat, CGSize, String, NSAttributedString

### Community 52 - "GlassIconButton"
Cohesion: 0.15
Nodes (12): .presentationToolbar, .body, GlassIconButton, .body, Constants, PresentationActionsToolbar, .body, .clearActionsCapsule (+4 more)

### Community 53 - "BackgroundFitToolbar"
Cohesion: 0.20
Nodes (13): BackgroundFitBadgeLabel, .body, BackgroundFitToggleLabel, .body, BackgroundFitToolbar, .body, .expandedOptions, .toggleButton (+5 more)

### Community 54 - "MainView"
Cohesion: 0.24
Nodes (8): MainView, .adaptiveWorkspace, .iPadPortraitWorkspace, .iPhoneLandscapeWorkspace, .iPhonePortraitPrompt, CGFloat, WorkspaceLayout, .iPhoneLyricsPanelWidth

### Community 55 - "LyrioraUITests"
Cohesion: 0.15
Nodes (6): LyrioraUITests, LyrioraUITestsLaunchTests, .runsForEachTargetApplicationUIConfiguration, Bool, XCTest, XCTestCase

### Community 56 - "CodingKeys"
Cohesion: 0.17
Nodes (12): CodingKey, CodingKeys, effectAssignments, effectFallback, effectIntensity, effectSpeed, fallbackAnimation, transitionAssignments (+4 more)

### Community 57 - "Foundation"
Cohesion: 0.21
Nodes (3): CoreGraphics, Foundation, LyricClipboardImporter

### Community 58 - "LocalFileImageBackground"
Cohesion: 0.24
Nodes (10): ResolvedBackgroundContentMode, fill, fit, CGSize, LocalFileImageBackground, .body, .resolvedMode, CGSize (+2 more)

### Community 59 - "Identifiable"
Cohesion: 0.09
Nodes (19): ButtonRole, CaseIterable, Identifiable, AnimationApplyScope, allSlides, currentSlide, .id, .label (+11 more)

### Community 60 - "SlideTextStyle"
Cohesion: 0.23
Nodes (10): SlideTextStyle, .fontSize, Bool, Double, Encoder, Int, CodableColor, .color (+2 more)

### Community 61 - "MetalTextEffectRepresentable"
Cohesion: 0.50
Nodes (4): ContainerView, MetalTextEffectRepresentable, Context, NSView

### Community 62 - "PresentationBackgroundView"
Cohesion: 0.31
Nodes (9): ConfigurableDefaultGradientView, .layerIdentity, .transition, .body, .body, PresentationBackgroundView, .backgroundContent, .body (+1 more)

### Community 63 - "DefaultBackgroundMeshStyle"
Cohesion: 0.14
Nodes (15): .body, DefaultBackgroundMeshStyle, .colors, daylightWaves, morningHaze, twilightWaves, violetDusk, .wavePoints (+7 more)

### Community 64 - ".matches"
Cohesion: 0.38
Nodes (5): LibrarySearch, LyricDocument, .searchableText, Bool, String

### Community 65 - "SettingsSheet"
Cohesion: 0.20
Nodes (10): EdgeInsets, .sidebarSections, DefaultBackgroundPresetPreview, .body, DefaultBackgroundPreviewCard, .body, SettingsSheet, .defaultBackgroundSection (+2 more)

### Community 66 - "LyricEditorNavigationOption"
Cohesion: 0.17
Nodes (10): Hashable, LyricEditorNavigationOption, .id, lyrics, .systemImage, .title, typography, String (+2 more)

### Community 67 - "MetalTextEffectParameters"
Cohesion: 0.18
Nodes (11): MetalTextEffectParameters, .isActive, MetalTextEffectSupport, Bool, CGImage, Double, Float, TimeInterval (+3 more)

### Community 68 - "DefaultBackgroundPreset"
Cohesion: 0.17
Nodes (11): DefaultBackgroundPreset, daylightWaves, .id, .isAdaptive, .label, meshWaves, morningHaze, twilightWaves (+3 more)

### Community 69 - "PresentationTextConfiguration"
Cohesion: 0.27
Nodes (9): PresentationTextConfiguration, SlideTextStyle, Bool, CGFloat, Color, Double, Font, SlideTextStyle (+1 more)

### Community 70 - "AdaptivePresentationText"
Cohesion: 0.18
Nodes (8): CGSize, AdaptivePresentationText, .body, .lines, Bool, Int, String, UUID

### Community 71 - ".shadowColor"
Cohesion: 0.24
Nodes (8): GlassControlChrome, .foregroundColor, Bool, Color, ColorScheme, LinearGradient, .expandedSearchField, .body

### Community 72 - "PlaylistRepository"
Cohesion: 0.36
Nodes (3): PlaylistRepository, FileManager, URL

### Community 74 - "CodingKeys"
Cohesion: 0.18
Nodes (11): CodingKeys, colorSeed, createdAt, id, language, simplePlayProjectID, simplePlayProjectName, storedSlides (+3 more)

### Community 75 - "content"
Cohesion: 0.29
Nodes (7): content, MetalTextEffectContainer, .body, Content, TimeInterval, .body, .body

### Community 76 - "LyricRepository"
Cohesion: 0.29
Nodes (5): LyricRepository, FileManager, LyricDocument, URL, UUID

### Community 77 - ".resolve"
Cohesion: 0.36
Nodes (5): CharacterSet, MediaDisplayName, Bool, Set, String

### Community 78 - "BlurredBackgroundLayer"
Cohesion: 0.33
Nodes (8): BlurredBackgroundLayer, .body, BlurredBackgroundModifier, CGFloat, Content, Double, View, View

### Community 79 - "LyricCardView"
Cohesion: 0.22
Nodes (10): Layout, .trailingControlInset, LyricCardView, .footerShape, .overflowActions, CGFloat, LyricDocument, String (+2 more)

### Community 80 - "TransitionSpeedControl"
Cohesion: 0.20
Nodes (9): .defaultTransitionControls, Bool, Double, Int, String, Void, TransitionSpeedControl, .body (+1 more)

### Community 81 - "PlaylistMediaPreview"
Cohesion: 0.36
Nodes (9): PlaylistImagePreview, .body, PlaylistMediaPreview, .body, PlaylistVideoPreview, .body, CGFloat, Image (+1 more)

### Community 82 - "LyricPlaySyncMessageKind"
Cohesion: 0.22
Nodes (9): LyricPlaySyncMessageKind, catalogRequest, catalogResponse, error, linkSection, linkSectionAck, presence, presenceAck (+1 more)

### Community 83 - "MacWindowConfigurator"
Cohesion: 0.43
Nodes (4): MacWindowConfigurator, Context, NSView, View

### Community 84 - ".parse"
Cohesion: 0.22
Nodes (6): .parsed, .wordCount, .parsedSampleText, .scopeTargets, Int, Int

### Community 85 - "GlassToolbarIconSize"
Cohesion: 0.22
Nodes (9): GlassToolbarIconSize, .frameSize, .iconFont, prominent, regular, GlassToolbarMetrics, .controlHeight, CGFloat (+1 more)

### Community 86 - "AppViewModel.swift"
Cohesion: 0.17
Nodes (8): PhotosPickerDisplayNameResolver, PhotosPickerItem, String, VideoControlsReveal, Observation, Photos, PhotosUI, UniformTypeIdentifiers

### Community 87 - ".linearGradient"
Cohesion: 0.32
Nodes (5): LyricGradient, Color, LinearGradient, UInt64, .body

### Community 88 - ".body"
Cohesion: 0.32
Nodes (7): CenterPanelView, .body, String, WorkspaceDisplayToolbar, .displayButtonAccessibilityLabel, .iPadPortraitDetailWorkspace, .iPhoneLandscapeDetailWorkspace

### Community 90 - "VideoPlaybackMode"
Cohesion: 0.29
Nodes (6): Bool, VideoPlaybackMode, loop, .loopsVideo, playOnce, .toggled

### Community 92 - "WorkspaceCompactLayout.swift"
Cohesion: 0.33
Nodes (6): EnvironmentValues, .workspaceCompactLayout, Bool, WorkspaceDevice, .isPad, .isPhone

### Community 93 - "DisplayInfoSheet"
Cohesion: 0.29
Nodes (6): DisplayInfoSheet, .body, .statusDescription, Bool, String, Void

### Community 94 - "LyricsLibraryPanelView"
Cohesion: 0.33
Nodes (7): LyricsLibraryPanelView, .deleteAlertBinding, .filteredLyrics, .isPlaylistFiltered, .isSearching, Binding, Bool

### Community 95 - "LyricImportError"
Cohesion: 0.33
Nodes (6): LocalizedError, LyricImportError, empty, .errorDescription, notText, unsupportedContent

### Community 96 - "TextAnimationTarget"
Cohesion: 0.29
Nodes (7): String, TextAnimationTarget, all, .label, line, paragraph, word

### Community 97 - "PickedImageFile"
Cohesion: 0.40
Nodes (6): PickedImageFile, .transferRepresentation, PickedVideoFile, .transferRepresentation, Transferable, TransferRepresentation

### Community 98 - "LyrioraApp"
Cohesion: 0.40
Nodes (4): App, LyrioraApp, .body, Scene

## Knowledge Gaps
- **370 isolated node(s):** `LyricPlaySync`, `VideoControlsReveal`, `.resolutionDescription`, `.displayMonitorInterval`, `.isExternalDisplayConnected` (+365 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **3 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AppViewModel` connect `AppViewModel` to `ExternalDisplayManager`, `PresentationPreviewView`, `LyricEditorView`, `LyricTheme`, `SlideGridView`, `LibraryPlaylistKind`, `MediaAsset`, `GlobalStyleEditorContent`, `LyricImportParser`, `LyricPlaySyncServer`, `MediaThumbnailView`, `VideoPlaybackController`, `LyricSlide`, `PresentationBackgroundLayer`, `Sendable`, `PlaylistEditorSheet`, `.init`, `.body`, `PlaylistPickerSheet`, `GlassIconButton`, `MainView`, `SettingsSheet`, `AppViewModel.swift`, `.body`, `VideoPlaybackMode`, `LyricsLibraryPanelView`, `LyrioraApp`, `ContentView`?**
  _High betweenness centrality (0.187) - this node is a cross-community bridge._
- **Why does `SwiftUI` connect `SwiftUI` to `PresentationPreviewView`, `LyricEditorView`, `LyricTheme`, `SlideGridView`, `GlobalStyleEditorContent`, `TextAnimationEditorSection`, `LyricSlideLivePreview`, `MediaThumbnailView`, `SlideDetailEditorView`, `SlideTransitionTextContainer`, `PlaylistGlassModal.swift`, `ExplicitLinePresentationText`, `LyricSlide`, `PresentationBackgroundLayer`, `PlayerLayerView`, `LibraryMorphSearchHeader`, `.transitionTransform`, `ProTextSegmentView`, `String`, `TypewriterRevealText`, `GlassCircleIcon`, `GlassIconButton`, `BackgroundFitToolbar`, `MainView`, `Foundation`, `DefaultBackgroundMeshStyle`, `SettingsSheet`, `LyricEditorNavigationOption`, `MetalTextEffectParameters`, `AdaptivePresentationText`, `BlurredBackgroundLayer`, `LyricCardView`, `TransitionSpeedControl`, `PlaylistMediaPreview`, `AppViewModel.swift`, `.linearGradient`, `.body`, `WorkspaceCompactLayout.swift`, `DisplayInfoSheet`, `LyrioraApp`, `ContentView`, `GlassMorphAnimation.swift`?**
  _High betweenness centrality (0.116) - this node is a cross-community bridge._
- **Why does `TextAnimationKind` connect `TextAnimationKind` to `Sendable`, `MetalTextEffectParameters`, `.transitionTransform`, `TextAnimationAssignment`, `ProTextSegmentView`, `TextAnimationEditorSection`, `ParsedSlideText`, `String`, `Foundation`, `Identifiable`, `SlideAnimationProfile`, `View`?**
  _High betweenness centrality (0.093) - this node is a cross-community bridge._
- **Are the 16 inferred relationships involving `AppViewModel` (e.g. with `.body` and `LyrioraApp`) actually correct?**
  _`AppViewModel` has 16 INFERRED edges - model-reasoned connections that need verification._
- **Are the 12 inferred relationships involving `SlideAnimationProfile` (e.g. with `.body` and `.previewStageContent()`) actually correct?**
  _`SlideAnimationProfile` has 12 INFERRED edges - model-reasoned connections that need verification._
- **What connects `LyricPlaySync`, `VideoControlsReveal`, `.resolutionDescription` to the rest of the system?**
  _370 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `ExternalDisplayManager` be split into smaller, more focused modules?**
  _Cohesion score 0.053763440860215055 - nodes in this community are weakly interconnected._