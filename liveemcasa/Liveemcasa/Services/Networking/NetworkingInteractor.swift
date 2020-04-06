//
//  NetworkingInteractor.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 05/04/20.
//  Copyright © 2020 Daniel Maia dos Passos. All rights reserved.
//

import Foundation

typealias NetworkingStatus = NetworkReachabilityManager.NetworkReachabilityStatus

protocol NetworkingInteractorProtocols {
  func check()
  func registerListener()
}

protocol NetworkingInteractorResponse {
  func networkingAvailable()
  func networkingNotAvailable()
}

protocol NetworkingListenerResponse {
  func networkingStatusChanged(status: NetworkingStatus)
}

class NetworkingInteractor {
  var response: NetworkingInteractorResponse?
  var listener: NetworkingListenerResponse?
}

extension NetworkingInteractor: NetworkingInteractorProtocols {
  func registerListener() {
    NetworkManager.shared.listener { status in
      self.listener?.networkingStatusChanged(status: status)
    }
  }
  
  func check() {
    if NetworkManager.shared.isInternetAvailable() {
      response?.networkingAvailable()
    } else {
      response?.networkingNotAvailable()
    }
  }
}
