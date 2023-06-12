//
//  VistaRegistro.swift
//  InterfazP
//
//  Created by Alumno on 05/06/23.
//

import SwiftUI
import Firebase

struct VistaRegistro: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var nombre = ""
    @State private var correo = ""
    @State private var contraseña = ""
    @State private var confContraseña = ""
    
    @State private var showConfPassword = false
    @State private var showPassword = false
    
    @State private var mostrarAlerta = false
    
    enum ActiveAlert {
        case first, second
    }
    
    @State private var descripcion = ""
    @State private var titulo = ""
    @State private var activeAlert: ActiveAlert = .first
    
    func register() {
        
        if nombre.count != 0 && contraseña == confContraseña && contraseña.count >= 6 {
            Auth.auth().createUser(withEmail: correo, password: contraseña) { result, error in
                if error != nil {
                    print(error!.localizedDescription)
                    titulo = "Registro no exitoso"
                    descripcion = "Lo sentimos, revise los datos e intente de nuevo"
                    self.activeAlert = .second
                }
                else {
                    titulo = "Registro exitoso"
                    descripcion = "¡Registro correcto!"
                    self.activeAlert = .first
                }
            }
        }
        else {
            titulo = "Registro no exitoso"
            self.activeAlert = .second
            if nombre.count == 0 {
                descripcion = "Complete todos los campos"
            }
            else if contraseña.count < 6 {
                descripcion = "La contraseña debe tener al menos 6 caracteres"
            }
            else {
                descripcion = "Las contraseñas no coinciden"
            }
        }
        mostrarAlerta = true
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            HStack (spacing: 0){
                GeometryReader { geo1 in
                    VStack{
                        ZStack{
                            Color(red: 247/255 , green: 186/255 , blue: 106/255)
                        }
                        VStack {
                            HStack{
                                Button(action: {
                                    dismiss()
                                }) {
                                    HStack {
                                        Image(systemName: "chevron.left")
                                            .foregroundColor(.white)
                                        Text("Regresar")
                                        //.font(.title)
                                            .foregroundColor(.white)
                                        //.background(Color.blue)
                                            .cornerRadius(10)
                                    }
                                    //                                    .alignmentGuide(.leading) { _ in 0 } // Align the content to the leading edge
                                    //                                    .alignmentGuide(.top) { geo1 in
                                    //                                        -geometry.size.height / 2 // Align the content to the top edge
                                    //                                    }
                                    .padding(.leading, 40)
                                    .padding(.top, 40)
                                }
                                Spacer()
                            }
                            Spacer()
                            
                            VStack {
                                Image(systemName: "person.crop.square.filled.and.at.rectangle")
                                    .foregroundColor(.black)
                                    .font(.largeTitle)
                                Text("Registrar cuenta")
                                    .font(.largeTitle)
                                    .foregroundColor(Color.black)
                                    .bold()
                                //.padding([.top, .bottom], 40)
                                    .background(Color.clear)
                                    .frame(width: geo1.size.width*0.5)
                            }
                            
                            
                            
                            VStack (alignment: .leading, spacing: 15) {
                                HStack{
                                    Image(systemName: "person.crop.circle")
                                        .foregroundColor(.black)
                                        .font(.title)
                                    TextField("Nombre", text: self.$nombre)
                                        .padding()
                                        .background(Color.white)
                                        .foregroundColor(.black)
                                        .disableAutocorrection(true)
                                        .cornerRadius(20.0)
                                }
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
                                HStack {
                                    Button(action: {
                                        showConfPassword.toggle()
                                    }) {
                                        Image(systemName: showConfPassword ? "eye.slash" : "eye")
                                            .foregroundColor(.black)
                                            .font(.title)
                                    }
                                    if showConfPassword {
                                        TextField("Confirmar contraseña", text: self.$confContraseña)
                                            .padding()
                                            .background(Color.white)
                                            .foregroundColor(.black)
                                            .disableAutocorrection(true)
                                            .cornerRadius(20.0)
                                    } else {
                                        SecureField("Confirmar contraseña", text: self.$confContraseña)
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
                            
                            //HStack {
                            Button(action: {
                                register()
                            }) {
                                Text("Registrar")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color(red: 38/255 , green: 169/255 , blue: 224/255))
                                    .cornerRadius(10)
                            }
                            .alert(isPresented: $mostrarAlerta) {
                                switch activeAlert {
                                case .first:
                                    return Alert(title: Text(titulo), message: Text(descripcion), dismissButton: .default(Text("OK")) { dismiss()})
                                case .second:
                                    return Alert(title: Text(titulo), message: Text(descripcion), dismissButton: .default(Text("OK")) {})
                                }
                                
                            }
                            
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            
                            //}
                            
                        }
                        .frame(height: geo1.size.height)
                    }
                    .keyboardAdaptive()
                }
                .background(Color(red: 247/255 , green: 186/255 , blue: 106/255))
                .frame(width: geometry.size.width * 2/3)
                .keyboardAdaptive()
                
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

struct VistaRegistro_Previews: PreviewProvider {
    static var previews: some View {
        VistaRegistro()
    }
}
