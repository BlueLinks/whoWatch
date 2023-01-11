//
//  episodeListView.swift
//  whoWatch
//
//  Created by Scott Brown on 11/01/2023.
//

import SwiftUI

struct episodeListView: View {
    
    var episodeLib : episodeLibrary
    
    var body: some View {
        NavigationView{
            List {
                ForEach(episodeLib.episodes) { ep in
                    HStack(spacing: 10){
                        Text("\(ep.orderNo)")
                            .frame(width: 40)
                            .font(.title3)
                        VStack(alignment: .leading){
                            Text("\(ep.show) - S:\(ep.series), E:\(ep.episode)")
                                .font(.caption)
                            HStack{
                                Text(ep.title)
                                    .font(.headline)
                            }
                        }
                    }
                }
            }
            .navigationTitle("All Episodes")
        }
    }
}

struct episodeListView_Previews: PreviewProvider {
    static var previews: some View {
        let episodeLib = episodeLibrary(episodes: Bundle.main.decode("doccyWho.json"))
        episodeListView(episodeLib: episodeLib)
            .preferredColorScheme(.dark)
    }
}
