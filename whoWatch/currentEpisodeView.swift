//
//  currentEpisodeView.swift
//  whoWatch
//
//  Created by Scott Brown on 10/01/2023.
//

import SwiftUI

struct currentEpisodeView: View {
    var currentEpisode: episode
    var backgroundColor : Color
    var logo: Image
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(backgroundColor.shadow(.drop(color: .black, radius: 10, x: 10, y: 10)))
                .blendMode(.softLight)
            VStack(spacing: 10){
                Text("Current")
                    .font(.title3)
                logo
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                Text(currentEpisode.title)
                    .font(.title)
                HStack{
                    Text("Series:  \(currentEpisode.series)")
                    Text("Episode: \(currentEpisode.episode)")
                }
            }.padding()
        }
            .fixedSize()
        .edgesIgnoringSafeArea(.all)
    }
}

struct currentEpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        let episodeLib = episodeLibrary(episodes: Bundle.main.decode("doccyWho.json"))
        
        let controller = watchCardViews(mainEpisode: .constant(episodeLib.episodes[1]),
                                        previousEpisode: .constant(episodeLib.episodes[1]),
                                        nextEpisode: .constant(episodeLib.episodes[1]))
        
        let currentEp = episodeLib.episodes[5]
        ZStack{
            controller.getBackgroundColor(ep: currentEp)
            currentEpisodeView(currentEpisode: currentEp, backgroundColor: controller.getBackgroundColor(ep: currentEp), logo: controller.getLogo(currentEp: currentEp))
        }.preferredColorScheme(.dark)
    }
}
