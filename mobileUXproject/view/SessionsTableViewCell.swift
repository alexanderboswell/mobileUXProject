//
//  SessionsTableViewCell.swift
//  mobileUXproject
//
//  Created by alexander boswell on 9/27/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

class SessionsTableViewCell: UITableViewCell {
	
	var collectionViewOffset: CGFloat {
		get {
			return collectionView.contentOffset.x
		}
		
		set {
			collectionView.contentOffset.x = newValue
		}
	}

	@IBOutlet weak var sessionsLabel: UILabel!
	@IBOutlet private weak var collectionView: UICollectionView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func setCollectionViewDataSourceDelegate
		<D: UICollectionViewDataSource & UICollectionViewDelegate>
		(dataSourceDelegate: D, forRow row: Int) {
		
		collectionView.delegate = dataSourceDelegate
		collectionView.dataSource = dataSourceDelegate
		collectionView.tag = row
		collectionView.reloadData()
	}
}
