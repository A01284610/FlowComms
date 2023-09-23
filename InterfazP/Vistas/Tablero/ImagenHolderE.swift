//
//  ImagenHolderE.swift
//  InterfazP
//
//  Created by Diego Esparza on 09/06/23.
//

import SwiftUI
import Firebase

import FirebaseStorage
import FirebaseFirestore

struct ImagenHolderE: View {
    
    @Binding var imgList: [Imagen]
    let img: Imagen
    var myIndex: Int
    let retrievedImages: [String: UIImage]
    
    
    var body: some View {
        ZStack {
            if  img.descripcion == "def" {
                Image(img.imagen)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if img.online {
                let storageRef = Storage.storage().reference()
                let fileRef = storageRef.child(img.imagen)
                
                if let image = retrievedImages[img.imagen] {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    // Handle the case when the image is not available.
                    // For example, display a placeholder image or show an error message
                    Image(systemName: "rectangle.on.rectangle.slash")
                        .font(.body)
                        .imageScale(.large)
                        .foregroundColor(.red)
                        //.resizable()
                        //.aspectRatio(contentMode: .fit)
                        //.padding(10)
                        //.background(Color.white)
                        //.clipShape(Rectangle())
                        //.cornerRadius(20)
                }
            } else {
                // Local image path handling
                if let uiImage = UIImage(contentsOfFile: img.imagen) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    Image(systemName: "rectangle.on.rectangle.slash")
                        .font(.body)
                        .imageScale(.large)
                        .foregroundColor(.black)
                        //.resizable()
                        //.aspectRatio(contentMode: .fit)
                        //.padding(10)
                        //.background(Color.white)
                        //.clipShape(Rectangle())
                        //.cornerRadius(20)
                }
            }
            
            
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            imgList.remove(at: myIndex)
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.2)
                                .background(Color.red)
                                .clipShape(Circle())
                        })
                        .padding()
                    }
                }
            }
        }
    }
    
}

//struct ImagenHolderE_Previews: PreviewProvider {
//    static var previews: some View {
//        ImagenHolderE(imgList: .constant([]), img: Imagen(nombre: "blue", imagen: "bBlue", descripcion: "globo b", tags: ["b","globo"], nino: 1, online: false), myIndex: 0)
//    }
//}
