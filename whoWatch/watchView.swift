//
//  watchView.swift
//  whoWatch
//
//  Created by Scott Brown on 06/01/2023.
//

import SwiftUI
import Neumorphic

struct watchView: View {
    
    let episodeLib : episodeLibrary
    
    @State var mainEpisode : episode = episode(title: "???", show: "???", series: "???", episode: "???", startTime: Date(), endTime: Date(), prettyTime: "???", orderNo: 999)
    
    let impactMed = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        NavigationView{
            Group{
                watchCardViews(mainEpisode: $mainEpisode,
                               episodeLib: episodeLib,
                               backButton: { self.backButton() },
                               currentButton: { self.currentButton() },
                               forwardButton: { self.forwardButton() })
            }
            .navigationBarTitle("whoWatch")
        }
        .onAppear(perform: {
            mainEpisode = episodeLib.whatToWatch()
        }).preferredColorScheme(.dark)
    }
    
    func backButton() -> Void {
        impactMed.impactOccurred()
        if let newMainEpiosde = episodeLib.getPreviousEpisode(currentEp: mainEpisode) {
            mainEpisode = newMainEpiosde
        }
    }
    
    func currentButton() -> Void {
        impactMed.impactOccurred()
        mainEpisode = episodeLib.whatToWatch()
    }
    
    func forwardButton() -> Void {
        impactMed.impactOccurred()
        if let newMainEpiosde = episodeLib.getNextEpisode(currentEp: mainEpisode) {
            mainEpisode = newMainEpiosde
        }
    }
    
}

struct watchView_Previews: PreviewProvider {
    static var previews: some View {
        let episodeLib = episodeLibrary(episodes: Bundle.main.decode("doccyWho.json"))
        watchView(episodeLib: episodeLib)
    }
}
