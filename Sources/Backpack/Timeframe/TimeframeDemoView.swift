//
//  TimeframeDemoView.swift
//  Backpack
//
//  Created by Matt Bonney on 8/15/23.
//

import SwiftUI
import Charts

struct TimeframeDemoView: View {
    @State private var chartTimeframe: Timeframe = .today

    var body: some View {
        VStack {
            Picker("Timeframe", selection: $chartTimeframe) {
                ForEach(Timeframe.defaultChartTimeframes) { timeframe in
                    Text(timeframe.description)
                        .tag(timeframe)
                }
            }
//            .pickerStyle(.segmented)

            Text("Columns to use: ") + Text(chartTimeframe.chartXAxisSubdivisions, format: .number)

            Chart {
                ForEach(0...chartTimeframe.chartXAxisSubdivisions, id: \.self) { index in
                    BarMark(
                        x: .value("X\(index)", index),
                        y: .value("Y\(index)", index)
                    )
                }
            }
            .chartXScale(range: .plotDimension(startPadding: 0, endPadding: 0))
            .chartXAxisLabel(chartTimeframe.description, position: .top, alignment: .leading, spacing: nil)
            .chartXScale(domain: 0...chartTimeframe.chartXAxisSubdivisions, range: .plotDimension, type: nil)
        }
        .padding()
    }
}

struct TimeframeDemoView_Previews: PreviewProvider {
    static var previews: some View {
        TimeframeDemoView()
    }
}
