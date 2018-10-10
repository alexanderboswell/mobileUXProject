//
//  SessionsTableViewController.swift
//  mobileUXproject
//
//  Created by alexander boswell on 9/27/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

public let LOGIN_NOTIFICATION = NSNotification.Name("LoggedIn")
public let LOGOUT_NOTIFICATION = NSNotification.Name("LoggedOut")

class SessionsTableViewController: UITableViewController, ResponseToSessionProtocol {
	
	lazy var slideInTransitioningDelegate = SlideInPresentationManager()
	private var storedOffsets = [Int: CGFloat]()
	private var sessionsByWeek = [(String, [StudySession])]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		loadSessions()
		NotificationCenter.default.addObserver(self, selector: #selector(loadSessions), name: LOGIN_NOTIFICATION, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(clearSessions), name: LOGOUT_NOTIFICATION, object: nil)
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? SessionViewController,
		   let session = sender as? StudySession {
			slideInTransitioningDelegate.screenAmount = .Ratio5_6
			vc.transitioningDelegate = slideInTransitioningDelegate
			vc.modalPresentationStyle = .custom
			
			vc.slideInTransitioningDelegate = slideInTransitioningDelegate
			vc.session = session
			vc.delegate = self
		}
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sessionsByWeek.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SessionsTableViewCell else {
			return UITableViewCell()
		}
		cell.selectionStyle = .none
		cell.sessionsLabel.text = sessionsByWeek[indexPath.row].0
		return cell
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 184.0
	}
	
	
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		guard let tableViewCell = cell as? SessionsTableViewCell else { return }
		
		tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
		tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
	}
	
	override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		guard let tableViewCell = cell as? SessionsTableViewCell else { return }
		
		storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
	}
	
	//MARK: ResponseToSessionProtocol
	
	func reloadCell(session: StudySession) {
		for (i, _) in sessionsByWeek.enumerated() {
			for (j, tempSession) in sessionsByWeek[i].1.enumerated() {
				if session == tempSession {
					if let tableViewCell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? SessionsTableViewCell {
					
						tableViewCell.collectionView.reloadItems(at: [IndexPath(row: j, section: 0)])
						if let collectionViewCell = tableViewCell.collectionView.cellForItem(at: IndexPath(row: j, section: 0)) as? SessionCollectionViewCell {

							setReponseimages(session: session, collectionViewCell: collectionViewCell)
						}
					}
				}
			}
		}
	}
	
	//MARK: Private Methods
	
	@objc private func loadSessions() {
		Client.getSessionsByWeek { (response) in
			if let sessionsByWeek = response {
				self.sessionsByWeek = sessionsByWeek
				self.tableView.reloadData()
			} else {
				
			}
		}
	}
	
	@objc private func  clearSessions() {
		sessionsByWeek = []
		storedOffsets = [Int: CGFloat]()
		self.tableView.reloadData()
	}
	
	private func setReponseimages(session: StudySession, collectionViewCell: SessionCollectionViewCell) {
		switch session.currentResponse {
		case .confirmed?:
			collectionViewCell.checkImageView.image = UIImage(named: "check")
			collectionViewCell.questionImageView.image = UIImage(named: "questionGrey")
			collectionViewCell.canceledImageView.image = UIImage(named: "xGrey")
		case .maybe?:
			collectionViewCell.checkImageView.image = UIImage(named: "checkGrey")
			collectionViewCell.questionImageView.image = UIImage(named: "question")
			collectionViewCell.canceledImageView.image = UIImage(named: "xGrey")
		case .canceled?:
			collectionViewCell.checkImageView.image = UIImage(named: "checkGrey")
			collectionViewCell.questionImageView.image = UIImage(named: "questionGrey")
			collectionViewCell.canceledImageView.image = UIImage(named: "x")
		default:
			collectionViewCell.checkImageView.image = UIImage(named: "check")
			collectionViewCell.questionImageView.image = UIImage(named: "question")
			collectionViewCell.canceledImageView.image = UIImage(named: "x")
		}
	}

}
extension SessionsTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? SessionCollectionViewCell else {
			return UICollectionViewCell()
		}
		
		let session = sessionsByWeek[collectionView.tag].1[indexPath.row]
		cell.courrseTitleLabel.text = session.courseTitle
		cell.dateLabel.text = session.date
		cell.locationLabel.text = "\(session.roomNumber) \(session.building)"
		cell.confirmedLabel.text = "\(session.numberConfirmed)"
		cell.maybeLabel.text = "\(session.numberMaybe)"
		cell.canceledLabel.text = "\(session.numberCanceled)"
		setReponseimages(session: session, collectionViewCell: cell)
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? SessionCollectionViewCell else { return }
		
		cell.configureShadowAndBorder()
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return sessionsByWeek[collectionView.tag].1.count
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		performSegue(withIdentifier: "showSession", sender: sessionsByWeek[collectionView.tag].1[indexPath.row])
	}
}
