//
//  MKMapView+Extension.swift
//  FNUIKit
//
//  Created by Alexandr Zhuchinskiy
//  Copyright © 2019 Alexandr Zhuchinskiy. All rights reserved.
//

import MapKit

public typealias Edges = (ne: CLLocationCoordinate2D, sw: CLLocationCoordinate2D)

public extension MKMapView {
    func edgePoints() -> Edges {
        let neMapPoint = MKMapPoint(x: visibleMapRect.maxX, y: visibleMapRect.origin.y)
        let swMapPoint = MKMapPoint(x: visibleMapRect.origin.x, y: visibleMapRect.maxY)
        let neCoord = neMapPoint.coordinate
        let swCoord = swMapPoint.coordinate
        return (ne: neCoord, sw: swCoord)
    }
}
