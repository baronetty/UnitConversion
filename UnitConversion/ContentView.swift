import SwiftUI

struct ContentView: View {
    @State private var amountCelsius = 0.0
    @State private var unitDegreeInput = 0
    @State private var unitDegreeOutput = 0
    @FocusState private var amountIsFocused: Bool
    
    var unitsDegree: [String] = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var convertedValue: Double {
        let inputUnit = unitsDegree[unitDegreeInput]
        let outputUnit = unitsDegree[unitDegreeOutput]

        var result = amountCelsius

        if inputUnit == "Celsius" && outputUnit == "Fahrenheit" {
            result = amountCelsius * 9 / 5 + 32
        } else if inputUnit == "Celsius" && outputUnit == "Kelvin" {
            result = amountCelsius + 273.15
        } else if inputUnit == "Fahrenheit" && outputUnit == "Celsius" {
            result = (amountCelsius - 32) * 5 / 9
        } else if inputUnit == "Fahrenheit" && outputUnit == "Kelvin" {
            result = (amountCelsius - 32) * 5 / 9 + 273.15
        } else if inputUnit == "Kelvin" && outputUnit == "Celsius" {
            result = amountCelsius - 273.15
        } else if inputUnit == "Kelvin" && outputUnit == "Fahrenheit" {
            result = (amountCelsius - 273.15) * 9 / 5 + 32
        }

        return result
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Input") {
                    TextField("Degree", value: $amountCelsius, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Pick Unit", selection: $unitDegreeInput) {
                        ForEach(0..<unitsDegree.count, id: \.self) {
                            Text(unitsDegree[$0])
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Output") {
                    Text("Converted: \(convertedValue, specifier: "%.2f") \(unitsDegree[unitDegreeOutput])")
                    
                    Picker("Pick Unit", selection: $unitDegreeOutput) {
                        ForEach(0..<unitsDegree.count, id: \.self) {
                            Text(unitsDegree[$0])
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Degree Converter")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
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
