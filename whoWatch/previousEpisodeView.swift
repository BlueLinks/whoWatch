//
//  previousEpisodeView.swift
//  whoWatch
//
//  Created by Scott Brown on 10/01/2023.
//

import SwiftUI

struct previousEpisodeView: View {
    var previousEpisode: episode
    var backgroundColor : Color
    var logo: Image
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50, style: .continuous)
                .fill(backgroundColor.shadow(.drop(color: .black, radius: 10, x: 10, y: 10)))
                .blendMode(.softLight)
            VStack(spacing: 5){
                Text("Previous")
                    .font(.title3)
//                logo
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 40)
                Text(previousEpisode.show)
                    .font(.title)
                Text(previousEpisode.title)
                    .font(.title2)
                HStack{
                    Text("Series:  \(previousEpisode.series)")
                    Text("Episode: \(previousEpisode.episode)")
                }
    
                Button(){
                    print("Going back")
                } label: {
                    Image(systemName: "arrow.backward")
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

struct previousEpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        let episodeLib = episodeLibrary(episodes: Bundle.main.decode("doccyWho.json"))
        
        let controller = watchCardViews(mainEpisode: .constant(episodeLib.episodes[5]),
                                        previousEpisode: .constant(episodeLib.episodes[4]),
                                        nextEpisode: .constant(episodeLib.episodes[6]))
        
        let previousEp = episodeLib.episodes[4]
        
        ZStack{
            controller.getBackgroundColor(ep: previousEp)
            previousEpisodeView(previousEpisode: previousEp, backgroundColor: controller.getBackgroundColor(ep: previousEp), logo: controller.getLogo(currentEp: previousEp))
        }.preferredColorScheme(.dark)
    }
}
