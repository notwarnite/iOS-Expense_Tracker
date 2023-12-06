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
                Section {
                    TextField("Amount", value: $expense.value, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Enter Amount")
                }
                Section {
                    TextField("Description", text: $expense.name)
                } header: {
                    Text("Description")
                }
                
                Section{
                    DatePicker("Date", selection: $expense.date, displayedComponents: .date)
                }
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
