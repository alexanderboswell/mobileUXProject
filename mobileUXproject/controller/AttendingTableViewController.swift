//
//  AttendingTableViewController.swift
//  mobileUXproject
//
//  Created by alexander boswell on 10/16/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

class AttendingTableViewController: UIViewController, ResponseToSessionProtocol {
	
	lazy var slideInTransitioningDelegate = SlideInPresentationManager()
	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var noAttendingView: UIView!
	
	private let impact = UIImpactFeedbackGenerator()
	private var sessions = [StudySession]()
	private var badgeValue = 0

    override func viewDidLoad() {
        super.viewDidLoad()
		
		NotificationCenter.default.addObserver(self, selector: #selector(addSession), name: ADDED_STUDY_SESSION_NOTIFICATION, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(removeSession), name: REMOVED_STUDY_SESSION_NOTIFICATION, object: nil)
		
		loadData()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		badgeValue = 0
		self.tabBarController?.tabBar.items?[0].badgeValue = nil
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? SessionViewController,
			let session = sender as? StudySession {
			vc.session = session
			slideInTransitioningDelegate.screenAmount = .Ratio4_6
			vc.transitioningDelegate = slideInTransitioningDelegate
			vc.modalPresentationStyle = .custom
			vc.slideInTransitioningDelegate = slideInTransitioningDelegate
			
			vc.delegate = self
		}
	}
	
	@objc func addSession() {
		badgeValue += 1
		self.tabBarController?.tabBar.items?[0].badgeValue = "\(badgeValue)"
		loadData()
	}
	
	@objc func removeSession() {
		badgeValue -= 1
		if badgeValue <= 0 {
			badgeValue = 0
			self.tabBarController?.tabBar.items?[0].badgeValue = nil
		} else {
			self.tabBarController?.tabBar.items?[0].badgeValue = "\(badgeValue)"
		}
		
		loadData()
	}
	
	@objc func loadData() {
		Client.getAttendingSessions { (sessions) in
			self.sessions = sessions
			self.sessions.sort(by: { (session1, session2) -> Bool in
				return session1.startDate < session2.startDate
			})
			
			self.checkIfEmptyTable()
			self.tableView.reloadData()
		}
	}
	
	private func checkIfEmptyTable() {
		if self.sessions.count == 0 {
			self.noAttendingView.isHidden = false
		} else {
			self.noAttendingView.isHidden  = true
		}
	}
	
	//MARK: ResponseToSessionProtocol
	
	func AddedSession(session: StudySession) {
		reloadCell(session: session)
		NotificationCenter.default.post(name: ADDED_STUDY_SESSION_NOTIFICATION, object: session)
	}
	
	func RemovedSession(session: StudySession) {
		reloadCell(session: session)
		NotificationCenter.default.post(name: REMOVED_STUDY_SESSION_NOTIFICATION, object: session)
	}
	
	
	
	func reloadCell(session: StudySession) {
		for (i, tempSession) in sessions.enumerated() {
			if session == tempSession {
				sessions.remove(at: i)
				tableView.deleteRows(at: [IndexPath(row: i, section: 0)], with: .automatic)
			}
		}
		checkIfEmptyTable()
	}
	
}
extension AttendingTableViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sessions.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "attendingCell", for: indexPath) as? AttendingTableViewCell else { return UITableViewCell() }
		
		cell.session = sessions[indexPath.row]
		cell.selectionStyle = .none
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		impact.impactOccurred()
		performSegue(withIdentifier: "showSession", sender: sessions[indexPath.row])
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return  98.0
	}
	
}
