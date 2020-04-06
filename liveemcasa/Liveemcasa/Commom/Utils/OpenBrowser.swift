//
//  OpenBrowser.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 05/04/20.
//  Copyright © 2020 Daniel Maia dos Passos. All rights reserved.
//

import Foundation
import UIKit

class OpenBrowser {
  
  static let sharedInstance = OpenBrowser()
  
  private init() { }
  
  // MARK: - Public functions
  
  /// Configure actionSheet, all parameters are optional and only parameters with values will be shown
  ///
  /// - Parameters:
  ///   - title: title of actionSheet. Can be nil
  ///   - message: subtitle of actionSheet. Can be nil
  ///   - url: url of actionSheet. Can be nil
  func openBrowser(viewController : UIViewController, title : String, message : String, url: String) {
    
    let sharedApplication = UIApplication.shared
    
    let alert = UIAlertController(title: title,
                                  message: message,
                                  preferredStyle: .actionSheet)
    
    let safariURL = URL(string: url) //URL(string: String(format: "https://%@", url))
    /* let chromeURL = URL(string: String(format: "googlechrome://%@", url))
    let operaURL  = URL(string: String(format: "opera-http://%@", url)) */
    
    let safariAction = UIAlertAction(title: "Safari", style: .default) { (_) in
      UIApplication.shared.open(safariURL!, options: [:], completionHandler: nil)
    }
    /* let googleChromeAction = UIAlertAction(title: "Google Chrome", style: .default) { (_) in
      UIApplication.shared.open(chromeURL!, options: [:], completionHandler: nil)
    }
    let operaAction = UIAlertAction(title: "Opera", style: .default) { (_) in
      UIApplication.shared.open(operaURL!, options: [:], completionHandler: nil)
    } */
    let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { (_) in }
    
    if sharedApplication.canOpenURL(safariURL!) {
      alert.addAction(safariAction)
    }
    /*if sharedApplication.canOpenURL(chromeURL!) {
      alert.addAction(googleChromeAction)
    }
    if sharedApplication.canOpenURL(operaURL!) {
      alert.addAction(operaAction)
    } */

    alert.addAction(cancelAction)
    
    viewController.present(alert, animated: true, completion: nil)
  }
}
