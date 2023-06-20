//
//  watchView-ViewModel.swift
//  whoWatch
//
//  Created by Scott Brown on 17/06/2023.
//

import Foundation
import SwiftUI

extension watchView {
    @MainActor class ViewModel: ObservableObject {
        
        var episodeLib = episodeLibrary()
        
        @Published var mainEpisode : episode?
        
        var previousEpisode: episode? {
            if let currentEpisode = mainEpisode {
                return episodeLib.getPreviousEpisode(currentEp: currentEpisode)
            }
            return nil
        }
        
        var nextEpisode: episode? {
            if let currentEpisode = mainEpisode {
                return episodeLib.getNextEpisode(currentEp: currentEpisode)
            }
            return nil
        }
        
        var showingCurrentEpisode : Bool {
            if let mainEpisode = mainEpisode {
                return mainEpisode == episodeLib.whatToWatch()
            }
            return false
        }
        
        init(){
            onCurrentPressed()
        }
        
        func onBackPressed() -> Void {
            if let newMainEpiosde = episodeLib.getPreviousEpisode(currentEp: mainEpisode!) {
                mainEpisode = newMainEpiosde
            }
        }
        
        func onCurrentPressed() -> Void {
            mainEpisode = episodeLib.whatToWatch()
        }
        
        func onForwardPressed() -> Void {
            if let newMainEpiosde = episodeLib.getNextEpisode(currentEp: mainEpisode!) {
                mainEpisode = newMainEpiosde
            }
        }
    }
}
