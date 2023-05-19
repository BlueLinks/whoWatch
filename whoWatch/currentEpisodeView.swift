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
    
    @State private var timeRemaining = 86400.00 // default value 24hrs in seconds
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var formattedTimeRemaining = ""
    
    @State var workoutDateRange = Date()...Date().addingTimeInterval(5*60)
    
    let formatter = DateComponentsFormatter()
    
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
                Text(currentEpisode.title)
                    .multilineTextAlignment(.center)
                    .font(.title)
                HStack{
                    Text("Series: \(currentEpisode.series), Episode: \(currentEpisode.episode)")
                        .multilineTextAlignment(.center)
                }
                if title != "Watch Now!"{
                    // This is not the current episode
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
                } else {
                    // This is the current episode, show timer
                    VStack{
                        Text("Time left to watch...")
                            .font(.headline)
                        Text("\(formattedTimeRemaining)")
                    }
                    .frame(width: 250, height: 75)
                    .background(.black.opacity(0.5))
                                .clipShape(Capsule())
                }
            }.padding()
        }
        .onAppear(){
            timeRemaining = currentEpisode.endTime.timeIntervalSince(Date())
            workoutDateRange = currentEpisode.startTime...currentEpisode.endTime
        }
        .onReceive(timer) { time in
            if timeRemaining > 0 {
                timeRemaining -= 1
                formatter.unitsStyle = .short
                formattedTimeRemaining = formatter.string(from: TimeInterval(timeRemaining))!
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
}

struct currentEpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        let episodeLib = episodeLibrary(episodes: Bundle.main.decode("doccyWho.json"))
        
        let controller = watchCardViews(mainEpisode: .constant(episodeLib.episodes[0]),
                                        episodeLib: episodeLib)
        
        let currentEp = episodeLib.whatToWatch()
        ZStack{
            controller.getBackgroundColor(ep: currentEp)
            currentEpisodeView(title: "Watch Now!", currentEpisode: currentEp, backgroundColor: controller.getBackgroundColor(ep: currentEp), logo: controller.getLogo(currentEp: currentEp), function: { print("Going back to current") })
        }.preferredColorScheme(.dark)
    }
}
