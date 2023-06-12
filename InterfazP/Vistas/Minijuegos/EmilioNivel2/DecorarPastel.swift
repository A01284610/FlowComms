//
//  DecorarPastel.swift
//  InterfazP
//
//  Created by Diego Esparza on 09/06/23.
//

import SwiftUI

struct DecorarPastel: View {
    
    @State var offset: CGSize = .zero
    @State private var image1Position = CGPoint(x: 100, y: 100)
    @State private var image2Position = CGPoint(x: 250, y: 100)
    @State private var pastelImage = "Emilio/pastelA"
    @State private var ladrillosImage = "Emilio/ladrillos"
    @State private var betunAzul = "Emilio/betunAzul"
    @State private var betunes = ""
    @State private var velas = ""
    @State private var perlas = ""
    @State private var chispas = ""
    @State private var imagenes = ""
    
    @Environment(\.dismiss) private var dismiss
    @State private var mostrarMenu = false
    
    @State private var mostrarComunicaciones = false
    
    var body: some View {
        VStack(){
            
            Spacer()
            
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
                
                Spacer()
                
                
                VStack(){
                    
                    
                    GeometryReader { geo in
                        
                        
                        Text("Nivel 2")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(width: geo.size.width * 0.45, height: geo.size.height * 0.45)
                            .cornerRadius(20)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color(red: 251/255 , green: 198/255 , blue: 18/255)))
                            .position(CGPoint(x: geo.size.width/2, y: 2 * geo.size.height/7))
                        
                        Spacer()
                        
                        
                        Text("Decora el pastel")
                            .foregroundColor(Color.white)
                            .frame(width: geo.size.width * 0.45, height: geo.size.height * 0.45)
                            .bold()
                            .cornerRadius(20)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color(red: 0.295, green: 0.31, blue: 0.441)))
                            .position(CGPoint(x: geo.size.width/2, y: 6 * geo.size.height/7))
                        
                    }
                    
                }
                .frame(height:170)
                //.background(Color.red)
                
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
                //.padding(.top, 40)
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
                //.padding(.top, 40)
                .fullScreenCover(isPresented: $mostrarMenu){
                    VistaMenu()
                }
                
            }
            
            
            
            GeometryReader { geo in
                HStack {
                    GeometryReader { geo2 in
                        ZStack{
                            Image(ladrillosImage)
                                .resizable()
                                .frame(width:geo2.size.width*1,height:geo2.size.height*1.0)
                            //width:geo2.size.width*1,height:geo2.size.height*1.0
                                .scaledToFill()
                            
                            
                            Image(pastelImage)
                                .resizable()
                                .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                .scaledToFill()
                                .offset(x: 20, y: 45)
                            
                            Image(betunes)
                                .resizable()
                                .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                .scaledToFill()
                                .offset(x: 20, y: 45)
                            
                            Image(velas)
                                .resizable()
                                .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                .scaledToFill()
                                .offset(x: 20, y: 45)
                            
                            Image(perlas)
                                .resizable()
                                .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                .scaledToFill()
                                .offset(x: 20, y: 45)
                            
                            Image(chispas)
                                .resizable()
                                .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                .scaledToFill()
                                .offset(x: 20, y: 45)
                                .onDrop(of: ["public.text"], isTargeted: nil) { providers in
                                    if let provider = providers.first {
                                        provider.loadObject(ofClass: NSString.self) { item, _ in
                                            if let string = item as? NSString {
                                                if string == "betunAzul" {
                                                    DispatchQueue.main.async {
                                                        betunes = "Emilio/betunAzul"
                                                    }
                                                }else if string == "betunRosa" {
                                                    DispatchQueue.main.async{
                                                        betunes = "Emilio/betunRosa"
                                                        
                                                    }
                                                }else if string == "betunNaranja" {
                                                    DispatchQueue.main.async{
                                                        betunes = "Emilio/betunNaranja"
                                                        
                                                    }
                                                }else if string == "chispas" {
                                                    DispatchQueue.main.async{
                                                        chispas = "Emilio/chispas"
                                                    }
                                                }else if string == "perlas" {
                                                    DispatchQueue.main.async{
                                                        perlas = "Emilio/perlas"
                                                    }
                                                } else if string == "velas" {
                                                    DispatchQueue.main.async{
                                                        velas = "Emilio/velas"
                                                    }
                                                }else if string == "blanco"{
                                                    DispatchQueue.main.async{
                                                        velas = ""
                                                        perlas = ""
                                                        chispas = ""
                                                        betunes = ""
                                                        
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    return true
                                }
                            
                            
                            
                        }
                        
                    }
                    .padding()
                    
                    VStack(){
                        GeometryReader { geo2 in
                            //Aqui va lo relacionando con arrastrar y soltar
                            Image("Emilio/betun_azul")
                                .resizable()
                                .onDrag {
                                    return NSItemProvider(object: "betunAzul" as NSString)
                                }
                            
                                .frame(width: 100, height: 100)
                                .position(CGPoint(x: 80, y: 70))
                            Image("Emilio/betun_rosa")
                                .resizable()
                                .onDrag {
                                    return NSItemProvider(object: "betunRosa" as NSString)
                                }
                            
                                .frame(width: 100, height: 100)
                                .position(CGPoint(x: 230, y: 70))
                            Image("Emilio/betun_naranja")
                                .resizable()
                                .onDrag {
                                    return NSItemProvider(object: "betunNaranja" as NSString)
                                }
                            
                                .frame(width: 100, height: 100)
                                .position(CGPoint(x: 230, y: 220))
                            
                            Image("Emilio/chispa")
                                .resizable()
                                .onDrag {
                                    return NSItemProvider(object: "chispas" as NSString)
                                }
                            
                                .frame(width: 100, height: 100)
                                .position(CGPoint(x: 80, y: 370))
                            Image("Emilio/perla")
                                .resizable()
                                .onDrag {
                                    return NSItemProvider(object: "perlas" as NSString)
                                }
                            
                                .frame(width: 100, height: 100)
                                .position(CGPoint(x: 230, y: 370))
                            Image("Emilio/vela")
                                .resizable()
                                .onDrag {
                                    return NSItemProvider(object: "velas" as NSString)
                                }
                            
                                .frame(width: 100, height: 100)
                                .position(CGPoint(x: 80, y: 220))
                            
                            Image(pastelImage)
                                .resizable()
                                .onDrag {
                                    return NSItemProvider(object: "blanco" as NSString)
                                }
                            
                                .frame(width: 100, height: 100)
                                .position(CGPoint(x: 150, y: 470))
                            
                        }
                    }
                    .frame(width: geo.size.width*0.25)
                    .background(Color(red: 0.502, green: 0.502, blue: 0.502))
                    .padding()
                }
                .background(.white)
                .padding()
            }
            
            Spacer()
            
        }
        .background(LinearGradient(
            gradient: Gradient(colors: [Color(red: 125 / 255, green: 132 / 255, blue: 199 / 255), Color.purple]),
            startPoint: .leading,
            endPoint: .trailing
        ))
    }
    
}

struct DecorarPastel_Previews: PreviewProvider {
    static var previews: some View {
        DecorarPastel()
    }
}
