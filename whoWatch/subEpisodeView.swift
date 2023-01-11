//
//  subEpisodeView.swift
//  whoWatch
//
//  Created by Scott Brown on 10/01/2023.
//

import SwiftUI

struct subEpisodeView: View {
    var title : String
    var subEpisode: episode
    var backgroundColor : Color
    var logo: Image
    var function: () -> Void
    var buttonLabel : String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50, style: .continuous)
                .fill(backgroundColor.shadow(.drop(color: .black, radius: 10, x: 10, y: 10)))
                .blendMode(.softLight)
            VStack(spacing: 5){
                Text(title)
                    .font(.title3)
                Spacer()
                Text(subEpisode.show)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .font(.title2)
                Text(subEpisode.title)
                    .multilineTextAlignment(.center)
                    .font(.title3)
                Text("S:\(subEpisode.series) E:\(subEpisode.episode)")
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                Spacer()
                Button(){
                    self.function()
                } label: {
                    Image(systemName: buttonLabel)
                        .padding()
                        .background(Color(.blue))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .padding()
            }.padding([.horizontal, .top], 20)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct subEpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        let episodeLib = episodeLibrary(episodes: Bundle.main.decode("doccyWho.json"))
        
        let controller = watchCardViews(mainEpisode: .constant(episodeLib.episodes[5]),
                                        episodeLib: episodeLib)
        
        let subEp = episodeLib.episodes[4]
        
        ZStack{
            controller.getBackgroundColor(ep: subEp)
            subEpisodeView(title: "Next",
                           subEpisode: subEp,
                           backgroundColor: controller.getBackgroundColor(ep: subEp),
                           logo: controller.getLogo(currentEp: subEp),
                           function: { print("Hello, World") },
                           buttonLabel: "arrow.forward")
        }.preferredColorScheme(.dark)
    }
}
