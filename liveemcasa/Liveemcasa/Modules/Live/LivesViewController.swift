//
//  LivesViewController.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 04/04/20.
//  Copyright (c) 2020 Daniel Maia dos Passos. All rights reserved.
//

import UIKit

final class LivesViewController: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var placeholderView: PlaceholderView!
  
  // MARK: - Class properties
  
  private let columnLayout = ColumnFlowLayout(
    cellsPerRow: 2,
    height: 250,
    minimumInteritemSpacing: 8,
    minimumLineSpacing: 8,
    sectionInset: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
  )
  
  // MARK: - Public properties
  
  private var presenter: LivesPresenterInterface!

  // MARK: - Life Cycle -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let interactor = LivesInteractor()
    let livesWireframe = LivesWireframe(navigationController: self.navigationController!)
    presenter = LivesPresenter(view: self, interactor: interactor, wireframe: livesWireframe)
    
    viewConfiguration()
    collectionConfiguration()
  }
  
  // MARK: - Class Configurations
  
  private func viewConfiguration() {
    self.title = presenter.getTitle()
    presenter.callService()
    placeholderView.delegate = self
  }
  
  // MARK: - Class Methods
  
  private func collectionConfiguration() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.collectionViewLayout = columnLayout
    collectionView.contentInsetAdjustmentBehavior = .always
    
    collectionView.register(LivesCollectionViewCell.nib, forCellWithReuseIdentifier: LivesCollectionViewCell.identifier)
  }
  
  // MARK: - UIActions
  
}

// MARK: - Extensions

extension LivesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return presenter.numberOfItems()
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return presenter.cell(for:collectionView, at:indexPath)
  }
}

extension LivesViewController: UITableViewDelegate {
}

extension LivesViewController: LivesViewInterface {
  func updateTableView() {
    collectionView.reloadData()
  }
  
  func showProgress(show: Bool) {
    placeholderView.isHidden = true
    collectionView.isHidden = show
    self.fullScreenLoading(hide: !show)
  }
  
  func showPlaceholderScreenError() {
    self.fullScreenLoading(hide: true)
    collectionView.isHidden = true
    placeholderView.isHidden = false
  }
}

extension LivesViewController: PlaceholderViewDelegate {
  func tryAgainIsPressed() {
    presenter.callService()
  }
}

