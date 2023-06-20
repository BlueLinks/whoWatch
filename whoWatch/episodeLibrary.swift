//
//  episodeLibrary.swift
//  whoWatch
//
//  Created by Scott Brown on 07/01/2023.
//

import Foundation
import SwiftUI

class episodeLibrary : ObservableObject {
    
    let episodes : [episode]
    
    init(){
        if let path = Bundle.main.path(forResource: "doccyWho", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                if let decoded = try? decoder.decode([episode].self, from: data) {
                    episodes = decoded
                    return
                }
            }
        }
        episodes = []
    }
    
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
    
    
    func whatToWatch() -> episode {
        print("Checking what to watch")
        let currentDate = Date()
        for potentialEpisode in episodes {
            if potentialEpisode.startTime < Date() && potentialEpisode.endTime > currentDate {
                return potentialEpisode
            }
        }
        fatalError("No episode to watch")
    }
}
