//
//  SettingsView-ViewModel.swift
//  whoWatch
//
//  Created by Scott Brown on 09/06/2023.
//

struct settingsModel : Codable {
    public var startDate = Date()
    public var endDate = Date()
    public var doctorWhoToggle : Bool = true
    public var torchwoodToggle: Bool = true
    public var sarahJaneToggle: Bool = true
}

import Foundation

extension SettingsView {
    @MainActor class ViewModel: ObservableObject {
        
        private let decoder = JSONDecoder()
        private let encoder = JSONEncoder()
        
        @Published var startDate: Date = Date()
        @Published var endDate: Date = Date()
        @Published var doctorWhoToggle: Bool = true
        @Published var torchwoodToggle: Bool = true
        @Published var sarahJaneToggle: Bool = true
        
        private var initialSettings: settingsModel = settingsModel()
        
        public var hasChanged: Bool {
            if Calendar.current.isDate(startDate, equalTo: initialSettings.startDate, toGranularity: .day) &&
                Calendar.current.isDate(endDate, equalTo: initialSettings.endDate, toGranularity: .day) &&
                doctorWhoToggle == initialSettings.doctorWhoToggle &&
                torchwoodToggle == initialSettings.torchwoodToggle &&
                sarahJaneToggle == initialSettings.sarahJaneToggle {
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
            if let data = UserDefaults.standard.data(forKey: "SettingsProfile") {
                do {
                    let decodedSettings = try decoder.decode(settingsModel.self, from: data)
                    startDate = decodedSettings.startDate
                    endDate = decodedSettings.endDate
                    doctorWhoToggle = decodedSettings.doctorWhoToggle
                    torchwoodToggle = decodedSettings.torchwoodToggle
                    sarahJaneToggle = decodedSettings.sarahJaneToggle
                    // Save settings to compare later for reset func
                    initialSettings = decodedSettings
                    
                } catch {
                    print("Unable to Decode settings (\(error))")
                }
            }
        }
        
        func save(){
            
            let settingsModel = settingsModel(
            startDate: startDate,
            endDate: endDate,
            doctorWhoToggle: doctorWhoToggle,
            torchwoodToggle: torchwoodToggle,
            sarahJaneToggle: sarahJaneToggle)
            
            do {
                let data = try encoder.encode(settingsModel)
                UserDefaults.standard.set(data, forKey: "SettingsProfile")
                loadFromUserDefaults()
            } catch {
                print("Unable to Encode settings (\(error))")
            }
        }
    }
}
