//
//  TableViewE.swift
//  InterfazP
//
//  Created by Diego Esparza on 09/06/23.
//

import SwiftUI

struct TableViewE: View {
    
    @Binding var board: Tablero
    //    @State var myImages: [Imagen]
    //    private var columns: Int
    //    private var rows: Int
    
    let retrievedImages: [String: UIImage]
    
    
    @State var selectedIndices: [Int] = []
    
    //    init(board: Tablero) {
    //        self.board = board
    //        self.columns = board.numCol
    //        self.rows = board.numRow
    //        self.myImages = board.imagenes
    //    }
    
    
    var body: some View {
        GeometryReader { geometry in
            let spacing: CGFloat = 8
            let availableWidth = (geometry.size.width - (spacing * CGFloat(board.numCol - 1)))*0.9
            let availableHeight = (geometry.size.height - (spacing * CGFloat(board.numRow - 1)))*0.9
            let itemSize = min(availableWidth / CGFloat(board.numCol), availableHeight / CGFloat(board.numRow))
            
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(itemSize), spacing: spacing), count: board.numCol), spacing: spacing) {
                ForEach(Array(board.imagenes.enumerated()), id: \.element) { (index, imageObject) in
                    ImagenHolderE(imgList: $board.imagenes, img: imageObject, myIndex: index, retrievedImages: retrievedImages)
                        .frame(width: itemSize, height: itemSize)
                        .border(selectedIndices.contains(index) ? Color.blue : Color.clear)
                        .background(selectedIndices.contains(index) ? Color.blue.opacity(0.3) : Color.clear)
                        .onTapGesture {
                            handleImageTapped(index)
                        }
                }
            }
            .padding()
        }
    }
    
    private func handleImageTapped(_ index: Int) {
        if selectedIndices.isEmpty {
            selectedIndices.append(index)
        } else if selectedIndices.count == 1 {
            if selectedIndices.contains(index) {
                selectedIndices.removeAll()
            } else {
                selectedIndices.append(index)
                swapImages(from: selectedIndices[0], to: selectedIndices[1])
                selectedIndices.removeAll()
            }
        }
    }
    
    private func swapImages(from sourceIndex: Int, to destinationIndex: Int) {
        guard sourceIndex != destinationIndex else { return }
        let sourceImageObject = board.imagenes[sourceIndex]
        let destinationImageObject = board.imagenes[destinationIndex]
        
        board.imagenes[sourceIndex] = destinationImageObject
        board.imagenes[destinationIndex] = sourceImageObject
    }
    
}

//struct TableViewE_Previews: PreviewProvider {
//    static var previews: some View {
//
//        let testImages : [Imagen] = [
//            Imagen(nombre: "blue", imagen: "Alex/bBlue", descripcion: "def", tags: ["b","globo"], nino: 1, online: false),
//            Imagen(nombre: "red", imagen: "Alex/bRed", descripcion: "def", tags: ["b","globo"], nino: 1, online: false),
//            Imagen(nombre: "yell", imagen: "Alex/bYellow", descripcion: "def", tags: ["b","globo"], nino: 1, online: false),
//            Imagen(nombre: "candle", imagen: "Alex/candle", descripcion: "def", tags: ["b","globo"], nino: 1, online: false)
//        ]
//
//        TableViewE(board: .constant(Tablero(nombre: "asd", numCol: 2, numRow: 2, descripcion: "este es un tablero", imagenes: testImages)))
//
//    }
//}
