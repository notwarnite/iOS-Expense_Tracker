//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Ritwik Singh on 29/11/23.
//

import SwiftUI
import SwiftData
import Charts

struct FilteredListView: View {
    
    @Query private var expenses: [Expense] = []
    let expenseCategory: ExpenseCategory?
    
    init(expenseCategory: ExpenseCategory?) {
        self.expenseCategory = expenseCategory
        
        if let expenseCategory {
            _expenses = Query(filter: #Predicate { $0.categoryId == expenseCategory.id } )
        }
        
    }
    
    var body: some View {
        
        List {
            ForEach(expenses) { expense in
                HStack {
                    Text(expense.name)
                    Spacer()
                    Text(expense.value, format: .currency(code: "USD"))
                }
            }
            
        }
        .overlay {
            if expenses.isEmpty {
                ContentUnavailableView(label: {
                    Label("No Expenses Available", systemImage: "list.bullet.rectangle.portrait")
                })
                .offset(y: -40)
            }
        }
        
    }
}

struct ContentView: View {
    
    @Environment(\.modelContext) var context
    @Query(sort: \Expense.date) var expenses: [Expense]
    @State var isShowingExpenseSheet: Bool = false
    @State private var expenseToEdit: Expense?
    @State private var filterExpense: ExpenseCategory = .food
    @State private var showChart: Bool = false
    
    var body: some View {
        TabView {
            VStack{
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
                .navigationTitle("Expenses")
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            VStack{
                Chart (expenses, id: \.id) { element in
                    SectorMark(
                        angle: .value("Category", element.categoryId),
                      innerRadius: .ratio(0.618),
                      angularInset: 1.5
                    )
                   .cornerRadius(5)
                   .foregroundStyle(by: .value("Name", element.category.title))
                }

            }
            .padding()
            .tabItem {
                Label("Insights", systemImage: "magnifyingglass")
            }
            
            VStack{
                HStack{
                    Text("Filter")
                    Picker("Category", selection: $filterExpense) {
                        ForEach(ExpenseCategory.allCases) { category in
                            Text(category.title).tag(category)
                        }
                    }
                }
                FilteredListView(expenseCategory: filterExpense)
            }
            .tabItem {
                Label("Filter", systemImage: "circle.grid.3x3")
            }
        }
        
    }
}

struct ExpenseCell: View {
    let expense: Expense
    
    var body: some View {
        HStack {
            Text(expense.date, format: .dateTime.month(.abbreviated).day())
            Spacer()
            Text(expense.name)
            Spacer()
            Text(expense.value, format: .currency(code: "USD"))
        }
    }
}

#Preview {
    ContentView()
}
