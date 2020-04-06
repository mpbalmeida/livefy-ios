//
//  PresenterInterface.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 04/04/20.
//  Copyright © 2020 Daniel Maia dos Passos. All rights reserved.
//

import Foundation

protocol PresenterInterface: class {

}

extension PresenterInterface {
  
  var networking: NetworkingInteractor {
    let interactor = NetworkingInteractor()
    interactor.response = self as? NetworkingInteractorResponse
    interactor.listener = self as? NetworkingListenerResponse
    return interactor
  }

}
