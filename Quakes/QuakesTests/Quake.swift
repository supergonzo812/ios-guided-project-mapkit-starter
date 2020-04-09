//
//  Quake.swift
//  Quakes
//
//  Created by Chris Gonzales on 4/9/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import Foundation

class Quake: NSObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case magnitude = "mag"
        case time
        case place
        case latitude
        case longitude
        case properties
        case geometry
        case coordinates
    }
    
    let magnitude: Double?
    let time: Date
    let place: String
    let latitude: Double
    let longitude: Double
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let propertiesContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .properties)
        let geometryContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .geometry)
        var coordinatesContainer = try geometryContainer.nestedUnkeyedContainer(forKey: .coordinates)
        
        
        self.magnitude = try? propertiesContainer.decode(Double.self,
                                                        forKey: .magnitude)
        self.time = try propertiesContainer.decode(Date.self,
                                                   forKey: .time)
        self.place = try propertiesContainer.decode(String.self,
                                                    forKey: .place)
        self.longitude = try coordinatesContainer.decode(Double.self)
        self.latitude = try coordinatesContainer.decode(Double.self)
        
        
        super.init()
    }
    
}
