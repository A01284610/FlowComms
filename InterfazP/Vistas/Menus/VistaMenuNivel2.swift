//
//  VistaMenuNivel2.swift
//  InterfazP
//
//  Created by Alumno on 09/06/23.
//

import SwiftUI

struct VistaMenuNivel2: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var mostrarMenuNivel1 = false
    @State private var mostrarMenuNivel2 = false
    @State private var mostrarMenuNivel3 = false
    @State private var mostrarMenuNivel4 = false
    @State private var mostrarMenu = false
    @State private var mostrarComunicaciones = false
    
    
    var body: some View {
        ZStack {
            //Color(red: 247/255, green: 186/255, blue: 106/255)
            Color(red: 125 / 255, green: 132 / 255, blue: 199 / 255)
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
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
                            var tempImages: [Imagen] = [
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
                    
                    Spacer()
                    
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Spacer()
                            VStack {
                                Text("Decorar pastel")
                                    .font(.custom("HelveticaNeue", size: 60))
                                    .bold()
                                    .foregroundColor(.white)
                                
                                Button(action: {
                                    print("Top left button tapped")
                                    mostrarMenuNivel1 = true
                                }) {
                                    GeometryReader { geo in
                                        VStack(spacing: 0) {
                                            Spacer()
                                            
                                            Image("Menus/MenuPastel")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                            //.frame(width: geo.size.width * 0.5, height: geo.size.height * 0.5)
                                                .shadow(radius: 15)
                                                .padding()
                                            
                                            Spacer()
                                        }
                                    }
                                    .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.70)
                                    .background(Color(red: 206 / 255, green: 231 / 255, blue: 65 / 255))
                                    .cornerRadius(geometry.size.width * 0.05)
                                    .shadow(radius: 20)
                                }
                                .fullScreenCover(isPresented: $mostrarMenuNivel1){
                                    DecorarPastelNivel2()
                                }
                            }
                            
                            Spacer()
                            VStack {
                                Text("Reventar globos")
                                    .font(.custom("HelveticaNeue", size: 60))
                                    .bold()
                                    .foregroundColor(.white)
                                
                                Button(action: {
                                    print("Top right button tapped")
                                    mostrarMenuNivel2 = true
                                }) {
                                    GeometryReader { geo in
                                        VStack(spacing: 0) {
                                            Spacer()
                                            
                                            Image("Menus/MenuGlobos")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                            //.frame(width: geo.size.width * 0.5, height: geo.size.height * 0.5)
                                                .shadow(radius: 15)
                                                .padding()
                                            
                                            Spacer()
                                        }
                                    }
                                    .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.70)
                                    .background(Color(red: 251/255 , green: 198/255 , blue: 18/255))
                                    .cornerRadius(geometry.size.width * 0.05)
                                    .shadow(radius: 20)
                                }
                                .fullScreenCover(isPresented: $mostrarMenuNivel2){
                                    RevientaGlobosNivel2()
                                }
                            }
                            
                            Spacer()
                        }
                        
                        
                        Spacer()
                    }
                }
            }
        }
    }
    
}

struct VistaMenuNivel2_Previews: PreviewProvider {
    static var previews: some View {
        VistaMenuNivel2()
    }
}
