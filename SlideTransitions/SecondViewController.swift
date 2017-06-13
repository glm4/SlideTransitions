//
//  SecondViewController.swift
//  SlideTransitions
//
//  Created by German on 6/13/17.
//  Copyright © 2017 German. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func tapToExit(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}
