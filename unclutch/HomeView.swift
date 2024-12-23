//
//  ContentView.swift
//  unclutch
//
//  Created by Selvarajan on 23/12/24.
//

import SwiftUI

struct HomeView: View {
    @State var showActivityWindow: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.indigo.edgesIgnoringSafeArea(.all)
                
                Button {
                    showActivityWindow.toggle()
                } label: {
                    Text("Start Unclutching")
                        .padding(20)
                        .foregroundStyle(.white)
                        .background(.green)
                        .cornerRadius(15)
                }
                .sheet(isPresented: $showActivityWindow) {
                    AppPicker()
                }
            }
        }
        
    }
}

#Preview {
    HomeView()
}
