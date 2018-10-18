//
//  FilterViewController.swift
//  mobileUXproject
//
//  Created by alexander boswell on 10/17/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	@IBOutlet weak var tableView: UITableView!
	
	var slideInTransitioningDelegate: SlideInPresentationManager!
	var delegate: FilterProtocol?
	var filters: [String]!
	var courseTitles: [String]!

	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		tableView.reloadData()
    }
	
	@IBAction func close(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return courseTitles.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as? FilterTableViewCell else {
			return UITableViewCell()
		}
		let title = courseTitles[indexPath.row]
		cell.courseTitleLabel.text = title
		cell.courseTitle = title
		if filters.contains(title) {
			cell.isOn = true
		} else {
			cell.isOn = false
		}
		
		cell.delegate = delegate
		cell.selectionStyle = .none
		
		return cell
	}
}
