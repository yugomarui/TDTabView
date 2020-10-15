//
//  TDTabChildViewController.swift
//  TDTabView
//
//  Created by y.marui on 2020/10/15.
//

import UIKit

open class TDTabChildViewController: UIViewController {

    public func exitFullScreen() {
        if let tabVC = parent as? TDTabViewController {
            tabVC.hideContainerView()
        } else if let nvc = parent as? UINavigationController,
                  let tabVC = nvc.parent as? TDTabViewController {
            tabVC.hideContainerView()
        }
    }
}
