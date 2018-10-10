//
//  ActionButton.swift
//  mobileUXproject
//
//  Created by alexander boswell on 10/9/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

class ActionButton: UIButton {

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		layer.cornerRadius = 10
		layer.masksToBounds = true
	}
}
