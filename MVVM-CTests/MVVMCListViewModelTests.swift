//
//  MVVMCListViewModelTests.swift
//  MVVM-C
//
//  Created by Scotty on 24/05/2016.
//  Copyright © 2018 Diligent Robot Ltd. All rights reserved.
//

import XCTest

class MVVMCListViewModelTests: XCTestCase
{
    
    var currentExpectaion: XCTestExpectation?
    
    func testDefaults()
    {
        let vm = MVVMCListViewModel()
        XCTAssertEqual(0,vm.numberOfItems)
        XCTAssertEqual("List", vm.title)
        XCTAssertNil(vm.viewDelegate)
        XCTAssertNil(vm.model)
        XCTAssertNil(vm.coordinatorDelegate)
    }
    
    func testNumberOfItems() {
        
        let vm = MVVMCListViewModel()
        
        // We can test with the actual app model as it produces hard coded data
        // In normal testing we would create a ListModel implementation with fix test data to use,
        vm.model = MVVMCListModel()
        
        // The View Model will be getting its data asynchronously
        // so we need to wait for it to be populated with data
        // This is not a good way to do this but this is a demo so I can ignore it
        // for now but will come back and fix it sometime.
        while vm.numberOfItems == 0 {
            sleep(1)
        }
        
        XCTAssertEqual(7,vm.numberOfItems)
    }
    
    func testItemAtIndex() {
        
        let vm = MVVMCListViewModel()
        
        // We can test with the actual app model as it produces hard coded data
        // In normal testing we would create a ListModel implementation with fix test data to use,
        vm.model = MVVMCListModel()
        
        // The View Model will be getting its data asynchronously
        // so we need to wait for it to be populated with data
        // This is not a good way to do this but this is a demo so I can ignore it
        // for now but will come back and fix it sometime.
        while vm.numberOfItems == 0 {
            sleep(1)
        }
        
        
        // Test a value from the start , end and middle of list
        var dataItem = vm.item(atIndex: 0)
        XCTAssertNotNil(dataItem)
        
        guard let item = dataItem else { return }
        
        XCTAssertEqual("James T Kirk", item.name)
        XCTAssertEqual("Captain", item.role)
        
        
        dataItem = vm.item(atIndex: 6)
        XCTAssertNotNil(dataItem)
        
        guard let item2 = dataItem else { return }
        
        XCTAssertEqual("Pavel Chekov", item2.name)
        XCTAssertEqual("Ensign", item2.role)
        
        
        dataItem = vm.item(atIndex: 3)
        XCTAssertNotNil(dataItem)
        
        guard let item3 = dataItem else { return }
        
        XCTAssertEqual("Montgomery Scott", item3.name)
        XCTAssertEqual("Lieutenant Commander", item3.role)
        
    }
    
    func testItemAtIndexWithInvalidIndex() {
        
        let vm = MVVMCListViewModel()
        
        // We can test with the actual app model as it produces hard coded data
        // In normal testing we would create a ListModel implementation with fixed test data to use,
        vm.model = MVVMCListModel()
        
        // Test a value from beyond the end of the list
        let dataItem = vm.item(atIndex: vm.numberOfItems + 1)
        XCTAssertNil(dataItem)
    }
    
    /// Mock Delegate Class to test ListViewModelCoordinatorDelegate
    class MockListViewModelCoordinatorDelegate: MockDelegate, ListViewModelCoordinatorDelegate {
        
        let expectedData: DataItem?
        
        init(expectedData: DataItem?, expectation: XCTestExpectation) {
            self.expectedData = expectedData
            super.init(expectation: expectation)
        }
        
        func listViewModelDidSelectData(_ viewModel: ListViewModel, data: DataItem) {
            XCTAssertEqual(expectedData?.name, data.name)
            XCTAssertEqual(expectedData?.role, data.role)
            expectation?.fulfill()
        }
    }
    
    
    func testUseItemAtIndex()
    {
        let testExpectation = expectation(description: "testUseItemAtIndex")
        let vm = MVVMCListViewModel()
        let index = 6
        
        // We can test with the actual app model as it produces hard coded data
        // In normal testing we would create a ListModel implementation with fixed test data to use,
        let model = MVVMCListModel()
        vm.model = model
        
        // Get Items from the model so we know what items to expect.
        model.items { items in
            let expectedData = items[index]
            let mockDelegate = MockListViewModelCoordinatorDelegate(expectedData: expectedData, expectation: testExpectation)
            vm.coordinatorDelegate = mockDelegate
            vm.useItem(atIndex: index)
        }
        
        waitForExpectations(timeout: 1) { error in
            vm.coordinatorDelegate = nil
        }
    }
}
