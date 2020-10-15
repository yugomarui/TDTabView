//
//  TDTabCollectionCell.swift
//  TDTabView
//
//  Created by y.marui on 2020/10/15.
//

import UIKit

protocol TDTabCollectionCellDelegate: class {
    func willAnimateCell(cell: TDTabCollectionCell)
    func didTapCell(cell: TDTabCollectionCell)
}

public class TDTabCollectionCell: UICollectionViewCell {

    private  var mainView: UIView

    var viewConroller: UIViewController!
    var indexPath: IndexPath!
    var collectionView: UICollectionView!
    
    weak var delegate: TDTabCollectionCellDelegate?

    private var isFullScreen = false

    private var angle: CGFloat {
        return -60 * CGFloat.pi / 180.0
    }
    private let scaleOut: CGFloat = 0.8
    private let translateY: CGFloat = -20
    private lazy var topPadding: CGFloat = -(UIScreen.main.bounds.height/2 + translateY)*(1 - cos(angle))

    private var diagonalTransform3D: CATransform3D {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -3000.0
        transform = CATransform3DRotate(transform, angle, 1.0, 0.0, 0.0)
        transform = CATransform3DScale(transform, scaleOut, scaleOut, scaleOut)
        transform = CATransform3DTranslate(transform, 0.0, translateY, 0.0)
        return transform
    }

    
    let statusView = UIView()
    
    override init(frame: CGRect) {
        mainView = UIView(frame: frame)
        super.init(frame: frame)
        
        let screenHeight = UIScreen.main.bounds.height
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topPadding),
             mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             mainView.heightAnchor.constraint(equalToConstant: screenHeight - statusBarHeight)])
        addSubview(mainView)
        
        addSubview(statusView)
        statusView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [statusView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topPadding),
             statusView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             statusView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             statusView.heightAnchor.constraint(equalToConstant: screenHeight - statusBarHeight)])
        insertSubview(statusView, at: 0)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func setup(viewConroller: UIViewController, indexPath: IndexPath, collectionView: UICollectionView) {
        self.viewConroller = viewConroller
        self.indexPath = indexPath
        self.collectionView = collectionView
        
        layer.zPosition = CGFloat(indexPath.row)
        
        viewConroller.view.isUserInteractionEnabled = false
        mainView.addSubview(viewConroller.view)

        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCell(_:)))
        mainView.addGestureRecognizer(gesture)
        mainView.isUserInteractionEnabled = true

        mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowRadius = 5
        mainView.layer.shadowOpacity = 1.00
        mainView.layer.masksToBounds = false
        mainView.layer.transform = diagonalTransform3D
   
        statusView.backgroundColor = UIColor(red: 220/250, green: 220/250, blue: 220/250, alpha: 1)
        statusView.layer.transform = diagonalTransform3D
    }

    @objc func didTapCell(_ gesture: UITapGestureRecognizer) {
        delegate?.willAnimateCell(cell: self)
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let basicAnim = CABasicAnimation(keyPath: "transform")
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0.0, -frame.minY - topPadding + collectionView.contentOffset.y + statusBarHeight, 0.0)
        basicAnim.toValue = transform
        basicAnim.duration = 0.2
        basicAnim.fillMode = .forwards
        basicAnim.isRemovedOnCompletion = false
        basicAnim.delegate = self
        mainView.layer.add(basicAnim, forKey: nil)
        
        let animation = CABasicAnimation(keyPath: "shadowOpacity")
        animation.fromValue = layer.shadowOpacity
        animation.toValue = 0.0
        animation.duration = 0.2
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        mainView.layer.add(animation, forKey: animation.keyPath)
        
        let statusBasicAnim = CABasicAnimation(keyPath: "transform")
        var statusTransform = CATransform3DIdentity
        statusTransform = CATransform3DTranslate(statusTransform, 0.0, -frame.minY - topPadding + collectionView.contentOffset.y - statusBarHeight - 20, 0.0)
        statusBasicAnim.toValue = statusTransform
        statusBasicAnim.duration = 0.2
        statusBasicAnim.fillMode = .forwards
        statusBasicAnim.isRemovedOnCompletion = false
        statusBasicAnim.delegate = self
        statusView.layer.add(statusBasicAnim, forKey: nil)

        isFullScreen = true
        viewConroller.view.isUserInteractionEnabled = true
    }

    func backToList() {
        isFullScreen = false

        mainView.addSubview(viewConroller.view)

        let basicAnim = CABasicAnimation(keyPath: "transform")
        basicAnim.toValue = diagonalTransform3D
        basicAnim.duration = 0.2
        basicAnim.fillMode = .forwards
        basicAnim.isRemovedOnCompletion = false
        basicAnim.delegate = self
        mainView.layer.add(basicAnim, forKey: nil)
        statusView.layer.add(basicAnim, forKey: nil)
        
        let animation = CABasicAnimation(keyPath: "shadowOpacity")
        animation.fromValue = layer.shadowOpacity
        animation.toValue = 1
        animation.duration = 0.2
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        mainView.layer.add(animation, forKey: animation.keyPath)

        viewConroller.view.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func moveForward() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: -500)
        }, completion: nil)
    }
    
    func moveBackward() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: 800)
        }, completion: nil)
    }
}

extension TDTabCollectionCell: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if isFullScreen {
            delegate?.didTapCell(cell: self)
        }
    }
}
