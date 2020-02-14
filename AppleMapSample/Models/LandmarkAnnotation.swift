//
//  LandmarkAnnotation.swift
//  AppleMapSample
//
//  Created by ryencatchers on 2020/02/14.
//  Copyright © 2020 themselves. All rights reserved.
//

import Foundation
import MapKit

class LandmarkAnnotation: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D

    init(title: String?,
         subtitle: String?,
         coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
    

    let sourceCoord = CLLocationCoordinate2D(latitude: 37.5703244, longitude: 126.9741083)
    let destinationCoord = CLLocationCoordinate2D(latitude: 37.5752395, longitude: 126.9710357)
    
    static func requestMockData()-> [LandmarkAnnotation] {
        return [
            LandmarkAnnotation(title: "Bengalore",
                               subtitle:"Bengaluru (also called Bangalore) is the capital of India's southern Karnataka state.",
                               coordinate: .init(latitude: 12.9716, longitude: 77.5946)),
            LandmarkAnnotation(title: "Mumbai",
                               subtitle:"Mumbai (formerly called Bombay) is a densely populated city on India’s west coast",
                               coordinate: .init(latitude: 19.0760, longitude: 72.8777)),
            LandmarkAnnotation(title: "hello",
                               subtitle:"hello.",
                               coordinate: .init(latitude: 37.5703244, longitude: 126.9741083)),
            LandmarkAnnotation(title: "bye",
                               subtitle:"bye.",
                               coordinate: .init(latitude: 37.5752395, longitude: 126.9710357))
            
        ]
    }
}
