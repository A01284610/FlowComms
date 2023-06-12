//
//  VistaMenu.swift
//  InterfazP
//
//  Created by Diego Esparza on 07/06/23.
//

import SwiftUI
import Firebase

struct VistaMenu: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var mostrarMenuMinijuegos = false
    @State private var mostrarComunicaciones = false
    @State private var terminarSesion = false
    
    @State private var tituloAlerta = ""
    @State private var descripcion = ""
    @State private var showAlert = false
    
    enum ActiveAlert {
        case first, second
    }
    
    @State private var activeAlert: ActiveAlert = .first
    
    func signOut() {
        
        do {
            try Auth.auth().signOut()
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            tituloAlerta = "Cierre de sesión no exitoso"
            descripcion = "No se ha cerrado la sesión, intente de nuevo."
            self.activeAlert = .second
            showAlert = true
        }
        tituloAlerta = "Cierre de sesión exitoso"
        descripcion = "Se ha cerrado la sesión de manera exitosa."
        //terminarSesion = true
        self.activeAlert = .first
        showAlert = true
    }
    
    
    var body: some View {
        ZStack {
            Color(red: 247/255 , green: 186/255 , blue: 106/255)
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                VStack {
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            signOut()
                        }) {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.red)
                                .clipShape(Rectangle())
                                .cornerRadius(20)
                        }
                        .padding(.trailing, 40)
                        .padding(.top, 40)
                        .fullScreenCover(isPresented: $terminarSesion){
                            VistaInicio()
                        }
                        .alert(isPresented: $showAlert) {
                            switch activeAlert {
                            case .first:
                                return Alert(title: Text(tituloAlerta), message: Text(descripcion), dismissButton: .default(Text("OK")) { terminarSesion = true})
                            case .second:
                                return Alert(title: Text(tituloAlerta), message: Text(descripcion), dismissButton: .default(Text("OK")) {})
                            }
                            
                        }
                        
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 0) {
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
                                            
                                            Image("Menus/MenuComunicaciones")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: geo.size.width * 0.5, height: geo.size.width * 0.5)
                                                .shadow(radius: 15)
                                                .padding()
                                            
                                            Text("Comunicaciones")
                                                .font(.custom("HelveticaNeue", size: 50))
                                                .bold()
                                                .foregroundColor(.black)
                                                .frame(width: geo.size.width, height: 40)
                                            
                                            Spacer()
                                        }
                                    }
                                    .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.85)
                                    .background(Color(red: 206 / 255, green: 231 / 255, blue: 65 / 255))
                                    .cornerRadius(geometry.size.width * 0.05)
                                    .shadow(radius: 20)
                                }
                                .fullScreenCover(isPresented: $mostrarComunicaciones){
                                    VistaMenuTablero()
                                }
                            }
                            
                            Spacer()
                            VStack {
                                Button(action: {
                                    print("Left button tapped")
                                    mostrarMenuMinijuegos = true
                                }) {
                                    GeometryReader { geo in
                                        VStack(spacing: 0) {
                                            Spacer()
                                            
                                            Image("Menus/MenuVideojuego")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: geo.size.width * 0.5, height: geo.size.width * 0.5)
                                                .shadow(radius: 15)
                                                .padding()
                                            
                                            Text("Minijuegos")
                                                .font(.custom("HelveticaNeue", size: 50))
                                                .bold()
                                                .foregroundColor(.black)
                                                .frame(width: geo.size.width, height: 40)
                                            
                                            Spacer()
                                        }
                                    }
                                    .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.85)
                                    .background(Color(red: 125 / 255, green: 132 / 255, blue: 199 / 255))
                                    .cornerRadius(geometry.size.width * 0.05)
                                    .shadow(radius: 20)
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
}



struct VistaMenu_Previews: PreviewProvider {
    static var previews: some View {
        VistaMenu()
    }
}
