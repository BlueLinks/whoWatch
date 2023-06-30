//
//  mainView.swift
//  whoWatch
//
//  Created by Scott Brown on 11/01/2023.
//

import SwiftUI

class librarySavedStatus : ObservableObject {
    @Published var hasChanged : Bool = false
}

struct mainView: View {
    
    @StateObject var libSavedStatus = librarySavedStatus()
    
    var body: some View {
        TabView {
            watchView()
                .environmentObject(libSavedStatus)
                .tabItem {
                    Label("Watch", systemImage: "tv")
                }
            
            episodeListView()
                .tabItem {
                    Label("List", systemImage: "list.dash")
                }
            
            SettingsView()
                .environmentObject(libSavedStatus)
                .tabItem{
                    Label("Settings", systemImage: "gear")
                }
        }.preferredColorScheme(.dark)
            .onAppear {
                print(libSavedStatus.hasChanged)
            }
    }
}

struct mainView_Previews: PreviewProvider {
    static var previews: some View {
        mainView()
    }
}
