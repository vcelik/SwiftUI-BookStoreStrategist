//
//  ExpensesViewModel.swift
//  BookStoreStrategist
//
//  Created by Volkan Celik on 15/08/2023.
//

import Foundation
import Combine

class ExpensesViewModel:ObservableObject{
    @Published private var expenses:[Expense]=[]
    @Published var monthlyExpenseDate:[ExpensesStates]=[]
    @Published var totalExpenses:Double=0
    
    private var subscriptions=Set<AnyCancellable>()
    
    init(){
        print("Expenses changed")
        //fetch data from server
        $expenses.sink { [unowned self] expenses in
            let fixedExpense=self.expensesByMonth(for: .fixed, expenses: expenses)
            let variableExpense=self.expensesByMonth(for: .variable, expenses: expenses)
            self.monthlyExpenseDate=self.calculateTotalMonthlyExpenses(fixedExpenses: fixedExpense, variableExpense: variableExpense)
            self.totalExpenses=calculteTotal(for: expenses)
        }
        .store(in: &subscriptions)

    }
    
    func expensesByMonth(for category:ExpenseCategory,expenses:[Expense])->[(month:Int,amount:Double)]{
        let calendar=Calendar.current
        var expensesByMonth:[Int:Double]=[:]
        
        for expense in expenses where expense.category == category{
            let month=calendar.component(.month, from: expense.expenseDate)
            expensesByMonth[month,default: 0]+=expense.amount
        }
        
        let result=expensesByMonth.map{(month:$0.key,amount:$0.value)}
        return result.sorted{$0.month<$1.month}
    }
    
    func calculateTotalMonthlyExpenses(fixedExpenses:[(month:Int,amount:Double)],variableExpense:[(month:Int,amount:Double)])->[ExpensesStates]{
        var result=[ExpensesStates]()
        let count=min(fixedExpenses.count,variableExpense.count)
        
        for index in 0..<count{
            let month=fixedExpenses[index].month
            result.append(ExpensesStates(month: month, fixedExpenses: fixedExpenses[index].amount, variableExpense: variableExpense[index].amount))
        }
        return result
    }
    
    func calculteTotal(for expenses:[Expense])->Double{
        let totalExpenses=expenses.reduce(0){total,expense in
            total+expense.amount
        }
        return totalExpenses
    }
    
    
    func filteredExpenses(for category:ExpenseCategory,expenses:[Expense])->[(date:Date,amount:Double)]{
        let result=expenses.filter{$0.category == category}
        return result.sorted(by: {$0.expenseDate<$1.expenseDate})
            .map{(date:$0.expenseDate,amount:$0.amount)}
    }
    
    //MARK: - preview
    
    static var preview:ExpensesViewModel{
        let vm=ExpensesViewModel()
        vm.expenses=Expense.yearExamples
        return vm
    }
}

struct ExpensesStates:Identifiable{
    let month:Int
    let fixedExpenses:Double
    let variableExpense:Double
    
    var totalExpense:Double{
        fixedExpenses + variableExpense
    }
    
    var id:Int{
        return month
    }
}


