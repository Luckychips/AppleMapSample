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
//        convert()
//        let sourceCoord = CLLocationCoordinate2D(latitude: 37.5816061, longitude: 127.004803)
//        let destinationCoord = CLLocationCoordinate2D(latitude: 37.5703712, longitude: 126.9741075)
        
        let sourceCoord = CLLocationCoordinate2D(latitude: 37.4998222, longitude: 127.0349081)
        let destinationCoord = CLLocationCoordinate2D(latitude: 37.5019392, longitude: 127.0300831)

        let source = MKPlacemark(coordinate: sourceCoord)
        let destination = MKPlacemark(coordinate: destinationCoord)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: source)
        request.destination = MKMapItem(placemark: destination)
        request.requestsAlternateRoutes = true
        request.transportType = .walking
        
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
    
    func convert() {
        let geocoder = CLGeocoder()
        let addressString = "서울특별시 역삼동 테헤란로 142"
        // latitude : 37.4998222, longitude : 127.0349081
//        let addressString = "서울특별시 강남구 테헤란로7길 32"
        // latitude : 37.5019392, longitude : 127.0300831
        
        
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    print("latitude : \(location.coordinate.latitude), longitude : \(location.coordinate.longitude)")
                    return
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
