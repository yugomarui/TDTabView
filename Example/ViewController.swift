//
//  ViewController.swift
//  Example
//
//  Created by y.marui on 2020/10/15.
//

import UIKit
import TDTabView

class ViewController: TDTabViewController {
    
    var vc1: UIViewController!
    var vc2: UIViewController!
    var vc3: UIViewController!
    var vc4: UIViewController!
    var vc5: UIViewController!
    var vc6: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let storyboard1 = UIStoryboard(name: "Table", bundle: nil)
        vc1 = storyboard1.instantiateInitialViewController()
        
        let storyboard2 = UIStoryboard(name: "Image", bundle: nil)
        vc2 = storyboard2.instantiateInitialViewController()
        
        let storyboard3 = UIStoryboard(name: "Web", bundle: nil)
        vc3 = storyboard3.instantiateInitialViewController()
        
        vc4 = storyboard1.instantiateInitialViewController()
        
        vc5 = storyboard2.instantiateInitialViewController()
        
        vc6 = storyboard3.instantiateInitialViewController()
    }
}

extension ViewController: TDTabViewControllerDelegate {
    func viewControllers() -> [UIViewController] {
        return [vc1, vc2, vc3, vc4, vc5, vc6]
    }
    
    func backgroundColor() -> UIColor? {
        return UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.8)
    }
}
