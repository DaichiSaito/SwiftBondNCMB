//
//  FavTestCollectionViewCell.swift
//  SwiftBondNCMB
//
//  Created by DaichiSaito on 2016/10/29.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit
import Bond
class FavTestCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var contentsImageView: UIImageView!

    @IBOutlet weak var favImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentsImageView.image = nil
        favImageView.image = nil
        bnd_bag.dispose()
    }
}