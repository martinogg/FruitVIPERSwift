//
//  CommonProtocols.swift
//  FruitVIPER
//
//  Created by martin ogg on 08/02/2018.
//  Copyright © 2018 martinogg. All rights reserved.
//

import Foundation

protocol APIDataManagerInputProtocol: class
{
    /**
     * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
     */
    func getOnlineData(onSuccess: @escaping (([Fruit]) -> ()), onFail: @escaping ((Error) -> ()))
    func sendEventDisplay(time: Int)
}
