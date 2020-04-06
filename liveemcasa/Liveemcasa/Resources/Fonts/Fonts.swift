//
//  Fonts.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 05/04/20.
//  Copyright © 2020 Daniel Maia dos Passos. All rights reserved.
//

import Foundation

enum Fonts {
  
  case montserratReg
  case montserratBold
  case montserratExtraBold
  case montserratLight
  case montserratMedium
  case montserratSemiBold

  var name:String {
    
    switch self {
      
    case .montserratBold:
      return "Montserrat-Bold"
      
    case .montserratReg:
      return "Montserrat-Regular"
      
    case .montserratExtraBold:
      return "Montserrat-ExtraBold"

    case .montserratLight:
      return "Montserrat-Light"
      
    case .montserratMedium:
      return "Montserrat-Medium"
      
    case .montserratSemiBold:
      return "Montserrat-SemiBold"
    }
  }
}
