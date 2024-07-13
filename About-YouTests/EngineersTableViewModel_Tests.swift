//
//  EngineersTableViewModel_Tests.swift
//  About-YouTests
//
//  Created by Prateek on 2024/07/13.
//

import XCTest
@testable import About_You

final class EngineersTableViewModel_Tests: XCTestCase {
    
    var viewModelUnderTest: EngineersTableViewModel!
    var mockView: MockEngineersTableView?
    var testEngineers = [Engineer]()

    override func setUpWithError() throws {
        class MockView: MockEngineersTableView {
            
            override func updateList() {
                expectation.fulfill()
            }
        }
        mockView = MockView()
    }

    override func tearDownWithError() throws {
        testEngineers = [Engineer]()
        mockView = nil
        viewModelUnderTest = nil
    }
    
    func testEngineersListOrderByBugs() {
        testEngineers = Engineer.mockDataForOrderByBugs()
        viewModelUnderTest = EngineersTableViewModel(engineers: testEngineers, delegate: mockView)
        viewModelUnderTest.orderEngineers(by: .bugs)
        let expectedOrder = [4, 10, 12, 50]
        let bugs = (0..<4).compactMap { viewModelUnderTest.engineer(at: $0) }.compactMap { $0.quickStats.bugs }
        XCTAssertEqual(expectedOrder, bugs)
        wait(for: [mockView!.expectation])
    }
    
    func testEngineersListOrderByCoffees() {
        testEngineers = Engineer.mockDataForOrderByCoffees()
        viewModelUnderTest = EngineersTableViewModel(engineers: testEngineers, delegate: mockView)
        viewModelUnderTest.orderEngineers(by: .coffees)
        let expectedOrder = [4, 10, 12, 50]
        let coffees = (0..<4).compactMap { viewModelUnderTest.engineer(at: $0) }.compactMap { $0.quickStats.coffees }
        XCTAssertEqual(expectedOrder, coffees)
        wait(for: [mockView!.expectation])
    }
    
    func testEngineersListOrderByYears() {
        testEngineers = Engineer.mockDataForOrderByYears()
        viewModelUnderTest = EngineersTableViewModel(engineers: testEngineers, delegate: mockView)
        viewModelUnderTest.orderEngineers(by: .years)
        let expectedOrder = [4, 10, 12, 50]
        let years = (0..<4).compactMap { viewModelUnderTest.engineer(at: $0) }.compactMap { $0.quickStats.years }
        XCTAssertEqual(expectedOrder, years)
        wait(for: [mockView!.expectation])
    }
    
    func testThatIncorrectIndexValueReturnsNull() {
        testEngineers = Engineer.mockData()
        viewModelUnderTest = EngineersTableViewModel(engineers: testEngineers, delegate: mockView)
        XCTAssertNil(viewModelUnderTest.engineer(at: 10))
        XCTAssertNil(viewModelUnderTest.displayInfo(forEngineerAt: 10))
        XCTAssertNotNil(viewModelUnderTest.engineer(at: 2))
        XCTAssertNotNil(viewModelUnderTest.displayInfo(forEngineerAt: 2))
    }
}

private extension Engineer {
    
    static func mockData() -> [Engineer] {
        return [.createMockEngineer(name: "Engineer1", role: "role1"),
                .createMockEngineer(name: "Engineer2", role: "role2"),
                .createMockEngineer(name: "Engineer3", role: "role3"),
                .createMockEngineer(name: "Engineer4", role: "role4")]
    }
    
    static func mockDataForOrderByBugs() -> [Engineer] {
        return [.createMockEngineer(name: "Engineer1", role: "role1", bugs: 12),
                .createMockEngineer(name: "Engineer2", role: "role2", bugs: 10),
                .createMockEngineer(name: "Engineer3", role: "role3", bugs: 50),
                .createMockEngineer(name: "Engineer4", role: "role4", bugs: 4)]
    }
    
    static func mockDataForOrderByYears() -> [Engineer] {
        return [.createMockEngineer(name: "Engineer1", role: "role1", years: 12),
                .createMockEngineer(name: "Engineer2", role: "role2", years: 10),
                .createMockEngineer(name: "Engineer3", role: "role3", years: 50),
                .createMockEngineer(name: "Engineer4", role: "role4", years: 4)]
    }
    
    static func mockDataForOrderByCoffees() -> [Engineer] {
        return [.createMockEngineer(name: "Engineer1", role: "role1", coffees: 12),
                .createMockEngineer(name: "Engineer2", role: "role2", coffees: 10),
                .createMockEngineer(name: "Engineer3", role: "role3", coffees: 50),
                .createMockEngineer(name: "Engineer4", role: "role4", coffees: 4)]
    }
    
    private static func createMockEngineer(name: String,
                                           role: String,
                                           years: Int = 0,
                                           coffees: Int = 0,
                                           bugs: Int = 0) -> Engineer {
        return Engineer(name: name,
                        role: role,
                        quickStats: QuickStats(years: years, coffees: coffees, bugs: bugs),
                        questions: [])
    }
}
