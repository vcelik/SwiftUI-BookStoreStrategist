//
//  BookCategory.swift
//  BookStoreStrategist
//
//  Created by Volkan Celik on 12/08/2023.
//

import Foundation

enum BookCategory:Identifiable,CaseIterable{
    case fiction
    case biography
    case children
    case computerScience
    case fantasy
    case business
    
    var id:Self{
        self
    }
    
    var displayName:String{
        switch self {
        case .fiction:
            "Fiction"
        case .biography:
            "Biography"
        case .children:
            "Children"
        case .computerScience:
            "Computer Science"
        case .fantasy:
            "Fantasy"
        case .business:
            "Business"
        }
    }
}
