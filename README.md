# TDTabView

![Pod Platform](https://img.shields.io/cocoapods/p/TDTabView.svg?style=flat)
![Pod License](https://img.shields.io/cocoapods/l/TDTabView.svg?style=flat)
[![Pod Version](https://img.shields.io/cocoapods/v/TDTabView.svg?style=flat)](http://cocoapods.org/pods/TDTabView)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

`TDTabView` is tab View like Safari.

## Demo

<img width="40%"  src="https://github.com/ymarui/TDTabView/blob/images/demo.gif">

## Usage

```swift
import UIKit
import TDTabView

class ViewController: TDTabViewController {
    
    var vc1: UIViewController!
    var vc2: UIViewController!
    var vc3: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let storyboard1 = UIStoryboard(name: "Table", bundle: nil)
        vc1 = storyboard1.instantiateInitialViewController()
        
        let storyboard2 = UIStoryboard(name: "Image", bundle: nil)
        vc2 = storyboard2.instantiateInitialViewController()
        
        let storyboard3 = UIStoryboard(name: "Web", bundle: nil)
        vc3 = storyboard3.instantiateInitialViewController()
    }
}

extension ViewController: TDTabViewControllerDelegate {
    func viewControllers() -> [UIViewController] {
        return [vc1, vc2, vc3]
    }
    
    func backgroundColor() -> UIColor? {
        return UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.8)
    }
}

```

## Installation

### CocoaPods

Add this to your Podfile.

```ogdl
pod 'TDTabView'
```

### Carthage

Add this to your Cartfile.

```ogdl
github "ymarui/TDTabView"
```

## License

MIT

