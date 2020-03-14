//
//  RecommendedTableViewCell.swift
//  Meyender
//
//  Created by Varun Gupta on 08/03/2020.
//  Copyright © 2020 Varun Gupta. All rights reserved.
//

import UIKit

class RecommendedTableViewCell: UITableViewCell {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.register(UINib.init(nibName: "RecommendedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecommendedCollectionViewCell")
    }
}
