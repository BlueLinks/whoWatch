//
//  SettingsView-ViewModel.swift
//  whoWatch
//
//  Created by Scott Brown on 09/06/2023.
//

import Foundation
import SwiftUI

struct settingsModel : Codable {
    public var startDate = Date()
    public var endDate = Date()
    public var doctorWhoToggle : Bool = true
    public var torchwoodToggle: Bool = true
    public var sarahJaneToggle: Bool = true
}

extension SettingsView {
    @MainActor class ViewModel: ObservableObject {
        
        private let decoder = JSONDecoder()
        private let encoder = JSONEncoder()
        
        private let libSaver = librarySaver()
        
        private var initialStartDate : Date = Date()
        private var initialEndDate : Date = Date()
        private var initialDoctorWhoToggle : Bool = true
        private var initialTorchwoodToggle : Bool = true
        private var initialSarahJaneToggle : Bool = true
        
        @Published var startDateInput: Date = Date()
        @Published var endDateInput: Date = Date()
        @Published var doctorWhoToggleInput: Bool = true
        @Published var torchwoodToggleInput: Bool = true
        @Published var sarahJaneToggleInput: Bool = true
        
        private var initialSettings: settingsModel = settingsModel()
        
        public var hasChanged: Bool {
            if Calendar.current.isDate(startDateInput, equalTo: initialStartDate, toGranularity: .day) &&
                Calendar.current.isDate(endDateInput, equalTo: initialEndDate, toGranularity: .day) &&
                doctorWhoToggleInput == initialDoctorWhoToggle &&
                torchwoodToggleInput == initialTorchwoodToggle &&
                sarahJaneToggleInput == initialSarahJaneToggle {
                return false
            } else {
                return true
            }
            
        }
        
        init(){
            loadFromUserDefaults()
        }
        
        public func reset(){
            loadFromUserDefaults()
        }
        
        private func loadFromUserDefaults(){
            startDateInput = UserDefaults.standard.object(forKey: "startDate") as? Date ?? Date()
            initialStartDate = startDateInput
            
            endDateInput = UserDefaults.standard.object(forKey: "endDate") as? Date ?? Date().addingTimeInterval(3.154e+7)
            initialEndDate = endDateInput
            
            doctorWhoToggleInput = UserDefaults.standard.bool(forKey: "doctorWhoToggle")
            initialDoctorWhoToggle = doctorWhoToggleInput
            
            torchwoodToggleInput = UserDefaults.standard.bool(forKey: "torchwoodToggle")
            initialTorchwoodToggle = torchwoodToggleInput
            
            sarahJaneToggleInput = UserDefaults.standard.bool(forKey: "sarahJaneToggle")
            initialSarahJaneToggle = sarahJaneToggleInput
        }
        
        func save(){
            print("Saving date \(startDateInput)")
            UserDefaults.standard.set(startDateInput, forKey: "startDate")
            UserDefaults.standard.set(endDateInput, forKey: "endDate")
            UserDefaults.standard.set(doctorWhoToggleInput, forKey: "doctorWhoToggle")
            UserDefaults.standard.set(torchwoodToggleInput, forKey: "torchwoodToggle")
            UserDefaults.standard.set(sarahJaneToggleInput, forKey: "sarahJaneToggle")
            loadFromUserDefaults()
            libSaver.saveNewLibary(startDate: startDateInput, endDate: endDateInput, doctorWho: doctorWhoToggleInput, torchwood: torchwoodToggleInput, sarahJane: sarahJaneToggleInput)
        }
    }
}
