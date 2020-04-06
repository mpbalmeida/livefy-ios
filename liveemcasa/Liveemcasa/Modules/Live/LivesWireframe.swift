//
//  LivesWireframe.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 04/04/20.
//  Copyright (c) 2020 Daniel Maia dos Passos. All rights reserved.
//
//

import UIKit

final class LivesWireframe: BaseWireframe {
  
  // MARK: - Private properties -
  private var moduleViewController = LivesViewController(nibName: nil, bundle: nil)
  // MARK: - Module setup -
  
  func configureModule(with viewController: LivesViewController) {
    moduleViewController = viewController
    
    /*let interactor = LivesInteractor()
    let presenter = LivesPresenter(view: viewController, interactor: interactor)
    viewController.presenter = presenter */
  }
  
  // MARK: - Transitions -
  
  func show(with transition: Transition, animated: Bool = true) {
    /* configureModule(with: moduleViewController)
    show(moduleViewController, with: transition, animated: animated) */
  }
  
  // MARK: - Private Routing -
  
  private func showConnectionErrorAlert() {
  }

  private func showErrorAlert() {
    
  }
  
  private func goToDetails() {
    
  }
  
  private func openUrlLive(urlLive: String) {
    OpenBrowser.sharedInstance.openBrowser(viewController: self.moduleViewController,
                                           title: LiveStrings.titleActionSheets,
                                           message: "",
                                           url: urlLive)
  }
}

// MARK: - Extensions -

extension LivesWireframe: LivesWireframeInterface {
  
  func navigate(to option: LivesNavigationOption) {
    switch option {
    case .showConnectionErrorAlert:
      self.showConnectionErrorAlert()
    case .showErrorAlert:
      self.showErrorAlert()
    case .goToDetails:
      self.goToDetails()
    case .openUrlLive(let urlLive):
      self.openUrlLive(urlLive: urlLive)
     }
  }
}


