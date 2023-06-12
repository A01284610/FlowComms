//
//  VistaTestV.swift
//  InterfazP
//
//  Created by Diego Esparza on 09/06/23.
//

import SwiftUI
import Firebase

import FirebaseStorage
import FirebaseFirestore

struct VistaTestV: View {
    
    @State var board: Tablero
    
    @State private var isAddPictoVisible = false

    @State var nombre: String = "";
    @State private var etiquetas = ""

    @State var buscaGrupo: String = "";

    @State private var showAlert = false
    @State private var alertTitle = "Lo sentimos"
    @State private var alertMsg = "Hubo un error"
    
    @State private var selectedPictoGroup = ""
    @State var pictograms: [Imagen]
    
    @Environment(\.dismiss) private var dismiss
    @State private var mostrarMenu = false
    
    @State var retrievedImages = [UIImage]()
    
    private func retrieveImages() {
        // Get the data from DB
        let db = Firestore.firestore()
        
        db.collection("Pictogramas").getDocuments { snapshot, error in
            
            if error == nil && snapshot != nil {
                
                var paths = [String]()
                // Loop through all the returned docs
                for doc in snapshot!.documents {
                    paths.append(doc["url"] as! String)
                }
                
                // Loop each file path
                for path in paths {
                    let storageRef = Storage.storage().reference()
                    let fileRef = storageRef.child(path)
                    
                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                        
                        if error == nil && data != nil{
                            if let image = UIImage(data: data!){
                                DispatchQueue.main.async {
                                    retrievedImages.append(image)
                                }
                            }
                            
                            
                        }
                    }
                } // endl loop through paths
            }
            
        }
        // Get the image data in stogra for each image
    }
    
    var body: some View {
        GeometryReader { geo  in
            ZStack{
                
                HStack{
                    VStack{
                        
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
                            //.padding(.top, 40)
                            
                            Spacer()
                            
                            Text("Editor")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
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
                        
                        ZStack{
                            Rectangle()
                                .fill(Color(red: 240/255, green: 240/255, blue: 240/255))
                                .cornerRadius(20)
//                            TableViewE(board: $board, )
                            
                        }
                        
                        VStack{
                            Text("Guardar Tablero")
                                .font(.title2)
                            
                            HStack{
                                Text("Nombre: ")
                                TextField("", text: $nombre)
                                    .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                                    .cornerRadius(2)
                                    .padding(2)
                            }
                            HStack{
                                Text("Etiquetas: ")
                                
                                TextField("", text: $etiquetas)
                                    .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                                    .cornerRadius(2)
                                    .padding(2)
                            }
                            HStack{
                                Spacer()
                                Button("Guardar") {
                                    if nombre.isEmpty || etiquetas.isEmpty {
                                        alertTitle = "Campos vacíos"
                                        alertMsg = "Por favor, complete todos los campos."
                                        showAlert = true
                                        return
                                    }
                                    
                                    if board.numCol == 0 || board.numRow == 0 {
                                        alertTitle = "Campos vacíos"
                                        alertMsg = "Por favor, complete las dimensiones"
                                        showAlert = true
                                        return
                                    }
                                    
//                                    guard let _ = Double(board.numCol), let _ = Double(board.numRow) else {
//                                        alertTitle = "Valores inválidos"
//                                        alertMsg = "Los valores deben ser números."
//                                        showAlert = true
//                                        return
//                                    }
                                    
                                    //GUARDAR ALGO
                                    
                                }
                                .padding()
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .background(.green)
                                .border(.black, width: 4)
                                .cornerRadius(5)
                                
                                Spacer()
                                Spacer()
                                Button("Cancelar") {
                                    nombre = ""
                                    etiquetas = ""
                                }
                                .padding()
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .background(.red)
                                .border(.black, width: 4)
                                .cornerRadius(5)
                                
                                Spacer()
                            }
                        }
                        .padding(5)
                        .background(.white)
                        .cornerRadius(20)
                    }
                    .padding(10)
                    .background(.blue)
                    
                    VStack{
                        HStack{
                            Spacer()
                            Button("Subir Imagen") {
                                isAddPictoVisible = true
                            }
                            .padding([.horizontal],20)
                            .sheet(isPresented: $isAddPictoVisible) {
                                AddPictogram(isPresented: $isAddPictoVisible, pictograms: $pictograms)
                            }
                        }
                        TextField("Busqueda", text: $buscaGrupo)
                            .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                            .cornerRadius(5)
                            .padding([.horizontal],20)
                        
                        List(pictograms.filter { picto in
                            buscaGrupo.isEmpty || (picto.nombre.range(of: buscaGrupo, options: .caseInsensitive) != nil || picto.tags.contains { tag in
                                tag.range(of: buscaGrupo, options: .caseInsensitive) != nil
                            })
                        }, id: \.self) { picto in
                            HStack {
                                Image(picto.imagen)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                VStack(alignment: .leading) {
                                    Text(picto.nombre)
                                        .font(.headline)
                                        .padding(.bottom, 8)
                                    HStack {
                                        ForEach(picto.tags, id: \.self) { tag in
                                            Text(tag)
                                                .font(.subheadline)
                                        }
                                    }
                                }
                                Spacer()
                                Button("+") {
                                    if board.imagenes.count >= board.numCol*board.numRow{
                                        alertTitle = "Limite de Imagenes"
                                        alertMsg = "Por favor elimine imagenes antes de agregar una nueva"
                                        showAlert = true
                                        return
                                    }
                                    board.imagenes.append(Imagen(nombre: picto.nombre, imagen: picto.imagen, descripcion: picto.descripcion, tags: picto.tags, nino: picto.nino, online: picto.online))
                                }
                                .frame(width: 10, height:10)
                                .padding()
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .background(.green)
                                .border(.black, width: 4)
                                .cornerRadius(5)
                            }
                        }
                        .navigationTitle("Grupos")
                        
                        HStack{
                            
                            VStack{
                                Text("dimensiones")
                                    .cornerRadius(10)
                                    .padding(5)
                                    .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                                    .cornerRadius(10)
                                
                                HStack{
                                    TextField("X", text: Binding<String>(
                                        get: { String(board.numCol) },
                                        set: { board.numCol = Int($0) ?? 0 }
                                    ))
                                        .cornerRadius(10)
                                        .padding(5)
                                        .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                                        .frame(width: 40)

                                    Text("X")
                                    TextField("Y", text: Binding<String>(
                                        get: { String(board.numRow) },
                                        set: { board.numRow = Int($0) ?? 0 }
                                    ))
                                        .cornerRadius(10)
                                        .padding(5)
                                        .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                                        .frame(width: 40)

                                    
                                }
                            }
                            Spacer()
                            
                            VStack {
                                ForEach(retrievedImages, id: \.self) { image in
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                }
                            }
                            .onAppear{
                                retrieveImages()
                            }
                            
                            
                            
                        }
                    }
                    .frame(width: geo.size.width/3)
                    .background(.red)
                }
            
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMsg),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
}

var customLabel_Test: some View {
    Text("⌵")
        .offset(y: -4)
        .foregroundColor(.black)
        .font(.title)
        .padding()
        .frame(height: 32)
        .background(Color(red: 230/255, green: 230/255, blue: 230/255))
        .cornerRadius(16)
}

struct VistaTestV_Previews: PreviewProvider {
    static var previews: some View {
        let testImages : [Imagen] = [
            Imagen(ident:"1", nombre: "blue", imagen: "Alex/bBlue", descripcion: "globo b", tags: ["b"], nino: 1, online: false),
            Imagen(ident:"2", nombre: "red", imagen: "Alex/bRed", descripcion: "globo b", tags: ["b","jacobo"], nino: 1, online: false),
            Imagen(ident:"3", nombre: "yell", imagen: "Alex/bYellow", descripcion: "globo b", tags: ["a","juan"], nino: 1, online: false),
            Imagen(ident:"4", nombre: "candle", imagen: "Alex/candle", descripcion: "globo b", tags: ["b","globo", "si"], nino: 1, online: false),
            Imagen(ident:"5", nombre: "adsads", imagen: "Alex/bBlue", descripcion: "globo b", tags: ["b","globo", "diferente"], nino: 1, online: false),
            Imagen(ident:"6", nombre: "sdfs", imagen: "Alex/bRed", descripcion: "globo b", tags: ["b","globo", "familia"], nino: 1, online: false),
            Imagen(ident:"7", nombre: "ghg", imagen: "Alex/bYellow", descripcion: "globo b", tags: ["b","globo", "vela"], nino: 1, online: false),
        ]
        
        TableEditor(board: Tablero(nombre: "asd", numCol: 4, numRow: 2, descripcion: "este es un tablero", imagenes: testImages), pictograms: testImages)
    }
}
