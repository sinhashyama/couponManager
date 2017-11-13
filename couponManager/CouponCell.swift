//
//  CouponCell.swift
//  couponManager
//
//  Created by Singh, Abhay on 6/30/17.
//  Copyright © 2017 SHC. All rights reserved.
//

import UIKit

protocol CouponCellDeleteDelegate: class {
    func deleteCell(cell: CouponCell)
}

class CouponCell: UICollectionViewCell {

    @IBOutlet weak var sellarImage: UIImageView!
    @IBOutlet weak var discountPlace: UILabel!
    @IBOutlet weak var headline: UILabel!
    @IBOutlet weak var expire: UILabel!
    @IBOutlet weak var discountValue: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var offerView: UIView!
    //var pan: UIPanGestureRecognizer!
    var showingBack = false
    weak var delegate: CouponCellDeleteDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup(){
        cardView.layer.cornerRadius = 20.0
        offerView.layer.cornerRadius = 20.0
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.numberOfTouchesRequired = 1
        self.contentView.addGestureRecognizer(doubleTap)
        self.contentView.isUserInteractionEnabled = true
        doubleTap.delaysTouchesBegan = true
    }
    
    func doubleTapped() {
        delegate?.deleteCell(cell: self)
        print("gesture recognie double tap")
    }
    
}







//extension UIView {
//    
//    func dropShadow(scale: Bool = true) {
//        self.layer.masksToBounds = false
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOpacity = 0.7
//        self.layer.shadowOffset = CGSize(width: -1, height: 3)
//        self.layer.shadowRadius = 15.0
//        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
//    }
//}


//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        if (pan.state == UIGestureRecognizerState.changed) {
//            let p: CGPoint = pan.translation(in: self)
//            let width = self.contentView.frame.width
//            let height = self.contentView.frame.height
//            self.contentView.frame = CGRect(x: p.x,y: 0, width: width, height: height);
//            //self.deleteLabel1.frame = CGRect(x: p.x - deleteLabel1.frame.size.width-10, y: 0, width: 100, height: height)
//            //self.deleteLabel2.frame = CGRect(x: p.x + width + deleteLabel2.frame.size.width, y: 0, width: 100, height: height)
//        }
//
//    }
//
//    func onPan(_ pan: UIPanGestureRecognizer) {
//        let collectionView: UICollectionView = self.superview as! UICollectionView
//        if pan.state == UIGestureRecognizerState.began {
//
//        } else if pan.state == UIGestureRecognizerState.changed {
//            collectionView.collectionViewLayout.invalidateLayout()
//            self.setNeedsLayout()
//            self.layoutIfNeeded()
//        } else {
//            if abs(pan.velocity(in: self).x) > 500 {
//                let collectionView: UICollectionView = self.superview as! UICollectionView
//                //let indexPath: IndexPath = collectionView.indexPathForItem(at: self.center)!
//                //collectionView.delegate?.collectionView!(collectionView, performAction: #selector(onPan(_:)), forItemAt: indexPath, withSender: nil)
//            } else {
//                UIView.animate(withDuration: 0.2, animations: {
//                    collectionView.collectionViewLayout.invalidateLayout()
//                    self.setNeedsLayout()
//                    self.layoutIfNeeded()
//                })
//            }
//            //collectionView.reloadData()
//        }
//    }
//
//
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//
//    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        return abs((pan.velocity(in: pan.view)).x) > abs((pan.velocity(in: pan.view)).y)
//    }
