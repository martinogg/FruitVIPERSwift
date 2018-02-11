//
//  FruitAPIResponse.swift
//  FruitVIPER
//
//  Created by martin ogg on 07/02/2018.
//  Copyright © 2018 martinogg. All rights reserved.
//

import Foundation
import ObjectMapper

class FruitAPIResponse: Mappable {
    var fruit: [Fruit]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        fruit <- map["fruit"]
    }
}
