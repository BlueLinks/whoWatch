//
//  episodeListView.swift
//  whoWatch
//
//  Created by Scott Brown on 11/01/2023.
//

import SwiftUI

struct episodeListView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView{
            List {
                ForEach(viewModel.epiosdes) { ep in
                    HStack(spacing: 10){
                        Text("\(ep.orderNum)")
                            .frame(width: 40)
                            .font(.title3)
                        VStack(alignment: .leading){
                            Text("\(ep.show) - S:\(ep.series), E:\(ep.episodeNum)")
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
            .onAppear {
                viewModel.getEpisodes()
            }
        }
    }
}

struct episodeListView_Previews: PreviewProvider {
    static var previews: some View {
        episodeListView()
            .preferredColorScheme(.dark)
    }
}
