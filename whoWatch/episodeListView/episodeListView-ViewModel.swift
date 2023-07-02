//
//  episodeListView-ViewModel.swift
//  whoWatch
//
//  Created by Scott Brown on 30/06/2023.
//

import Foundation
import SwiftUI

extension episodeListView {
    @MainActor class ViewModel: ObservableObject {
        
        private var libLoader = libraryLoader()
        @Published var epiosdes = [episode]()
        
        
        func getEpisodes() {
            if UserDefaults.standard.bool(forKey: "libHasSaved") || epiosdes.isEmpty {
                epiosdes = libLoader.loadLibrary()
            }
        }
    }
}
