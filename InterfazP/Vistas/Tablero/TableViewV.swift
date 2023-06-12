//
//  TableViewV.swift
//  InterfazP
//
//  Created by Alejandro Lizarraga on 11/06/23.
//

import SwiftUI



struct TableViewV: View {
    
    @Binding var board: Tablero
    
    let TTS: Bool
    //    @State var myImages: [Imagen]
    //    private var columns: Int
    //    private var rows: Int
    
    let retrievedImages: [String: UIImage]
    
    var body: some View {
        GeometryReader { geometry in
            let spacing: CGFloat = 8
            let availableWidth = (geometry.size.width - (spacing * CGFloat(board.numCol - 1)))*0.9
            let availableHeight = (geometry.size.height - (spacing * CGFloat(board.numRow - 1)))*0.9
            let itemSize = min(availableWidth / CGFloat(board.numCol), availableHeight / CGFloat(board.numRow))
            
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(itemSize), spacing: spacing), count: board.numCol), spacing: spacing) {
                ForEach(Array(board.imagenes.enumerated()), id: \.element) { (index, imageObject) in
                    ImagenHolderV(imgList: $board.imagenes, img: imageObject, TTS: TTS, myIndex: index, retrievedImages: retrievedImages)
                        .frame(width: itemSize, height: itemSize)
                }
            }
            .padding()
        }
    }
}

//struct TableViewV_Previews: PreviewProvider {
//    static var previews: some View {
//        TableViewV()
//    }
//}
