//
//  librarySaver.swift
//  whoWatch
//
//  Created by Scott Brown on 29/06/2023.
//

import Foundation
import SwiftUI

class librarySaver : libraryJSONInterface{
    
    private var encoder = JSONEncoder()
    private var decoder = JSONDecoder()
    
    public func saveNewLibary(startDate: Date, endDate: Date, doctorWho: Bool, torchwood: Bool, sarahJane: Bool) -> Void {
        if let path = Bundle.main.path(forResource: "doccyWho", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
                decoder.dateDecodingStrategy = .secondsSince1970
                if let decoded = try? decoder.decode([rawEpisode].self, from: data) {
                    var episodes = [episode]()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy/MM/dd - HH:mm:ss"
                    let prunedList = pruneShows(list: decoded, doctorWho: doctorWho, torchwood: torchwood, sarahJane: sarahJane)
                    let listofDates = getEquallySpacedDates(startDate: startDate, endDate: endDate, numberOfDates: prunedList.count + 1)
                    for (i, ep) in prunedList.enumerated() {
                        let newEp = episode(title: ep.title,
                                            show: ep.show,
                                            series: ep.series,
                                            episodeNum: ep.episodeNum,
                                            startTime: listofDates?[i] ?? Date(),
                                            endTime: listofDates?[i + 1] ?? Date(),
                                            prettyTime: formatter.string(from: listofDates?[i] ?? Date()),
                                            orderNum: i+1,
                                            watched: false)
                        episodes.append(newEp)
                    }
                    writeToDisk(episodes: episodes)
                }
            }
        }
    }
    
    public func writeToDisk(episodes : [episode]) {
        if let encoded = try? JSONEncoder().encode(episodes) {
            let path = getLibPath()
            try? encoded.write(to: path, options: [.atomic, .completeFileProtection])
            UserDefaults.standard.set(true, forKey: "libHasSaved")
        }
    }
    
    private func  pruneShows(list : [rawEpisode], doctorWho: Bool, torchwood: Bool, sarahJane: Bool) -> [rawEpisode]{
        var allowedShows = [String]()
        if doctorWho {
            allowedShows.append("Doctor Who")
        }
        if torchwood {
            allowedShows.append("Torchwood")
        }
        if sarahJane {
            allowedShows.append("Sarah Jane Adventures")
        }
        let trimmedList = list.filter { allowedShows.contains( $0.show) }
        return trimmedList

    }
    
}
