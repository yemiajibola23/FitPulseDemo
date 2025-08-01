//
//  HeartRateMonitorViewModelTests.swift
//  FitPulseDemoTests
//
//  Created by Amira Ajibola  on 7/31/25.
//

import Testing
@testable import FitPulseDemo

struct HeartRateMonitorViewModelTests {

    @Test func testUpdateStatsIncrementsCorrectly() {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let viewModel = HeartRateMonitorViewModel()
        
        viewModel.updateStats(with: 80)
        viewModel.updateStats(with: 75)
        viewModel.updateStats(with: 90)
        
        #expect(viewModel.bpm == 90)
        #expect(viewModel.minBPM == 75)
        #expect(viewModel.maxBPM == 90)
        #expect(viewModel.avgBPM == 81)
        
    }

}
