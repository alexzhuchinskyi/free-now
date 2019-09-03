import FNApi
import FNFoundation

enum VehicleSearchCommand {
    case startLoading
    case finishedLoading
    case present(VehicleSearchViewState)
    case title(String)
    case error(Error)
}

enum VehicleSearchViewEvent {
    case viewDidLoad
}

class VehicleSearchKitchen: Kitchen {
    private enum Constants {
        static let title = "Vehicles"
    }

    typealias Command = VehicleSearchCommand
    typealias ViewEvent = VehicleSearchViewEvent

    weak var delegate: AnyKitchenDelegate<VehicleSearchCommand>?

    private var vehicleService: VehicleService
    private var viewStateFactory: VehiclesViewStateFactory

    init(vehicleService: VehicleService, viewStateFactory: VehiclesViewStateFactory) {
        self.vehicleService = vehicleService
        self.viewStateFactory = viewStateFactory
    }

    func receive(event: VehicleSearchViewEvent) {
        switch event {
        case .viewDidLoad:
            delegate?.perform(.title(Constants.title))
            loadVehicles()
        }
    }

    private func loadVehicles(within boundsArea: Coordinate.BoundsArea = .defaultBoundsArea()) {
        delegate?.perform(.startLoading)
        vehicleService.vehicles(for: boundsArea)
            .onComplete { [weak self] result in
                guard let strongSelf = self else {
                    return
                }

                strongSelf.delegate?.perform(.finishedLoading)

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
