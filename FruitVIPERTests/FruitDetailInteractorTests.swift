//
//  FruitDetailInteractorTests.swift
//  FruitVIPERTests
//
//  Created by martin ogg on 08/02/2018.
//  Copyright © 2018 martinogg. All rights reserved.
//

import XCTest
@testable import FruitVIPER

class FruitDetailInteractorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    class MockAPIDataManager: APIDataManagerInputProtocol {
        func getOnlineData(onSuccess: @escaping (([Fruit]) -> ()), onFail: @escaping ((Error) -> ())) { }
        
        var sendEventDisplayCallback: ((Int)->())?
        
        func sendEventDisplay(time: Int) {
            sendEventDisplayCallback?(time)
        }
    }
    
    func testFinishedLoading() {
        let interatorToTest = FruitDetailInteractor()
        let mockAPIDataManager = MockAPIDataManager()
        interatorToTest.apiDataManager = mockAPIDataManager
        
        let displayCallbackExpectation = expectation(description: "displayCallbackExpectation")
        
        mockAPIDataManager.sendEventDisplayCallback = {timeElapsed in
            displayCallbackExpectation.fulfill()
            XCTAssert(timeElapsed > 0)
        }
        
        interatorToTest.finishedLoading(startedAt: 0.0)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
