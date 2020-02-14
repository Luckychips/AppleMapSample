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
        let sourceCoord = CLLocationCoordinate2D(latitude: 37.5816061, longitude: 127.004803)
        let destinationCoord = CLLocationCoordinate2D(latitude: 37.5703712, longitude: 126.9741075)
        let source = MKPlacemark(coordinate: sourceCoord)
        let destination = MKPlacemark(coordinate: destinationCoord)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: source)
        request.destination = MKMapItem(placemark: destination)
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            guard let unwrapped = response else {
                return
            }
            
            let route = unwrapped.routes[0]
            
            
            for step in route.steps {
                print("\(String(format: "%.0fm", step.distance)) - \(step.instructions)")
            }
            
            view.addOverlay(route.polyline)
            view.setVisibleMapRect(route.polyline.boundingMapRect, animated: false)
        }
        
        view.delegate = context.coordinator
        view.addAnnotations(landmarks)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
