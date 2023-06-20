//
//  watchView.swift
//  whoWatch
//
//  Created by Scott Brown on 06/01/2023.
//

import SwiftUI
import Neumorphic

struct watchView: View {
    
    @StateObject private var viewModel = ViewModel()
    @State var mainEpisode : episode = episode(title: "???", show: "???", series: "???", episodeNum: "???", startTime: Date(), endTime: Date(), prettyTime: "???", orderNum: 999)
    
    let impactMed = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        NavigationView{
            Group{
                if (viewModel.mainEpisode != nil) {
                    watchCardViews(mainEpisode: viewModel.mainEpisode!,
                                   previousEpisode: viewModel.previousEpisode,
                                   nextEpisode: viewModel.nextEpisode,
                                   showingCurrentEpisode: viewModel.showingCurrentEpisode,
                                   backButton: { viewModel.onBackPressed() },
                                   currentButton: { viewModel.onCurrentPressed() },
                                   forwardButton: { viewModel.onForwardPressed() })
                }
            }
            .navigationBarTitle("whoWatch")
        }.preferredColorScheme(.dark)
        
            .onAppear{
                if let mainEpisode = viewModel.mainEpisode {
                    print(mainEpisode.title)
                }
            }
    }
    
}

struct watchView_Previews: PreviewProvider {
    static var previews: some View {
        watchView()
    }
}
