//
//  MVVMDetailViewModelTests.swift
//  MVVM-C
//
//  Created by Scotty on 24/05/2016.
//  Copyright © 2018 Diligent Robot Ltd. All rights reserved.
//

import XCTest

class MVVMDetailViewModelTests: XCTestCase
{

    func testInitialDefaults() {
        let vm = MVVMCDetailViewModel()
        XCTAssertNil(vm.detail)
        XCTAssertNil(vm.viewDelegate)
        XCTAssertNil(vm.model)
        XCTAssertNil(vm.coordinatorDelegate)
    }
    
    func testDetail()
    {
        let vm = MVVMCDetailViewModel()
        let item = MVVMCDataItem(name: "Test Name", role: "Test Role")
        let model = MVVMCDetailModel(detailItem: item)
        vm.model = model
        
        // The View Model will be getting its data asynchronously
        // so we need to wait for it to be populated with data
        // This is not a good way to do this but this is a demo so I can ignore it
        // for now but will come back and fix it sometime.
        while vm.detail == nil {
            sleep(1)
        }
        
        guard let detail = vm.detail else {
            XCTFail("No Detail")
            return
        }
        
        XCTAssertEqual("Test Name", detail.name)
        XCTAssertEqual("Test Role", detail.role)
    }
    
    class MockDetailViewModelViewDelegate: MockDelegate, DetailViewModelViewDelegate {
        
        let expectedItem: DataItem
        
        init(expectedItem: DataItem, expectation: XCTestExpectation) {
            self.expectedItem = expectedItem
            super.init(expectation: expectation)
        }
        
        func detailDidChange(viewModel: DetailViewModel) {
            
            guard viewModel.detail != nil else { return }
            
            XCTAssertEqual(expectedItem.name, viewModel.detail?.name)
            XCTAssertEqual(expectedItem.role, viewModel.detail?.role)
            expectation?.fulfill()
        }
    }
    
    func testDetailDidChange() {
        
        let vm = MVVMCDetailViewModel()
        let expectedItem = MVVMCDataItem(name: "Test Name", role: "Test Role")
        let model = MVVMCDetailModel(detailItem: expectedItem)
        
        
        let testExpectation =  expectation(description: "testDetailDidChange")
        let delegate = MockDetailViewModelViewDelegate(expectedItem: expectedItem, expectation: testExpectation)
        
        vm.viewDelegate = delegate
        vm.model = model
        
        waitForExpectations(timeout: 1) { error in
            vm.viewDelegate = nil
        }
    }
    
    
    class MockDetailViewModelCoordinatorDelegate: MockDelegate, DetailViewModelCoordinatorDelegate {
        
        func detailViewModelDidEnd(_ viewModel: DetailViewModel) {
            expectation?.fulfill()
        }
    }
    
    func testCoordinatorDelegate()
    {
        let vm = MVVMCDetailViewModel()
        
        let testExpectation =  expectation(description: "testDetailViewModelDidEnd")
        let delegate = MockDetailViewModelCoordinatorDelegate(expectation: testExpectation)
        vm.coordinatorDelegate = delegate
        
        vm.done()
        waitForExpectations(timeout: 1) { error in
            vm.viewDelegate = nil
        }
   }
}
