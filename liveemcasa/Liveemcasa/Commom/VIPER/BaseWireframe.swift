//
//  BaseWireframe.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 04/04/20.
//  Copyright © 2020 Daniel Maia dos Passos. All rights reserved.
//

import Foundation
import UIKit

enum Transition {
  case root
  case push
}

protocol WireframeInterface: class {
  func popToRoot(_ animated: Bool)
  func popToViewController(viewController: UIViewController, animated: Bool)
  func popFromNavigationController(animated: Bool)
  func dismiss(animated: Bool)
}


class BaseWireframe {
  
  weak var navigationController: UINavigationController!
  weak private var popGesture: UIGestureRecognizer?
  private var transition = CATransition()
    
  required init(navigationController: UINavigationController) {
    self.navigationController = navigationController
    
    if let gesture = self.popGesture {
      self.navigationController!.view.addGestureRecognizer(gesture)
    }
  }
  
  fileprivate func removePopGesture() {
    if navigationController!.responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) {
      self.popGesture = navigationController!.interactivePopGestureRecognizer
      self.navigationController!.view.removeGestureRecognizer(navigationController!.interactivePopGestureRecognizer!)
    }
  }
  
  func show(_ viewController: UIViewController, with transition: Transition, animated: Bool) {
    switch transition {
      
    case .push:
      navigationController.pushViewController(viewController, animated: animated)
      removePopGesture()
      
    case .root:
      navigationController.setViewControllers([viewController], animated: animated)
    }
  }
}

extension BaseWireframe: WireframeInterface {
  func popToRoot(_ animated: Bool) {
    _ = navigationController.popToRootViewController(animated: animated)
  }

  func popToViewController(viewController: UIViewController, animated: Bool) {
    _ = navigationController.popToViewController(viewController, animated: animated)
  }

  func popFromNavigationController(animated: Bool) {
    _ = navigationController.popViewController(animated: animated)
  }

  func dismiss(animated: Bool) {
    if navigationController != nil {
      navigationController.dismiss(animated: animated)
    }
  }
}
