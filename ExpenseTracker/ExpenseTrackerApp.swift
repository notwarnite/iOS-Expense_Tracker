//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Ritwik Singh on 29/11/23.
//

import SwiftUI
import SwiftData

@main
struct ExpenseTrackerApp: App {
    
    let container: ModelContainer = {
            let schema = Schema([Expense.self])
            let container = try! ModelContainer(for: schema, configurations: [])
            
            return container
        }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
