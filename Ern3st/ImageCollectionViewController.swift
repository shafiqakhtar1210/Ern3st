//
//  ViewController.swift
//  iOS Example
//
//  Created by Jin Wang on Feb 8, 2017.
//  Copyright © 2017 Uthoft. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

class SimpleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
    func configCell(imageURL: String){
        
    }
    
    
}



class ImageCollectionViewController: UICollectionViewController {
    let apiManager = ApiNetworkManager()
    /// animator, clipToBounds, row, column
    private let animators: [(LayoutAttributesAnimator, Bool, Int, Int)] = [(ParallaxAttributesAnimator(), true, 1, 1),
                                                         (ZoomInOutAttributesAnimator(), true, 1, 1),
                                                         (RotateInOutAttributesAnimator(), true, 1, 1),
                                                         (LinearCardAttributesAnimator(), false, 1, 1),
                                                         (CubeAttributesAnimator(), true, 1, 1),
                                                         (CrossFadeAttributesAnimator(), true, 1, 1),
                                                         (PageAttributesAnimator(), true, 1, 1),
                                                         (SnapInAttributesAnimator(), true, 2, 4)]
    @IBOutlet var dismissGesture: UISwipeGestureRecognizer!
    
    var animator = (ParallaxAttributesAnimator(), true, 1, 1)
    var direction: UICollectionView.ScrollDirection = .horizontal
    
    let cellIdentifier = "SimpleCollectionViewCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // Turn on the paging mode for auto snaping support.
        collectionView?.isPagingEnabled = true
        
        if let layout = collectionView?.collectionViewLayout as? AnimatedCollectionViewLayout {
            layout.scrollDirection = direction
            layout.animator = animator.0
        }
        
        dismissGesture.direction = direction == .horizontal ? .down : .left
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSwipeDown(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool { return true }
}

extension ImageCollectionViewController: UICollectionViewDelegateFlowLayout {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let c = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
       
        
        return c
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: view.bounds.width / CGFloat(animator.2), height: view.bounds.height / CGFloat(animator.3))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

