//
//  MockEngineersTableView.swift
//  About-YouTests
//
//  Created by Prateek on 2024/07/13.
//

import XCTest
@testable import About_You

class MockEngineersTableView: EngineersTableViewModelDelegate {
    var expectation = XCTestExpectation(description: "update list")
    func updateList() {
        XCTFail()
    }
}
