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
    var showingCurrentEpisode : Bool
    
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
                    Text("Series: \(currentEpisode.series), Episode: \(currentEpisode.episodeNum)")
                        .multilineTextAlignment(.center)
                }
                if !showingCurrentEpisode{
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
        
        let showingCurrentEpisode = true
        let controller = watchView()
        
        ZStack{
            controller.getBackgroundColor(ep: episode.example)
            currentEpisodeView(title: "Watch Now!", currentEpisode: episode.example, backgroundColor: controller.getBackgroundColor(ep: episode.example), logo: controller.getLogo(currentEp: episode.example), function: { print("Going back to current") }, showingCurrentEpisode: showingCurrentEpisode)
        }.preferredColorScheme(.dark)
    }
}
