//
//  libraryJSONInterface.swift
//  whoWatch
//
//  Created by Scott Brown on 30/06/2023.
//

import Foundation

class libraryJSONInterface {
    
    internal let saveKey = "usersLibrary"
    
    internal func getLibPath() -> URL {
        return URL.documentsDirectory.appendingPathComponent(saveKey)
    }
 
    internal func getEquallySpacedDates(startDate: Date, endDate: Date, numberOfDates: Int) -> [Date]? {
        guard numberOfDates > 1 else { return nil }
        var dates: [Date] = []
        
        // Calculate the time interval between the start and end dates
        let timeInterval = endDate.timeIntervalSince(startDate)
        
        // Calculate the interval between each equally spaced date
        let interval = timeInterval / Double(numberOfDates - 1)
        
        // Generate the equally spaced dates
        for i in 0..<numberOfDates {
            let date = startDate.addingTimeInterval(Double(i) * interval)
            dates.append(date)
        }
        
        return dates
    }
}
