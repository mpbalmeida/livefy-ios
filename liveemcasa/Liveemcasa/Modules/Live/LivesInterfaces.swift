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
  
  // CollectionView
  func numberOfItems() -> Int
  func cell(for collectionView: UICollectionView, at index: IndexPath) -> UICollectionViewCell
  
}

protocol LivesInteractorInterface: InteractorInterface {
}
