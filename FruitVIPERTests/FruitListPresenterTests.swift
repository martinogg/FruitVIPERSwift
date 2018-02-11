//
//  FruitListPresenterTests.swift
//  FruitVIPERTests
//
//  Created by martin ogg on 07/02/2018.
//  Copyright © 2018 martinogg. All rights reserved.
//

import XCTest
@testable import FruitVIPER

class FruitListPresenterTests: XCTestCase {
    
    let presenterToTest = FruitListPresenter()
    let testFruit = [Fruit(fruitname: "1", price: 1, weight: 1), Fruit(fruitname: "2", price: 2, weight: 2)]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    class MockInteractor: FruitListInteractorInputProtocol {
        
        func getOnlineData() {
            getOnlineDataCalled = true
        }
        
        var presenter: FruitListInteractorOutputProtocol?
        
        var apiDataManager: APIDataManagerInputProtocol?
        
        var localDatamanager: FruitListLocalDataManagerInputProtocol?
        
        var getOnlineDataCalled = false
        
    }
    
    class MockView: FruitListViewProtocol {
        var presenter: FruitListPresenterProtocol?
        
        var showFruitCallback: (([Fruit])->())?
        var showErrorCallback: ((Error)->())?
        
        var pushFruitDetailsViewCallBack: ((Fruit)->())?
        func pushFruitDetailsView(for fruit: Fruit) {
            pushFruitDetailsViewCallBack?(fruit)
        }
        
        func show(fruit: [Fruit]) {
            showFruitCallback?(fruit)
        }
        
        func show(error: Error) {
            showErrorCallback?(error)
        }
        
        
    }
    
    func testViewDidLoad() {
        
        let interactor = MockInteractor()
        presenterToTest.interactor = interactor
        
        presenterToTest.viewDidLoad()
        XCTAssert(interactor.getOnlineDataCalled == true)
    }
    
    func testShowFruit() {
        let view = MockView()
        let showFruitExpectation = expectation(description: "testShowFruit")
        
        presenterToTest.view = view
        
        view.showFruitCallback = { [unowned self] fruit in
            showFruitExpectation.fulfill()
            XCTAssert(self.testFruit == fruit)
        }
        
        presenterToTest.show(fruit: testFruit)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testShowError() {
        let view = MockView()
        let testError: Error = NSError(domain: "AnError", code: 1, userInfo: nil)
        let showErrorExpectation = expectation(description: "testShowError")
        
        presenterToTest.view = view
        
        view.showErrorCallback = { error in
            showErrorExpectation.fulfill()
            XCTAssert(testError.localizedDescription == error.localizedDescription)
        }
        
        presenterToTest.show(error: testError)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSelectedFruit() {
        let view = MockView()
        let callbackExpectation = expectation(description: "pushFruitDetailsViewCallBack")
        view.pushFruitDetailsViewCallBack = { [unowned self] fruit in
            callbackExpectation.fulfill()
            XCTAssert(fruit == self.testFruit[1])
        }
        presenterToTest.view = view
        
        presenterToTest.selected(fruit: testFruit[1])
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testRefreshData() {
        let interactor = MockInteractor()
        presenterToTest.interactor = interactor
        
        presenterToTest.refreshData()
        XCTAssert(interactor.getOnlineDataCalled == true)
    }
}
