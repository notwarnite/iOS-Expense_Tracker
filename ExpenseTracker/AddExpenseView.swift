//
//  AddExpenseView.swift
//  ExpenseTracker
//
//  Created by Ritwik Singh on 29/11/23.
//

import SwiftUI
import SwiftData
import Foundation

struct AddExpenseView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var date: Date = .now
    @State private var value: Double = 0
    @State private var selectedOption: ExpenseCategory = .food
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $value, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Enter Amount")
                }
                Section {
                    TextField("Description", text: $name)
                } header: {
                    Text("Description")
                }
                Section {
                    Picker("Category", selection: $selectedOption) {
                        ForEach(ExpenseCategory.allCases) { option in
                            Text(option.title).tag(option)
                        }
                    }.pickerStyle(.menu)
                    
                } header: {
                    Text("Category")
                }
                
                Section{
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
            }
            .navigationTitle("Add new expense")
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        let expense = Expense(name: name, date: date, value: value, category: selectedOption)
                        context.insert(expense)
                        
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddExpenseView()
}
