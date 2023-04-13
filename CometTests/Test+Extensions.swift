//
//  Test+Extensions.swift
//  CometTests
//
//  Created by Noah Little on 13/4/2023.
//

import Foundation
import XCTest
import Combine

private var bag = Set<AnyCancellable>()

extension XCTestCase {
    func subscribeForChanges<T>(
        _ publisher: Published<T>.Publisher,
        expectation: XCTestExpectation
    ) {
        publisher
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &bag)
    }
}
