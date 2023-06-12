//
//  MenuNivel1.swift
//  InterfazP
//
//  Created by Diego Esparza on 08/06/23.
//

import SwiftUI
import Subsonic

struct MenuNivel1: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var opcionGato = false
    @State var opcionPerro = false
    @State private var mostrarMenu = false
    @State private var mostrarComunicaciones = false
    
    var body: some View {
        ZStack {
            Color(red: 125 / 255, green: 132 / 255, blue: 199 / 255)
            VStack {
                
                HStack {
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
                    
                    Button(action: {
                        mostrarMenu = true
                    }) {
                        Image(systemName: "house.fill")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Rectangle())
                            .cornerRadius(20)
                    }
                    .padding(.trailing, 40)
                    .padding(.top, 40)
                    .fullScreenCover(isPresented: $mostrarMenu){
                        VistaMenu()
                    }
                    
                }
                
                //Title Level and Name
                GeometryReader { geo in
                    VStack {
                        Text("NIVEL 1")
                            .font(.custom("HelveticaNeue", size: 40))
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color(red: 206 / 255, green: 231 / 255, blue: 65 / 255))
                                    .frame(width: geo.size.width/2, height: 70))
                            .position(x: geo.size.width/3.5, y: geo.size.height/3.1)
                        Text("Toca la mascota")
                            .foregroundColor(Color.white)
                            .font(.custom("HelveticaNeue", size: 40))
                            .background(
                                RoundedRectangle(cornerRadius: 1, style: .continuous)
                                    .fill(Color(red: 75 / 255, green: 79 / 255, blue: 113 / 255))
                                    .frame(width: geo.size.width/2, height: 70))
                            .position(x: geo.size.width/3.5)
                    }
                    .position(x: geo.size.width/1.4, y: geo.size.height/2.1)
                }
                //Pet Options
                GeometryReader { geo in
                    HStack {
                        Spacer()
                        Button {
                            opcionGato = true
                        } label: {
                            Image("Nivel1/gato")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width/3, height: geo.size.height)
                        }
                        .fullScreenCover(isPresented: $opcionGato) {
                            GatoNivel1()
                        }
                        Spacer()
                        Button {
                            opcionPerro = true
                        } label: {
                            Image("Nivel1/perro")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width/3, height: geo.size.height)
                        }
                        .fullScreenCover(isPresented: $opcionPerro) {
                            PerroNivel1()
                        }
                        Spacer()
                    }
                    .frame(width: geo.size.width, height: geo.size.height/2.3)
                }
            }
        }
        .ignoresSafeArea()
    }
    
}

struct MenuNivel1_Previews: PreviewProvider {
    static var previews: some View {
        MenuNivel1()
    }
}
