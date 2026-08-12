//
//  SlideTransitionTextContainer.swift
//  Lyriora
//

import SwiftUI

struct SlideTransitionTextContainer<Content: View>: View {
    let slideID: UUID
    let text: String
    let playsTransition: Bool
    var transitionSpeed: Double = 1
    var transitionWordStagger: Bool = false
    var replayToken: Int = 0
    var presentationToken: Int = 0
    /// When true, slide changes show content immediately; transitions run only on replay.
    var skipsTransitionOnSlideChange: Bool = false
    @ViewBuilder var content: (_ state: SlideTransitionState, _ displayedText: String) -> Content

    @State private var activeSlideID: UUID
    @State private var displayedText: String
    @State private var enterProgress: Double = 1
    @State private var isExiting = false
    @State private var transitionTask: Task<Void, Never>?
    @State private var settingsReplayTask: Task<Void, Never>?
    @State private var transitionGeneration = 0
    @State private var lastPresentationToken = 0

    init(
        slideID: UUID,
        text: String,
        playsTransition: Bool,
        transitionSpeed: Double = 1,
        transitionWordStagger: Bool = false,
        replayToken: Int = 0,
        presentationToken: Int = 0,
        skipsTransitionOnSlideChange: Bool = false,
        @ViewBuilder content: @escaping (_ state: SlideTransitionState, _ displayedText: String) -> Content
    ) {
        self.slideID = slideID
        self.text = text
        self.playsTransition = playsTransition
        self.transitionSpeed = transitionSpeed
        self.transitionWordStagger = transitionWordStagger
        self.replayToken = replayToken
        self.presentationToken = presentationToken
        self.skipsTransitionOnSlideChange = skipsTransitionOnSlideChange
        self.content = content
        _activeSlideID = State(initialValue: slideID)
        _displayedText = State(initialValue: text)
        _lastPresentationToken = State(initialValue: presentationToken)
    }

    private var wordCount: Int {
        max(1, SlideTextTokenizer.parse(text).totalWordCount)
    }

    private var effectiveWordCount: Int {
        transitionWordStagger ? wordCount : 1
    }

    private var enterDuration: TimeInterval {
        SlideTransitionTiming.enterDuration(
            wordCount: effectiveWordCount,
            speed: transitionSpeed,
            wordStagger: transitionWordStagger
        )
    }

    private var exitDuration: TimeInterval {
        SlideTransitionTiming.exitDuration(
            wordCount: effectiveWordCount,
            speed: transitionSpeed,
            wordStagger: transitionWordStagger
        )
    }

    private var enterAnimation: Animation {
        if transitionWordStagger && wordCount > 1 {
            return .linear(duration: enterDuration)
        }
        return .easeOut(duration: enterDuration)
    }

    private var transitionState: SlideTransitionState {
        SlideTransitionState(enterProgress: enterProgress, isExiting: isExiting)
    }

    var body: some View {
        content(transitionState, displayedText)
            .onAppear {
                activeSlideID = slideID
                displayedText = text
                lastPresentationToken = presentationToken
                if skipsTransitionOnSlideChange {
                    enterProgress = 1
                    isExiting = false
                } else {
                    runEnterAnimationIfNeeded()
                }
            }
            .onChange(of: slideID) { _, newID in
                guard newID != activeSlideID else { return }
                scheduleSlideChange(to: newID, text: text)
            }
            .onChange(of: text) { _, newText in
                guard slideID == activeSlideID, !isExiting else { return }
                displayedText = newText
            }
            .onChange(of: replayToken) { _, _ in
                guard playsTransition else { return }
                scheduleReplayEnter()
            }
            .onChange(of: transitionSpeed) { _, _ in
                guard playsTransition else { return }
                scheduleDebouncedSettingsReplay()
            }
            .onChange(of: transitionWordStagger) { _, _ in
                guard playsTransition else { return }
                scheduleReplayEnter()
            }
            .onChange(of: presentationToken) { _, newToken in
                guard newToken != lastPresentationToken else { return }
                lastPresentationToken = newToken
                scheduleSlideChange(to: slideID, text: text)
            }
            .onDisappear {
                cancelTransitionWork()
            }
    }

    private func cancelTransitionWork() {
        transitionTask?.cancel()
        transitionTask = nil
        settingsReplayTask?.cancel()
        settingsReplayTask = nil
        transitionGeneration += 1
    }

    private func scheduleDebouncedSettingsReplay() {
        settingsReplayTask?.cancel()
        settingsReplayTask = Task {
            try? await Task.sleep(for: .milliseconds(160))
            guard !Task.isCancelled else { return }
            await MainActor.run {
                scheduleReplayEnter()
            }
        }
    }

    private func scheduleSlideChange(to newID: UUID, text newText: String) {
        cancelTransitionWork()
        let generation = transitionGeneration

        guard playsTransition, !skipsTransitionOnSlideChange else {
            completeSlideChange(to: newID, text: newText)
            return
        }

        withAnimation(.easeIn(duration: exitDuration)) {
            isExiting = true
            enterProgress = 0
        }

        transitionTask = Task {
            try? await Task.sleep(for: .seconds(exitDuration))
            guard !Task.isCancelled else { return }
            await MainActor.run {
                guard generation == transitionGeneration else { return }
                completeSlideChange(to: newID, text: newText)
            }
        }
    }

    private func scheduleReplayEnter() {
        settingsReplayTask?.cancel()
        settingsReplayTask = nil
        transitionTask?.cancel()
        transitionTask = nil
        transitionGeneration += 1
        let generation = transitionGeneration

        var reset = Transaction()
        reset.disablesAnimations = true
        withTransaction(reset) {
            isExiting = false
            enterProgress = 0
        }

        transitionTask = Task {
            try? await Task.sleep(for: .milliseconds(20))
            guard !Task.isCancelled else { return }
            await MainActor.run {
                guard generation == transitionGeneration else { return }
                runEnterAnimationIfNeeded()
            }
        }
    }

    @MainActor
    private func completeSlideChange(to newID: UUID, text newText: String) {
        activeSlideID = newID
        displayedText = newText
        isExiting = false
        if skipsTransitionOnSlideChange {
            enterProgress = 1
        } else {
            enterProgress = 0
            runEnterAnimationIfNeeded()
        }
    }

    @MainActor
    private func runEnterAnimationIfNeeded() {
        guard playsTransition else {
            enterProgress = 1
            isExiting = false
            return
        }

        isExiting = false

        var reset = Transaction()
        reset.disablesAnimations = true
        withTransaction(reset) {
            enterProgress = 0
        }

        withAnimation(enterAnimation) {
            enterProgress = 1
        }
    }
}
