//
//  ContentView.swift
//  weSplit
//
//  Created by Noel Craig on 2023-11-22.
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountisFocused: Bool
    
    let tipPercentages = [10, 15, 18, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = billAmount / 100 * tipSelection
        let grandTotal = billAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $billAmount, format: .currency(code: Locale.current.currency?.identifier ?? "CDN"))
                     .keyboardType(.decimalPad)
                     .focused($amountisFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                .pickerStyle(.segmented)
            }
                Section("Total amount for each person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "CDN"))
                }
            }
            .navigationTitle("Split The Bill")
            .toolbar {
                if amountisFocused {
                    Button("Done") {
                        amountisFocused = false
                    }
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
