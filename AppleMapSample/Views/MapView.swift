//
//  MapView.swift
//  AppleMapSample
//
//  Created by ryencatchers on 2020/02/14.
//  Copyright © 2020 themselves. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let landmarks = LandmarkAnnotation.requestMockData()
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let coord = CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946)
        let span = MKCoordinateSpan(latitudeDelta: 15, longitudeDelta: 15)
        let region = MKCoordinateRegion(center: coord, span: span)
        view.delegate = context.coordinator
        view.setRegion(region, animated: true)
        view.addAnnotations(landmarks)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
