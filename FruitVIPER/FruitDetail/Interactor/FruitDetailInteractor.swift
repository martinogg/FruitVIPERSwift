//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

class FruitDetailInteractor: FruitDetailInteractorInputProtocol
{
    weak var presenter: FruitDetailInteractorOutputProtocol?
    var apiDataManager: APIDataManagerInputProtocol?
    
    init() {}
    
    func finishedLoading(startedAt: Double) {
        let timeElapsed = Int((Date.init().timeIntervalSince1970 - startedAt) * 1000.0)
        apiDataManager?.sendEventDisplay(time: timeElapsed)
    }
}
