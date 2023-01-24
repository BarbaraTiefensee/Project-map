//
//  Coordinates.swift
//  Project_Map
//
//  Created by Bárbara Tiefensee on 18/08/21.
////
import UIKit
import MapKit

class Local: NSObject, MKAnnotation{

    var name: String
    var coordinate: CLLocationCoordinate2D

    init(name: String, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.coordinate = coordinate
    }
}

struct Company: Codable {
    var name: String
    var address: Address
    var images: [String]
    
    enum CodingKeys: String, CodingKey {
        case name, address, images
    }
}

struct Address: Codable {
    var street: String
    var number: String
    var complement: String?
    var neighbourhood: String
    var city: String
    var state: String
    var zipcode: String
    var country: String
    var coordinates: Coordinates
}

struct Coordinates: Codable {
    var latitude: Double
    var longitude: Double
}
