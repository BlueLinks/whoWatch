//
//  episodeLibrary.swift
//  whoWatch
//
//  Created by Scott Brown on 07/01/2023.
//

import Foundation
import SwiftUI

struct rawEpisode : Decodable {
    let title : String
    let show : String
    let series : String
    let episodeNum : String // Come up with better name
    let orderNum : Int
    
}

class episodeLibrary : ObservableObject {
    
    private let decoder = JSONDecoder()
    
    private let libLoader = libraryLoader()
    
    public var episodes : [episode] = []
    
    func getNextEpisode(currentEp : episode) -> episode? {
        if currentEp.orderNum != episodes.count {
            return episodes[currentEp.orderNum]
        }
        else {
            return nil
        }
    }
    
    func getPreviousEpisode(currentEp : episode) -> episode? {
        if currentEp.orderNum != 1 {
            return episodes[currentEp.orderNum - 2]
        }
        else {
            return nil
        }
    }
    
    func loadData(){
        episodes.removeAll()
        episodes = libLoader.loadLibrary()
    }
    
    func whatToWatch() -> episode? {
        let currentDate = Date()
        for potentialEpisode in episodes {
            if potentialEpisode.startTime < currentDate && potentialEpisode.endTime > currentDate {
                return potentialEpisode
            }
        }
        return nil
    }
}
