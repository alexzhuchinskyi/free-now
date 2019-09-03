import MapKit
import FNUIKit
import FNFoundation

class VehicleMapViewController: UIViewController {

    @IBOutlet private var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
        }
    }

    private var kitchen: AnyKitchen<VehicleMapViewEvent, VehicleMapCommand>!
    private var loadingIndicator: LoadingIndicatorProvider!

    func inject(kitchen: AnyKitchen<VehicleMapViewEvent, VehicleMapCommand>, loadingIndicator: LoadingIndicatorProvider) {
        self.kitchen = kitchen
        self.loadingIndicator = loadingIndicator
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        kitchen.receive(event: .viewDidLoad)
    }

    private func showVehicles(from viewState: VehicleSearchViewState) {
        viewState.vehicles.forEach {
            let annotation = VehicleAnnotation(title: $0.type,
                                               coordinate: .init(latitude: $0.latitude.doubleValue,
                                                                 longitude: $0.longitude.doubleValue))
            mapView.addAnnotation(annotation)
        }
    }

    private func showErrorBanner(with error: Error) {
        // TODO: - implement show banner
    }
}

extension VehicleMapViewController: KitchenDelegate {
    func perform(_ command: VehicleMapCommand) {
        switch command {
        case .title(let title):
            self.title = title
        case .present(let viewState):
            showVehicles(from: viewState)
        case .error(let error):
            showErrorBanner(with: error)
        }
    }
}

extension VehicleMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        kitchen.receive(event: .requestVehicles(for: mapView.edgePoints()))
    }
}
