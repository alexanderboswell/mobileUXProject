//
//  AccountViewController.swift
//  mobileUXproject
//
//  Created by alexander boswell on 10/2/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	//MARK: Login outlets
	@IBOutlet private weak var LoginView: UIView!
	@IBOutlet private weak var firstAccountLabel: UILabel!
	@IBOutlet private weak var secondAccountLabel: UILabel!
	@IBOutlet private weak var loginButton: UIButton!
	
	//MARK: Account outlets
	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var profileImageView: UIImageView!
	@IBOutlet private weak var nameLabel: UILabel!
	
	//MARK: Private variables
	private var selectedAccount: Int?
	private var rows = [Any]()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		setupTapGestures()

		if Client.signedInAccount != nil {
			configureViewWithAccount()
		} else {
			configureViewWithoutAccount()
		}
	}
	
	//MARK: Actions

	@IBAction private func login(_ sender: UIButton) {
		Client.login(accountNumber: selectedAccount ?? 0)
		configureViewWithAccount()
		NotificationCenter.default.post(name: LOGIN_NOTIFICATION, object: nil)
	}
	
	@IBAction func logout(_ sender: UIButton) {
		Client.logout()
		configureViewWithoutAccount()
		NotificationCenter.default.post(name: LOGOUT_NOTIFICATION, object: nil)
	}
	
	@objc func firstAccountTap(_ sender: UITapGestureRecognizer) {
		loginButton.isEnabled = true
		firstAccountLabel.textColor = UIColor.accentColor
		secondAccountLabel.textColor = UIColor.black
		selectedAccount = 0
	}

	@objc func secondAccountTap(_ sender: UITapGestureRecognizer) {
		loginButton.isEnabled = true
		firstAccountLabel.textColor = UIColor.black
		secondAccountLabel.textColor = UIColor.accentColor
		selectedAccount = 1
	}
	
	//MARK: UITableViewDataSource and UITableViewDelegate
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return rows.count
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let rowIndex = indexPath.row
		if let _ = rows[indexPath.row] as? String {
			return 40.0
		} else if let _ = rows[rowIndex] as? Course {
			return 100.0
		} else if let _ = rows[rowIndex] as? StudyPreference {
			return 47.0
		} else {
			return 40.0
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let rowIndex = indexPath.row
		if let sectionTitle = rows[rowIndex] as? String, let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as? AccountHeaderTableViewCell {
			
			cell.titleLabel.text = sectionTitle
			return cell
			
		} else if let course = rows[rowIndex] as? Course, let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as? AccountCourseTableViewCell {
			
			cell.course = course
			return cell
			
		} else if let preference = rows[rowIndex] as? StudyPreference, let cell = tableView.dequeueReusableCell(withIdentifier: "PreferenceCell", for: indexPath) as? AccountPreferenceTableViewCell {
			
			cell.preference = preference
			return cell
			
		} else {
			return UITableViewCell()
		}
	}
	
	//MARK: Private methods
	
	private func setupTapGestures() {
		let firstAccountTap = UITapGestureRecognizer(target: self, action: #selector(self.firstAccountTap(_:)))
		
		firstAccountLabel.addGestureRecognizer(firstAccountTap)
		firstAccountLabel.isUserInteractionEnabled = true
		
		let secondAccountTap = UITapGestureRecognizer(target: self, action: #selector(self.secondAccountTap(_:)))
		
		secondAccountLabel.addGestureRecognizer(secondAccountTap)
		secondAccountLabel.isUserInteractionEnabled = true
	}
	
	private func configureViewWithAccount() {
		if let account = Client.signedInAccount {
			LoginView.isHidden = true
			profileImageView.image = account.profileImage
			nameLabel.text = account.name
			loadData(account: account)
		}
	}
	
	private  func configureViewWithoutAccount() {
		LoginView.isHidden = false
		selectedAccount = nil
		firstAccountLabel.textColor = UIColor.black
		secondAccountLabel.textColor = UIColor.black
		loginButton.isEnabled = false
	}
	
	private func loadData(account: Account) {
		
		rows = []
		rows.append("Enrolled Courses")
		for course in account.courses {
			rows.append(course)
		}
		
		rows.append("Study Preferences")
		for preference in account.studyPreferences {
			rows.append(preference)
		}
		tableView.reloadData()
//		UIView.transition(with: tableView, duration: 1.0, options: .transitionCrossDissolve, animations:
//			{
//				self.tableView.alpha = 1.0
//
//			}, completion: nil)
//		tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .automatic)
	}
}
