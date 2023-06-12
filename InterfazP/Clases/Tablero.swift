//
//  Tablero.swift
//  InterfazP
//
//  Created by Diego Esparza on 09/06/23.
//

import Foundation

struct Tablero : Hashable, Codable, Identifiable{
    var id = UUID()
    var ident: String!
    var nombre: String
    var numCol: Int
    var numRow : Int
    var descripcion : String
    var imagenes : [Imagen]
}
