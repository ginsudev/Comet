//
//  AppPickerViewModelTests.swift
//  CometTests
//
//  Created by Noah Little on 13/4/2023.
//

import XCTest
import Combine
@testable import Comet

final class AppPickerViewModelTests: XCTestCase {
    private var bag = Set<AnyCancellable>()
    
    private let workspaceMock = ApplicationWorkspaceMock()
    
    private let cachedApps: [ApplicationWorkspace.ApplicationProxy] = [
        .init(id: "mock_id_1", displayName: "Mock_1", isSystem: true),
        .init(id: "mock_id_2", displayName: "Mock_2", isSystem: false)
    ]
    
    override func tearDown() {
        UserDefaults.standard.setAppProxies(nil, forKey: Keys.appCache)
    }
    
    func storeInDefaults() {
        UserDefaults.standard.setAppProxies(cachedApps, forKey: Keys.appCache)
    }
    
    func testLoadAppsIfAppsIsEmpty() {
        // GIVEN there are cached apps
        storeInDefaults()
        
        // GIVEN a new sut
        let sut: AppPicker.ViewModel = .init(
            visibleApplicationGroup: .all,
            title: "Test",
            isSinglePicker: true,
            workspace: workspaceMock
        )
        
        // GIVEN there are initially no apps
        XCTAssertEqual(sut.appModels, [])
        
        // WHEN the view loads
        sut.loadIfNeeded()
        
        // THEN the applications are set
        XCTAssertNotEqual(sut.appModels, [])
    }
    
    func testLoadFromUserDefaultsThenRealApps() {
        var realApps: [ApplicationWorkspace.ApplicationProxy] = []
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
        
        // WHEN the view did appear
        sut.loadIfNeeded()
        
        // THEN the apps were set to the cached apps
        XCTAssertEqual(
            sut.appModels.map(\.id),
            cachedApps.compactMap { $0.id }
        )
        
        workspaceMock.loadApplicationsPublisher()
            .receive(on: DispatchQueue.main)
            .sink { apps in
                realApps = apps
                realExpectation.fulfill()
            }
            .store(in: &bag)
        
        wait(for: [realExpectation], timeout: 1.0)

        // THEN the apps were set to the real apps
        XCTAssertEqual(
            sut.appModels.map(\.id),
            realApps.compactMap { $0.id }
        )
    }
    
    func testLoadRealApplicationsIfNoCachedApps() {
        var realApps: [ApplicationWorkspace.ApplicationProxy] = []
        let realExpectation = XCTestExpectation(description: "real apps were set")

        // GIVEN there are no cached apps
        
        // GIVEN a new sut
        let sut: AppPicker.ViewModel = .init(
            visibleApplicationGroup: .all,
            title: "Test",
            isSinglePicker: true,
            workspace: workspaceMock
        )
        
        // WHEN the view did appear
        sut.loadIfNeeded()

        workspaceMock.loadApplicationsPublisher()
            .receive(on: DispatchQueue.main)
            .sink { apps in
                realApps = apps
                realExpectation.fulfill()
            }
            .store(in: &bag)
        
        wait(for: [realExpectation], timeout: 1.0)

        // THEN the apps were set to the real apps
        XCTAssertEqual(
            sut.appModels.map(\.id),
            realApps.compactMap { $0.id }
        )
        
        // THEN the cached apps were set to the real apps
        XCTAssertEqual(realApps, UserDefaults.standard.appProxies(forKey: Keys.appCache))
    }
}


