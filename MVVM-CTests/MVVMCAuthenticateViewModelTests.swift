//
//  MVVMCAuthenticateViewModelTests.swift
//  MVVM-C
//
//  Created by Scotty on 23/05/2016.
//  Copyright © 2018 Diligent Robot Ltd. All rights reserved.
//

import XCTest

class MVVMCAuthenticateViewModelTests: XCTestCase
{
    
    func testInitialDefaults() {
        let vm = MVVMCAuthenticateViewModel()
        XCTAssertEqual("", vm.email)
        XCTAssertEqual("", vm.password)
        XCTAssertFalse(vm.canSubmit)
        XCTAssertEqual("", vm.errorMessage)
        XCTAssertNil(vm.viewDelegate)
        XCTAssertNil(vm.model)
        XCTAssertNil(vm.coordinatorDelegate)
    }
    
    func testEmail()
    {
        let vm = MVVMCAuthenticateViewModel()
        vm.email = "scotty@example.com"
        XCTAssertEqual("scotty@example.com", vm.email)
    }
    
    func testPassword()
    {
        let vm = MVVMCAuthenticateViewModel()
        vm.password = "password"
        XCTAssertEqual("password", vm.password)
    }

    func testCanSubmit() {
        let vm = MVVMCAuthenticateViewModel()
        XCTAssertFalse(vm.canSubmit)
        
        vm.email = "scotty@example.com"
        vm.password = ""
        XCTAssertFalse(vm.canSubmit)
        
        vm.email = ""
        vm.password = "password"
        XCTAssertFalse(vm.canSubmit)
        
        vm.email = "scotty@example.com"
        vm.password = "password"
        XCTAssert(vm.canSubmit)
    }
    
    class MockAuthenticateViewModelViewDelegateCanSubmitStatusDidChange: MockDelegate, AuthenticateViewModelViewDelegate {
        
        let expectedCanSubmit: Bool
        
        init(expectedCanSubmit: Bool, expectation: XCTestExpectation) {
            self.expectedCanSubmit = expectedCanSubmit
            super.init(expectation: expectation)
        }
        
        func canSubmitStatusDidChange(_ viewModel: AuthenticateViewModel, status: Bool)
        {
            XCTAssertEqual(expectedCanSubmit, status)
            XCTAssertEqual(expectedCanSubmit, viewModel.canSubmit)
            expectation?.fulfill()
        }
        
        func errorMessageDidChange(_ viewModel: AuthenticateViewModel, message: String)
        {
            XCTFail("canSubmitStatusDidChange delegate method should not be called")
        }
    }
    
    
    func testCanSubmitDelegateCanSubmitStatusDidChange() {
        let vm = MVVMCAuthenticateViewModel()
        XCTAssertFalse(vm.canSubmit)
        
        vm.email = "scotty@example.com"
        vm.password = ""
        
        let testExpectation =  expectation(description: "testCanSubmitDelegateCanSubmitStatusDidChange")
        
        let mockDelegate = MockAuthenticateViewModelViewDelegateCanSubmitStatusDidChange(expectedCanSubmit: true, expectation: testExpectation)
        
        vm.viewDelegate = mockDelegate
       
        vm.password = "password"
        
        waitForExpectations(timeout: 1) { error in
            vm.viewDelegate = nil
        }
    }
    
    
    
    
    class MockAuthenticateViewModelViewDelegateErrorMessageChange: MockDelegate, AuthenticateViewModelViewDelegate {
        
        let expectedErrorMessage: String
        
        init(expectedErrorMessage: String, expectation: XCTestExpectation) {
            self.expectedErrorMessage = expectedErrorMessage
            super.init(expectation: expectation)
        }
        
        func canSubmitStatusDidChange(_ viewModel: AuthenticateViewModel, status: Bool)
        {
            XCTFail("canSubmitStatusDidChange delegate method should not be called")
        }
        
        func errorMessageDidChange(_ viewModel: AuthenticateViewModel, message: String)
        {
            XCTAssertEqual(expectedErrorMessage, message)
            XCTAssertEqual(expectedErrorMessage, viewModel.errorMessage)
            expectation?.fulfill()
        }
    }
    
    func testErrorMessageDidChange() {
        
        let vm = MVVMCAuthenticateViewModel()
        let testExpectation =  expectation(description: "testErrorMessageDidChange")
        let expectedErrorMessage = "Incomplete or Invalid Data";
        let mockDelegate = MockAuthenticateViewModelViewDelegateErrorMessageChange(expectedErrorMessage: expectedErrorMessage, expectation: testExpectation)
        
         vm.viewDelegate = mockDelegate
        
        // Call submit with no model set on the viewModel should produce an error message
        vm.submit()
     
        waitForExpectations(timeout: 1) { error in
            vm.viewDelegate = nil
        }
    }
    
    
    class MockAuthenticateViewModelViewCoordinatorDelegate: MockDelegate, AuthenticateViewModelCoordinatorDelegate {
        
        func authenticateViewModelDidLogin(viewModel: AuthenticateViewModel) {
            expectation?.fulfill()
        }
    }
    
    func testCoordinatorDelegate()
    {
        let vm = MVVMCAuthenticateViewModel()
        vm.model = MVVMCAuthenticateModel()
        
        let testExpectaion =  expectation(description: "testCoordinatorDelegate")
        let mockDelegate = MockAuthenticateViewModelViewCoordinatorDelegate(expectation: testExpectaion)
        vm.coordinatorDelegate = mockDelegate
        
        vm.email = "scotty@example.com"
        vm.password = "password"
 
        vm.submit()
        
        waitForExpectations(timeout: 1) { error in
            vm.coordinatorDelegate = nil
        }
    }
}


