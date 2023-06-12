//
//  ImagenHolderV.swift
//  InterfazP
//
//  Created by Alejandro Lizarraga on 11/06/23.
//

import SwiftUI
import Firebase

import FirebaseStorage
import FirebaseFirestore

import AVFoundation

struct ImagenHolderV: View {
    @Binding var imgList: [Imagen]
    let img: Imagen
    let TTS: Bool
    var myIndex: Int
    let retrievedImages: [String: UIImage]
    
    let synthesizer = AVSpeechSynthesizer()
    
    
    
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
                    // Handle the case when the image is not available
                    // For example, display a placeholder image or show an error message
                    Image(systemName: "rectangle.on.rectangle.slash")
                        .font(.body)
                        .imageScale(.large)
                        .foregroundColor(.red)
                        //.resizable()
                        .aspectRatio(contentMode: .fit)
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
            
            
            
        }
        .onTapGesture {
            speakF(text: "\(img.nombre)", isOn: TTS)
        }
    }
    
    func speakF(text: String, isOn: Bool) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "es-MX")
        if isOn {
            synthesizer.speak(utterance)
        }
    }
}

//struct ImagenHolderV_Previews: PreviewProvider {
//    static var previews: some View {
//        ImagenHolderV()
//    }
//}
