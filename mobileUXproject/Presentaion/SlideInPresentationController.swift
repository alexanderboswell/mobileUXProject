//
//  SlideInPresentationController.swift
//  mobileUXproject
//
//  Created by alexander boswell on 9/29/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

class SlideInPresentationController: UIPresentationController {
	//1
	// MARK: - Properties
	fileprivate var dimmingView: UIView!
	private var direction: PresentationDirection
	
	
	override var frameOfPresentedViewInContainerView: CGRect {
		
		//1
		var frame: CGRect = .zero
		frame.size = size(forChildContentContainer: presentedViewController,
						  withParentContainerSize: containerView!.bounds.size)
		
		//2
		switch direction {
		case .right:
			frame.origin.x = containerView!.frame.width*(1.0/3.0)
		case .bottom:
			frame.origin.y = containerView!.frame.height*(1.0/6.0)
		default:
			frame.origin = .zero
		}
		return frame
	}
	
	//2
	init(presentedViewController: UIViewController,
		 presenting presentingViewController: UIViewController?,
		 direction: PresentationDirection) {
		self.direction = direction
		
		//3
		super.init(presentedViewController: presentedViewController,
				   presenting: presentingViewController)
		
		setupDimmingView()
	}
	
	override func presentationTransitionWillBegin() {
		
		// 1
		containerView?.insertSubview(dimmingView, at: 0)
		
		// 2
		NSLayoutConstraint.activate(
			NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|",
										   options: [], metrics: nil, views: ["dimmingView": dimmingView]))
		NSLayoutConstraint.activate(
			NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|",
										   options: [], metrics: nil, views: ["dimmingView": dimmingView]))
		
		//3
		guard let coordinator = presentedViewController.transitionCoordinator else {
			dimmingView.alpha = 1.0
			return
		}
		
		coordinator.animate(alongsideTransition: { _ in
			self.dimmingView.alpha = 1.0
		})
	}
	
	override func dismissalTransitionWillBegin() {
		guard let coordinator = presentedViewController.transitionCoordinator else {
			dimmingView.alpha = 0.0
			return
		}
		
		coordinator.animate(alongsideTransition: { _ in
			self.dimmingView.alpha = 0.0
		})
	}
	
	override func containerViewWillLayoutSubviews() {
		presentedView?.frame = frameOfPresentedViewInContainerView
	}
	
	override func size(forChildContentContainer container: UIContentContainer,
					   withParentContainerSize parentSize: CGSize) -> CGSize {
		switch direction {
		case .left, .right:
			return CGSize(width: parentSize.width*(2.0/3.0), height: parentSize.height)
		case .bottom, .top:
			return CGSize(width: parentSize.width, height: parentSize.height*(5.0/6.0))
		}
	}
	
}
// MARK: - Private
private extension SlideInPresentationController {
	func setupDimmingView() {
		dimmingView = UIView()
		dimmingView.translatesAutoresizingMaskIntoConstraints = false
		dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
		dimmingView.alpha = 0.0
		
		let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
		dimmingView.addGestureRecognizer(recognizer)
		
		let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
		swipeRecognizer.direction = .down
		self.presentedView?.addGestureRecognizer(swipeRecognizer)
	}
	@objc dynamic func handleTap(recognizer: Any) {
		presentingViewController.dismiss(animated: true)
	}
}
