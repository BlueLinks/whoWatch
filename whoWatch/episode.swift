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
    var episode : String // Come up with better name
    var startTime : Date
    var endTime : Date
    var prettyTime: String
    var orderNo : Int
}
