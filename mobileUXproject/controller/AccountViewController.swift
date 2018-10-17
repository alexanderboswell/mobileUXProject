//
//  AccountViewController.swift
//  mobileUXproject
//
//  Created by alexander boswell on 10/2/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddCourseProtocol {
	
	//MARK: Login outlets
	@IBOutlet private weak var LoginView: UIView!
	
	//MARK: Account outlets
	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var profileImageView: UIImageView!
	@IBOutlet private weak var nameLabel: UILabel!
	@IBOutlet private weak var blurView: UIVisualEffectView!
	
	//MARK: Private variables
	private var rows = [Any]()
	private var presentedCourseIndex: IndexPath?
	private let impact = UIImpactFeedbackGenerator()
	
	//MARK: Public variables
	lazy var slideInTransitioningDelegate = SlideInPresentationManager()
	
	//MARK: Viewcontroller lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()
		
		if Client.signedInAccount != nil {
			configureViewWithAccount()
		} else {
			configureViewWithoutAccount()
		}
		
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		setupProfileImage()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		impact.impactOccurred()
		if let vc = segue.destination as? CourseViewController,
			let course = sender as? Course {
			slideInTransitioningDelegate.screenAmount = .Ratio3_6
			vc.transitioningDelegate = slideInTransitioningDelegate
			vc.modalPresentationStyle = .custom
			
			vc.course = course
		} else if let vc = segue.destination as? AddCourseViewController {
			
			slideInTransitioningDelegate.screenAmount = .Ratio4_6
			vc.transitioningDelegate = slideInTransitioningDelegate
			vc.modalPresentationStyle = .custom
			vc.delegate = self
		}
	}
	
	//MARK: Actions

	@IBAction private func login(_ sender: UIButton) {
		Client.login(accountNumber: sender.tag)
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
	
	//MARK: UITableViewDataSource and UITableViewDelegate
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return rows.count
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let rowIndex = indexPath.row
		if let _ = rows[indexPath.row] as? String {
			return 56.0
		} else if let _ = rows[rowIndex] as? Course {
			return 84.0
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
	
	//MARK: AddCourseProtocol
	func addCourse(course: Course) {
		rows.insert(course, at: 1)
		tableView.insertRows(at: [IndexPath(row: 1, section: 0)], with: .fade)
		Client.signedInAccount?.courses.append(course)
	}
	
	
	//MARK: Private methods
	
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
	}
	
	private func setupProfileImage() {
		let imageSize: CGFloat = 125.0
		let x = self.profileImageView.frame.midX  - imageSize / 2
		let y = self.profileImageView.frame.midY - imageSize / 2
		profileImageView.frame = CGRect(x: x, y: y, width: imageSize, height: imageSize)
		
		profileImageView.layer.borderWidth = 2
		profileImageView.layer.masksToBounds = false
		profileImageView.layer.borderColor = UIColor.white.cgColor
		profileImageView.layer.cornerRadius = profileImageView.frame.height/2
		profileImageView.clipsToBounds = true
		
		blurView.alpha = 0.45
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
