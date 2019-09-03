//
//  LoadingIndicator.swift
//  FNUIKit
//
//  Created by Alexandr Zhuchinskiy
//  Copyright © 2019 Alexandr Zhuchinskiy. All rights reserved.
//

public protocol LoadingIndicatorProvider {
    func show(in view: UIView)
    func hide()
    var isHidden: Bool { get }
}

class LoadingIndicator: LoadingIndicatorProvider {

    var isHidden: Bool {
        return activityIndicator.isHidden
    }

    private var contentView: UIView!
    private var loadingView: UIView!
    private var activityIndicator: UIActivityIndicatorView!

    func show(in view: UIView) {
        contentView = view
        startLoading()
    }

    func hide() {
        stopLoading()
    }

    private func startLoading() {
        setup()
        contentView.addSubview(loadingView)
        activityIndicator.startAnimating()
    }

    private func stopLoading() {
        activityIndicator.stopAnimating()
        loadingView.removeFromSuperview()
    }

    private func setup() {
        let view = UIView()
        view.frame = contentView.frame
        view.center = contentView.center
        view.backgroundColor = UIColor.clear

        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        containerView.center = contentView.center
        containerView.backgroundColor = UIColor.darkGray
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 10

        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.center = CGPoint(x: containerView.frame.size.width / 2, y: containerView.frame.size.height / 2)
        containerView.addSubview(activityIndicator)
        view.addSubview(containerView)
        loadingView = view
    }
}
