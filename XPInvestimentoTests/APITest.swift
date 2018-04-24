//
//  APITest.swift
//  XPInvestimentoTests
//
//  Created by Kaique Magno Dos Santos on 22/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import XCTest
@testable import XPInvestimento

class APITest: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetCharactersRequest() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let request = GetCharacters()
        
        let waiter = XCTWaiter(delegate: self)
        let answerAPIExpectation = XCTestExpectation(description: "AnswerAPI")
        
        APIManager.shared.send(request) { (response) in
            switch response {
            case .success(let dataContainer):
                XCTAssertNotNil(dataContainer.results)
                XCTAssertNotNil(dataContainer.results.count > 0)
                answerAPIExpectation.fulfill()
            
            case .failure(let error):
                XCTFail(error.localizedDescription)
                answerAPIExpectation.fulfill()
                print(error.localizedDescription)
            }
        }
        
        waiter.wait(for: [answerAPIExpectation], timeout: 20.0, enforceOrder: true)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: - XCTWaiterDelegate
    override func waiter(_ waiter: XCTWaiter, didFulfillInvertedExpectation expectation: XCTestExpectation) {
        
    }
    override func waiter(_ waiter: XCTWaiter, didTimeoutWithUnfulfilledExpectations unfulfilledExpectations: [XCTestExpectation]) {
        XCTFail("Did not fulfil expectations")
    }
}

