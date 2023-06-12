//
//  Nino.swift
//  InterfazP
//
//  Created by Diego Esparza on 09/06/23.
//

import Foundation

struct Nino : Hashable, Codable, Identifiable{
    var id = UUID()
    var ident: String!
    var nombre: String
    var fechaNacimiento: String
    var descripcion : String
    var miniGameLevel : Int
    var tableros : [Tablero]
}
