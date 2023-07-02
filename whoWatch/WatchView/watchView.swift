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
                ZStack{
                    
                    LinearGradient(gradient: Gradient(colors: [getBackgroundColor(ep: mainEpisode), getBackgroundColor(ep: mainEpisode).darker(by: 0.5)]), startPoint: .topLeading, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.top)
                    
                    GeometryReader { geo in
                        VStack(){
                            
                            Spacer()
                            
                            MainEpisodeView(title: viewModel.mainEpisodeViewTitle,
                                            currentEpisode: mainEpisode,
                                            backgroundColor: getBackgroundColor(ep: mainEpisode),
                                            logo: getLogo(currentEp: mainEpisode),
                                            function: {viewModel.onCurrentPressed() }, showingCurrentEpisode: viewModel.showingCurrentEpisode
                            )
                            .frame(minWidth: geo.size.width * 0.5,
                                   maxWidth: geo.size.width * 0.9,
                                   minHeight: geo.size.width * 0.4,
                                   maxHeight: geo.size.width * 0.8)
                            
                            Spacer()
                            
                            VStack(){
                                if !viewModel.showingCurrentEpisode {
                                    Button(){
                                        viewModel.onCurrentPressed()
                                    } label: {
                                        Text("Back to watch now")
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                    }
                                    .buttonStyle(.bordered)
                                    .tint(Color.blue)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)                                }
                                HStack(){
                                    
                                    if let previousEpisode = viewModel.previousEpisode {
                                        Button(){
                                            viewModel.onBackPressed()
                                        } label : {
                                            Text("Previous")
                                                .padding()
                                                .frame(maxWidth: .infinity)
                                        }
                                        .buttonStyle(.bordered)
                                        .tint(Color.red)
                                    }
                                    
                                    if let nextEpisode = viewModel.nextEpisode {
                                        Button(){
                                            viewModel.onForwardPressed()
                                        } label : {
                                            Text("Next")
                                                .padding()
                                                .frame(maxWidth: .infinity)
                                        }
                                        .buttonStyle(.bordered)
                                        .tint(Color.green)
                                    }
                                }
                                
                            }
                            .padding([.leading, .trailing])
                            Spacer()
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                    }
                }
            } else {
                Text("There's nothing to show!")
            }
        }
        .onAppear(){
            viewModel.refreshLib()
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
