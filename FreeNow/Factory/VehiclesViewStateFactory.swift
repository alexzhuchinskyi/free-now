import Foundation
import FNApi

struct VehicleSearchViewState {
    struct Vehicle {
        let id: Int
        let latitude: String
        let longitude: String
        let type: String
    }

    let vehicles: [Vehicle]
}

class VehiclesViewStateFactory {
    func make(from result: VehicleSearchResult) -> VehicleSearchViewState {
        let vehicles = result.vehicles.map { VehicleSearchViewState.Vehicle(id: $0.id,
                                                                            latitude: $0.coordinate.latitude.stringValue,
                                                                            longitude: $0.coordinate.longitude.stringValue,
                                                                            type: $0.type)
        }
        return .init(vehicles: vehicles)
    }
}
