import SwiftUI

struct DecorarPastelNivel2: View {
    
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
    @State private var pastelL1 = ""
    @State private var pastelL2 = ""
    @State private var pastelL3 = ""
    
    
    @Environment(\.dismiss) private var dismiss
    @State private var mostrarMenu = false
    
    @State private var mostrarComunicaciones = false
    
    @State var cakeBox = CGRect.zero
    
    @State var dragAmountBetunAzul = CGSize.zero
    @State var dragAmountBetunRosa = CGSize.zero
    @State var dragAmountBetunNaranja = CGSize.zero
    @State var dragAmountChispas = CGSize.zero
    @State var dragAmountPerlas = CGSize.zero
    @State var dragAmountVelas = CGSize.zero
    @State var dragAmountBlanco = CGSize.zero


    
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
                            
                            GeometryReader { geo3 in
                                Image(pastelImage)
                                    .resizable()
                                    .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                    .scaledToFill()
                                    .offset(x: 20, y: 45)
                                    .overlay {
                                        Color.clear
                                            .onAppear{
                                                cakeBox = geo3.frame(in: .global)
                                            }
                                    }
                            }
                            .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)


                            
                            Image(pastelL1)
                                .resizable()
                                .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                .scaledToFill()
                                .offset(x: 20, y: 45)
                            
                            Image(pastelL2)
                                .resizable()
                                .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                .scaledToFill()
                                .offset(x: 20, y: 45)
                            
                            Image(pastelL3)
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

//                            Image("Emilio/pastelA")
//                                .resizable()
//                                .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.2)
//                                .scaledToFill()
//                                .offset(x: 20, y: 140)
                        }
                        
                    }
                    .padding()
                    
                    VStack(){
                        GeometryReader { geo2 in
                            //Aqui va lo relacionando con arrastrar y soltar
                            Image("Emilio/betun_azul")
                                .resizable()
                                .offset(dragAmountBetunAzul)
                                .gesture(
                                    DragGesture(coordinateSpace: .global)
                                        .onChanged{
                                            self.dragAmountBetunAzul = CGSize(width: $0.translation.width, height: $0.translation.height)
                                        }
                                        .onEnded { _ in
                                            let minYInRange: CGFloat = 400  // Define the lower boundary of the smaller y range
                                            let maxYInRange: CGFloat = 550  // Define the upper boundary of the smaller y range
                                            
                                            if cakeBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 80 + dragAmountBetunAzul.width, y: (geo2.frame(in: .global).minY) + 100 + dragAmountBetunAzul.height)) &&
                                                minYInRange..<maxYInRange ~= (geo2.frame(in: .global).minY) - 235 + dragAmountBetunAzul.height {
                                                DispatchQueue.main.async {
                                                    pastelL1 = "Emilio/betunAzulL1"
                                                }
                                            }
                                            else if cakeBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 80 + dragAmountBetunAzul.width, y: (geo2.frame(in: .global).minY) + 100 + dragAmountBetunAzul.height)) &&
                                                        minYInRange..<maxYInRange ~= (geo2.frame(in: .global).minY) - 105 + dragAmountBetunAzul.height {
                                                DispatchQueue.main.async {
                                                    pastelL2 = "Emilio/betunAzulL2"
                                                }
                                                print("Hol2")
                                            }
                                            else if cakeBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 80 + dragAmountBetunAzul.width, y: (geo2.frame(in: .global).minY) + 100 + dragAmountBetunAzul.height)) &&
                                                        minYInRange..<maxYInRange ~= (geo2.frame(in: .global).minY) - 20 + dragAmountBetunAzul.height {
                                                DispatchQueue.main.async {
                                                    pastelL3 = "Emilio/betunAzulL3"
                                                }
                                                print("Hol3")
                                            }
                                            self.dragAmountBetunAzul = .zero
                                        }
                                )
                                .frame(width: 100, height: 100)
                                .position(CGPoint(x: 80, y: 70))
                            
                            Image("Emilio/betun_rosa")
                                .resizable()
                                .offset(dragAmountBetunRosa)
                                .gesture(
                                    DragGesture(coordinateSpace: .global)
                                        .onChanged{
                                            self.dragAmountBetunRosa = CGSize(width: $0.translation.width, height: $0.translation.height)
                                        }
                                        .onEnded { _ in
                                            let minYInRange: CGFloat = 400  // Define the lower boundary of the smaller y range
                                            let maxYInRange: CGFloat = 550  // Define the upper boundary of the smaller y range
                                            
                                            if cakeBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 80 + dragAmountBetunRosa.width, y: (geo2.frame(in: .global).minY) + 100 + dragAmountBetunRosa.height)) &&
                                                minYInRange..<maxYInRange ~= (geo2.frame(in: .global).minY) - 235 + dragAmountBetunRosa.height {
                                                DispatchQueue.main.async {
                                                    pastelL1 = "Emilio/betunRosaL1"
                                                }
                                            }
                                            else if cakeBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 80 + dragAmountBetunRosa.width, y: (geo2.frame(in: .global).minY) + 100 + dragAmountBetunRosa.height)) &&
                                                        minYInRange..<maxYInRange ~= (geo2.frame(in: .global).minY) - 105 + dragAmountBetunRosa.height {
                                                DispatchQueue.main.async {
                                                    pastelL2 = "Emilio/betunRosaL2"
                                                }
                                                print("Hol2")
                                            }
                                            else if cakeBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 80 + dragAmountBetunRosa.width, y: (geo2.frame(in: .global).minY) + 100 + dragAmountBetunRosa.height)) &&
                                                        minYInRange..<maxYInRange ~= (geo2.frame(in: .global).minY) - 20 + dragAmountBetunRosa.height {
                                                DispatchQueue.main.async {
                                                    pastelL3 = "Emilio/betunRosaL3"
                                                }
                                                print("Hol3")
                                            }
                                            self.dragAmountBetunRosa = .zero
                                        }
                                )
                                .frame(width: 100, height: 100)
                                .position(CGPoint(x: 230, y: 70))
                            
                            Image("Emilio/betun_naranja")
                                .resizable()
                                .offset(dragAmountBetunNaranja)
                                .gesture(
                                    DragGesture(coordinateSpace: .global)
                                        .onChanged{
                                            self.dragAmountBetunNaranja = CGSize(width: $0.translation.width, height: $0.translation.height)
                                        }
                                        .onEnded { _ in
                                            let minYInRange: CGFloat = 400  // Define the lower boundary of the smaller y range
                                            let maxYInRange: CGFloat = 550  // Define the upper boundary of the smaller y range
                                            
                                            if cakeBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 80 + dragAmountBetunNaranja.width, y: (geo2.frame(in: .global).minY) + 100 + dragAmountBetunNaranja.height)) &&
                                                minYInRange..<maxYInRange ~= (geo2.frame(in: .global).minY) - 85 + dragAmountBetunNaranja.height {
                                                DispatchQueue.main.async {
                                                    pastelL1 = "Emilio/betunNaranjaL1"
                                                }
                                                print("Hol1")
                                            }
                                            else if cakeBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 80 + dragAmountBetunNaranja.width, y: (geo2.frame(in: .global).minY) + 100 + dragAmountBetunNaranja.height)) &&
                                                        minYInRange..<maxYInRange ~= (geo2.frame(in: .global).minY) + 45 + dragAmountBetunNaranja.height {
                                                DispatchQueue.main.async {
                                                    pastelL2 = "Emilio/betunNaranjaL2"
                                                }
                                                print("Hol2")
                                            }
                                            else if cakeBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 80 + dragAmountBetunNaranja.width, y: (geo2.frame(in: .global).minY) + 100 + dragAmountBetunNaranja.height)) &&
                                                        minYInRange..<maxYInRange ~= (geo2.frame(in: .global).minY) + 130 + dragAmountBetunNaranja.height {
                                                DispatchQueue.main.async {
                                                    pastelL3 = "Emilio/betunNaranjaL3"
                                                }
                                                print("Hol3")
                                            }
                                            self.dragAmountBetunNaranja = .zero
                                        }
                                )
                                .frame(width: 100, height: 100)
                                .position(CGPoint(x: 230, y: 220))
                            
                            Image("Emilio/chispa")
                                .resizable()
                                .offset(dragAmountChispas)
                                .gesture(
                                    DragGesture(coordinateSpace: .global)
                                        .onChanged{
                                            self.dragAmountChispas = CGSize(width: $0.translation.width, height: $0.translation.height)
                                        }
                                        .onEnded { _ in
                                            if cakeBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 80 + dragAmountChispas.width, y: (geo2.frame(in: .global).minY) + 370 + dragAmountChispas.height)) {
                                                    DispatchQueue.main.async {
                                                        chispas = "Emilio/chispas"
                                                    }
                                                    }
                                                    self.dragAmountChispas = .zero
                                                }
                                )
                            
                                .frame(width: 100, height: 100)
                                .position(CGPoint(x: 80, y: 370))
                            Image("Emilio/perla")
                                .resizable()
                                .offset(dragAmountPerlas)
                                .gesture(
                                    DragGesture(coordinateSpace: .global)
                                        .onChanged{
                                            self.dragAmountPerlas = CGSize(width: $0.translation.width, height: $0.translation.height)
                                        }
                                        .onEnded { _ in
                                            if cakeBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 230 + dragAmountPerlas.width, y: (geo2.frame(in: .global).minY) + 370 + dragAmountPerlas.height)) {
                                                    DispatchQueue.main.async {
                                                        perlas = "Emilio/perlas"
                                                    }
                                                    }
                                                    self.dragAmountPerlas = .zero
                                                }
                                )
                            
                                .frame(width: 100, height: 100)
                                .position(CGPoint(x: 230, y: 370))
                            Image("Emilio/vela")
                                .resizable()
                                .offset(dragAmountVelas)
                                .gesture(
                                    DragGesture(coordinateSpace: .global)
                                        .onChanged{
                                            self.dragAmountVelas = CGSize(width: $0.translation.width, height: $0.translation.height)
                                        }
                                        .onEnded { _ in
                                            if cakeBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 80 + dragAmountVelas.width, y: (geo2.frame(in: .global).minY) + 220 + dragAmountVelas.height)) {
                                                    DispatchQueue.main.async {
                                                        velas = "Emilio/velas"
                                                    }
                                                    }
                                                    self.dragAmountVelas = .zero
                                                }
                                )
                                .frame(width: 100, height: 100)
                                .position(CGPoint(x: 80, y: 220))
                            
                            Image(pastelImage)
                                .resizable()
                                .offset(dragAmountBlanco)
                                .gesture(
                                    DragGesture(coordinateSpace: .global)
                                        .onChanged{
                                            self.dragAmountBlanco = CGSize(width: $0.translation.width, height: $0.translation.height)
                                        }
                                        .onEnded { _ in
                                            if cakeBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 150 + dragAmountBlanco.width, y: (geo2.frame(in: .global).minY) + 470 + dragAmountBlanco.height)) {
                                                DispatchQueue.main.async {
                                                    velas = ""
                                                    perlas = ""
                                                    chispas = ""
                                                    betunes = ""
                                                    pastelL1 = ""
                                                    pastelL2 = ""
                                                    pastelL3 = ""
                                                }
                                            }
                                            self.dragAmountBlanco = .zero
                                        }
                                )
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

struct DecorarPastelNivel2_Previews: PreviewProvider {
    static var previews: some View {
        DecorarPastelNivel2()
    }
}
