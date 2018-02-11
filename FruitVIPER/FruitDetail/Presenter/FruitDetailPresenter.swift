//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

class FruitDetailPresenter: FruitDetailPresenterProtocol, FruitDetailInteractorOutputProtocol
{
    var fruit: Fruit?
    var startTime: Double = 0.0
    
    weak var view: FruitDetailViewProtocol?
    var interactor: FruitDetailInteractorInputProtocol?
    var wireFrame: FruitDetailWireFrameProtocol?
    
    init() {}
    
    func viewDidLoad() {
        if let fruit = self.fruit {
            view?.show(fruit: fruit)
        }
        interactor?.finishedLoading(startedAt: startTime)
    }
}
