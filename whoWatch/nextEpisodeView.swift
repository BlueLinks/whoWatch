//
//  nextEpisodeView.swift
//  whoWatch
//
//  Created by Scott Brown on 10/01/2023.
//

import SwiftUI

struct nextEpisodeView: View {
    var nextEpisode: episode
    var backgroundColor : Color
    var logo: Image
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50, style: .continuous)
                .fill(backgroundColor.shadow(.drop(color: .black, radius: 10, x: 10, y: 10)))
                .blendMode(.softLight)
            VStack(spacing: 5){
                Text("Next")
                    .font(.title3)
//                logo
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 40)
                Text(nextEpisode.show)
                    .font(.title)
                Text(nextEpisode.title)
                    .font(.title2)
                HStack{
                    Text("Series:  \(nextEpisode.series)")
                    Text("Episode: \(nextEpisode.episode)")
                }
    
                Button(){
                    print("Going forward")
                } label: {
                    Image(systemName: "arrow.forward")
                        .padding()
                        .background(Color(.blue))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .padding()
            }.padding([.horizontal, .top], 30)
        }.fixedSize()
        .edgesIgnoringSafeArea(.all)
    }
}

struct nextEpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        let episodeLib = episodeLibrary(episodes: Bundle.main.decode("doccyWho.json"))
        
        let controller = watchCardViews(mainEpisode: .constant(episodeLib.episodes[5]),
                                        previousEpisode: .constant(episodeLib.episodes[4]),
                                        nextEpisode: .constant(episodeLib.episodes[6]))
        
        let nextEp = episodeLib.episodes[6]
        
        ZStack{
            controller.getBackgroundColor(ep: nextEp)
            nextEpisodeView(nextEpisode: nextEp, backgroundColor: controller.getBackgroundColor(ep: nextEp), logo: controller.getLogo(currentEp: nextEp))
        }.preferredColorScheme(.dark)
    }
}
