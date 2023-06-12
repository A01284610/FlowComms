//
//  GatoNivel3.swift
//  InterfazP
//
//  Created by Diego Esparza on 08/06/23.
//

import SwiftUI
import Subsonic
import AVFoundation

struct GatoNivel3: View {
    
    let synthesizer = AVSpeechSynthesizer()
    
    @State var catImage = "Nivel3/gatoversion1"
    @State var bowlImage = "Nivel3/catBowlEmpty"
    @State var textToSpeech = true
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 125 / 255, green: 132 / 255, blue: 199 / 255), Color.purple]),
                startPoint: .leading,
                endPoint: .trailing
            )
            GeometryReader { geo in
                VStack {
                    Text("NIVEL 3")
                        .font(.custom("HelveticaNeue", size: 40))
                        .onTapGesture {
                            speakF(text: "Nivel 3", isOn: textToSpeech)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color(red: 255 / 255, green: 0 / 255, blue: 0 / 255))
                                .frame(width: geo.size.width/2, height: geo.size.height/11))
                    Text("Juega con el Gato")
                        .foregroundColor(Color.white)
                        .font(.custom("HelveticaNeue", size: 40))
                        .onTapGesture {
                            speakF(text: "Juega con el Gato", isOn: textToSpeech)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 1, style: .continuous)
                                .fill(Color(red: 75 / 255, green: 79 / 255, blue: 113 / 255))
                                .frame(width: geo.size.width/2, height: geo.size.height/10))
                        .padding()
                }
                .frame(width: geo.size.width + geo.size.width/2.25, height: geo.size.width/5)
            }
            GeometryReader { geo in
                HStack {
                    ZStack {
                        Rectangle()
                            .fill(Color.brown)
                            .frame(width: geo.size.width - geo.size.width/15, height: geo.size.height/1.6)
                            .position(x:geo.size.width/2 - geo.size.width/33, y:geo.size.height/1.676)
                        Image("Nivel3/backgroundGato")
                            .resizable()
                            .frame(width: geo.size.width/1.5 - geo.size.width/15, height: geo.size.height/1.6)
                        Image(catImage)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(x:-1, y:1)
                            .frame(width: geo.size.width/1.5 - geo.size.width/15, height: geo.size.height/1.9)
                            .position(x:geo.size.width/5.5,y:geo.size.height/1.6)
                            .onTapGesture {
                                speakF(text: "Gato", isOn: textToSpeech)
                            }
                            .onDrop(of: ["public.text"], isTargeted: nil) { providers in
                                if let provider = providers.first {
                                    provider.loadObject(ofClass: NSString.self) { item, _ in
                                        if let string = item as? NSString {
                                            if string == "dogBall" {
                                                play(sound: "catPlay.mp3")
                                                DispatchQueue.main.async {
                                                    play(sound: "catMeow1.mp3")
                                                    catImage = "Nivel3/gatoJugando"
                                                    Task {
                                                        try? await Task.sleep(nanoseconds: UInt64(5 * 1E9))
                                                        catImage = "Nivel3/gatoversion1"
                                                    }
                                                }
                                            } else if string == "sponge"{
                                                play(sound: "scrubbing.mp3")
                                                DispatchQueue.main.async {
                                                    catImage = "Nivel3/catShower"
                                                    Task {
                                                        play(sound: "catMeow1.mp3")
                                                        try? await Task.sleep(nanoseconds: UInt64(3 * 1E9))
                                                        catImage = "Nivel3/gatoversion1"
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                return true
                            }
                        Image(bowlImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width/6, height: geo.size.height)
                            .position(x:geo.size.width/2.3,y:geo.size.height/1.26)
                            .onTapGesture {
                                speakF(text: "Tazón del gato", isOn: textToSpeech)
                            }
                            .onDrop(of: ["public.text"], isTargeted: nil) { providers in
                                if let provider = providers.first {
                                    provider.loadObject(ofClass: NSString.self) { item, _ in
                                        if let string = item as? NSString {
                                            if string == "dogFoodBag" {
                                                play(sound:"catMeow1.mp3")
                                                DispatchQueue.main.async {
                                                    bowlImage = "Nivel3/catBowlFood"
                                                    catImage = "Nivel3/gatoComiendo"
                                                    Task {
                                                        play(sound:"pourFood.mp3")
                                                        try? await Task.sleep(nanoseconds: UInt64(3 * 1E9))
                                                        bowlImage = "Nivel3/catBowlEmpty"
                                                        catImage = "Nivel3/gatoversion1"
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                return true
                            }
                        
                    }
                    .position(x: geo.size.width/3, y: geo.size.height/2 + geo.size.height/10)
                    
                    ZStack {
                        VStack {
                            Image("Nivel3/woodenBox")
                                .resizable()
                                .frame(width: geo.size.width/3, height: geo.size.height/5)
                            Image("Nivel3/woodenBox")
                                .resizable()
                                .frame(width: geo.size.width/3, height: geo.size.height/5)
                            Image("Nivel3/woodenBox")
                                .resizable()
                                .frame(width: geo.size.width/3, height: geo.size.height/5)
                        }
                        .position(x:geo.size.width/3.3,y:geo.size.height/1.67)
                    }
                }
                .frame(width: geo.size.width, height: geo.size.width/1.2)
            }
            GeometryReader { geo in
                Image("Nivel3/catFoodBag")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width/3, height: geo.size.height/6)
                    .position(x:geo.size.width/1.39, y:geo.size.height/2.57)
                    .shadow(radius: 10)
                    .onTapGesture {
                        speakF(text: "Comida para el gato", isOn: textToSpeech)
                    }
                    .onDrag {
                        return NSItemProvider(object: "dogFoodBag" as NSString)
                    }
                Text("Comida")
                    .foregroundColor(Color.black)
                    .font(.custom("HelveticaNeue", size: 50))
                    .bold()
                    .position(x:geo.size.width/1.17, y:geo.size.height/2.57)
                    .onTapGesture {
                        speakF(text: "Comida", isOn: textToSpeech)
                    }
                Image("Nivel3/sponge")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width/2, height: geo.size.height/7)
                    .position(x:geo.size.width/1.42, y:geo.size.height/1.66)
                    .shadow(radius: 10)
                    .onTapGesture {
                        speakF(text: "Esponja", isOn: textToSpeech)
                    }
                    .onDrag {
                        return NSItemProvider(object: "sponge" as NSString)
                    }
                Text("Limpieza")
                    .foregroundColor(Color.black)
                    .font(.custom("HelveticaNeue", size: 50))
                    .bold()
                    .position(x:geo.size.width/1.16, y:geo.size.height/1.66)
                    .onTapGesture {
                        speakF(text: "Limpieza", isOn: textToSpeech)
                    }
                Image("Nivel3/catToy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width/3, height: geo.size.height/6)
                    .position(x:geo.size.width/1.39, y:geo.size.height/1.23)
                    .shadow(radius: 10)
                    .onTapGesture {
                        speakF(text: "Juguete para el gato", isOn: textToSpeech)
                    }
                    .onDrag {
                        return NSItemProvider(object: "dogBall" as NSString)
                    }
                Text("Jugar")
                    .foregroundColor(Color.black)
                    .font(.custom("HelveticaNeue", size: 50))
                    .bold()
                    .position(x:geo.size.width/1.17, y:geo.size.height/1.23)
                    .onTapGesture {
                        speakF(text: "Jugar", isOn: textToSpeech)
                    }
                Button(action: {
                    dismiss()
                }) {
                    Text("Regresar")
                        .frame(width: geo.size.width / 3, height: geo.size.height / 9)
                        .background(Color.red)
                        .cornerRadius(30)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                }
                .background(Color.clear)
                .position(x: geo.size.width - geo.size.width/1.3, y: geo.size.height/11)
                //                    Button("Regresar") {
                //                        dismiss()
                //                    }
                //                    .frame(width: geo.size.width/3, height: geo.size.height/9)
                //                    .background(.red)
                //                    .cornerRadius(30)
                //                    .font(.largeTitle)
                //                    .foregroundColor(.white)
                //                    .shadow(radius: 10)
                //                    .position(x: geo.size.width - geo.size.width/1.3, y: geo.size.height/11)
                
                Group {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(red: 0 / 255, green: 0 / 255, blue: 0 / 255))
                        .frame(width: geo.size.width/3.6, height: geo.size.height/15)
                        .position(x: geo.size.width/4.5, y: geo.size.height/5)
                        .opacity(0.5)
                    Text("Text-To-Speech")
                        .foregroundColor(Color.white)
                        .font(.custom("HelveticaNeue", size: 30))
                        .bold()
                        .position(x: geo.size.width/5, y: geo.size.height/5)
                    Toggle("text",isOn: $textToSpeech)
                        .position(x: geo.size.width - geo.size.width*1.15, y: geo.size.height/5)
                    
                }
            }
            
        }
        .ignoresSafeArea()
    }
    
    func speakF(text: String, isOn: Bool) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "es-MX")
        if isOn {
            synthesizer.speak(utterance)
        }
    }
    
    
}

struct GatoNivel3_Previews: PreviewProvider {
    static var previews: some View {
        GatoNivel3()
    }
}
