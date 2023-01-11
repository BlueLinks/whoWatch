//
//  mainView.swift
//  whoWatch
//
//  Created by Scott Brown on 11/01/2023.
//

import SwiftUI

struct mainView: View {
    
    let episodeLib = episodeLibrary(episodes: Bundle.main.decode("doccyWho.json"))
    
    var body: some View {
            TabView {
                watchView(episodeLib: episodeLib)
                    .tabItem {
                        Label("Watch", systemImage: "tv")
                    }

                episodeListView(episodeLib: episodeLib)
                    .tabItem {
                        Label("List", systemImage: "list.dash")
                    }
            }
        }
    }

struct mainView_Previews: PreviewProvider {
    static var previews: some View {
        mainView()
    }
}
