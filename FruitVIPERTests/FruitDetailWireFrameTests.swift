//
//  FruitDetailWireFrameTests.swift
//  FruitVIPERTests
//
//  Created by martin ogg on 07/02/2018.
//  Copyright © 2018 martinogg. All rights reserved.
//

import XCTest
@testable import FruitVIPER

class FruitDetailWireFrameTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAttachVIPERClasses() {
        let view = FruitDetailView()
        let fruit = Fruit()
        let startTime: Double = 2.0
        
        FruitDetailWireFrame.attachVIPERClasses(to: view, with: fruit, startTime: startTime)
        
        XCTAssert(view.presenter != nil)
        guard let presenter = view.presenter else {
            XCTFail()
            return
        }
        
        XCTAssert(presenter.fruit == fruit)
        XCTAssert(presenter.startTime == startTime)
        XCTAssert(presenter.view === view)
        XCTAssert(presenter.wireFrame is FruitDetailWireFrame)
        XCTAssert(presenter.interactor is FruitDetailInteractor)
        
        guard let interactor = presenter.interactor else {
            XCTFail()
            return
        }
        
        XCTAssert(interactor.presenter === presenter)
        XCTAssert(interactor.apiDataManager is APIDataManager)
    }
}
