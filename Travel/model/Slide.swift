//
//  Slide.swift
//  Travel
//
//  Created by Takashi Taguchi on 2021/05/21.
//

import Foundation

struct Slide {
    let imageName: String
    let title: String
    let description: String
    
    static let collection: [Slide] = [
        Slide(imageName: "imSlide1", title: "Welcome to Trafel", description: "Trafel allows you to travel around the world, make new friends and create memorable experience"),
        Slide(imageName: "imSlide2", title: "Connect Socially", description: "Connect across continents to strangers via the app"),
        Slide(imageName: "imSlide3", title: "Safe And Secures", description: "Each trip is planned according to the strictest safety standards to ensure passenger safety")
    ]
}
