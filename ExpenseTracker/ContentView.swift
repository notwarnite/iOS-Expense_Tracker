//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Ritwik Singh on 29/11/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var context
    @Query(sort: \Expense.date) var expenses: [Expense]
    @State var isShowingExpenseSheet: Bool = false
    @State private var expenseToEdit: Expense?
    
    var body: some View {
        VStack{
            HStack{
                Text("Expenses")
                    .font(.title)
                    .fontWeight(.bold)
            }
            
                        
            NavigationStack {
                List {
                    ForEach(expenses) { expense in
                        ExpenseCell(expense: expense)
                            .onTapGesture {
                                expenseToEdit = expense
                            }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            context.delete(expenses[index])
                        }
                    }
                }
                .sheet(isPresented: $isShowingExpenseSheet) {
                    AddExpenseView()
                        .presentationDetents([.fraction(0.70)])
                }
                .sheet(item: $expenseToEdit) { expense in
                    UpdateExpenseView(expense: expense)
                        .presentationDetents([.fraction(0.75)])
                }
                .toolbar {
                    if !expenses.isEmpty {
                        Button("Add Expense", systemImage: "plus") {
                            isShowingExpenseSheet = true
                        }
                    }
                }
                .overlay {
                    if expenses.isEmpty {
                        ContentUnavailableView(label: {
                            Label("No Expenses", systemImage: "list.bullet.rectangle.portrait")
                        }, description: {
                            Text("Start adding expenses to your list.")
                        }, actions: {
                            Button("Add Expense") {
                                isShowingExpenseSheet = true
                            }
                        })
                        .offset(y: -40)
                    }
                }
            }
        }
    }
}

struct ExpenseCell: View {
    let expense: Expense
    
    var body: some View {
        HStack {
            Text(expense.date, format: .dateTime.month(.abbreviated).day())
                .frame(width: 70, alignment: .leading)
            Text(expense.name)
            Spacer()
            Text(expense.value, format: .currency(code: "USD"))
        }
    }
}

#Preview {
    ContentView()
}
