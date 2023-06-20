//
//  episode.swift
//  whoWatch
//
//  Created by Scott Brown on 06/01/2023.
//

import Foundation

struct episode : Codable, Identifiable {
    let id = UUID()
    let title : String
    let show : String
    let series : String
    var episodeNum : String // Come up with better name
    var startTime : Date
    var endTime : Date
    var prettyTime: String
    var orderNum : Int
    
    static let example = episode(title: "Vincent and the Doctor", show: "Doctor Who", series: "5", episodeNum: "10", startTime: Date(timeIntervalSince1970: 1685285688.8888888), endTime: Date(timeIntervalSince1970: 1685393777.7777777), prettyTime: "2023/05/28 - 14:54:48", orderNum: 119)
}

extension episode : Equatable {
    static func == (lhs: episode, rhs: episode) -> Bool {
        return lhs.title == rhs.title &&
        lhs.show == rhs.show &&
        lhs.series == lhs.series &&
        lhs.episodeNum == rhs.episodeNum
    }
}
