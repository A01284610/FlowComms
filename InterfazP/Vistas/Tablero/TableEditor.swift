//
//  TableEditor.swift
//  InterfazP
//
//  Created by Diego Esparza on 09/06/23.
//


import SwiftUI
import Firebase

import FirebaseStorage
import FirebaseFirestore

struct TableEditor: View {
    
    @State var board: Tablero
    
    @State private var isAddPictoVisible = false
    
    @State var nombre: String = "";
    @State private var etiquetas = ""
    
    @State var buscaGrupo: String = "";
    
    @State private var showAlert = false
    @State private var alertTitle = "Lo sentimos"
    @State private var alertMsg = "Hubo un error"
    
    @State private var selectedPictoGroup = ""
    @State var pictograms: [Imagen] = []
    @State var boards: [Tablero] = []
    
    
    @State var localPictograms: [Imagen] = []
    @State var localBoards: [Tablero] = []
    
    
    @State var retrievedImages: [String: UIImage] = [:]
    
    @Environment(\.dismiss) private var dismiss
    @State private var mostrarMenu = false
    
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
                            TableViewE(board: $board, retrievedImages: retrievedImages)
                            
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
                                    
                                    //GUARDAR ALGO
                                    uploadBoard()
                                    dismiss()
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
                            Button("Subir Imagen +") {
                                isAddPictoVisible = true
                            }
                            .padding(5)
                            .background(.white)
                            .foregroundColor(.gray)
                            .fontWeight(.bold)
                            .padding([.horizontal],20)
                            .cornerRadius(50)
                            .sheet(isPresented: $isAddPictoVisible) {
                                AddPictogram(isPresented: $isAddPictoVisible, pictograms: $pictograms)
                            }
                        }
                        HStack{
                            TextField("Búsqueda", text: $buscaGrupo)
                                .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                                .cornerRadius(5)
                                .padding([.horizontal],20)
                            
                            Button {
                                updatePictos(){}
                            } label: {
                                Image(systemName: "arrow.clockwise.circle.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                    .frame(width: 48, height: 48)
                            }
                            
                        }
                        
                        
                        List(pictograms.filter { picto in
                            buscaGrupo.isEmpty || (picto.nombre.range(of: buscaGrupo, options: .caseInsensitive) != nil || picto.tags.contains { tag in
                                tag.range(of: buscaGrupo, options: .caseInsensitive) != nil
                            })
                        }, id: \.self) { picto in
                            HStack {
                                if  picto.descripcion == "def" {
                                    Image(picto.imagen)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                } else if picto.online {
                                    let storageRef = Storage.storage().reference()
                                    let fileRef = storageRef.child(picto.imagen) //CHECAR
                                    
                                    if let image = retrievedImages[picto.imagen] {
                                        Image(uiImage: image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                    } else {
                                        // Handle the case when the image is not available
                                        // For example, display a placeholder image or show an error message
//                                        Text("Image not found")
//                                            .foregroundColor(.red)
                                        Image(systemName: "rectangle.on.rectangle.slash")
                                            .font(.largeTitle)
                                            .foregroundColor(.red)
                                            //.resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                            //.padding(10)
                                            //.background(Color.white)
                                            //.clipShape(Rectangle())
                                            //.cornerRadius(20)
                                    }
                                    
                                    
                                } else {
                                    // Local image path handling
                                    // Local image path handling HERE
                                    if let uiImage = UIImage(contentsOfFile: picto.imagen) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50) // Adjust the frame size as needed
                                    } else {
                                        //Text("Image not found") // Display an error message if the image cannot be loaded
                                        Image(systemName: "rectangle.on.rectangle.slash") // xmark.seal exclamationmark.triangle rectangle.on.rectangle.slash xmark.icloud
                                            .font(.largeTitle)
                                            .foregroundColor(.black)
                                            //.resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                            //.padding(10)
                                            //.background(Color.white)
                                            //.clipShape(Rectangle())
                                            //.cornerRadius(20)
                                    }
                                    
                                }
                                
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
                                Text("Dimensiones")
                                    .cornerRadius(10)
                                    .padding(5)
                                    .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                                    .cornerRadius(10)
                                
                                HStack{
                                    Picker("X", selection: $board.numCol) {
                                        ForEach(1...10, id: \.self) { number in
                                            Text("\(number)")
                                                .font(.headline)
                                        }
                                    }
                                    .pickerStyle(MenuPickerStyle())
                                    //.padding(5)
                                    .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                                    .frame(width: 60, height:40)
                                    .cornerRadius(20)
                                    .shadow(radius: 2)
                                    
                                    Image(systemName: "xmark")
                                    Picker("Y", selection: $board.numRow) {
                                        ForEach(1...10, id: \.self) { number in
                                            Text("\(number)")
                                                .font(.headline)
                                        }
                                    }
                                    
                                    .pickerStyle(MenuPickerStyle())
                                    //.padding(5)
                                    .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                                    .frame(width: 60, height:40)
                                    .cornerRadius(20)
                                    .shadow(radius: 2)
                                    
                                    
                                }
                            }
                            
                        }
                    }
                    .frame(width: geo.size.width/3)
                    .background(.red)
                }
                
            }
        }
        .onAppear(){
            updatePictos(){}
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMsg),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func updatePictos(completion: @escaping () -> Void) {
        pictograms.removeAll()
        
        // Retrieve default pictos
        let tempImages: [Imagen] = [
            Imagen(ident: "1", nombre: "perro", imagen: "DefaultPictos/perro", descripcion: "def", tags: ["animal", "macosta", "perro", "default"], nino: 1, online: false),
            Imagen(ident: "1", nombre: "gato", imagen: "DefaultPictos/gato", descripcion: "def", tags: ["animal", "macosta", "gato", "default"], nino: 1, online: false)
        ]
        
        pictograms.append(contentsOf: tempImages)
        
        //RETRIEVE LOCAL
        let myFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("localPictos.plist")
        
        if let myFileURL = myFileURL {
            if FileManager.default.fileExists(atPath: myFileURL.path) {
                // The file exists, so you can proceed with retrieving the data
                
                do {
                    // Loading the data from the file
                    let loadedData = try Data(contentsOf: myFileURL)
                    
                    // Decoding the array from the data
                    let decoder = PropertyListDecoder()
                    let decodedArray = try decoder.decode([Imagen].self, from: loadedData)
                    
                    // Use the decodedArray as needed
                    pictograms.append(contentsOf: decodedArray)
                    
                } catch {
                    // Error handling for data loading or decoding errors
                    print("Error loading or decoding data: \(error)")
                }
            } else {
                // The file doesn't exist, handle the situation accordingly
                // For example, you can assume it's the first time and initialize the array
                var myArray = [Imagen]() //CHECAR
                // Perform any necessary operations with myArray
            }
        } else {
            // Handle the case where the fileURL is nil
            // This can occur if there is an issue with retrieving the document directory URL
        }
        //RETIREVE LOCAL
        
        // Retrieve online pictos using asynchronous Firestore API
        fetchOnlinePictos { result in
            switch result {
            case .success(let retrievedPictos):
                pictograms.append(contentsOf: retrievedPictos)
                completion() // Invoke the completion handler when the operation is done
            case .failure(let error):
                // Handle the error case
                print("Error fetching pictos: \(error)")
                // Show an alert or handle the error in any other way
                completion() // Invoke the completion handler even in case of an error
            }
        }
    }
    
    private func uploadBoard(){
        do {
            let a = Tablero(nombre: nombre, numCol: board.numCol, numRow: board.numRow, descripcion: etiquetas, imagenes: board.imagenes)
            
            let myFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("localBoards.plist")
            
            if let myFileURL = myFileURL {
                if FileManager.default.fileExists(atPath: myFileURL.path) {
                    // The file exists, so you can proceed with retrieving the data
                    
                    do {
                        // Loading the data from the file
                        let loadedData = try Data(contentsOf: myFileURL)
                        
                        // Decoding the array from the data
                        let decoder = PropertyListDecoder()
                        var decodedArray = try decoder.decode([Tablero].self, from: loadedData)
                        
                        // Use the decodedArray as needed
                        decodedArray.append(a)
                        
                        //after retrieveng already stored data overwrite with new dataAA
                        
                        let encoder = PropertyListEncoder()
                        encoder.outputFormat = .binary
                        let encodedData = try encoder.encode(decodedArray)
                        
                        try encodedData.write(to: myFileURL)
                        
                    } catch {
                        print("Error loading or decoding data: \(error)")
                    }
                } else {
                    do {
                        // Encoding the empty array to Data
                        let encoder = PropertyListEncoder()
                        encoder.outputFormat = .binary
                        let encodedData = try encoder.encode([a])
                        
                        // Storing the data to the file
                        try encodedData.write(to: myFileURL)
                        
                    } catch {
                        print("Error encoding or writing data: \(error)")
                    }
                    // The file doesn't exist, handle the situation accordingly
                    // For example, you can assume it's the first time and initialize the array
                    var myArray = [Tablero]() //CHECAR
                    // Perform any necessary operations with myArray
                }
            } else {
                
            }
            //EN TRY TO ADD TO STORAGE LOCAL
        } catch {
            showAlert = true
            alertTitle = "Error"
            alertMsg = "Failed to store the image locally."
        }
    }
    
    private func getBoards(){
        let myFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("localBoards.plist")
        
        if let myFileURL = myFileURL {
            if FileManager.default.fileExists(atPath: myFileURL.path) {
                // The file exists, so you can proceed with retrieving the data
                
                do {
                    // Loading the data from the file
                    let loadedData = try Data(contentsOf: myFileURL)
                    
                    // Decoding the array from the data
                    let decoder = PropertyListDecoder()
                    let decodedArray = try decoder.decode([Tablero].self, from: loadedData)
                    
                    // Use the decodedArray as needed
                    boards.append(contentsOf: decodedArray)
                    
                } catch {
                    // Error handling for data loading or decoding errors
                    print("Error loading or decoding data: \(error)")
                }
            } else {
                // The file doesn't exist, handle the situation accordingly
                // For example, you can assume it's the first time and initialize the array
                var myArray = [Imagen]() //CHECAR
                // Perform any necessary operations with myArray
            }
        } else {
            // Handle the case where the fileURL is nil
            // This can occur if there is an issue with retrieving the document directory URL
        }
    }
    
    
    private func fetchOnlinePictos(completion: @escaping (Result<[Imagen], Error>) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("Pictogramas").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            var retrievedPictos: [Imagen] = []
            
            for doc in snapshot?.documents ?? [] {
                let tempS: String = doc["tags"] as? String ?? ""
                let tempTags: [String] = tempS.components(separatedBy: ", ")
                
                let tempUrl: String = doc["url"] as? String ?? ""
                let tempDesc: String = doc["descripcion"] as? String ?? ""
                
                let tempImage = Imagen(nombre: doc["nombre"] as? String ?? "", imagen: tempUrl, descripcion: tempDesc, tags: tempTags, nino: doc["nino"] as? Int ?? 0, online: doc["nino"] as? Bool ?? false)
                
                retrievedPictos.append(tempImage)
                
                let storageRef = Storage.storage().reference()
                let fileRef = storageRef.child(tempUrl)
                
                fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                    
                    if error == nil && data != nil{
                        if let image = UIImage(data: data!){
                            DispatchQueue.main.async {
                                retrievedImages[tempUrl] = image
                            }
                        }
                        
                        
                    }
                }
            }
            
            completion(.success(retrievedPictos))
        }
    }
    
}

var customLabel: some View {
    Text("⌵")
        .offset(y: -4)
        .foregroundColor(.black)
        .font(.title)
        .padding()
        .frame(height: 32)
        .background(Color(red: 230/255, green: 230/255, blue: 230/255))
        .cornerRadius(16)
}


extension FileManager {
    static var documentsDirectoryURL: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}


//struct TableEditor_Previews: PreviewProvider {
//    static var previews: some View {
//        var tempImages : [Imagen] = [
//            Imagen(ident:"1", nombre: "perro", imagen: "placeholder", descripcion: "def", tags: ["animal", "macosta", "perro", "default"], nino: 1, online: false),
//            Imagen(ident:"1", nombre: "gato", imagen: "placeholder", descripcion: "def", tags: ["animal", "macosta", "perro", "default"], nino: 1, online: false),
//        ]
//
//        TableEditor(board: Tablero(nombre: "asd", numCol: 4, numRow: 2, descripcion: "este es un tablero", imagenes: tempImages))
//    }
//}
