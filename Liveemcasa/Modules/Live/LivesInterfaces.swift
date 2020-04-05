//
//  LivesInterfaces.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 04/04/20.
//  Copyright (c) 2020 Daniel Maia dos Passos. All rights reserved.
//
//

import UIKit

enum LivesNavigationOption {
}

protocol LivesWireframeInterface: WireframeInterface {
  func navigate(to option: LivesNavigationOption)
}

protocol LivesViewInterface: ViewInterface {
  func updateTableView()
  func showProgress(show: Bool)
}

protocol LivesPresenterInterface: PresenterInterface {
  func getTitle() -> String
  func viewConfiguration()
  
  // TableView
  func cellForRowAt(index: IndexPath, tableView: UITableView) -> UITableViewCell
  func numberOfRowsInSection(section: Int) -> Int
  func numberOfSections() -> Int
  func heightForRowAt(index: IndexPath, tableView: UITableView ) -> CGFloat
  func didSelectRowAt(index: IndexPath)
  
}

protocol LivesInteractorInterface: InteractorInterface {
}
