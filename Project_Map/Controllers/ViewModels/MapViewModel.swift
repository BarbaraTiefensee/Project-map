//
//  MapViewModel.swift
//  Project_Map
//
//  Created by Bárbara Tiefensee on 24/08/21.
//

import CoreLocation.CLLocation

protocol MapViewModelDelegate: AnyObject {
    func createAnnotation(title: String?, coordinate: CLLocationCoordinate2D)
    func showAnnotation()
}

class MapViewModel {
    
    
    
    var local = [
        Local(name: "PremierSoft", coordinate: CLLocationCoordinate2D(latitude: -26.9164710402418, longitude: -49.06858213725254)),
        Local(name: "Babi", coordinate: CLLocationCoordinate2D(latitude: -26.916653052520896, longitude:  -49.06210327392992))
    ]
}
