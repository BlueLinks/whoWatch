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
                    DatePicker(selection: $viewModel.startDateInput, in: ...viewModel.endDateInput, displayedComponents: .date) {
                        Text("When to start watching?")
                    }
                    DatePicker(selection: $viewModel.endDateInput, in: viewModel.startDateInput..., displayedComponents: .date) {
                        Text("When to finish?")
                    }
                }
                Section("Shows"){
                    Toggle("Doctor Who", isOn: $viewModel.doctorWhoToggleInput)
                    Toggle("Torchwood", isOn: $viewModel.torchwoodToggleInput)
                    Toggle("Sarah Jane Adventures", isOn: $viewModel.sarahJaneToggleInput)
                }
                Section(){
                    VStack{
                        
                        Button(){
                            showSaveAlert.toggle()
                        } label: {
                            Text("Save changes")
                                .padding()
                                .frame(maxWidth: .infinity)
                        }
                        
                        .buttonStyle(.bordered)
                        .tint(Color.blue)
                        .disabled(!viewModel.hasChanged)
                        .alert("Are you sure you want to save?", isPresented: $showSaveAlert){
                            Button("Cancel", role: .cancel){}
                            Button("I'm sure"){
                                viewModel.save()
                            }
                        }
                        Button(){
                            viewModel.reset()
                        } label: {
                            Text("Reset changes")
                                .padding()
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .tint(Color.red)
                        .disabled((!viewModel.hasChanged))
                    }
                }
                .listRowBackground(Color.clear)
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
