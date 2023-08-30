//
//  AddPictogram.swift
//  GameTest
//
//  Created by Alejandro Lizarraga on 08/06/23.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import Network

struct AddPictogram: View {
    @Binding var isPresented: Bool
    @Binding var pictograms: [Imagen]
    
    @State var localPictograms: [Imagen] = []
    
    @State private var reachability = try! NWPathMonitor(requiredInterfaceType: .wifi)
    @State private var isConnected = true
    
    @State var name: String = ""
    @State var group: String = ""
    @State var isOnline: Bool = false
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    
    @State private var showAlert = false
    @State private var alertTitle = "lo sentimos"
    @State private var alertMsg = "hubo un error"
    
    
    
    var body: some View {
        ZStack {
            Color.gray
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .blur(radius: 10)
            
            VStack(spacing: 20) {
                Text("Guarde su pictograma")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                HStack {
                    Text("Imagen:")
                    Button(action: {
                        showImagePicker = true
                    }) {
                        Text("Subir")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(selectedImage: $selectedImage, showImagePicker: $showImagePicker)
                    }
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                    }
                }
                
                HStack {
                    Text("Nombre:")
                    TextField("Ingrese el nombre", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Etiquetas:")
                    TextField("Ingrese las etiquetas", text: $group)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Subir en línea:")
                    Toggle("", isOn: $isOnline)
                        .labelsHidden()
                }
                
                HStack{
                    Spacer()
                    
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Cancelar")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if name.isEmpty || group.isEmpty {
                            alertTitle = "Campos vacíos"
                            alertMsg = "Por favor, complete todos los campos."
                            showAlert = true
                            return
                        }
                        
                        if selectedImage == nil {
                            alertTitle = "Imagen no seleccionada"
                            alertMsg = "Por favor, seleccione una imagen."
                            showAlert = true
                            return
                        }
                        
                        if isOnline && !isConnected {
                            alertTitle = "Sin conexión"
                            alertMsg = "No se pudo subir la imagen en línea debido a la falta de conexión a Internet."
                            showAlert = true
                            return
                        }
                        
                        uploadPhoto()
                        isPresented = false
                        
                    }) {
                        Text("Agregar")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Spacer()
                    
                }
                
                
            }
            .padding()
        }
        .onAppear {
            checkNetworkConnectivity()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMsg),
                dismissButton: .default(Text("OK"))
            )
        }
        
    }
    
    private func checkNetworkConnectivity() {
        reachability.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                isConnected = (path.status == .satisfied)
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        reachability.start(queue: queue)
    }
    
    private func isConnectedToNetwork() -> Bool {
        return reachability.currentPath.status == .satisfied
    }
    
    private func uploadPhoto() {
        
        // Make sure theres an image
        
        guard selectedImage != nil else {
            return
        }
        // Create storage reference
        let storageRef = Storage.storage().reference()
        
        // Specify the file path and name
        let path = "Pictogramas/\(name).jpg"
        let fileRef = storageRef.child(path)
        
        // Turn our image into data and compress it
        var compressionQuality: CGFloat = 1.0
        var imageData = selectedImage!.jpegData(compressionQuality: compressionQuality)
        let maxSize: Int = 2 * 1024 * 1024 // 2MB
        
        while let data = imageData, data.count > maxSize && compressionQuality > 0.1 {
            compressionQuality -= 0.1
            imageData = selectedImage!.jpegData(compressionQuality: compressionQuality)
        }
        
        if (isOnline && isConnected){
            // Upload that data
            let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
                // Check error
                if error == nil && metadata != nil {
                    // Save a reference to the file in Firestore DB
                    let db = Firestore.firestore()
                    db.collection("Pictogramas").document().setData(["nombre": name, "url": path, "descripcion": "una imagen", "tags": group, "nino": 1, "online": true])
                }
                
            }
            
            
        } else {
            // Store locally
            guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                showAlert = true
                alertTitle = "Error"
                alertMsg = "Failed to access local storage."
                return
            }
            
            let folderURL = documentsURL.appendingPathComponent("myPictos")
            
            do {
                try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
                
                let imageName = "\(UUID().uuidString).jpg"
                let fileURL = folderURL.appendingPathComponent(imageName)
                
                do {
                    try imageData?.write(to: fileURL)
                    print("Image saved successfully at: \(fileURL.path)")
                } catch {
                    print("Error saving image: \(error)")
                }
                
                
                let arrayTags = group.components(separatedBy: ", ")
                let localPath = fileURL.path
                //                        let localPath = "/Documents/myPictos/\(imageName)"
                
                
                let a = Imagen(nombre: name, imagen: localPath, descripcion: "una imagen", tags: arrayTags, nino: 1, online: false)
                
                //TRY TO ADD TO STORAGE LOCAL
                let myFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("localPictos.plist")
                
                if let myFileURL = myFileURL {
                    if FileManager.default.fileExists(atPath: myFileURL.path) {
                        // The file exists, so you can proceed with retrieving the data
                        
                        do {
                            // Loading the data from the file
                            let loadedData = try Data(contentsOf: myFileURL)
                            
                            // Decoding the array from the data
                            let decoder = PropertyListDecoder()
                            var decodedArray = try decoder.decode([Imagen].self, from: loadedData)
                            
                            // Use the decodedArray as needed
                            decodedArray.append(a)
                                                        
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
                        // The file doesn't exist,
                 
                        var myArray = [Imagen]()
                    }
                } else {
                    
                }
                //EN TRY TO ADD TO STORAGE LOCAL
            } catch {
                showAlert = true
                alertTitle = "Error"
                alertMsg = "Failed to store the image locally."
            }
            // END Store locally
            
            
            
            
            
            
        }
        
        
        
    }
    
    
    
    
}


//struct AddPictogram_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPictogram(isPresented: .constant(true))
//    }
//}
