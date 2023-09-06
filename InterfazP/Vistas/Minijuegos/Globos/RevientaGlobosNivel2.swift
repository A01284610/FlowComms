//
//  RevientaGlobosNivel2.swift
//  InterfazP
//
//  Created by Diego Esparza on 09/06/23.
//

import SwiftUI

struct RevientaGlobosNivel2: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var maxGlobos: Double = 15
    @State var minGlobos: Double = 3
    let inOrder: Bool = false
    @State var sizeGlobo: Double = 100
    
    
    @State private var isSettingsVisible = false
    
    @State private var counter = 0
    @State private var score = 0
    @State private var nCandles = 0
    @State private var positions: [(Float, Float)] = []
    @State private var setColors: [String] = []
    
    @State private var mostrarComunicaciones = false
    
    
    @State private var viewID = UUID()
    
    let balloons: [String] = ["Alex/globo_amarillo","Alex/globo_celeste","Alex/globo_indigo","Alex/globo_morado","Alex/globo_naranja","Alex/globo_rojo","Alex/globo_verde"]
    
    
    
    func changeArray(in geo: GeometryProxy) {
        print(counter)
        if counter >= nCandles {
            positions.removeAll()
            setColors.removeAll()
            nCandles = Int.random(in: Int(minGlobos)...Int(maxGlobos))
            
            let bounds = geo.frame(in: .local)
            let minX = Float(bounds.minX + (bounds.maxX-bounds.minX)*0.05)
            let minY = Float(bounds.minY + (bounds.maxY-bounds.minY)*0.2)
            let maxX = Float(bounds.maxX - (bounds.maxX-bounds.minX)*0.15)
            let maxY = Float(bounds.maxY - (bounds.maxY-bounds.minY)*0.05)
            
            for _ in 0..<nCandles {
                let randomX = Float.random(in: minX...maxX)
                let randomY = Float.random(in: minY...maxY)
                let position: (Float, Float) = (randomX, randomY)
                positions.append(position)
                setColors.append(balloons.randomElement()!)
            }
            viewID = UUID()
            counter = 0
            print("N: \(nCandles)")
        }
    }
    
    
    var body: some View {
        GeometryReader{ geo2 in
            VStack {
                HStack{
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrowshape.backward.fill")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Rectangle())
                            .cornerRadius(20)
                    }
                    .padding(.leading, 40)
                    .padding(.top, 40)
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    
                    Text("NIVEL 2")
                        .font(.custom("HelveticaNeue", size: 40))
                        .shadow(radius: 10)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color(red: 251/255 , green: 198/255 , blue: 18/255))
                                .frame(width: geo2.size.width/2, height: geo2.size.height/11))
                    
                    Spacer()
                    Spacer()
                    
                    Button(action: {
                        mostrarComunicaciones = true
                    }) {
                        Image(systemName: "person.wave.2.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color(red: 206 / 255, green: 231 / 255, blue: 65 / 255))
                            .clipShape(Rectangle())
                            .cornerRadius(20)
                    }
                    .padding(.trailing, 15)
                    .padding(.top, 40)
                    .fullScreenCover(isPresented: $mostrarComunicaciones){
                        let tempImages: [Imagen] = [
                            Imagen(ident: "1", nombre: "perro", imagen: "DefaultPictos/perro", descripcion: "def", tags: ["animal", "macosta", "perro", "default"], nino: 1, online: false),
                            Imagen(ident: "1", nombre: "gato", imagen: "DefaultPictos/gato", descripcion: "def", tags: ["animal", "macosta", "gato", "default"], nino: 1, online: false)
                        ]
                        
                        TableComms(board: Tablero(nombre: "Comunicador Básico", numCol: 2, numRow: 1, descripcion: "plchldr", imagenes: tempImages))
                    }
                    
                    Button {
                        isSettingsVisible = true
                    } label: {
                        Image(systemName: "gear")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Rectangle())
                            .cornerRadius(20)
                    }
                    .sheet(isPresented: $isSettingsVisible) {
                        GloboSetting(isSettingsVisible: $isSettingsVisible, maxGlobos: $maxGlobos, minGlobos: $minGlobos, sizeGlobo: $sizeGlobo, counter: $counter, nCandles: $nCandles)
                    }
                    .padding(.trailing, 40)
                    .padding(.top, 40)
                    
                    
                    
                    
                    
                    
                }
                
                GeometryReader { geo in
                    ZStack {
                        Image("Alex/LugarFiestas")
                            .resizable()
                            .opacity(0.50)
                        
                        ForEach(positions.indices.reversed(), id: \.self) { index in
                            let index2 = index + 1
                            BalloonView(counter: $counter, score: $score, inOrder: inOrder, num: index2, fSize: Int(sizeGlobo)+120, imageString: setColors[index])
                                .frame(width: CGFloat(sizeGlobo+120), height: CGFloat(sizeGlobo+120))
                                .id(viewID) // Unique identifier for each candle view
                                .position(
                                    x: CGFloat(positions[index].0),
                                    y: CGFloat(positions[index].1)
                                )
                            
                            
                        }
                    }
                    .background(.black)
                    .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY)
                    .frame(width: geo.size.width * 0.90)
                    .onAppear {
                        changeArray(in: geo)
                    }
                    .onChange(of: counter) { _ in
                        changeArray(in: geo)
                    }
                    .onChange(of: UIDevice.current.orientation) { newOrientation in
                        changeArray(in: geo)
                    }
                    
                }
                
                Text("Globos reventados: \(score)")
                    .font(.custom("HelveticaNeue", size: 40))
                    .shadow(radius: 10)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(red: 230/255, green: 230/255, blue: 230/255))
                            .frame(width: geo2.size.width/2, height: geo2.size.height/11))
                
                
                
                
            }
            .background(LinearGradient(
                gradient: Gradient(colors: [Color(red: 125 / 255, green: 132 / 255, blue: 199 / 255), Color.purple]),
                startPoint: .leading,
                endPoint: .trailing
            ))
        }
        
        
        
    }
    
    
}

struct RevientaGlobosNivel2_Previews: PreviewProvider {
    static var previews: some View {
        RevientaGlobosNivel2()
    }
}
