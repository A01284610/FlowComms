//
//  GloboSetting.swift
//  InterfazP
//
//  Created by Alumno on 09/06/23.
//

import SwiftUI

import SwiftUI


struct GloboSetting: View {
    
    @Binding var isSettingsVisible: Bool
    
    @Binding var maxGlobos: Int
    @Binding var minGlobos: Int
    @Binding var sizeGlobo: Int
    
    @Binding var counter: Int
    @Binding var nCandles: Int
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Max Globos")
                .font(.largeTitle)
                .fontWeight(.bold)
            Stepper(value: $maxGlobos, in: minGlobos...100) {
                Text("\(maxGlobos)")
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .frame(width: 200)
            
            
            Text("Min Globos")
                .font(.largeTitle)
                .fontWeight(.bold)
            Stepper(value: $minGlobos, in: 1...maxGlobos) {
                Text("\(minGlobos)")
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .frame(width: 200)
            
            
            Text("Size Globo")
                .font(.largeTitle)
                .fontWeight(.bold)
            Stepper(value: $sizeGlobo, in: 5...200) {
                Text("\(sizeGlobo)")
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .frame(width: 200)
            Button(action: {
                counter = nCandles
                isSettingsVisible = false
            }) {
                Text("Actualizar")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}
