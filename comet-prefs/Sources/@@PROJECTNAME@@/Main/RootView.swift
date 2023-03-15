import SwiftUI
import Comet

struct RootView: View {
    @StateObject private var preferenceStorage = PreferenceStorage()
    
    var body: some View {
        Form {
            Section {
                Toggle("Enabled", isOn: $preferenceStorage.isEnabled)
            } header: {
                Text("The best tweak ever")
            } footer: {
                Text("A footer for the best tweak ever.")
                    .foregroundColor(preferenceStorage.isEnabled ? .green : .red)
                    .animation(.default, value: preferenceStorage.isEnabled)
            }
        }
    }
}
