//
//  FruitListWireFrameTests.swift
//  FruitVIPERTests
//
//  Created by martin ogg on 07/02/2018.
//  Copyright © 2018 martinogg. All rights reserved.
//

import XCTest
@testable import FruitVIPER

class FruitListWireFrameTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAttachVIPERClasses() {
        let viewForResult = FruitListView()
        FruitListWireFrame.attachVIPERClasses(to: viewForResult)
        
        XCTAssert(viewForResult.presenter is FruitListPresenter)
        guard let presenterToTest = viewForResult.presenter else {
            XCTFail()
            return
        }
        
        XCTAssert(presenterToTest.interactor is FruitListInteractor)
        XCTAssert(presenterToTest.wireFrame is FruitListWireFrame)
        XCTAssert(presenterToTest.view === viewForResult)
        
        guard let interactorToTest = presenterToTest.interactor else {
            XCTFail()
            return
        }
        
        XCTAssert(interactorToTest.presenter === presenterToTest)
        XCTAssert(interactorToTest.apiDataManager is APIDataManager)
        XCTAssert(interactorToTest.localDatamanager is FruitListLocalDataManager)
        
    }
    
}
