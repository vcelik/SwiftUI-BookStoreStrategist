//
//  MonthlyChartView.swift
//  BookStoreStrategist
//
//  Created by Volkan Celik on 14/08/2023.
//

import SwiftUI
import Charts


struct MonthlyChartView: View {
    
    let salesData:[Sale]
    
    var body: some View {
        Chart(salesData) { sale in
            BarMark(x: .value("Month", sale.saleDate,unit: .month), y: .value("Sales", sale.quantity))
        }
        .chartXAxis {
            AxisMarks { _ in
               // AxisGridLine()
                AxisValueLabel(format: .dateTime.month(.abbreviated),centered: true)
            }
        }
    }
}

#Preview {
    MonthlyChartView(salesData: Sale.threeMonthsExamples())
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
