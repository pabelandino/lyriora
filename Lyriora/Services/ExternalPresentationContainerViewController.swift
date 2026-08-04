//
//  ExternalPresentationContainerViewController.swift
//  Lyriora
//

#if canImport(UIKit)
import SwiftUI
import UIKit

@MainActor
final class ExternalPresentationContainerViewController: UIViewController {
    var onBoundsChange: ((CGSize) -> Void)?

    private var hostingController: UIHostingController<AnyView>?
    private var lastReportedBounds: CGSize = .zero

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.insetsLayoutMarginsFromSafeArea = false
    }

    func setContent(_ content: some View) {
        let wrapped = AnyView(
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        )

        if let hostingController {
            hostingController.rootView = wrapped
            view.setNeedsLayout()
            view.layoutIfNeeded()
            reportBoundsIfNeeded(force: true)
            return
        }

        let controller = UIHostingController(rootView: wrapped)
        controller.view.backgroundColor = .black
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.insetsLayoutMarginsFromSafeArea = false
        if #available(iOS 16.4, *) {
            controller.safeAreaRegions = []
        }

        addChild(controller)
        view.addSubview(controller.view)
        NSLayoutConstraint.activate([
            controller.view.topAnchor.constraint(equalTo: view.topAnchor),
            controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        controller.didMove(toParent: self)

        hostingController = controller
        reportBoundsIfNeeded(force: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        reportBoundsIfNeeded(force: false)
    }

    func reset() {
        hostingController?.willMove(toParent: nil)
        hostingController?.view.removeFromSuperview()
        hostingController?.removeFromParent()
        hostingController = nil
        lastReportedBounds = .zero
    }

    private func reportBoundsIfNeeded(force: Bool) {
        let size = view.bounds.size
        guard size.width > 1, size.height > 1 else { return }
        guard force || size != lastReportedBounds else { return }

        lastReportedBounds = size
        onBoundsChange?(size)
    }
}
#endif
