//
//  StudentsTableViewController.swift
//  mobileUXproject
//
//  Created by alexander boswell on 10/9/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

class StudentsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	var students: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	//MARK: Actions
	@IBAction func close(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
	//MARK: UItableviewdelegate/datasource
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return students.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
			return UITableViewCell()
		}
		
		cell.textLabel?.text = students[indexPath.row]
		return cell
	}
}
