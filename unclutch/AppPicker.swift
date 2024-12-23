//
//  AppPicker.swift
//  unclutch
//
//  Created by Selvarajan on 23/12/24.
//


import SwiftUI
import FamilyControls
import ManagedSettings
import DeviceActivity

struct AppPicker: View {
    @Environment(\.presentationMode) private var presentationManager
    
    @State var selection = FamilyActivitySelection()
    let socialStore = ManagedSettingsStore(named: .social)

    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            Color.indigo.edgesIgnoringSafeArea(.all)
            
            VStack {
                FamilyActivityPicker(selection: $selection)
                //                .frame(height: 400)
                //                .padding()
                
                HStack {
                    Button {
                        let selectedCategories = selection.categoryTokens
                        let selectedApplications = selection.applicationTokens
                        
                        if selectedCategories.isEmpty && selectedApplications.isEmpty {
                            // Show an alert if no selection was made
                            alertMessage = "Please select at least one app or category to restrict."
                            showAlert = true
                        } else {
                            // Apply restrictions and show success message
                            socialStore.shield.applicationCategories = .specific(selectedCategories)
                            socialStore.shield.applications = selectedApplications
                            alertMessage = "Restrictions applied successfully!"
                            showAlert = true
                        }
                    } label: {
                        Text("Restrict the Apps")
                            .padding()
                            .foregroundStyle(.white)
                            .background(.green)
                            .cornerRadius(10)
                    }
                    .padding(.vertical)
                    
                    Button {
                        socialStore.clearAllSettings()
                        
//                        alertMessage = "Restrictions cleared successfully!"
//                        showAlert = true
                        presentationManager.wrappedValue.dismiss()
                        
                    } label: {
                        Text("Clear Restrictions")
                            .padding()
                            .foregroundStyle(.white)
                            .background(.indigo)
                            .cornerRadius(10)
                    }
                }
            }
            .onChange(of: selection) { newSelection in
                let applications = selection.applications
                let categories = selection.categories
                let webDomains = selection.webDomains
            }
        }
        // Present alert when `showAlert` is true
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Notification"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}



struct AppPicker_Previews: PreviewProvider {
    static var previews: some View {
        AppPicker()
    }
}
