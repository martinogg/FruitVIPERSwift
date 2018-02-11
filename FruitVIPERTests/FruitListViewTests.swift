//
//  FruitListViewTests.swift
//  FruitVIPERTests
//
//  Created by martin ogg on 07/02/2018.
//  Copyright © 2018 martinogg. All rights reserved.
//

import XCTest
@testable import FruitVIPER

class FruitListViewTests: XCTestCase {
    
    let viewToTest = FruitListView()
    let testFruit = [Fruit(fruitname: "1", price: 1, weight: 1), Fruit(fruitname: "2", price: 2, weight: 2)]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    class MockPresenter: FruitListPresenterProtocol {
        
        var startTime: Double = 0
        var refreshDataCalled = false
        func refreshData() {
            refreshDataCalled = true
        }
        
        var didViewLoadCalled = false
        
        var view: FruitListViewProtocol?
        var interactor: FruitListInteractorInputProtocol?
        var wireFrame: FruitListWireFrameProtocol?
        var selectedFruit: Fruit?
        
        func viewDidLoad() {
            didViewLoadCalled = true
        }
        
        var selectedFruitCallback: ((Fruit)->())?
        func selected(fruit: Fruit) {
            selectedFruitCallback?(fruit)
        }
    }
    
    func testViewDidLoad() {
        
        let presenter = MockPresenter()
        viewToTest.presenter = presenter
        viewToTest.viewDidLoad()
        
        XCTAssert(presenter.didViewLoadCalled == true)
        XCTAssert(viewToTest.tableView.refreshControl != nil)
    }
    
    func testPrepareSegue() {
        let destinationView = FruitDetailView()
        let presenter = FruitListPresenter()
        presenter.selectedFruit = Fruit()
        viewToTest.presenter = presenter
        
        let storyboardSegue = UIStoryboardSegue.init(identifier: "segue", source: UIViewController(), destination: destinationView)

        
        viewToTest.prepare(for: storyboardSegue, sender: nil)
        
        // Other tests should be done but at least if the presenter exists, it shows VIPER attach was done. Let the WireFrame Tests check the others
        XCTAssert(destinationView.presenter != nil)
    }
    
    func testPushFruitDetailsView() {
        class FruitListViewWithPerformSegueCatch: FruitListView {
            var performSegueCalledIdentifier = ""
            
            override open func performSegue(withIdentifier identifier: String, sender: Any?) {
                performSegueCalledIdentifier = identifier
            }
        }
        
        let fruitListViewToTest = FruitListViewWithPerformSegueCatch()
        
        let presenter = FruitListPresenter()
        fruitListViewToTest.presenter = presenter
        
        let fruit = Fruit()
        
        fruitListViewToTest.pushFruitDetailsView(for: fruit)
        
        XCTAssert(presenter.selectedFruit == fruit)
        XCTAssert(presenter.startTime > 0.0)
        XCTAssert(fruitListViewToTest.performSegueCalledIdentifier == "fruitdetails")
        
    }
    
    class MockTableView: UITableView {
        var reloadDataCalled = false
        override func reloadData() {
            reloadDataCalled = true
        }
    }
    class MockRefreshControl: UIRefreshControl {
        var endRefreshingCalled = false
        override func endRefreshing() {
            super.endRefreshing()
            endRefreshingCalled = true
        }
    }
    
    func testShowError() {
        let testError = NSError(domain: "E1", code: 1, userInfo: nil)
        let refreshControl = MockRefreshControl()

        viewToTest.tableView.refreshControl = refreshControl
        
        viewToTest.show(error: testError)
        
        XCTAssert(refreshControl.endRefreshingCalled == true)
        
    }
    
    func testShowFruit() {
        let tableView = MockTableView()
        let refreshControl = MockRefreshControl()
        
        viewToTest.tableView = tableView
        tableView.refreshControl = refreshControl // Note: custom refresh control MUST be placed AFTER the mockTableView is added to the view.
        
        viewToTest.show(fruit: testFruit)
        
        XCTAssert(viewToTest.fruit == testFruit)
        XCTAssert(tableView.reloadDataCalled == true)
        XCTAssert(refreshControl.endRefreshingCalled == true)
    }
    
    func testTableRowsCount() {
        viewToTest.show(fruit: testFruit)
        let rowsCount = viewToTest.tableView(viewToTest.tableView, numberOfRowsInSection: 0)
        XCTAssert(rowsCount == testFruit.count)
    }
    
    func testTableCell() {
        viewToTest.show(fruit: testFruit)
        let cellToTest = viewToTest.tableView(viewToTest.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        let cellText = cellToTest.textLabel?.text ?? "Error"
        XCTAssert(cellText == testFruit[0].fruitname)
        
        let cellToTest1 = viewToTest.tableView(viewToTest.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        let cellText1 = cellToTest1.textLabel?.text ?? "Error"
        XCTAssert(cellText1 == testFruit[1].fruitname)
    }
    
    func testRefreshData() {
        let presenter = MockPresenter()
        viewToTest.presenter = presenter
        
        viewToTest.refreshData(UIRefreshControl())
        
        XCTAssert(presenter.refreshDataCalled == true)
    }
    
    func testDidSelectRow() {
        
        viewToTest.show(fruit: testFruit)
        
        let selectFruitExpectation = expectation(description: "DidSelectRow-select")
        let presenter = MockPresenter()
        let tapPosition = 1
        
        presenter.selectedFruitCallback = { [unowned self] fruit in
            selectFruitExpectation.fulfill()
            XCTAssert(fruit == self.testFruit[tapPosition])
        }
        
        viewToTest.presenter = presenter
        
        viewToTest.tableView(viewToTest.tableView, didSelectRowAt: IndexPath(row: tapPosition, section: 0))
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
