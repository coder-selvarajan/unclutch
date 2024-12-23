
import SwiftUI
import FamilyControls
import ManagedSettings
import DeviceActivity

struct AppPicker: View {
    @State var selection = FamilyActivitySelection()
    let socialStore = ManagedSettingsStore(named: .social)

    var body: some View {
        VStack {
            FamilyActivityPicker(selection: $selection)

            Button {
                let socialCategory = selection.categoryTokens
                let socialApplications = selection.applicationTokens
                print(socialCategory)
                print(socialApplications)
                socialStore.shield.applicationCategories = .specific(socialCategory)
                socialStore.shield.applications = socialApplications
            } label: {
                Text("Restrict the Apps")
                    .padding()
            }
            
            Button {
                socialStore.clearAllSettings()
            } label: {
                Text("Clear Restrictions")
                    .padding()
            }
        }
        .onChange(of: selection) { newSelection in
            let applications = selection.applications
            let categories = selection.categories
            let webDomains = selection.webDomains
        }
    }
}



struct AppPicker_Previews: PreviewProvider {
    static var previews: some View {
        AppPicker()
    }
}
