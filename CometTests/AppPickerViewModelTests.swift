//
//  AppPickerViewModelTests.swift
//  CometTests
//
//  Created by Noah Little on 13/4/2023.
//

import XCTest
@testable import Comet

final class AppPickerViewModelTests: XCTestCase {
    private let workspaceMock = CMApplicationWorkspaceMock()
    
    private let cachedApps: [[AnyHashable : Any]] = [
        ["identifier": "mock_id_1",
         "displayName": "Mock_1",
         "isSystem": 1
        ],
        ["identifier": "mock_id_2",
         "displayName": "Mock_2",
         "isSystem": 0
        ]
    ]
    
    override func tearDown() {
        UserDefaults.standard.set(nil, forKey: Keys.appCache)
    }
    
    func storeInDefaults() {
        UserDefaults.standard.set(cachedApps, forKey: Keys.appCache)
    }
    
    func testLoadAppsIfAppsIsEmpty() {
        let expectation = XCTestExpectation(description: "apps were set")
        
        // GIVEN a new sut
        let sut: AppPicker.ViewModel = .init(
            visibleApplicationGroup: .all,
            title: "Test",
            isSinglePicker: true,
            workspace: workspaceMock
        )
        
        subscribeForChanges(sut.$apps, expectation: expectation)
        
        // WHEN the view does appear
        sut.loadIfNeeded()
        wait(for: [expectation], timeout: 1.0)
        
        // THEN the applications are set
        XCTAssertNotEqual(sut.apps, [])
    }
    
    func testLoadFromUserDefaultsThenRealApps() {
        let cachedExpectation = XCTestExpectation(description: "cached apps were set")
        let realExpectation = XCTestExpectation(description: "real apps were set")

        // GIVEN there are cached apps
        storeInDefaults()
        
        // GIVEN a new sut
        let sut: AppPicker.ViewModel = .init(
            visibleApplicationGroup: .all,
            title: "Test",
            isSinglePicker: true,
            workspace: workspaceMock
        )
        
        subscribeForChanges(
            sut.$apps,
            expectation: cachedExpectation
        )
        
        // WHEN the view did appear
        sut.loadIfNeeded()
        wait(for: [cachedExpectation], timeout: 1.0)
        
        // THEN the apps were set to the cached apps
        XCTAssertEqual(
            sut.apps.map(\.id),
            cachedApps.compactMap { $0["identifier"] as? String }
        )
        
        subscribeForChanges(
            sut.$apps,
            expectation: realExpectation
        )
        wait(for: [realExpectation], timeout: 1.0)

        // THEN the apps were set to the real apps
        XCTAssertEqual(
            sut.apps.map(\.id),
            workspaceMock.allApplications().compactMap { $0["identifier"] as? String }
        )
    }
    
    func testLoadRealApplicationsIfNoCachedApps() {
        let expectation = XCTestExpectation(description: "real apps were set")
        
        // GIVEN there are no cached apps
        
        // GIVEN a new sut
        let sut: AppPicker.ViewModel = .init(
            visibleApplicationGroup: .all,
            title: "Test",
            isSinglePicker: true,
            workspace: workspaceMock
        )
        
        subscribeForChanges(
            sut.$apps,
            expectation: expectation
        )
        
        // WHEN the view did appear
        sut.loadIfNeeded()
        wait(for: [expectation], timeout: 1.0)
        
        // THEN the apps were set to the cached apps
        XCTAssertEqual(
            sut.apps.map(\.id),
            workspaceMock.allApplications().compactMap { $0["identifier"] as? String }
        )
    }
}


