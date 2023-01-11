//
//  currentEpisodeView.swift
//  whoWatch
//
//  Created by Scott Brown on 10/01/2023.
//

import SwiftUI

struct currentEpisodeView: View {
    
    var title : String
    var currentEpisode: episode
    var backgroundColor : Color
    var logo: Image
    var function: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(backgroundColor.shadow(.drop(color: .black, radius: 10, x: 10, y: 10)))
                .blendMode(.softLight)
            VStack(spacing: 10){
                Text(title)
                    .font(.title)
                logo
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 100)
                Text(currentEpisode.title)
                    .multilineTextAlignment(.center)
                    .font(.title)
                HStack{
                    Text("Series: \(currentEpisode.series), Episode: \(currentEpisode.episode)")
                        .multilineTextAlignment(.center)
                }
                if title != "Watch Now!"{
                    Button(){
                        self.function()
                    } label: {
                        Text("Back to current")
                            .padding()
                            .background(Color(.blue))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                    .padding()
                }
            }.padding()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct currentEpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        let episodeLib = episodeLibrary(episodes: Bundle.main.decode("doccyWho.json"))
        
        let controller = watchCardViews(mainEpisode: .constant(episodeLib.episodes[1]),
                                        episodeLib: episodeLib)
        
        let currentEp = episodeLib.episodes[5]
        ZStack{
            controller.getBackgroundColor(ep: currentEp)
            currentEpisodeView(title: "Next", currentEpisode: currentEp, backgroundColor: controller.getBackgroundColor(ep: currentEp), logo: controller.getLogo(currentEp: currentEp), function: { print("Going back to current") })
        }.preferredColorScheme(.dark)
    }
}
