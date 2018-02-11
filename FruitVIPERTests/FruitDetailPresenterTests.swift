//
//  FruitDetailPresenterTests.swift
//  FruitVIPERTests
//
//  Created by martin ogg on 08/02/2018.
//  Copyright © 2018 martinogg. All rights reserved.
//

import XCTest
@testable import FruitVIPER

class FruitDetailPresenterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    class MockView: FruitDetailViewProtocol {
        var presenter: FruitDetailPresenterProtocol?
        
        var showCallback: ((Fruit)->())?
        
        func show(fruit: Fruit) {
            showCallback?(fruit)
        }
    }
    
    class MockInteractor: FruitDetailInteractorInputProtocol {
        var presenter: FruitDetailInteractorOutputProtocol?
        
        var apiDataManager: APIDataManagerInputProtocol?
        
        var finishedLoadingCallback: ((Double)->())?
        func finishedLoading(startedAt: Double) {
            finishedLoadingCallback?(startedAt)
        }
        
    }
    
    func testViewDidLoad() {
        let presenterToTest = FruitDetailPresenter()
        
        let testStartedAtTime: Double = 2233
        presenterToTest.startTime = testStartedAtTime
        
        let view = MockView()
        presenterToTest.view = view
        
        let finishedLoadingCallbackExpectation = expectation(description: "finishedLoadingCallbackExpectation")
        
        let interactor = MockInteractor()
        
        presenterToTest.interactor = interactor
        
        interactor.finishedLoadingCallback = { startedAt in
            finishedLoadingCallbackExpectation.fulfill()
            XCTAssert(startedAt == testStartedAtTime)
        }
        
        let testFruit = Fruit(fruitname: "1", price: 1, weight: 1)
        let showCallbackExpectation = expectation(description: "showCallbackExpectation")
        
        presenterToTest.fruit = testFruit
        
        view.showCallback = { fruit in
            showCallbackExpectation.fulfill()
            XCTAssert(fruit == testFruit)
        }
        presenterToTest.viewDidLoad()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
