//
//  LivesInteractor.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 04/04/20.
//  Copyright (c) 2020 Daniel Maia dos Passos. All rights reserved.
//
//

import Foundation
import Moya
import Mapper

protocol GetLivesInteractorProtocol {
  func getLivesSuccess(success: [Live])
  func getLivesError(error: Error)
}

final class LivesInteractor {
  
  private let provider = MoyaProvider<LiveService>()
  
  // MARK: - Response Protocol

  var response: GetLivesInteractorProtocol?
  
  init() {}
  
  func getLives() {
    provider.request(.getLives) {result in

      switch result {
      case .success(let response):
        do {
          let filteredResponse = try response.filterSuccessfulStatusCodes()
          let lives = try filteredResponse.map(LiveResponse.self)
          print(lives)
          self.response?.getLivesSuccess(success: lives.lives)
        } catch {
          print(error.localizedDescription)
          self.response?.getLivesError(error: CustomErros.badResponse)
        }
      case .failure:
        self.response?.getLivesError(error: CustomErros.badResponse)
      }
    }
  }
}

// MARK: - Extensions -

extension LivesInteractor: LivesInteractorInterface {
}


