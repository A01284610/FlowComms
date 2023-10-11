import SwiftUI

struct AlinearFiguras: View {
    
    @State var offset: CGSize = .zero
    @State private var image1Position = CGPoint(x: 100, y: 100)
    @State private var image2Position = CGPoint(x: 250, y: 100)
    @State private var woodboxCirculo = "AlinearFiguras/woodbox_circulo"
    @State private var woodboxTriangulo = "AlinearFiguras/woodbox_triangulo"
    @State private var woodboxCuadrado = "AlinearFiguras/woodbox_cuadrado"
    @State private var woodboxOvalo = "AlinearFiguras/woodbox_ovalo"
    @State private var woodboxPoligono = "AlinearFiguras/woodbox_poligono"
    @State private var woodboxRectangulo = "AlinearFiguras/woodbox_rectangulo"
    @State private var circulo = ""
    @State private var triangulo = ""
    @State private var cuadrado = ""
    @State private var rectangulo = ""
    @State private var poligono = ""
    @State private var ovalo = ""
    
    
    
    
    @Environment(\.dismiss) private var dismiss
    @State private var mostrarMenu = false
    
    @State private var mostrarComunicaciones = false
    
    @State var circuloBox = CGRect.zero
    @State var trianguloBox = CGRect.zero
    @State var cuadradoBox = CGRect.zero
    @State var rectanguloBox = CGRect.zero
    @State var poligonoBox = CGRect.zero
    @State var ovaloBox = CGRect.zero
    @State var emptyWoodbox = CGRect.zero
    
    @State var dragAmountCirculo = CGSize.zero
    @State var dragAmountTriangulo = CGSize.zero
    @State var dragAmountCuadrado = CGSize.zero
    @State var dragAmountRectangulo = CGSize.zero
    @State var dragAmountPoligono = CGSize.zero
    @State var dragAmountOvalo = CGSize.zero
    @State var dragAmountEmptyWoodbox = CGSize.zero
    
    @State private var dragStartedX: CGFloat = 0
    @State private var dragStartedY: CGFloat = 0


    
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
                        
                        
                        Text("Alinear Figuras")
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
                            Image("AlinearFiguras/fondo")
                                .resizable()
                                .frame(width:geo2.size.width*1,height:geo2.size.height*1.0)
                                .scaledToFill()
                                .opacity(0.3)
                                .blur(radius: 5)
                        
                            
                            // 3 bloques de arriba
                            GeometryReader{ geo3 in
                                Image(woodboxCirculo)
                                    .resizable()
                                    .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.26)
                                    .scaledToFit()
                                    .overlay {
                                        Color.clear
                                            .onAppear{
                                                circuloBox = geo3.frame(in: .global)
                                            }
                                    }
                            }
                            .offset(y:geo2.size.height*0.2)
                            
                            
                            GeometryReader{ geo3 in
                                Image(woodboxTriangulo)
                                    .resizable()
                                    .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.27)
                                    .scaledToFit()
                                    .overlay {
                                        Color.clear
                                            .onAppear{
                                                trianguloBox = geo3.frame(in: .global)
                                            }
                                    }
                            }
                            .offset(x:geo2.size.width*0.33, y:geo2.size.height*0.2)
                            
                            
                            GeometryReader{ geo3 in
                                Image(woodboxCuadrado)
                                    .resizable()
                                    .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.27)
                                    .scaledToFit()
                                    .overlay {
                                        Color.clear
                                            .onAppear{
                                                cuadradoBox = geo3.frame(in: .global)
                                            }
                                    }
                            }
                            .offset(x:geo2.size.width*0.66, y:geo2.size.height*0.2)
                            
                            GeometryReader{ geo3 in
                                Image(woodboxRectangulo)
                                    .resizable()
                                    .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.27)
                                    .scaledToFit()
                                    .overlay {
                                        Color.clear
                                            .onAppear{
                                                rectanguloBox = geo3.frame(in: .global)
                                            }
                                    }
                            }
                            .offset(y:geo2.size.height*0.55)
                            
                            
                            GeometryReader{ geo3 in
                                Image(woodboxPoligono)
                                    .resizable()
                                    .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.27)
                                    .scaledToFit()
                                    .overlay {
                                        Color.clear
                                            .onAppear{
                                                poligonoBox = geo3.frame(in: .global)
                                            }
                                    }
                            }
                            .offset(x:geo2.size.width*0.33, y:geo2.size.height*0.55)
                            
                            
                            GeometryReader{ geo3 in
                                Image(woodboxOvalo)
                                    .resizable()
                                    .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.27)
                                    .scaledToFit()
                                    .overlay {
                                        Color.clear
                                            .onAppear{
                                                ovaloBox = geo3.frame(in: .global)
                                            }
                                    }
                            }
                            .offset(x:geo2.size.width*0.66, y:geo2.size.height*0.55)
                            
                            GeometryReader{ geo3 in
                                Rectangle()
                                    .fill(.clear)
                                    .frame(width:geo2.size.width*0.9,height:geo2.size.height*0.6)
                                    .scaledToFill()
                                    .overlay {
                                        Color.clear
                                            .onAppear{
                                                emptyWoodbox = geo3.frame(in: .global)
                                            }
                                    }
                            }
                            .offset(x:geo2.size.width*0.04,y:geo2.size.height*0.2)
                            
                            Image(circulo)
                                .resizable()
                                .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.26)
                                .scaledToFill()
                                .offset(x:geo2.size.width*(-0.3349), y:geo2.size.height*(-0.1699))
                            
                            Image(triangulo)
                                .resizable()
                                .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.27)
                                .scaledToFill()
                                .offset(x:geo2.size.width*(-0.005), y:geo2.size.height*(-0.164))
                            
                            Image(cuadrado)
                                .resizable()
                                .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.27)
                                .scaledToFill()
                                .offset(x:geo2.size.width*(0.325), y:geo2.size.height*(-0.164))
                            
                            Image(rectangulo)
                                .resizable()
                                .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.27)
                                .scaledToFill()
                                .offset(x:geo2.size.width*(-0.3349), y:geo2.size.height*(0.184))
                            
                            Image(poligono)
                                .resizable()
                                .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.27)
                                .scaledToFill()
                                .offset(x:geo2.size.width*(-0.005), y:geo2.size.height*(0.184))
                            
                            Image(ovalo)
                                .resizable()
                                .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.27)
                                .scaledToFill()
                                .offset(x:geo2.size.width*(0.325), y:geo2.size.height*(0.184))

                        }
                        
                    }
                    .padding()
                    
                    VStack(){
                        GeometryReader { geo2 in
                            //Aqui va lo relacionando con arrastrar y soltar
                            Image("AlinearFiguras/circulo")
                                .resizable()
                                .offset(dragAmountCirculo)
                                .gesture(
                                    DragGesture(coordinateSpace: .global)
                                        .onChanged{
                                            self.dragAmountCirculo = CGSize(width: $0.translation.width, height: $0.translation.height)
                                        }
                                        .onEnded { _ in
                                            if circuloBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 80 + dragAmountCirculo.width, y: (geo2.frame(in: .global).minY) + 100 + dragAmountCirculo.height)) {
                                                DispatchQueue.main.async {
                                                    circulo = "AlinearFiguras/circulo"
                                                }
                                            }
                                            self.dragAmountCirculo = .zero
                                        }
                                )
                                .frame(width: geo2.size.width*0.9, height: geo2.size.height*0.25)
                                .position(CGPoint(x: 80, y: 70))
                            
                            Image("AlinearFiguras/triangulo")
                                .resizable()
                                .offset(dragAmountTriangulo)
                                .gesture(
                                    DragGesture(coordinateSpace: .global)
                                        .onChanged{
                                            dragStartedX = $0.location.x
                                            dragStartedY = $0.location.y
                                            self.dragAmountTriangulo = CGSize(width: $0.translation.width, height: $0.translation.height)
                                        }
                                        .onEnded { _ in
                                            if trianguloBox.minX < dragStartedX && trianguloBox.width > dragStartedX && trianguloBox.minY < dragStartedY && trianguloBox.height-50 > dragStartedY {
                                                DispatchQueue.main.async {
                                                    triangulo = "AlinearFiguras/triangulo"
                                                }
                                            }
                                            self.dragAmountTriangulo = .zero
                                        }
                                )
                                .frame(width: geo2.size.width*0.8, height: geo2.size.height*0.25)
                                .position(CGPoint(x: 240, y: 70))
                            
                            Image("AlinearFiguras/cuadrado")
                                .resizable()
                                .offset(dragAmountCuadrado)
                                .gesture(
                                    DragGesture(coordinateSpace: .global)
                                        .onChanged{
                                            dragStartedX = $0.location.x
                                            dragStartedY = $0.location.y
                                            self.dragAmountCuadrado = CGSize(width: $0.translation.width, height: $0.translation.height)
                                        }
                                        .onEnded { _ in
                                            if cuadradoBox.minX < dragStartedX && cuadradoBox.width > dragStartedX && cuadradoBox.minY < dragStartedY && cuadradoBox.height-50 > dragStartedY {
                                                DispatchQueue.main.async {
                                                    cuadrado = "AlinearFiguras/cuadrado"
                                                }
                                            }
                                            self.dragAmountCuadrado = .zero
                                        }
                                )
                                .frame(width: geo2.size.width*0.8, height: geo2.size.height*0.27)
                                .position(CGPoint(x: 80, y: 220))
                            
                            Image("AlinearFiguras/ovalo")
                                .resizable()
                                .offset(dragAmountOvalo)
                                .gesture(
                                    DragGesture(coordinateSpace: .global)
                                        .onChanged{ 
                                            dragStartedX = $0.location.x
                                            dragStartedY = $0.location.y
                                            self.dragAmountOvalo = CGSize(width: $0.translation.width, height: $0.translation.height)
                                        }
                                        .onEnded { _ in
                                            if ovaloBox.minX < dragStartedX && ovaloBox.width > dragStartedX && ovaloBox.minY < dragStartedY && ovaloBox.height+100 > dragStartedY {
                                                DispatchQueue.main.async {
                                                    ovalo = "AlinearFiguras/ovalo"
                                                }
                                            }
                                            self.dragAmountOvalo = .zero
                                        }
                                )
                                .frame(width: geo2.size.width*0.7, height: geo2.size.height*0.25)
                                .position(CGPoint(x: 240, y: 220))
                            
                            Image("AlinearFiguras/poligono")
                                .resizable()
                                .offset(dragAmountPoligono)
                                .gesture(
                                    DragGesture(coordinateSpace: .global)
                                        .onChanged{
                                            dragStartedX = $0.location.x
                                            dragStartedY = $0.location.y
                                            self.dragAmountPoligono = CGSize(width: $0.translation.width, height: $0.translation.height)
                                        }
                                        .onEnded { _ in
                                            if poligonoBox.minX < dragStartedX && poligonoBox.width > dragStartedX && poligonoBox.minY < dragStartedY && poligonoBox.height+100 > dragStartedY {
                                                DispatchQueue.main.async {
                                                    poligono = "AlinearFiguras/poligono"
                                                }
                                            }
                                            self.dragAmountPoligono = .zero
                                        }
                                )
                            
                                .frame(width: geo2.size.width*0.7, height: geo2.size.height*0.25)
                                .position(CGPoint(x: 80, y: 370))
                            
                            Image("AlinearFiguras/rectangulo")
                                .resizable()
                                .offset(dragAmountRectangulo)
                                .gesture(
                                    DragGesture(coordinateSpace: .global)
                                        .onChanged{
                                            dragStartedX = $0.location.x
                                            dragStartedY = $0.location.y
                                            self.dragAmountRectangulo = CGSize(width: $0.translation.width, height: $0.translation.height)
                                        }
                                        .onEnded { _ in
                                            if rectanguloBox.minX < dragStartedX && rectanguloBox.width > dragStartedX && rectanguloBox.minY < dragStartedY && rectanguloBox.height+100 > dragStartedY {
                                                DispatchQueue.main.async {
                                                    rectangulo = "AlinearFiguras/rectangulo"
                                                }
                                            }
                                            self.dragAmountRectangulo = .zero
                                        }
                                )
                                .frame(width: geo2.size.width*0.7, height: geo2.size.height*0.25)
                                .position(CGPoint(x: 240, y: 370))
                        
                            
                            Image("AlinearFiguras/emptyWoodbox")
                                .resizable()
                                .offset(dragAmountEmptyWoodbox)
                                .gesture(
                                    DragGesture(coordinateSpace: .global)
                                        .onChanged{
                                            self.dragAmountEmptyWoodbox = CGSize(width: $0.translation.width, height: $0.translation.height)
                                        }
                                        .onEnded { _ in
                                            if emptyWoodbox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 150 + dragAmountEmptyWoodbox.width, y: (geo2.frame(in: .global).minY) + 470 + dragAmountEmptyWoodbox.height)) {
                                                DispatchQueue.main.async {
                                                    circulo = ""
                                                    triangulo = ""
                                                    cuadrado = ""
                                                    rectangulo = ""
                                                    poligono = ""
                                                    ovalo = ""
                                                }
                                            }
                                            self.dragAmountEmptyWoodbox = .zero
                                        }
                                )
                                .frame(width: geo2.size.width*0.6, height: geo2.size.height*0.15)
                                .position(CGPoint(x: 150, y: 470))
                            
                        }
                    }
                    .frame(width: geo.size.width*0.25)
                    .background(Color(red: 0.5, green: 0.65, blue: 0.7))
                    .padding()
                }
                .background(.white)
                .padding()
            }
            
            Spacer()
            
        }
        .background(LinearGradient(
            gradient: Gradient(colors: [Color(red: 135 / 255, green: 132 / 255, blue: 255 / 255), Color.green]),
            startPoint: .leading,
            endPoint: .trailing
        ))
    }
    
}

struct AlinearFiguras_Previews: PreviewProvider {
    static var previews: some View {
        AlinearFiguras()
    }
}
