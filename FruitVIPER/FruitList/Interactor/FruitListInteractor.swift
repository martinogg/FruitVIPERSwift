//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

class FruitListInteractor: FruitListInteractorInputProtocol
{
    weak var presenter: FruitListInteractorOutputProtocol?
    var apiDataManager: APIDataManagerInputProtocol?
    var localDatamanager: FruitListLocalDataManagerInputProtocol?
    
    init() {}
    
    func getOnlineData() {
        apiDataManager?.getOnlineData(onSuccess: { [unowned self] (fruit) in
            self.presenter?.show(fruit: fruit)
        }, onFail: { [unowned self] (error) in
            self.presenter?.show(error: error)
        })  
    }
}
