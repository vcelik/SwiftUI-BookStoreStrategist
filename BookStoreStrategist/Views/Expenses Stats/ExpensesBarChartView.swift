//
//  ExpensesBarChartView.swift
//  BookStoreStrategist
//
//  Created by Volkan Celik on 15/08/2023.
//

import SwiftUI
import Charts

struct ExpensesBarChartView: View {
    @ObservedObject var expensesViewModel:ExpensesViewModel
    var body: some View {
        Chart(expensesViewModel.monthlyExpenseDate) { data in
            Plot {
                BarMark(x: .value("month", month(for: data.month)), y: .value("expenses", data.fixedExpenses))
                    .foregroundStyle(by: .value("Expenses", "fixed"))
                    .position(by: .value("Expenses", "fixed"))

                BarMark(x: .value("month", month(for: data.month)), y: .value("expenses", data.variableExpense))
                    .foregroundStyle(by: .value("Expenses", "variable"))
                    .position(by: .value("Expenses", "variable"))
            }


        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    let formatter=DateFormatter()
    
    func month(for number:Int)->String{
        formatter.shortStandaloneMonthSymbols[number-1]
    }
}

#Preview {
    ExpensesBarChartView(expensesViewModel: .preview)
}
