//
//  episodeLibrary.swift
//  whoWatch
//
//  Created by Scott Brown on 07/01/2023.
//

import Foundation
import SwiftUI

struct episodeLibrary {
    
    let episodes : [episode]
    
    var currentEpisode : episode {
        return whatToWatch()
    }
    
    func getNextEpisode(currentEp : episode) -> episode? {
        if currentEp.orderNo != episodes.count {
            return episodes[currentEp.orderNo]
        }
        else {
            return nil
        }
    }
    
    func getPreviousEpisode(currentEp : episode) -> episode? {
        if currentEp.orderNo != 1 {
            return episodes[currentEp.orderNo - 2]
        }
        else {
            return nil
        }
    }
    
    
    func whatToWatch() -> episode {
        let currentDate = Date()
        for potentialEpisode in episodes {
            if potentialEpisode.startTime < Date() && potentialEpisode.endTime > currentDate {
                return potentialEpisode
            }
        }
        fatalError("No episode to watch")
    }
}
