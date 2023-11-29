//
//  DataModel.swift
//  ExpenseTracker
//
//  Created by Ritwik Singh on 29/11/23.
//

import Foundation
import SwiftData

@Model
class Expense {
    var id: UUID
    var name: String
    var date: Date
    var value: Double
    
    init(name: String, date: Date, value: Double) {
        self.id = UUID()
        self.name = name
        self.date = date
        self.value = value
    }
}
