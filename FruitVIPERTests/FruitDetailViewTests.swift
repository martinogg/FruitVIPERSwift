//
//  FruitDetailViewTests.swift
//  FruitVIPERTests
//
//  Created by martin ogg on 08/02/2018.
//  Copyright © 2018 martinogg. All rights reserved.
//

import XCTest
@testable import FruitVIPER

class FruitDetailViewTests: XCTestCase {
    
    let viewToTest = FruitDetailView()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    class MockPresenter: FruitDetailPresenterProtocol {
        var view: FruitDetailViewProtocol?
        var interactor: FruitDetailInteractorInputProtocol?
        var wireFrame: FruitDetailWireFrameProtocol?
        var fruit: Fruit?
        var startTime: Double = 0
        
        var viewDidLoadCalled = false
        func viewDidLoad() {
            viewDidLoadCalled = true
        }
    }
    
    func testViewDidLoad() {
        
        let presenter = MockPresenter()
        viewToTest.presenter = presenter
        
        viewToTest.viewDidLoad()
        
        XCTAssert(presenter.viewDidLoadCalled == true)
        
    }
    
    func testShowFruit() {
        let testFruit = Fruit(fruitname: "1", price: 1, weight: 1)
        
        let testText = "Fruit: \(testFruit.fruitname)\nPrice: \(testFruit.price)\nWeight: \(testFruit.weight)"
        
        let testLabel = UILabel()
        
        viewToTest.fruitDescription = testLabel
        
        viewToTest.show(fruit: testFruit)
        
        let setText = testLabel.text ?? "Error"
        
        XCTAssert(setText == testText)
    }
}
