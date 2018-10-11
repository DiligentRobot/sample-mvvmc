//
//  MockDelgate.swift
//  MVVM-CTests
//
//  Created by Scotty on 10/10/2018.
//  Copyright © 2018 Diligent Robot Ltd. All rights reserved.
//

import Foundation
import XCTest

class MockDelegate {
    let expectation: XCTestExpectation?
    
    init() {
        expectation = nil
    }
    
    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
}
