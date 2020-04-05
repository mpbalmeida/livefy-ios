//
//  TypeName.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 05/04/20.
//  Copyright © 2020 Daniel Maia dos Passos. All rights reserved.
//

import Foundation

protocol TypeName: AnyObject {
  var typeName: String { get }
}

extension TypeName {
  static var typeName: String {
    return String(describing: self)
  }

  var typeName: String {
    return String(describing: type(of: self))
  }
}

extension NSObject: TypeName { }
