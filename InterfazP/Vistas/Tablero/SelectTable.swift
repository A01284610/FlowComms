//
//  SelectTable.swift
//  InterfazP
//
//  Created by Alejandro Lizarraga on 11/06/23.
//

import SwiftUI
import Firebase

import FirebaseStorage
import FirebaseFirestore

struct SelectTable: View {
    
    @Binding var board: Tablero
    
    @State var boards: [Tablero] = []
    
    @State var selectedBoard: Tablero? = nil
    
    @State var busqueda: String = ""
    
    
    var body: some View {
        NavigationView {
            VStack{
                TextField("Search", text: $busqueda)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                List(boards.filter({ boardInstace in
                    busqueda.isEmpty || (boardInstace.nombre.range(of: busqueda, options: .caseInsensitive) != nil || (boardInstace.descripcion.range(of: busqueda, options: .caseInsensitive) != nil ))
                }), id: \.id) { boardInstance in
                    Button(action: {
                        selectedBoard = boardInstance
                        boardSelected()
                    }) {
                        VStack(alignment: .leading) {
                            Text(boardInstance.nombre)
                                .font(.headline)
                                .padding(.bottom, 8)
                            Text(boardInstance.descripcion)
                                .font(.subheadline)
                        }
                    }
                }
                .navigationTitle("Seleccione su tablero")
                
            }
            
        }
        .onAppear {
            getBoards()
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
                    var decodedArray = try decoder.decode([Tablero].self, from: loadedData)
                    
                    // Use the decodedArray as needed
                    boards.append(contentsOf: decodedArray)
                    
                } catch {
                    // Error handling for data loading or decoding errors
                    print("Error loading or decoding data: \(error)")
                }
            } else {
                // The file doesn't exist, handle the situation accordingly
                // For example, you can assume it's the first time and initialize the array
                var myArray = [Imagen]()
                // Perform any necessary operations with myArray
            }
        } else {
            // Handle the case where the fileURL is nil
            // This can occur if there is an issue with retrieving the document directory URL
        }
    }
    
    private func boardSelected() {
        if let selectedBoard = selectedBoard {
            board = selectedBoard
        }
    }
}

//struct SelectTable_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectTable()
//    }
//}
