//
//  ContentView.swift
//  whoWatch
//
//  Created by Scott Brown on 06/01/2023.
//

import SwiftUI
import Neumorphic

struct ContentView: View {
    
    let episodeLib = episodeLibrary(episodes: Bundle.main.decode("doccyWho.json"))
    
    @State var mainEpisode : episode?
    @State var previousEpisode : episode?
    @State var nextEpisode : episode?
    
    var body: some View {
        NavigationView{
            Group{
                if let mainEpisode = mainEpisode {
                    watchCardViews(mainEpisode: $mainEpisode,
                                   previousEpisode: $previousEpisode,
                                   nextEpisode: $nextEpisode)
                }
            }
                .navigationBarTitle("Watch")
        }
        .onAppear(perform: {
            mainEpisode = episodeLib.whatToWatch()
            if let mainEpisode = mainEpisode {
                previousEpisode = episodeLib.getPreviousEpisode(currentEp: mainEpisode)
                nextEpisode = episodeLib.getNextEpisode(currentEp: mainEpisode)
            }
        }).preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
