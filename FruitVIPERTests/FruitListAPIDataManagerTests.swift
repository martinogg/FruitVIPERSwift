//
//  FruitListAPIDataManagerTests.swift
//  FruitVIPERTests
//
//  Created by martin ogg on 07/02/2018.
//  Copyright © 2018 martinogg. All rights reserved.
//

import XCTest
import Alamofire
@testable import FruitVIPER

class FruitListAPIDataManagerTests: XCTestCase {
    var testBundle: Bundle!
    let testAPI = FruitListAPIDataManagerOverrideRequest()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testBundle = Bundle(for: type(of: self))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetOnlineData() {
        
        guard let path = testBundle.path(forResource: "testOKResponse", ofType: "json") else {
            XCTFail()
            return
        }
        let successExpectation = expectation(description: "testGetOnlineDataOK")
        let analyticsExpectation = expectation(description: "testSendEventLoadExpectation")
        
        testAPI.makeAlamofireRequestCallBack = {url, method in
            analyticsExpectation.fulfill()
            XCTAssert(method == .get)
            XCTAssert(url.absoluteString.starts(with: "www.awebsite.com/feedback?event=load&data="))
        }
        
        testAPI.testURL = NSURL.fileURL(withPath: path)
        testAPI.getOnlineData(onSuccess: { (fruit) in
            successExpectation.fulfill()
            XCTAssert(fruit[0].fruitname == "apple")
            XCTAssert(fruit[0].price == 11)
            XCTAssert(fruit[0].weight == 12)
            
        }) { (error) in
            XCTFail("Correct Data should not fail")
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetOnlineDataBadURL() {
        
        let failExpectation = expectation(description: "testGetOnlineDataBadURL")
        
        testAPI.testURL = NSURL.fileURL(withPath: "badpath")
        
        let analyticsExpectation = expectation(description: "testSendEventLoadExpectation")
        
        testAPI.makeAlamofireRequestCallBack = {url, method in
            analyticsExpectation.fulfill()
            XCTAssert(method == .get)
            XCTAssert(url.absoluteString.starts(with: "www.awebsite.com/feedback?event=error&data="))
        }
        
        testAPI.getOnlineData(onSuccess: { (fruit) in
            XCTFail("Bad Data should not Pass")
        }) { (error) in
            failExpectation.fulfill()
        }
        
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetOnlineDataBadJSON() {
        
        guard let path = testBundle.path(forResource: "testBADResponse", ofType: "json") else {
            fatalError()
        }
        let failExpectation = expectation(description: "testGetOnlineDataOK")
        
        testAPI.testURL = NSURL.fileURL(withPath: path)
        
        let analyticsExpectation = expectation(description: "testSendEventLoadExpectation")
        
        testAPI.makeAlamofireRequestCallBack = {url, method in
            analyticsExpectation.fulfill()
            XCTAssert(method == .get)
            XCTAssert(url.absoluteString.starts(with: "www.awebsite.com/feedback?event=error&data="))
        }
        
        testAPI.getOnlineData(onSuccess: { (fruit) in
            XCTFail("Bad Data should not Pass")
            
        }) { (error) in
            failExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    class FruitListAPIDataManagerOverrideRequest: APIDataManager {
        var makeAlamofireRequestCallBack: ((URL, HTTPMethod)->())?
        
        override func makeAlamofireRequest(url: URL, method: HTTPMethod) -> DataRequest {
            makeAlamofireRequestCallBack?(url, method)
            return super.makeAlamofireRequest(url: url, method: method)
        }
    }
    
    func testSendEventLoad() {
        
        let callbackExpectation = expectation(description: "testSendEventLoadExpectation")
        
        testAPI.makeAlamofireRequestCallBack = {url, method in
            callbackExpectation.fulfill()
            XCTAssert(method == .get)
            XCTAssert(url.absoluteString == "www.awebsite.com/feedback?event=load&data=100")
        }
        
        testAPI.sendEventLoad(time: 100)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSendEventDisplay() {
        
        let callbackExpectation = expectation(description: "testSendEventLoadExpectation")
        
        testAPI.makeAlamofireRequestCallBack = {url, method in
            callbackExpectation.fulfill()
            XCTAssert(method == .get)
            XCTAssert(url.absoluteString == "www.awebsite.com/feedback?event=display&data=100")
        }
        
        testAPI.sendEventDisplay(time: 100)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSendEventError() {
        
        let callbackExpectation = expectation(description: "testSendEventLoadExpectation")
        
        testAPI.makeAlamofireRequestCallBack = {url, method in
            callbackExpectation.fulfill()
            XCTAssert(method == .get)
            XCTAssert(url.absoluteString == "www.awebsite.com/feedback?event=error&data=SomeError")
        }
        
        testAPI.sendEventError(errorText: "SomeError")
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
