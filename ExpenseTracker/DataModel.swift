//
//  DataModel.swift
//  ExpenseTracker
//
//  Created by Ritwik Singh on 29/11/23.
//

import Foundation
import SwiftData


enum ExpenseCategory: Int, Codable, CaseIterable, Identifiable {
    case food = 1
    case utilities
    case transportation
    case entertainment
    case healthcare
    case other
    
    var id: Int {
        rawValue
    }
}

extension ExpenseCategory {
    var title: String {
        switch self {
        case .food:
            return "Food"
        case .utilities:
            return "Utilities"
        case .transportation:
            return "Transportation"
        case .entertainment:
            return "Entertainment"
        case .healthcare:
            return "Healthcare"
        case .other:
            return "Other"
        }
    }
}


@Model
class Expense {
    var name: String
    var date: Date
    var value: Double
    var categoryId: Int
    
    var category: ExpenseCategory {
        ExpenseCategory(rawValue: categoryId)!
    }
    
    
    init(name: String, date: Date, value: Double, category: ExpenseCategory) {
        self.name = name
        self.date = date
        self.value = value
        self.categoryId = category.id
    }
}
