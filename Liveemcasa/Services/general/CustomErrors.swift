//
//  CustomErrors.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 04/04/20.
//  Copyright © 2020 Daniel Maia dos Passos. All rights reserved.
//

import Foundation

enum CustomErros: Error {
  
  case providerParse
  case timeout
  case badResponse
  case noInternetConnection
  case invalidSession
  case invalidUser
  case invalidEmail
  case touchIDNotConfig
  case unexpected
  case invalidToken

  var unexpectedError: String {
    switch self {
    case .providerParse,
         .timeout,
         .badResponse,
         .invalidEmail,
         .invalidUser,
         .noInternetConnection,
         .touchIDNotConfig,
         .invalidSession,
         .unexpected,
         .invalidToken:
      return Constants.Strings.unexpectedError
    }
  }
  
  // MARK: - Get Description
  var desc: String {
    
    switch self {
    case .providerParse:
      return "Não foi possível realizar o parse do objeto."
    case .timeout, .badResponse:
      return "Não foi possível estabelecer uma conexão com os nossos servidores."
    case .noInternetConnection:
      return "Você está sem conexão com a internet."
    case .invalidSession:
      return "A sua sessão expirou."
    case .invalidUser:
      return "Login inválido."
    case .invalidEmail:
      return "E-mail inválido."
    case .touchIDNotConfig:
      return "TouchID não configurado."
    case .invalidToken:
      return "Token de acesso inválido."
    case .unexpected:
      return Constants.Strings.unexpectedError

    }
  }

}
