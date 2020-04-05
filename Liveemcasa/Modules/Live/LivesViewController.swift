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
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Class properties
  
  // MARK: - Public properties
  
  private var presenter: LivesPresenterInterface!

  // MARK: - Life Cycle -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let interactor = LivesInteractor()
    presenter = LivesPresenter(view: self, interactor: interactor)
    
    viewConfiguration()
    tableViewConfiguration()
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
  
  private func tableViewConfiguration() {
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.allowsSelection = true
    
    tableView.register(LivesTableViewCell.nib(), forCellReuseIdentifier: LivesPresenter.cellIdentifier)
  }
  
  // MARK: - UIActions
  
}

// MARK: - Extensions

extension LivesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.numberOfRowsInSection(section: section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return presenter.cellForRowAt(index: indexPath, tableView: tableView)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return presenter.heightForRowAt(index: indexPath, tableView: tableView)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter.didSelectRowAt(index: indexPath)
  }
}

extension LivesViewController: UITableViewDelegate {
}

extension LivesViewController: LivesViewInterface {
  func updateTableView() {
    tableView.reloadData()
  }
  
  func showProgress(show: Bool) {
    tableView.isHidden = show
  }
}

