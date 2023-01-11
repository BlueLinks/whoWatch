//
//  watchCardViews.swift
//  whoWatch
//
//  Created by Scott Brown on 10/01/2023.
//

import SwiftUI

extension Color {
    static func fromRGB(red: Double, green: Double, blue: Double) -> Color {
        return Color(red: red/255, green: green/255, blue: blue/255)
    }
    public func lighter(by amount: CGFloat = 0.2) -> Self { Self(UIColor(self).lighter(by: amount)) }
    public func darker(by amount: CGFloat = 0.2) -> Self { Self(UIColor(self).darker(by: amount)) }
}

extension UIColor {
    func mix(with color: UIColor, amount: CGFloat) -> Self {
        var red1: CGFloat = 0
        var green1: CGFloat = 0
        var blue1: CGFloat = 0
        var alpha1: CGFloat = 0

        var red2: CGFloat = 0
        var green2: CGFloat = 0
        var blue2: CGFloat = 0
        var alpha2: CGFloat = 0

        getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        color.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)

        return Self(
            red: red1 * CGFloat(1.0 - amount) + red2 * amount,
            green: green1 * CGFloat(1.0 - amount) + green2 * amount,
            blue: blue1 * CGFloat(1.0 - amount) + blue2 * amount,
            alpha: alpha1
        )
    }

    func lighter(by amount: CGFloat = 0.2) -> Self { mix(with: .white, amount: amount) }
    func darker(by amount: CGFloat = 0.2) -> Self { mix(with: .black, amount: amount) }
}

struct watchCardViews : View{
    
    @Binding var mainEpisode : episode?
    @Binding var previousEpisode : episode?
    @Binding var nextEpisode : episode?
    
    var seriesColor = [
        "Doctor Who" : [
            "1" : Color.fromRGB(red: 31, green: 50, blue: 68),
            "2" : Color(red: 16, green: 59, blue: 129),
            "3" : Color(red: 56, green: 44, blue: 29),
            "4" : Color(red: 35, green: 155, blue: 236),
            "5" : Color(red: 16, green: 77, blue: 89),
            "6" : Color(red: 98, green: 143, blue: 181),
            "7" : Color(red: 117, green: 19, blue: 58),
            "8" : Color(red: 162, green: 115, blue: 49),
            "9" : Color(red: 30, green: 30, blue: 28),
            "10" : Color(red: 86, green: 55, blue: 110),
            "11" : Color(red: 12, green: 35, blue: 115),
            "12" : Color(red: 51, green: 56, blue: 172),
            "13" : Color(red: 132, green: 38, blue: 29),
            "2008-2010 Specials" : Color(red: 102, green: 21, blue: 23),
            "2013 specials" : Color(red: 97, green: 31, blue: 31),
            "2022 Specials" : Color(red: 51, green: 64, blue: 72)
        ],
        "Torchwood" : [
            "1" : Color(red: 12, green: 8, blue: 10),
            "2" : Color(red: 156, green: 0, blue: 13),
            "Children of Earth" : Color(red: 74, green: 69, blue: 51),
            "Miracle Day" : Color(red: 176, green: 151, blue: 49)
        ],
        "Sarah Jane" : [
            "1" : Color(red: 58, green: 150, blue: 216),
            "2" : Color(red: 107, green: 0, blue: 74),
            "3" : Color(red: 50, green: 160, blue: 0),
            "4" : Color(red: 219, green: 185, blue: 0),
            "5" : Color(red: 140, green: 22, blue: 25)
        ]
    ]
    
    var body: some View {
        ZStack{
            if let mainEpisode = mainEpisode {
                LinearGradient(gradient: Gradient(colors: [getBackgroundColor(ep: mainEpisode), getBackgroundColor(ep: mainEpisode).darker(by: 0.5)]), startPoint: .topLeading, endPoint: .bottom)
                
                    .edgesIgnoringSafeArea(.all)
            }
            VStack(spacing: 50){
                if let mainEpisode = mainEpisode {
                    currentEpisodeView(currentEpisode: mainEpisode, backgroundColor: getBackgroundColor(ep: mainEpisode), logo: getLogo(currentEp: mainEpisode))
                }
                HStack{
                    if let previousEpisode = previousEpisode {
                        previousEpisodeView(previousEpisode: previousEpisode, backgroundColor: getBackgroundColor(ep: previousEpisode), logo: getLogo(currentEp: previousEpisode))
                    }
                    
                        if let nextEpisode = nextEpisode {
                            nextEpisodeView(nextEpisode: nextEpisode, backgroundColor: getBackgroundColor(ep: nextEpisode), logo: getLogo(currentEp: nextEpisode))
                            
                        }
                }
            }
        }
    }
    
    func getBackgroundColor(ep: episode) -> Color{
        
        return seriesColor[ep.show]![ep.series]!
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
        default:
            return Image(systemName: "questionmark.circle")
        }
    }
    
    struct watchCardViews_Previews: PreviewProvider {
        
        static var previews: some View {
            let episodeLib = episodeLibrary(episodes: Bundle.main.decode("doccyWho.json"))
            watchCardViews(mainEpisode: .constant(episodeLib.episodes[5]),
                           previousEpisode: .constant(episodeLib.episodes[4]),
                           nextEpisode: .constant(episodeLib.episodes[6]))
            .preferredColorScheme(.dark)
        }
    }
    
}
