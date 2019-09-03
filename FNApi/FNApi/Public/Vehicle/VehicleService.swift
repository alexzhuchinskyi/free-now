//
//  VehicleService.swift
//  FNApi
//
//  Created by Alexandr Zhuchinskiy
//  Copyright © 2019 Alexandr Zhuchinskiy. All rights reserved.
//

import Alamofire
import BrightFutures
import Foundation

public extension Coordinate {
    struct BoundsArea {
        let coordinate1: Coordinate
        let coordinate2: Coordinate
    }
}

extension Coordinate {
    public static func defaultCoordinate() -> Coordinate {
        return .init(latitude: -33.8670522, longitude: 151.1957362)
    }

    func toString() -> (String, String) {
        return ("\(latitude)", "\(longitude)")
    }
}

extension Coordinate.BoundsArea {
    public static func defaultBoundsArea() -> Coordinate.BoundsArea {
        return .init(coordinate1: .init(latitude: 53.694865, longitude: 9.757589),
                     coordinate2: .init(latitude: 53.394655, longitude: 10.099891))
    }

    public static func make(from neLatitude: Double, neLongitude: Double,
                            swLatitude: Double, swLongitude: Double) -> Coordinate.BoundsArea {
        return .init(coordinate1: .init(latitude: neLatitude, longitude: neLongitude),
                     coordinate2: .init(latitude: swLatitude, longitude: swLongitude))
    }
}

public class VehicleService: BaseService {
    private enum Constants {
        static let vehicleURL = "/PoiService/poi/v1"
        static let p1Latitude = "p1Lat"
        static let p2Latitude = "p2Lat"
        static let p1Longitude = "p1Lon"
        static let p2Longitude = "p2Lon"
    }

    public func vehicles(for boundsArea: Coordinate.BoundsArea = .defaultBoundsArea()) -> Future<VehicleSearchResult, APIError> {
        let coordindate1 = boundsArea.coordinate1.toString()
        let coordindate2 = boundsArea.coordinate2.toString()

        let params: Parameters = [
            Constants.p1Latitude: coordindate1.0,
            Constants.p1Longitude: coordindate1.1,
            Constants.p2Latitude: coordindate2.0,
            Constants.p2Longitude: coordindate2.1
        ]
        return performRequest(with: Constants.vehicleURL, params: params)
    }
}
