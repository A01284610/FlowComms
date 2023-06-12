//
//  VistaTest.swift
//  InterfazP
//
//  Created by Diego Esparza on 09/06/23.
//

import SwiftUI

struct VistaTest: View {
    
    @State private var mostrarMenuMinijuegos = false
    @State private var mostrarComunicaciones = false
    @State private var mostrarMenu = false
    
    var body: some View {
        ZStack {
            Color(red: 247/255, green: 186/255, blue: 106/255)
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                VStack{
                    HStack {
                        Spacer()
                        
                        VStack{
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
                            .padding(.trailing, 10)
                            .fullScreenCover(isPresented: $mostrarMenu){
                                VistaMenu()
                                // VistaComunicaciones()
                            }
                            
                            Button(action: {
                                // Handle house button tapped
                            }) {
                                Image(systemName: "gear")
                                    .font(.title)
                                    .foregroundColor(.black)
                                    .padding(10)
                                    .background(Color.white)
                                    .clipShape(Rectangle())
                                    .cornerRadius(20)
                            }
                        }
                    }
                    
                    //Spacer()
                    
                    HStack(spacing: 0) {
                        Spacer()
                        
                        VStack {
                            Button(action: {
                                print("Left button tapped")
                                mostrarComunicaciones = true
                            }) {
                                GeometryReader { geo in
                                    VStack(spacing: 0) {
                                        Spacer()
                                        
                                        Image("MenuComunicaciones")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: geo.size.width * 0.5, height: geo.size.width * 0.5)
                                            .padding()
                                        
                                        Text("Comunicaciones")
                                            .font(.headline)
                                            .foregroundColor(.black)
                                            .frame(width: geo.size.width, height: 40)
                                        
                                        Spacer()
                                    }
                                }
                                .frame(width: min(geometry.size.width * 0.45, geometry.size.height), height: min(geometry.size.width * 0.45, geometry.size.height))
                                .background(Color.white)
                                .cornerRadius(min(geometry.size.width, geometry.size.height) * 0.05)
                            }
                            //                            .fullScreenCover(isPresented: $mostrarComunicaciones){
                            //                                VistaComunicaciones()
                            //                            }
                        }
                        
                        Spacer()
                        
                        VStack {
                            Button(action: {
                                print("Right button tapped")
                                mostrarMenuMinijuegos = true
                            }) {
                                GeometryReader { geo in
                                    VStack(spacing: 0) {
                                        Spacer()
                                        
                                        Image("MenuVideojuego")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: geo.size.width * 0.5, height: geo.size.width * 0.5)
                                            .padding()
                                        
                                        Text("Minijuegos")
                                            .font(.headline)
                                            .foregroundColor(.black)
                                            .frame(width: geo.size.width, height: 40)
                                        
                                        Spacer()
                                    }
                                }
                                .frame(width: min(geometry.size.width * 0.45, geometry.size.height), height: min(geometry.size.width * 0.45, geometry.size.height))
                                .background(Color(red: 125 / 255, green: 132 / 255, blue: 199 / 255))
                                .cornerRadius(min(geometry.size.width, geometry.size.height) * 0.05)
                            }
                            .fullScreenCover(isPresented: $mostrarMenuMinijuegos){
                                VistaMenuMinijuegos()
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

struct VistaTest_Previews: PreviewProvider {
    static var previews: some View {
        VistaTest()
    }
}
