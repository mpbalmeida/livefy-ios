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
    livesWireframe.configureModule(with: self)
    presenter = LivesPresenter(view: self, interactor: interactor, wireframe: livesWireframe)
    
    viewConfiguration()
    collectionConfiguration()
  }
  
  // MARK: - Class Configurations
  
  private func viewConfiguration() {
    self.navigationItem.titleView = presenter.getTitle()
    presenter.callService(showProgress: true)
    placeholderView.delegate = self
  }
  
  // MARK: - Class Methods
  
  private func collectionConfiguration() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.collectionViewLayout = columnLayout
    collectionView.contentInsetAdjustmentBehavior = .always
    
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
    collectionView.refreshControl = refreshControl
    
    collectionView.register(LivesCollectionViewCell.nib, forCellWithReuseIdentifier: LivesCollectionViewCell.identifier)
  }
  
  @objc func refreshList(refreshControl: UIRefreshControl) {
    presenter.callService(showProgress: false)
    refreshControl.endRefreshing()
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
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    presenter.didSelectItemAt(collectionView, indexPath: indexPath)
  }
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
    presenter.callService(showProgress: true)
  }
}

