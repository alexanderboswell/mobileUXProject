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
	@IBOutlet private weak var firstAccountView: UIView!
	@IBOutlet private weak var secondAccountView: UIView!
	
	//MARK: Account outlets
	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var profileImageView: UIImageView!
	@IBOutlet private weak var nameLabel: UILabel!
	
	//MARK: Private variables
	private var selectedAccount: Int?
	private var rows = [Any]()
	private var presentedCourseIndex: IndexPath?
	
	//MARK: Public variables
	lazy var slideInTransitioningDelegate = SlideInPresentationManager()
	
	//MARK: Viewcontroller lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()
		
		setupTapGestures()

		if Client.signedInAccount != nil {
			configureViewWithAccount()
		} else {
			configureViewWithoutAccount()
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? CourseViewController,
			let course = sender as? Course {
			
			slideInTransitioningDelegate.screenAmount = .Ratio3_6
			vc.transitioningDelegate = slideInTransitioningDelegate
			vc.modalPresentationStyle = .custom
			
			vc.course = course
		} else if let vc = segue.destination as? AddCourseViewController {
			
			slideInTransitioningDelegate.screenAmount = .Ratio3_6
			vc.transitioningDelegate = slideInTransitioningDelegate
			vc.modalPresentationStyle = .custom
			
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
	
	@IBAction func removeCourse(segue: UIStoryboardSegue) {
		if let indexPath = presentedCourseIndex,
			let course = rows[indexPath.row] as? Course {
			rows.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
			presentedCourseIndex = nil
			Client.signedInAccount?.remove(course: course)
		}
	}
	
	@objc func firstAccountTap(_ sender: UITapGestureRecognizer) {
		loginButton.isEnabled = true
		selectedAccount = 0
		addBorder(view: firstAccountView)
		removeBorder(view: secondAccountView)
	}

	@objc func secondAccountTap(_ sender: UITapGestureRecognizer) {
		loginButton.isEnabled = true
		selectedAccount = 1
		addBorder(view: secondAccountView)
		removeBorder(view: firstAccountView)
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
			
			cell.selectionStyle = .none
			cell.titleLabel.text = sectionTitle
			if sectionTitle == "Enrolled Courses" {
				cell.button.isHidden = false
			} else  {
				cell.button.isHidden = true
			}
			return cell
			
		} else if let course = rows[rowIndex] as? Course, let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as? AccountCourseTableViewCell {
			
			cell.selectionStyle = .none
			cell.course = course
			return cell
			
		} else if let preference = rows[rowIndex] as? StudyPreference, let cell = tableView.dequeueReusableCell(withIdentifier: "PreferenceCell", for: indexPath) as? AccountPreferenceTableViewCell {
			
			cell.selectionStyle = .none
			cell.preference = preference
			return cell
			
		} else {
			return UITableViewCell()
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let course = rows[indexPath.row] as? Course {
			performSegue(withIdentifier: "showCourse", sender: course)
			presentedCourseIndex = indexPath
		}
	}
	
	//MARK: Private methods
	
	private func setupTapGestures() {
		let firstAccountTap = UITapGestureRecognizer(target: self, action: #selector(self.firstAccountTap(_:)))
		
		firstAccountView.addGestureRecognizer(firstAccountTap)
		firstAccountLabel.isUserInteractionEnabled = true
		
		let secondAccountTap = UITapGestureRecognizer(target: self, action: #selector(self.secondAccountTap(_:)))
		
		secondAccountView.addGestureRecognizer(secondAccountTap)
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
		removeBorder(view: firstAccountView)
		removeBorder(view: secondAccountView)
	}
	
	private func addBorder(view: UIView) {
		view.layer.cornerRadius = 10.0
		view.layer.borderWidth = 1.5
		view.layer.borderColor = UIColor.accentColor.cgColor
		view.layer.masksToBounds = true
	}
	
	private func removeBorder(view: UIView) {
		view.layer.cornerRadius = 10.0
		view.layer.borderWidth = 1.5
		view.layer.borderColor = UIColor.clear.cgColor
		view.layer.masksToBounds = true
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
	}
}
