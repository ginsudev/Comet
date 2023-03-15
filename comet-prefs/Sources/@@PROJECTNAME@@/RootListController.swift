import SwiftUI
import Comet
import @@PROJECTNAME@@C

class RootListController: CMViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup(content: RootView())
        self.title = "@@PROJECTNAME@@"
    }
}
