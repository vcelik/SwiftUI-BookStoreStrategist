//
//  SalesByWeekdayHeaderView.swift
//  BookStoreStrategist
//
//  Created by Volkan Celik on 15/08/2023.
//

import SwiftUI

struct SalesByWeekdayHeaderView: View {
    @ObservedObject var salesViewModel:SalesViewModel
    
    var body: some View {
        VStack(alignment:.leading){
            if let highestSellingweekday=salesViewModel.highestSellingWeekday{
                Text("Your highest selling day of the week is ") +
                Text("\(weekday(for:highestSellingweekday.number))").bold().foregroundStyle(Color.accentColor) +
                Text("\(Int(highestSellingweekday.sales)) sales per day.").bold()
            }
        }
    }
    
    let formatter=DateFormatter()
    
    func weekday(for number:Int)->String{
        formatter.weekdaySymbols[number-1]
    }
}

#Preview {
    SalesByWeekdayHeaderView(salesViewModel: .preview)
}
