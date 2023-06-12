//
//  Imagen.swift
//  InterfazP
//
//  Created by Diego Esparza on 09/06/23.
//

import Foundation

struct Imagen : Hashable, Codable, Identifiable{
    var id = UUID()
    var ident: String!
    var nombre: String
    var imagen: String
    var descripcion : String
    var tags : [String]
    var nino : Int
    var online : Bool
}
