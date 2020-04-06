//
//  NetworkManager.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 05/04/20.
//  Copyright © 2020 Daniel Maia dos Passos. All rights reserved.
//

import Foundation

class NetworkManager {

  private let manager = NetworkReachabilityManager(host: "m.google.com")

  static let shared: NetworkManager = {
    let instance = NetworkManager()
    return instance
  }()

  func isInternetAvailable() -> Bool {
    guard let manager = self.manager else { return false }
    return manager.isReachable
  }

  func listener(_ callback: @escaping (NetworkingStatus) -> Void) {
    manager?.listener = { status in
      callback(status)
    }
  }

  func setupReachability() {
    manager?.startListening()
  }
}
