//
//  Fruit.swift
//  FruitVIPER
//
//  Created by martin ogg on 07/02/2018.
//  Copyright © 2018 martinogg. All rights reserved.
//

import Foundation
import ObjectMapper

struct Fruit {
    var fruitname = ""
    var price: Int = 0
    var weight: Int = 0
}

extension Fruit: Equatable {
    static func ==(lhs: Fruit, rhs: Fruit) -> Bool {
        return ( (lhs.fruitname == rhs.fruitname) &&
                 (lhs.price == rhs.price) &&
                 (lhs.weight == rhs.weight) )
    }
}

extension Fruit: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        fruitname     <- map["fruitname"]
        price     <- map["price"]
        weight     <- map["weight"]
    }
    
}
