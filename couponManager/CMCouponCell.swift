//
//  CMCouponCell.swift
//  couponManager
//
//  Created by Singh, Abhay on 6/30/17.
//  Copyright © 2017 SHC. All rights reserved.
//

import UIKit

class CMCouponCell: UICollectionViewCell {
    
    var headerLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headerLabel = UILabel(frame: contentView.frame)
        contentView.addSubview(headerLabel)
    }
    
    
    
}
