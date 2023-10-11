//
//  DetailBookSalesView.swift
//  BookStoreStrategist
//
//  Created by Volkan Celik on 14/08/2023.
//

import SwiftUI

struct DetailBookSalesView: View {
    
    enum TimeInterval:String,CaseIterable,Identifiable{
        case day="Day"
        case week="Week"
        case month="Month"
        
        var id:Self{
            return self
        }
    }
    
    @ObservedObject var salesViewModel:SalesViewModel
    @State private var selectedTimeInterval=TimeInterval.day
    
    var body: some View {
        VStack(alignment:.leading){
            Picker(selection: $selectedTimeInterval.animation()) {
                ForEach(TimeInterval.allCases){interval in
                    Text(interval.rawValue)
                }
            } label: {
                Text("Time Interval for chart")
            }
            .pickerStyle(.segmented)
            
            Group{
                Text("You sold ") +
                Text("\(salesViewModel.totalSales) books").bold().foregroundColor(.accentColor) +
                Text(" in the last 90 days.")
            }.padding(.vertical)
            
            Group{
                switch selectedTimeInterval {
                case .day:
                    DailySalesChartView(salesData: salesViewModel.salesData)
                case .week:
                    WeeklySalesChartView(salesViewModel: salesViewModel)
                case .month:
                    MonthlyChartView(salesData: salesViewModel.salesData)
                }
            }
            .aspectRatio(0.8, contentMode: .fit)
            Spacer()

                
                

        }

    }
}

#Preview {
    DetailBookSalesView(salesViewModel: SalesViewModel.preview)
}
