//
//  FruitListInteractorTests.swift
//  FruitVIPERTests
//
//  Created by martin ogg on 07/02/2018.
//  Copyright © 2018 martinogg. All rights reserved.
//

import XCTest
@testable import FruitVIPER

class FruitListInteractorTests: XCTestCase {
    
    let interactorToTest = FruitListInteractor()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    class MockAPIDataManager: APIDataManagerInputProtocol {
        func sendEventDisplay(time: Int) { }
        
        var willFail = false
        var successFruit: [Fruit]
        
        init(successFruit: [Fruit]) {
            self.successFruit = successFruit
        }
        
        func getOnlineData(onSuccess: @escaping (([Fruit]) -> ()), onFail: @escaping ((Error) -> ())) {
            if willFail {
                onFail(NSError.init(domain: "Error", code: 1, userInfo: nil))
            } else {
                onSuccess(successFruit)
            }
        }
    }
    
    class MockPresenter: FruitListInteractorOutputProtocol {
        var showFruitCallback: ((_ fruit: [Fruit]) -> ())?
        var showErrorCallback: ((_ error: Error) -> ())?
        
        func show(fruit: [Fruit]) {
            showFruitCallback?(fruit)
        }
        
        func show(error: Error) {
            showErrorCallback?(error)
        }
    }
    
    func testGetOnlineDataSuccess() {
        
        let fruitToTest = [Fruit(fruitname: "1", price: 1, weight: 1), Fruit(fruitname: "2", price: 2, weight: 2)]
        let apiDataManager = MockAPIDataManager(successFruit: fruitToTest)
        interactorToTest.apiDataManager = apiDataManager
        
        let presenter = MockPresenter()
        
        interactorToTest.presenter = presenter
        
        let successExpectation = expectation(description: "FruitList Interactor getOnlineData Success")
        
        presenter.showFruitCallback = { fruit in
            successExpectation.fulfill()
            XCTAssert(fruit == fruitToTest)
        }
        
        presenter.showErrorCallback = { error in
            XCTFail("Should not fail")
        }
        
        apiDataManager.willFail = false
            
        interactorToTest.getOnlineData()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetOnlineDataFail() {
        let fruitToTest = [Fruit(fruitname: "1", price: 1, weight: 1), Fruit(fruitname: "2", price: 2, weight: 2)]
        let apiDataManager = MockAPIDataManager(successFruit: fruitToTest)
        interactorToTest.apiDataManager = apiDataManager
        
        let presenter = MockPresenter()
        
        interactorToTest.presenter = presenter
        
        let failExpectation = expectation(description: "FruitList Interactor getOnlineData Fail")
        
        presenter.showFruitCallback = { fruit in
            XCTFail("Should not succeed")
        }
        
        presenter.showErrorCallback = { error in
            failExpectation.fulfill()
        }
        
        apiDataManager.willFail = true
        
        interactorToTest.getOnlineData()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
