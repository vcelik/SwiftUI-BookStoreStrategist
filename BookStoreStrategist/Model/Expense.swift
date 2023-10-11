//
//  Expense.swift
//  BookStoreStrategist
//
//  Created by Volkan Celik on 14/08/2023.
//

import Foundation

struct Expense:Identifiable{
    let id=UUID()
    let title:String
    let amount:Double
    let expenseDate:Date
    let category:ExpenseCategory
    
    static var example=Expense(title: "Rent", amount: 2000, expenseDate: Date(timeIntervalSinceNow: -7_200_000), category: .fixed)
    
    static var examples = [
            Expense(title: "Rent", amount: 2000, expenseDate: Date(timeIntervalSinceNow: -7_200_000), category: .fixed),
            Expense(title: "Salaries", amount: 5000, expenseDate: Date(timeIntervalSinceNow: -14_400_000), category: .fixed),
            Expense(title: "Utilities", amount: 600, expenseDate: Date(timeIntervalSinceNow: -21_600_000), category: .fixed),
            Expense(title: "Marketing", amount: 1000, expenseDate: Date(timeIntervalSinceNow: -28_800_000), category: .variable),
            Expense(title: "Inventory", amount: 3000, expenseDate: Date(timeIntervalSinceNow: -36_000_000), category: .variable),
            Expense(title: "Maintenance", amount: 500, expenseDate: Date(timeIntervalSinceNow: -43_200_000), category: .fixed),
            Expense(title: "Equipment", amount: 1500, expenseDate: Date(timeIntervalSinceNow: -50_400_000), category: .variable)
        ]
    
    static var yearExamples:[Expense]{
        let formatter=DateFormatter()
        formatter.dateFormat="yyyy/MM/dd"
        var expenses=[Expense]()
        
        
        for month in 1...12{
            for _ in 1...10{
                let randomDay=Int.random(in: 1...28)
                let date=formatter.date(from: "2023/\(month)/\(randomDay)")!
                let category:ExpenseCategory=Bool.random() ? .fixed : .variable
                let title=category == .fixed ? "Rent" : "Supplies"
                let amount:Double=category == .fixed ? 2000 : Double.random(in: 100...500)
                expenses.append(Expense(title: title, amount: amount, expenseDate: date, category: category))
            }
        }
        return expenses
    }
    

    
}

enum ExpenseCategory{
    case fixed
    case variable
    
    var displayName:String{
        switch self {
        case .fixed:
            "Fixed"
        case .variable:
            "Variable"
        }
    }
}
