//
//  CalendarViewController.swift
//  mobileUXproject
//
//  Created by alexander boswell on 10/15/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController, FilterProtocol, ResponseToSessionProtocol {
	
	@IBOutlet private weak var calendarView: JTAppleCalendarView!
	@IBOutlet private weak var monthYearLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var noSessionsLabel: UILabel!
	@IBOutlet weak var filterAmountView: UIView!
	@IBOutlet weak var filterAmountLabel: UILabel!
	
	let formatter = DateFormatter()
	var savedDates = [String: Date]()
	var filters = [String]()
	var sessions = [StudySession]()
	
	var filteredSessionsForDate = [Date: [StudySession]]()
	lazy var slideInTransitioningDelegate = SlideInPresentationManager()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		setupCalendarView()
		tableView.tableFooterView = UIView()

    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		loadData()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? FilterViewController {
			slideInTransitioningDelegate.screenAmount = .Ratio3_6
			vc.transitioningDelegate = slideInTransitioningDelegate
			vc.modalPresentationStyle = .custom
			
			vc.slideInTransitioningDelegate = slideInTransitioningDelegate
			vc.delegate = self
		} else if let vc = segue.destination as? SessionViewController,
				  let session = sender as? StudySession {
			
			vc.session = session
			slideInTransitioningDelegate.screenAmount = .Ratio4_6
			vc.transitioningDelegate = slideInTransitioningDelegate
			vc.modalPresentationStyle = .custom
			vc.slideInTransitioningDelegate = slideInTransitioningDelegate
			
			vc.delegate = self
		}
	}
	
	//MARK:
	func AddedSession(session: StudySession) {
		reloadCell(session: session)
	}
	
	func RemovedSession(session: StudySession) {
		reloadCell(session: session)
	}
	
	
	func reloadCell(session: StudySession) {
		for (i, tempSession) in sessions.enumerated() {
			if session == tempSession {
					tableView.reloadRows(at: [IndexPath(row: i, section: 0)], with: .automatic)
			}
		}
	}
	
	//MARK: FilterProtocol
	
	func filterChanged() {
		loadData()
		var filterOnCount = 0
		for filter in Client.filters {
			if !filter.isOn {
				filterOnCount += 1
			}
		}
		
		if filterOnCount == 0 {
			filterAmountView.isHidden = true
		} else {
			filterAmountView.isHidden = false
			filterAmountLabel.text = "\(filterOnCount)"
		}
	
	}
	
	private func setupCalendarView() {
		// setup collection view cell insets
		calendarView.minimumLineSpacing = 0
		calendarView.minimumInteritemSpacing = 0
		calendarView.allowsMultipleSelection = false
		
		// setup year and month labels
		calendarView.visibleDates { (visibleDates) in
			self.setYearAndMonthLabels(visibleDates: visibleDates)
			let selectedDate = self.getSelectedDate(visibleDates: visibleDates)
			self.calendarView.selectDates([selectedDate])
			self.loadDataForDate(date: selectedDate)
		}
	}
	
	private func saveSelectedDate(date: Date) {
		savedDates[getKey(date: date)] = date
	}
	
	private func getKey(date: Date) -> String {
		formatter.dateFormat = "yyyy"
		let year =  formatter.string(from: date)
		formatter.dateFormat = "MMMM"
		let month = formatter.string(from: date)
		return "\(month)-\(year)"
	}
	
	private func getSelectedDate(visibleDates: DateSegmentInfo) -> Date {
		if let firstDayOfMonth = visibleDates.monthDates.first?.date {
			if let date = savedDates[getKey(date: firstDayOfMonth)] {
				return date
			} else {
				saveSelectedDate(date: firstDayOfMonth)
				return firstDayOfMonth
				
			}
		} else {
			return Date()
		}
	}
	
	private func handleTextSelected(cell: JTAppleCell?, cellState: CellState) {
		guard let cell = cell as? CalendarCollectionViewCell else { return }
		
		if cellState.isSelected {
			cell.selectedView.isHidden = false
			cell.sessionsIndictatorView.backgroundColor = .white
		} else {
			cell.selectedView.isHidden = true
			cell.sessionsIndictatorView.backgroundColor = .black
		}
	}
	
	private func handleCellTextColor(cell: JTAppleCell?, cellState: CellState) {
		guard let cell = cell as? CalendarCollectionViewCell else { return }
		
		if cellState.isSelected {
			cell.dateLabel.textColor = .white
			cell.sessionsIndictatorView.backgroundColor = .white
		} else {
			if cellState.dateBelongsTo == .thisMonth {
				cell.dateLabel.textColor = .black
				cell.sessionsIndictatorView.backgroundColor  = .black
			} else {
				cell.dateLabel.textColor = .gray
				cell.sessionsIndictatorView.backgroundColor = .gray
			}
		}
	}
	
	private func handleSessionIndicatorHidden(cell: CalendarCollectionViewCell, date: Date) {
		if let sessions = filteredSessionsForDate[date], sessions.count != 0 {
			cell.sessionsIndictatorView.isHidden = false
		} else {
			cell.sessionsIndictatorView.isHidden = true
		}
	}
	
	private func setYearAndMonthLabels(visibleDates: DateSegmentInfo) {
		if let date = visibleDates.monthDates.first?.date {
			formatter.dateFormat = "yyyy"
			let year =  formatter.string(from: date)
			formatter.dateFormat = "MMMM"
			monthYearLabel.text = "\(formatter.string(from: date)) \(year)"
		}
	}
	
	private func loadData() {
		Client.getSessions { (sessionsForDate) in
			self.filteredSessionsForDate = sessionsForDate
			
			for key in sessionsForDate.keys {
				for session in sessionsForDate[key] ?? [] {
					for filterTitle in session.filterTitles {
						for clientFilter in Client.filters {
							if clientFilter.title == filterTitle, clientFilter.isOn == false {
								self.filteredSessionsForDate[key]?.removeAll(where: { (tempSession) -> Bool in
									return session == tempSession
								})
							}
						}
					}
				}
			}
			
			self.calendarView.visibleDates { (visibleDates) in
				self.loadDataForDate(date: self.getSelectedDate(visibleDates: visibleDates))
				self.calendarView.reloadData()
			}
		}
	}
	
	private func loadDataForDate(date: Date) {
		if let sessions = filteredSessionsForDate[date], sessions.count != 0 {
			self.sessions = sessions
			self.noSessionsLabel.isHidden = true
		} else {
			self.sessions = []
			self.noSessionsLabel.isHidden = false
		}
		
		UIView.animate(withDuration: 0.3, animations: {
			self.tableView.reloadData()
		})
		tableView.scrollToTop(animated: false)
	}

}

extension CalendarViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sessions.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "calendarTableCell", for: indexPath) as? CalendarTableViewCell else { return UITableViewCell() }
		
		cell.session = sessions[indexPath.row]
		cell.selectionStyle = .none
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 88.0
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "showStudySession", sender: sessions[indexPath.row])
	}
	
}

extension CalendarViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
	func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
		guard let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "calendarCell", for: indexPath) as? CalendarCollectionViewCell else { return }
		
		handleTextSelected(cell: cell, cellState: cellState)
		handleCellTextColor(cell: cell, cellState: cellState)
		handleSessionIndicatorHidden(cell: cell, date: date)
		cell.dateLabel.text = cellState.text
	}
	
	func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
		guard let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "calendarCell", for: indexPath) as? CalendarCollectionViewCell else {
			return JTAppleCell()
		}
		
		handleTextSelected(cell: cell, cellState: cellState)
		handleCellTextColor(cell: cell, cellState: cellState)
		handleSessionIndicatorHidden(cell: cell, date: date)
		cell.dateLabel.text = cellState.text
		return cell
	}
	
	
	func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
		if cellState.dateBelongsTo == .previousMonthOutsideBoundary || cellState.dateBelongsTo == .followingMonthWithinBoundary {
			calendarView.deselect(dates: [date])
		} else {
			handleTextSelected(cell: cell, cellState: cellState)
			handleCellTextColor(cell: cell, cellState: cellState)
			saveSelectedDate(date: date)
			
			loadDataForDate(date: date)
		}
	}
	
	func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
		handleTextSelected(cell: cell, cellState: cellState)
		handleCellTextColor(cell: cell, cellState: cellState)
	}
	
	func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
		formatter.dateFormat = "yyyy MM dd"
		formatter.timeZone = Calendar.current.timeZone
		formatter.locale = Calendar.current.locale
		
		let startDate = formatter.date(from: "2018 10 01")
		let endDate = formatter.date(from: "2018 12 31")
		
		let parameters = ConfigurationParameters(startDate: startDate!, endDate: endDate!, generateInDates: .forAllMonths, generateOutDates: .tillEndOfRow)
		return parameters
	}
	
	func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
		setYearAndMonthLabels(visibleDates: visibleDates)
		calendarView.selectDates([getSelectedDate(visibleDates: visibleDates)])
	}
}
