import FNUIKit
import FNFoundation

class VehicleListViewController: UIViewController {

    private enum Constants {
        static let cellID = "VehicleTableViewCellID"
        static let estimatedCellHeight: CGFloat = 80.0
    }

    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = Constants.estimatedCellHeight
        }
    }

    private var viewState: VehicleSearchViewState? {
        didSet {
            tableView.reloadData()
        }
    }

    private var kitchen: AnyKitchen<VehicleSearchViewEvent, VehicleSearchCommand>!
    private var loadingIndicator: LoadingIndicatorProvider!

    func inject(kitchen: AnyKitchen<VehicleSearchViewEvent, VehicleSearchCommand>, loadingIndicator: LoadingIndicatorProvider) {
        self.kitchen = kitchen
        self.loadingIndicator = loadingIndicator
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        kitchen.receive(event: .viewDidLoad)
    }

    private func showErrorBanner(with error: Error) {
        // TODO: - implement show banner
    }
}

extension VehicleListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewState?.vehicles.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath) as! VehicleTableViewCell
        cell.configure(with: forceCast(viewState!.vehicles[indexPath.row], VehicleSearchViewState.Vehicle.self, justification: .cantBeNilAtThisPoint))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension VehicleListViewController: KitchenDelegate {
    func perform(_ command: VehicleSearchCommand) {
        switch command {
        case .title(let title):
            self.title = title
        case .startLoading:
            loadingIndicator.show(in: view)
        case .finishedLoading:
            loadingIndicator.hide()
        case .present(let viewState):
            self.viewState = viewState
        case .error(let error):
            showErrorBanner(with: error)
        }
    }
}
