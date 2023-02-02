//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Matheus Müller on 01/02/23.
//

import SwiftUI

struct ContentView: View {
    @State private var inputTemp = 0.0
    @State private var unitFrom = "Celsius"
    @State private var unitTo = "Celsius"
    @FocusState private var fieldFocus: Bool
    
    var result: Double {
        var resultValue = inputTemp
        
        if unitFrom == "Celsius" && unitTo == "Fahrenheit" {
            resultValue = (inputTemp * 1.8) + 32
        } else if unitFrom == "Celsius" && unitTo == "Kelvin" {
            resultValue = resultValue + 273.15
        } else if unitFrom == "Fahrenheit" && unitTo == "Celsius" {
            resultValue = (inputTemp - 32) / 1.8
        } else if unitFrom == "Fahrenheit" && unitTo == "Kelvin" {
            resultValue = (inputTemp + 459.67) * (5 / 9)
        } else if unitFrom == "Kelvin" && unitTo == "Celsius" {
            resultValue = resultValue - 273.15
        } else if unitFrom == "Kelvin" && unitTo == "Fahrenheit" {
            resultValue = (inputTemp - 273.15) * (9 / 5) + 32
        } else {
            resultValue = inputTemp
        }
        
        return resultValue
    }
    
    let units = ["Celsius", "Fahrenheit", "Kelvin"]
    
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Unit", selection: $unitFrom) {
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                    }
                    
                    TextField("Temperature", value: $inputTemp, formatter: Self.formatter)
                        .keyboardType(.numbersAndPunctuation) // Not using .decimalPad because don't have - symbol
                        .focused($fieldFocus)
                } header: {
                    Text("Convert From")
                }
                
                Section {
                    Picker("Unit", selection: $unitTo) {
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                    }
                } header: {
                    Text("Convert To")
                }
                
                Section {
                    Text(result, format: .number)
                } header: {
                    Text("Result")
                }
            }
            .navigationTitle("Temperature Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        fieldFocus = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
