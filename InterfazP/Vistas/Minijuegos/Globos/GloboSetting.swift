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
    
    @Binding var maxGlobos: Double
    @Binding var minGlobos: Double
    @Binding var sizeGlobo: Double
    
    @Binding var counter: Int
    @Binding var nCandles: Int
    
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Maximos Globos")
                .font(.largeTitle)
                .fontWeight(.bold)
            HStack{
                Slider(value: $maxGlobos, in: minGlobos...100, step: 1)
                Text("\(Int(maxGlobos))")
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .frame(width: 200)
            
            
//            Text("Minimos Globos")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//            HStack{
//                Slider(value: $minGlobos, in: 1...maxGlobos, step: 1)
//                Text("\(minGlobos)")
//                    .font(.title3)
//                    .fontWeight(.bold)
//            }
//            .frame(width: 200)
            
            
            Text("Tamaño de Globo")
                .font(.largeTitle)
                .fontWeight(.bold)
            HStack{
                Slider(value: $sizeGlobo, in: 5...200, step: 1)
                Text("\(Int(sizeGlobo))")
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
