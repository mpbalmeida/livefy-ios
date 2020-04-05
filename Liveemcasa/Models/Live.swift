//
//  Live.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 04/04/20.
//  Copyright © 2020 Daniel Maia dos Passos. All rights reserved.
//

import Mapper
 
struct Live: Mappable, Decodable {
  var id: Int = 0
  var name: String = ""
  var description: String = ""
  var link: String = ""
  var socialMedia: String = ""
  var category: String = ""
  var bands: [Band] = []
  
  init(map: Mapper) throws {
    try id = map.from("id")
    try name = map.from("name")
    try description = map.from("description")
    try link = map.from("link")
    try socialMedia = map.from("socialMedia")
    try category = map.from("category")
    try bands = map.from("bands") 
  }
}
