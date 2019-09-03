import FNApi
import FNUIKit
import FNFoundation

enum VehicleMapCommand {
    case title(String)
    case present(VehicleSearchViewState)
    case error(Error)
}

enum VehicleMapViewEvent {
    case viewDidLoad
    case requestVehicles(for: Edges)
}

class VehicleMapKitchen: Kitchen {
    private enum Constants {
        static let title = "Map"
    }

    typealias Command = VehicleMapCommand
    typealias ViewEvent = VehicleMapViewEvent

    weak var delegate: AnyKitchenDelegate<VehicleMapCommand>?

    private var vehicleService: VehicleService
    private var viewStateFactory: VehiclesViewStateFactory

    init(vehicleService: VehicleService, viewStateFactory: VehiclesViewStateFactory) {
        self.vehicleService = vehicleService
        self.viewStateFactory = viewStateFactory
    }

    func receive(event: VehicleMapViewEvent) {
        switch event {
        case .viewDidLoad:
            delegate?.perform(.title(Constants.title))
        case .requestVehicles(let edges):
            loadVehicles(from: edges)
        }
    }

    private func loadVehicles(from edges: Edges) {
        let boundsArea = Coordinate.BoundsArea.make(from: edges.ne.latitude,
                                                    neLongitude: edges.ne.longitude,
                                                    swLatitude: edges.sw.latitude,
                                                    swLongitude: edges.sw.longitude)
        vehicleService.vehicles(for: boundsArea)
            .onComplete { [weak self] result in
                guard let strongSelf = self else {
                    return
                }

                switch result {
                case .success(let vehicles):
                    let viewState = strongSelf.viewStateFactory.make(from: vehicles)
                    strongSelf.delegate?.perform(.present(viewState))

                case .failure(let error):
                    strongSelf.delegate?.perform(.error(error))
                }
        }
    }
}
