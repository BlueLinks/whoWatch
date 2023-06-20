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
                Text("S:\(subEpisode.series) E:\(subEpisode.episodeNum)")
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
        
        let controller = watchView()
        
        ZStack{
            controller.getBackgroundColor(ep: episode.example)
            subEpisodeView(title: "Next",
                           subEpisode: episode.example,
                           backgroundColor: controller.getBackgroundColor(ep: episode.example),
                           logo: controller.getLogo(currentEp: episode.example),
                           function: { print("Hello, World") },
                           buttonLabel: "arrow.forward")
        }.preferredColorScheme(.dark)
    }
}
