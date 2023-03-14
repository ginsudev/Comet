import Preferences
import SwiftUI
import @@PROJECTNAME@@C

class RootListController: PSViewController {
    private let hostingController: UIHostingController<RootView>

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.hostingController = .init(rootView: RootView())
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override convenience init(forContentSize contentSize: CGSize) {
        self.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Setup

private extension RootListController {
    func setup() {
        configureNavBar()
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
    
    func configureNavBar() {
        // Title for first view
        self.title = "@@PROJECTNAME@@"
    }
}

