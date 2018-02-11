//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

protocol FruitDetailViewProtocol: class
{
    var presenter: FruitDetailPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
    func show(fruit: Fruit)
}

protocol FruitDetailWireFrameProtocol: class
{
    static func attachVIPERClasses(to view: FruitDetailViewProtocol, with fruit: Fruit, startTime: Double)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
}

protocol FruitDetailPresenterProtocol: class
{
    var view: FruitDetailViewProtocol? { get set }
    var interactor: FruitDetailInteractorInputProtocol? { get set }
    var wireFrame: FruitDetailWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    var fruit: Fruit? {get set}
    var startTime: Double {get set}
    func viewDidLoad()
}

protocol FruitDetailInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
}

protocol FruitDetailInteractorInputProtocol: class
{
    var presenter: FruitDetailInteractorOutputProtocol? { get set }
    var apiDataManager: APIDataManagerInputProtocol? { get set }
    
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    func finishedLoading(startedAt: Double)
}

protocol FruitDetailDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
}
