//
//  TDTabViewController.swift
//  TDTabView
//
//  Created by y.marui on 2020/10/15.
//

import UIKit

public protocol TDTabViewControllerDelegate: class {
    func viewControllers() -> [UIViewController]
    func backgroundColor() -> UIColor?
    func backgroundView() -> UIView?
}

public extension TDTabViewControllerDelegate {
    func backgroundColor() -> UIColor? { return nil }
    func backgroundView() -> UIView? { return nil }
}

open class TDTabViewController: UIViewController {

    public weak var delegate: TDTabViewControllerDelegate?

    private var collectionView: UICollectionView!
    private var containerView: UIView!

    private var selectedCell: TDTabCollectionCell?

    open override func viewDidLoad() {
        super.viewDidLoad()

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: view.frame.width, height:  200)
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TDTabCollectionCell.self, forCellWithReuseIdentifier: "TDTabCollectionCell")
        collectionView.backgroundColor = .clear

        containerView = UIView(frame: view.frame)
        containerView.isHidden = true
        view.addSubview(containerView)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let backgroundView = delegate?.backgroundView() {
            collectionView.backgroundView = backgroundView
        } else if let backgroundColor = delegate?.backgroundColor() {
            collectionView.backgroundColor = backgroundColor
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    func hideContainerView() {
        if let oldViewController = children.first {
            oldViewController.willMove(toParent: self)
            oldViewController.removeFromParent()
        }
        
        containerView.isHidden = true
        
        for visivleCell in collectionView.visibleCells {
            (visivleCell as! TDTabCollectionCell).backToList()
        }
    }
}

extension TDTabViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.viewControllers().count ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TDTabCollectionCell", for: indexPath) as! TDTabCollectionCell
        let vc = delegate!.viewControllers()[indexPath.row]
        vc.view.frame = containerView.frame
        cell.setup(viewConroller: vc, indexPath: indexPath, collectionView: collectionView)
        cell.delegate = self
        return cell
    }
}

extension TDTabViewController: TDTabCollectionCellDelegate {
    
    func willAnimateCell(cell: TDTabCollectionCell) {
        selectedCell = cell
        
        for visivleCell in collectionView.visibleCells {
            if visivleCell != cell {
                if let tdCell = visivleCell as? TDTabCollectionCell {
                    if tdCell.indexPath.row < cell.indexPath.row {
                        tdCell.moveForward()
                    } else if tdCell.indexPath.row > cell.indexPath.row {
                        tdCell.moveBackward()
                    }
                }
            }
        }
    }
    
    func didTapCell(cell: TDTabCollectionCell) {
        addChild(cell.viewConroller!)
        cell.viewConroller!.view.frame = self.containerView.frame
        containerView.addSubview(cell.viewConroller!.view)
        cell.viewConroller!.didMove(toParent: self)

        containerView.isHidden = false
    }
}
