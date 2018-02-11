//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

class FruitListWireFrame: FruitListWireFrameProtocol
{
    static func attachVIPERClasses(to view: FruitListViewProtocol) {
        let presenter: FruitListPresenterProtocol & FruitListInteractorOutputProtocol = FruitListPresenter()
        let interactor: FruitListInteractorInputProtocol = FruitListInteractor()
        let apiDataManager: APIDataManagerInputProtocol = APIDataManager()
        let localDataManager: FruitListLocalDataManagerInputProtocol = FruitListLocalDataManager()
        let wireFrame: FruitListWireFrameProtocol = FruitListWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.apiDataManager = apiDataManager
        interactor.localDatamanager = localDataManager
    }
}
