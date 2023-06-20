//
//  mainView.swift
//  whoWatch
//
//  Created by Scott Brown on 11/01/2023.
//

import SwiftUI

struct mainView: View {
    
    var body: some View {
        TabView {
            watchView()
                .tabItem {
                    Label("Watch", systemImage: "tv")
                }
            
            episodeListView()
                .tabItem {
                    Label("List", systemImage: "list.dash")
                }
            
            SettingsView()
                .tabItem{
                    Label("Settings", systemImage: "gear")
                }
        }.preferredColorScheme(.dark)
    }
}

struct mainView_Previews: PreviewProvider {
    static var previews: some View {
        mainView()
    }
}
