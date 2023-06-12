//
//  TableComms.swift
//  InterfazP
//
//  Created by Alejandro Lizarraga on 11/06/23.
//

import SwiftUI
import Firebase

import FirebaseStorage
import FirebaseFirestore

struct TableComms: View {
    
    @State var board: Tablero
    
    @Environment(\.dismiss) private var dismiss
    
    @State var retrievedImages: [String: UIImage] = [:]
    
    @State private var isSelectTable = false
    
    @State var TTS = true
    
    
    
    var body: some View {
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
                .padding(.top, 20)
                
                Spacer()
                Spacer()
                Spacer()
                
                
                Text("\(board.nombre)")
                    .font(.custom("HelveticaNeue", size: 40))
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(red: 206 / 255, green: 231 / 255, blue: 65 / 255)))
                    .padding(.top, 20)
                
                HStack{
                    Toggle("", isOn: $TTS)
                    Image(systemName: "speaker.wave.2.fill")
                        .font(.title)
                        .foregroundColor(TTS ? .accentColor : .gray)
                        .background(Color.white)
                        .clipShape(Rectangle())
                        .cornerRadius(20)
                        .frame(width: 50, height: 50)
                }
                .padding(.top, 20)
                
                
                
                Spacer()
                
                Button(action: {
                    isSelectTable = true
                }) {
                    Image(systemName: "calendar")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding(10)
                        .background(Color.white)
                        .clipShape(Rectangle())
                        .cornerRadius(20)
                }
                .padding(.trailing, 40)
                .sheet(isPresented: $isSelectTable) {
                    SelectTable(board: $board)
                }
                .padding(.top, 20)
                
                
            }
            
            TableViewV(board: $board, TTS: TTS, retrievedImages: retrievedImages)
            
        }
        .onAppear(){
            fetchOnlinePictos { result in
                switch result {
                case .success(_):
                    print("Success!!!")
                case .failure(let error):
                    // Handle the error case
                    print("Error fetching pictos: \(error)")
                    // Show an alert or handle the error in any other way
                }
            }
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

//struct TableComms_Previews: PreviewProvider {
//    static var previews: some View {
//        TableComms()
//    }
//}
