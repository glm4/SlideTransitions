//
//  ViewController.swift
//  SlideTransitions
//
//  Created by German on 6/13/17.
//  Copyright © 2017 German. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var directionSelector: UISegmentedControl!
  @IBOutlet weak var effectSelector: UISegmentedControl!
  @IBOutlet weak var dimSlider: UISlider!
  @IBOutlet weak var thresholdSlider: UISlider!
  @IBOutlet weak var sizeSlider: UISlider!
  
  lazy var slidingController: SlideAnimationController = { [unowned self] in
    let animVC = SlideAnimationController(withEffect: self.currentEffect,
                                          proportion: self.currentRatio,
                                          from: self.currentDirection,
                                          duration: 0.35,
                                          dismissalThreshold: CGFloat(self.thresholdSlider.value),
                                          dimLevel: CGFloat(self.dimSlider.value))
    return animVC
    }()
  
  //MARK Demo purpose variables

  var currentEffect: SlideEffect { return effectSelector.selectedSegmentIndex == 0 ? .over : .moveOut }
  var currentDirection: SlideDirection {
    switch directionSelector.selectedSegmentIndex {
    case 0: return .left
    case 1: return .above
    case 2: return .right
    case 3: return .down
    default: return .left
    }
  }
  var currentRatio: CGFloat {
    return CGFloat(sizeSlider.value/100)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //Sets the presentingViewController transition delegate to the current VC
    segue.destination.transitioningDelegate = self
  }
  
  //MARK Configurable parameters
  
  @IBAction func effectChanged(_ sender: Any) {
    slidingController.animationEffect = currentEffect
  }
  
  @IBAction func directionChanged(_ sender: Any) {
    slidingController.direction = currentDirection
  }
  
  @IBAction func ratioChanged(_ sender: Any) {
    slidingController.menuProportion = currentRatio
  }
  
  @IBAction func thresholdChanged(_ sender: Any) {
    slidingController.dismissalThreshold = CGFloat(self.thresholdSlider.value)
  }
  
  @IBAction func dimChanged(_ sender: Any) {
    slidingController.dimLevel = CGFloat(self.dimSlider.value)
  }
}

extension ViewController: UIViewControllerTransitioningDelegate {
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    slidingController.presenting = false
    return slidingController
  }
  
  func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    slidingController.presenting = false
    return slidingController.inProgress ? slidingController : nil
  }
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    slidingController.presenting = true
    //Needed for interactive transitioning
    slidingController.wireTo(viewController: presenting)
    return slidingController
  }
}
