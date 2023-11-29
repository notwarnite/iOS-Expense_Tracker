//
//  UpdateExpenseView.swift
//  ExpenseTracker
//
//  Created by Ritwik Singh on 29/11/23.
//

import SwiftUI

struct UpdateExpenseView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var expense: Expense
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Expense Name", text: $expense.name)
                DatePicker("Date", selection: $expense.date, displayedComponents: .date)
                TextField("Value", value: $expense.value, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Update Expense")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Done") {
                        
                        dismiss()
                    }
                }
            }
        }
    }
}
