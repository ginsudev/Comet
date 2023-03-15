//
//  CMViewController.swift
//  Comet
//
//  Created by Noah Little on 15/3/2023.
//

import SwiftUI

// MARK: - Public

@objcMembers
open class CMViewController: UIViewController {
    private var hostingController: UIHostingController<AnyView>?
    
    public func setup<Content: View>(content: Content) {
        self.hostingController = .init(rootView: AnyView(content))
        guard let hostingController else { return }
        // Hosting controller config
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(hostingController)
        view.addSubview(hostingController.view)
        // Constraints
        hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        hostingController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        hostingController.didMove(toParent: self)
    }
}

// MARK: - Conformance

public extension CMViewController {
    func setRootController(_ controller: UIViewController?) { }
    func setParentController(_ controller: UIViewController?) { }
    func setSpecifier(_ specifier: AnyObject?) { }
}
