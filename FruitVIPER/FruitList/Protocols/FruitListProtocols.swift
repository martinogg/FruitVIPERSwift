//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

protocol FruitListViewProtocol: class
{
    var presenter: FruitListPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
    func pushFruitDetailsView(for fruit: Fruit)
    func show(fruit: [Fruit])
    func show(error: Error)
}

protocol FruitListWireFrameProtocol: class
{
    static func attachVIPERClasses(to view: FruitListViewProtocol)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
}

protocol FruitListPresenterProtocol: class
{
    var view: FruitListViewProtocol? { get set }
    var interactor: FruitListInteractorInputProtocol? { get set }
    var wireFrame: FruitListWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    var selectedFruit: Fruit? {get set}
    var startTime: Double {get set}
    
    func viewDidLoad()
    func selected(fruit: Fruit)
    func refreshData()
}

protocol FruitListInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
    func show(fruit: [Fruit])
    func show(error: Error)
}

protocol FruitListInteractorInputProtocol: class
{
    var presenter: FruitListInteractorOutputProtocol? { get set }
    var apiDataManager: APIDataManagerInputProtocol? { get set }
    var localDatamanager: FruitListLocalDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    func getOnlineData()
}

protocol FruitListDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
}

protocol FruitListLocalDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
}
