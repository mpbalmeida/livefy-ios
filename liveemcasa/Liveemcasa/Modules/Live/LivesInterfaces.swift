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
  case showConnectionErrorAlert
  case showErrorAlert
  case goToDetails
  case openUrlLive(urlLive: String)
}

protocol LivesWireframeInterface: WireframeInterface {
  func navigate(to option: LivesNavigationOption)
}

protocol LivesViewInterface: ViewInterface {
  func updateTableView()
  func showProgress(show: Bool)
  func showPlaceholderScreenError()
}

protocol LivesPresenterInterface: PresenterInterface {
  func getTitle() -> String
  func callService()
  
  // CollectionView
  func numberOfItems() -> Int
  func cell(for collectionView: UICollectionView, at index: IndexPath) -> UICollectionViewCell
  func didSelectItemAt(_ collectionView: UICollectionView, indexPath: IndexPath)
  
}

protocol LivesInteractorInterface: InteractorInterface {
}
