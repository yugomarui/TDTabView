//
//  ImageViewController.swift
//  Example
//
//  Created by y.marui on 2020/10/18.
//

import UIKit
import TDTabView

class ImageViewController: TDTabChildViewController {
    
    @IBAction func didTapRightButton(_ sender: Any) {
        exitFullScreen()
    }
}

