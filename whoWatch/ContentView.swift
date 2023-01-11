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
    
    let impactMed = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        NavigationView{
            Group{
                if let mainEpisode = mainEpisode {
                    watchCardViews(mainEpisode: $mainEpisode,
                                   previousEpisode: $previousEpisode,
                                   nextEpisode: $nextEpisode, episodeLib: episodeLib,
                                   backButton: { self.backButton() },
                                   forwardButton: { self.forwardButton() })
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
    
    func backButton() -> Void {
        impactMed.impactOccurred()
        if let newCurrentEp = previousEpisode {
            // previous episode exists
            let newPreviousEp = episodeLib.getPreviousEpisode(currentEp: newCurrentEp)
            nextEpisode = mainEpisode
            mainEpisode = newCurrentEp
            previousEpisode = newPreviousEp
        }
    }
    
    func forwardButton() -> Void {
        impactMed.impactOccurred()
        if let newCurrentEp = nextEpisode {
            previousEpisode = mainEpisode
            mainEpisode = newCurrentEp
            let newNextEpisode = episodeLib.getNextEpisode(currentEp: newCurrentEp)
            nextEpisode = newNextEpisode
            
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
