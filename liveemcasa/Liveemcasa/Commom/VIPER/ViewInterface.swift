//
//  ViewInterface.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 04/04/20.
//  Copyright © 2020 Daniel Maia dos Passos. All rights reserved.
//

import Foundation
import UIKit

protocol ViewInterface: class {
  func fullScreenLoading(hide: Bool)
  func fullScreenLoading(hide: Bool, height: CGFloat?)
}

extension ViewInterface where Self: UIViewController {
  
  func fullScreenLoading(hide: Bool) {
    fullScreenLoading(hide: hide, height: nil)
  }
  
  func fullScreenLoading(hide: Bool, height: CGFloat?) {

    let tag = 99
    if hide {
      for views in self.view.subviews where views.tag == tag {
        for activity in views.subviews where activity is UIActivityIndicatorView {
          views.removeFromSuperview()
        }
      }
    } else {
      let screenSize = UIScreen.main.bounds
      let screenWidth = screenSize.width
      let screenHeight = height ?? screenSize.height
      let view = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight))
      view.backgroundColor = UIColor.white
      view.tag = tag

      let activityIndicator = UIActivityIndicatorView()
      
      activityIndicator.startAnimating()
      activityIndicator.style = .large
      activityIndicator.color = UIColor.black
      view.addSubview(activityIndicator)
      
      activityIndicator.center =  view.center
      
      self.view.addSubview(view)
    }
  }
  
  func showConnectionErrorAlert() {
    let alert = UIAlertController(title: "Did you bring your towel?", message: "It's recommended you bring your towel before continuing.", preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

    self.present(alert, animated: true)
  }
}
