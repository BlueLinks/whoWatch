//
//  watchView.swift
//  whoWatch
//
//  Created by Scott Brown on 10/01/2023.
//

import SwiftUI

struct watchView : View{
    
    @StateObject private var viewModel = ViewModel()
    
    var seriesColor = [
        "Doctor Who" : [
            "1" : Color.fromRGB(red: 31, green: 50, blue: 68),
            "2" : Color.fromRGB(red: 16, green: 59, blue: 129),
            "3" : Color.fromRGB(red: 56, green: 44, blue: 29),
            "4" : Color.fromRGB(red: 35, green: 155, blue: 236),
            "5" : Color.fromRGB(red: 16, green: 77, blue: 89),
            "6" : Color.fromRGB(red: 98, green: 143, blue: 181),
            "7" : Color.fromRGB(red: 117, green: 19, blue: 58),
            "8" : Color.fromRGB(red: 162, green: 115, blue: 49),
            "9" : Color.fromRGB(red: 30, green: 30, blue: 28),
            "10" : Color.fromRGB(red: 86, green: 55, blue: 110),
            "11" : Color.fromRGB(red: 12, green: 35, blue: 115),
            "12" : Color.fromRGB(red: 51, green: 56, blue: 172),
            "13" : Color.fromRGB(red: 132, green: 38, blue: 29),
            "2008-2010 Specials" : Color.fromRGB(red: 102, green: 21, blue: 23),
            "2013 specials" : Color.fromRGB(red: 97, green: 31, blue: 31),
            "2022 Specials" : Color.fromRGB(red: 51, green: 64, blue: 72)
        ],
        "Torchwood" : [
            "1" : Color.fromRGB(red: 12, green: 8, blue: 10),
            "2" : Color.fromRGB(red: 156, green: 0, blue: 13),
            "Children of Earth" : Color.fromRGB(red: 74, green: 69, blue: 51),
            "Miracle Day" : Color.fromRGB(red: 176, green: 151, blue: 49)
        ],
        "Sarah Jane Adventures" : [
            "1" : Color.fromRGB(red: 58, green: 150, blue: 216),
            "2" : Color.fromRGB(red: 107, green: 0, blue: 74),
            "3" : Color.fromRGB(red: 50, green: 160, blue: 0),
            "4" : Color.fromRGB(red: 219, green: 185, blue: 0),
            "5" : Color.fromRGB(red: 140, green: 22, blue: 25)
        ]
    ]
    
    var body: some View {
        VStack{
            if let mainEpisode = viewModel.mainEpisode {
                VStack(alignment: .leading){
                    Text(viewModel.mainEpisodeViewTitle)
                        .font(.largeTitle)
                        .padding()
                    
                    VStack{
                        Spacer()
                        MainEpisodeView(title: viewModel.mainEpisodeViewTitle,
                                        currentEpisode: mainEpisode,
                                        backgroundColor: getBackgroundColor(ep: mainEpisode),
                                        logo: getLogo(currentEp: mainEpisode),
                                        function: {viewModel.onWatchedPressed() }, showingCurrentEpisode: viewModel.showingCurrentEpisode
                        )
                        Spacer()
                    }
                    VStack(){
                        Button(){
                            withAnimation{
                                viewModel.onCurrentPressed()
                            }
                        } label: {
                            Text("Back to watch now")
                                .padding()
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .tint(Color.blue)
                        .frame(maxWidth: .infinity)
                        .disabled(viewModel.showingCurrentEpisode)
                        
                        HStack(){
                            Button(){
                                withAnimation{
                                    viewModel.onBackPressed()
                                }
                            } label : {
                                Text("Previous")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.bordered)
                            .tint(Color.red)
                            .disabled(viewModel.previousEpisode == nil)
                            Button(){
                                withAnimation{
                                    viewModel.onForwardPressed()
                                }
                            } label : {
                                Text("Next")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.bordered)
                            .tint(Color.green)
                            .disabled(viewModel.nextEpisode == nil)
                        }
                    }
                    .padding()
                }
                
                .background(LinearGradient(gradient: Gradient(colors: [Color.black, getBackgroundColor(ep: mainEpisode), Color.black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.top))
            } else {
                Text("There's nothing to show")
            }
        }
        .onAppear(){
            viewModel.refreshLib()
        }
        .onDisappear(){
            viewModel.onViewDisappear()
        }
    }
    
    func getBackgroundColor(ep: episode) -> Color{
        if let backColor = seriesColor[ep.show]?[ep.series] {
            return backColor
        } else {
            return Color.blue
        }
    }
    
    func getLogo(currentEp : episode) -> Image {
        switch currentEp.show {
        case "Doctor Who":
            return getDWLogo(currentEp: currentEp)
        case "Torchwood":
            return Image("Torchwood")
        case "Sarah Jane Adventures":
            return Image("Sarah Jane")
        default:
            return Image(systemName: "questionmark.circle")
        }
    }
    
    func getDWLogo(currentEp: episode) -> Image{
        switch currentEp.series {
        case "1":
            return Image("9th Doctor")
        case "2", "3", "4", "2008-2010 Specials":
            return Image("10th Doctor")
        case "5", "6":
            return Image("11th Doctor 1")
        case "7", "2013 Specials":
            return Image("11th Doctor 2")
        case "8", "9", "10":
            return Image("12th Doctor")
        case "11", "12", "13", "2022 Specials":
            return Image("13th Doctor")
        default:
            return Image(systemName: "questionmark.circle")
        }
    }
    
    struct watchCardViews_Previews: PreviewProvider {
        
        static var previews: some View {
            
            watchView()
                .preferredColorScheme(.dark)
        }
    }
    
}
