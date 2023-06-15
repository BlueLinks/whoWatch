//
//  SettingsView.swift
//  whoWatch
//
//  Created by Scott Brown on 20/05/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var viewModel = ViewModel()
    @State private var showSaveAlert = false
    
    var body: some View {
        NavigationView{
            Form{
                Section("Dates"){
                    DatePicker(selection: $viewModel.startDate, displayedComponents: .date) {
                        Text("When to start watching")
                    }
                    DatePicker(selection: $viewModel.endDate, displayedComponents: .date) {
                        Text("When to finsih")
                    }
                }
                Section("Shows"){
                    Toggle("Doctor Who", isOn: $viewModel.doctorWhoToggle)
                    Toggle("Torchwood", isOn: $viewModel.torchwoodToggle)
                    Toggle("Sarah Jane Adventures", isOn: $viewModel.sarahJaneToggle)
                }
                Section(){
                    
                    Button(){
                        showSaveAlert.toggle()
                    } label: {
                        Text("Save changes")
                    }
                    .disabled(!viewModel.hasChanged)
                    .alert("Are you sure you want to save?", isPresented: $showSaveAlert){
                        Button("Cancel", role: .cancel){}
                        Button("I'm sure"){
                            viewModel.save()
                        }
                    }
                    Button(role: .destructive){
                        viewModel.reset()
                    } label: {
                        Text("Reset changes")
                    }
                    .disabled((!viewModel.hasChanged))
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
