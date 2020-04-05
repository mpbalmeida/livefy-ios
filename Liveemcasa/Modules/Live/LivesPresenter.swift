//
//  LivesPresenter.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 04/04/20.
//  Copyright (c) 2020 Daniel Maia dos Passos. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class LivesPresenter {
  
  // MARK: - Private properties -
  
  private weak var view: LivesViewInterface?
  private let interactor: LivesInteractor
  
  private var list = [Live]()
  static let cellIdentifier = "liveCell"
  
  private enum Strings {
    static let title = "Lives"
  }
  
  // MARK: - Lifecycle -
  
  init(view: LivesViewInterface,
       interactor: LivesInteractor) {
    self.view = view
    self.interactor = interactor
    
    self.interactor.response = self
  }
  
  // MARK: - Private Functions
  private func bindLives(lives: [Live]) {
    list = lives
    view?.showProgress(show: false)
    view?.updateTableView()
  }
  
}

// MARK: - Extensions -

extension LivesPresenter: LivesPresenterInterface {
  
  func getTitle() -> String {
    return Strings.title
  }
  
  func viewConfiguration() {
    view?.showProgress(show: true)
    self.interactor.getLives()
  }
  
  func cellForRowAt(index: IndexPath, tableView: UITableView) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: LivesPresenter.cellIdentifier, for: index) as? LivesTableViewCell
      else {
        return UITableViewCell()
    }
    
    cell.selectionStyle = .none
    cell.configCell(live: self.list[index.row])
    
    return cell
  }
  
  func numberOfRowsInSection(section: Int) -> Int {
    return list.count
  }
  
  func numberOfSections() -> Int {
    return 1
  }
  
  func heightForRowAt(index: IndexPath, tableView: UITableView) -> CGFloat {
    return 200.0
  }
  
  func didSelectRowAt(index: IndexPath) {
    
  }
}

extension LivesPresenter: GetLivesInteractorProtocol {
  func getLivesSuccess(success: [Live]) {
    self.bindLives(lives: success)
  }
  
  func getLivesError(error: Error) {
    
  }
  
  
}

