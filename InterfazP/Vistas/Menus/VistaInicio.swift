//
//  VistaInicio.swift
//  InterfazP
//
//  Created by Diego Esparza on 09/06/23.
//

import SwiftUI
import Firebase

struct VistaInicio: View {
    
    @State var nombre = ""
    @State var correo = ""
    @State var contraseña = ""
    @State var confContraseña = ""
    
    @State private var mostrarAlerta = false
    @State private var mostrarRegistro = false
    @State private var mostrarMenu = false
    
    @State private var titulo = ""
    @State private var errorDescripcion = ""
    @State private var showErrorAlert = false
    
    @State private var showPassword = false
    
    @State private var userIsLoggedIn = false
    
    func login() {
        Auth.auth().signIn(withEmail: correo, password: contraseña) { result, error in
            if error != nil {
                print(error!.localizedDescription)
                errorDescripcion = error!.localizedDescription
                showErrorAlert = true
            }
            else {
                mostrarMenu = true
            }
        }
    }
    
    func login2() {
        
        if correo.count != 0 && contraseña.count != 0 {
            Auth.auth().signIn(withEmail: correo, password: contraseña) { result, error in
                if error != nil {
                    print(error!.localizedDescription)
                    //errorDescripcion = error!.localizedDescription
                    titulo = "Inicio de sesión no exitoso"
                    errorDescripcion = "Asegurese de ingresar los datos correctamente."
                    showErrorAlert = true
                }
                else {
                    mostrarMenu = true
                }
            }
        }
        else {
            titulo = "Inicio de sesión no exitoso"
            errorDescripcion = "Complete todos los campos"
            showErrorAlert = true
        }
    }
    
    
    var body: some View {
        if userIsLoggedIn {
            VistaMenu()
        }
        else {
            content
        }
    }
    
    var content: some View {
        
        GeometryReader { geometry in
            HStack (spacing: 0){
                GeometryReader { geo1 in
                    VStack{
                        ZStack{
                            Color(red: 247/255 , green: 186/255 , blue: 106/255)
                        }
                        VStack {
                            Spacer()
                            Spacer()
                            VStack {
                                Image(systemName: "person.crop.circle.badge.checkmark")
                                    .foregroundColor(.black)
                                    .font(.largeTitle)
                                Text("Iniciar sesión")
                                    .font(.largeTitle)
                                    .foregroundColor(Color.black)
                                    .bold()
                                //.padding([.top, .bottom], 40)
                                    .background(Color.clear)
                                    .frame(width: geo1.size.width*0.5)
                            }
                            
                            VStack (alignment: .leading, spacing: 15) {
                                HStack{
                                    Image(systemName: "mail")
                                        .foregroundColor(.black)
                                        .font(.title)
                                    TextField("Correo electrónico", text: self.$correo)
                                        .padding()
                                        .background(Color.white)
                                        .foregroundColor(.black)
                                        .disableAutocorrection(true)
                                        .keyboardType(.emailAddress)
                                        .cornerRadius(20.0)
                                }
                                HStack {
                                    Button(action: {
                                        showPassword.toggle()
                                    }) {
                                        Image(systemName: showPassword ? "eye.slash" : "eye")
                                            .foregroundColor(.black)
                                            .font(.title)
                                    }
                                    if showPassword {
                                        TextField("Contraseña", text: self.$contraseña)
                                            .padding()
                                            .background(Color.white)
                                            .foregroundColor(.black)
                                            .disableAutocorrection(true)
                                            .cornerRadius(20.0)
                                    } else {
                                        SecureField("Contraseña", text: self.$contraseña)
                                            .padding()
                                            .background(Color.white)
                                            .foregroundColor(.black)
                                            .disableAutocorrection(true)
                                            .cornerRadius(20.0)
                                    }
                                    
                                }
                                
                                
                            }
                            .frame(width: geo1.size.width*0.75)
                            .padding()
                            
                            VStack{
                                Button(action: {
                                    login2()
                                }) {
                                    Text("Iniciar sesión")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color(red: 38/255 , green: 169/255 , blue: 224/255))
                                        .cornerRadius(10)
                                }
                                .fullScreenCover(isPresented: $mostrarMenu){
                                    VistaMenu()
                                    //VistaTest()
                                }
                                HStack(spacing: 0) {
                                    Text("¿Aún no tienes cuenta?")
                                    //.font(.title)
                                        .foregroundColor(.white)
                                        .padding()
                                    //.background(Color.blue)
                                        .cornerRadius(10)
                                    Button(action: {
                                        mostrarRegistro = true
                                    }) {
                                        Text("Registrate aquí")
                                        //.font(.title)
                                            .underline()
                                            .foregroundColor(.white)
                                            .padding()
                                            .cornerRadius(10)
                                    }
                                    .fullScreenCover(isPresented: $mostrarRegistro){
                                        VistaRegistro()
                                    }
                                    .alert(isPresented: $showErrorAlert) {
                                        Alert(
                                            title: Text(titulo),
                                            message: Text(errorDescripcion),
                                            dismissButton: .default(Text("OK"))
                                        )
                                    }
                                }
                                
                                
                                
                            }
                            
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            
                        }
                        .frame(height: geo1.size.height)
                    }
                    .onAppear {
                        Auth.auth().addStateDidChangeListener { auth, user in
                            if user != nil {
                                userIsLoggedIn.toggle()
                            }
                        }
                    }
                }
                .background(Color(red: 247/255 , green: 186/255 , blue: 106/255))
                .frame(width: geometry.size.width * 2/3)
                
                GeometryReader { geo2 in
                    VStack{
                        ZStack{
                            Color(red: 38/255 , green: 169/255 , blue: 224/255)
                        }
                        VStack {
                            Image("Logos/Logo1")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            Image("Logos/FlowCommsLogo2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            //.frame(width: geo1.size.width*0.4, height: geo1.size.height*0.4)
                        }
                        .frame(height: geo2.size.height)
                    }
                }
                .background(Color(red: 38/255 , green: 169/255 , blue: 224/255))
                .frame(width: geometry.size.width * 1/3)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
}

struct VistaInicio_Previews: PreviewProvider {
    static var previews: some View {
        VistaInicio()
    }
}
