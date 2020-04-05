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
  
  // MARK: - Class properties
  
  private let columnLayout = ColumnFlowLayout(
    cellsPerRow: 2,
    height: 250,
    minimumInteritemSpacing: 12,
    minimumLineSpacing: 12,
    sectionInset: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
  )
  
  // MARK: - Public properties
  
  private var presenter: LivesPresenterInterface!

  // MARK: - Life Cycle -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let interactor = LivesInteractor()
    presenter = LivesPresenter(view: self, interactor: interactor)
    
    viewConfiguration()
    collectionConfiguration()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Class Configurations
  
  private func viewConfiguration() {
    self.title = presenter.getTitle()
    presenter.viewConfiguration()
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
    collectionView.isHidden = show
  }
}

