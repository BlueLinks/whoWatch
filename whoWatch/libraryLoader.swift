//
//  libraryLoader.swift
//  whoWatch
//
//  Created by Scott Brown on 30/06/2023.
//

import Foundation

class libraryLoader : libraryJSONInterface {
    
    private let decoder = JSONDecoder()
    
    func loadLibrary() -> [episode] {
        let path = getLibPath()
        if let decoded = try? JSONDecoder().decode([episode].self, from: Data(contentsOf: path)) {
            print("Returning saved lib")
            return decoded
            }
        
        // no saved data
        print("No saved data, loading default")
        return loadDefaultLibrary()
    }
    
    private func loadDefaultLibrary() -> [episode] {
        if let path = Bundle.main.path(forResource: "doccyWho", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
                decoder.dateDecodingStrategy = .secondsSince1970
                if let decoded = try? decoder.decode([rawEpisode].self, from: data) {
                    var episodes = [episode]()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy/MM/dd - HH:mm:ss"
                    let listofDates = getEquallySpacedDates(startDate: Date(), endDate: Date().addingTimeInterval(3.154e+7), numberOfDates: decoded.count + 1)
                    for (i, ep) in decoded.enumerated() {
                        let newEp = episode(title: ep.title,
                                            show: ep.show,
                                            series: ep.series,
                                            episodeNum: ep.episodeNum,
                                            startTime: listofDates?[i] ?? Date(),
                                            endTime: listofDates?[i + 1] ?? Date(),
                                            prettyTime: formatter.string(from: listofDates?[i] ?? Date()),
                                            orderNum: i+1)
                        episodes.append(newEp)
                    }
                    return episodes
                }
            }
        }
        fatalError("Could not load default library")
    }
}
