//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

class FruitDetailWireFrame: FruitDetailWireFrameProtocol
{
    static func attachVIPERClasses(to view: FruitDetailViewProtocol, with fruit: Fruit, startTime: Double) {
        
        let presenter = FruitDetailPresenter()
        presenter.fruit = fruit
        presenter.startTime = startTime
        view.presenter = presenter
        view.presenter?.view = view
        view.presenter?.wireFrame = FruitDetailWireFrame()
        let interactor = FruitDetailInteractor()
        interactor.apiDataManager = APIDataManager()
        view.presenter?.interactor = interactor
        view.presenter?.interactor?.presenter = presenter
        
    }

}
