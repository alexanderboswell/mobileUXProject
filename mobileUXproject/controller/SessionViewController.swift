//
//  SessionViewController.swift
//  mobileUXproject
//
//  Created by alexander boswell on 9/29/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

class SessionViewController: UIViewController {

	@IBOutlet private weak var courseTitleLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var confirmedMembersLabel: UILabel!
	@IBOutlet weak var maybeMembersLabel: UILabel!
	@IBOutlet weak var canceledMembersLabel: UILabel!
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
    }
}
