//
//  Band.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 04/04/20.
//  Copyright © 2020 Daniel Maia dos Passos. All rights reserved.
//

import Mapper
 
struct Band: Mappable, Decodable {
  var id: Int = 0
  var name: String = ""
  var bucketFile: BucketFile // = BucketFile()
  
  init(map: Mapper) throws {
    try id = map.from("id")
    try name = map.from("name")
    try bucketFile = map.from("bucketFile")
  }
}

struct BucketFile: Mappable, Decodable {
  let id: Int
  var preSignedUrl: String = ""

  init(map: Mapper) throws {
    try id = map.from("id")
    try preSignedUrl = map.from("preSignedUrl")
  }
}
