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
        let libSaver = librarySaver()
        libSaver.saveNewLibary(startDate: Date(), endDate: Date().addingTimeInterval(3.154e+7), doctorWho: true, torchwood: true, sarahJane: true)
        return loadLibrary()
    }
}
