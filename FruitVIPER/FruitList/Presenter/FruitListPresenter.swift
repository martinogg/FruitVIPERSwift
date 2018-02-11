//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

class FruitListPresenter: FruitListPresenterProtocol, FruitListInteractorOutputProtocol
{
    var selectedFruit: Fruit?
    var startTime: Double = 0
    
    weak var view: FruitListViewProtocol?
    var interactor: FruitListInteractorInputProtocol?
    var wireFrame: FruitListWireFrameProtocol?
    
    init() {}
    
    func viewDidLoad() {
        interactor?.getOnlineData()
    }
    
    func selected(fruit: Fruit) {
        view?.pushFruitDetailsView(for: fruit)
    }
    
    func show(fruit: [Fruit]) {
        view?.show(fruit: fruit)
    }
    
    func show(error: Error) {
        view?.show(error: error)
    }
    
    func refreshData() {
        interactor?.getOnlineData()
    }
}
