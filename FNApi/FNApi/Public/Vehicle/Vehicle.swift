//
//  Vehicle.swift
//  FNApi
//
//  Created by Alexandr Zhuchinskiy
//  Copyright © 2019 Alexandr Zhuchinskiy. All rights reserved.
//

import Foundation

public struct Coordinate: Codable {
    public let latitude: Double
    public let longitude: Double
}

public struct Vehicle: Codable {
    public let id: Int
    public let coordinate: Coordinate
    public let state: String
    public let type: String
    public let heading: Double

    enum CodingKeys: String, CodingKey {
        case id
        case coordinate
        case state
        case type
        case heading
    }
}

public struct VehicleSearchResult: Codable {
    public let vehicles: [Vehicle]

    enum CodingKeys: String, CodingKey {
        case vehicles = "poiList"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.vehicles = try container.decode([Vehicle].self, forKey: .vehicles)
    }
}

extension VehicleSearchResult: FNDecodable {
    public static func decode(data: Data) throws -> VehicleSearchResult {
        let decoder = JSONDecoder()
        let restaurant = try decoder.decode(VehicleSearchResult.self, from: data)
        return restaurant
    }
}

extension Vehicle: FNDecodable {
    public static func decode(data: Data) throws -> Vehicle {
        let decoder = JSONDecoder()
        let restaurant = try decoder.decode(Vehicle.self, from: data)
        return restaurant
    }
}
