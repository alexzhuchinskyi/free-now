//
//  VehicleTableViewCell.swift
//  FreeNow
//
//  Created by Alexandr Zhuchinskiy
//  Copyright © 2019 Alexandr Zhuchinskiy. All rights reserved.
//

import FNUIKit

class VehicleTableViewCell: UITableViewCell {

    @IBOutlet private var idLabel: UILabel!
    @IBOutlet private var latitudeLabel: UILabel!
    @IBOutlet private var longitudeLabel: UILabel!
    @IBOutlet private var typeLabel: UILabel!

    func configure(with viewState: VehicleSearchViewState.Vehicle) {
        idLabel.text = viewState.id.stringValue
        latitudeLabel.text = viewState.latitude
        longitudeLabel.text = viewState.longitude
        typeLabel.text = viewState.type
    }

    override func prepareForReuse() {
        idLabel.text = nil
        latitudeLabel.text = nil
        longitudeLabel.text = nil
        typeLabel.text = nil
    }
}
