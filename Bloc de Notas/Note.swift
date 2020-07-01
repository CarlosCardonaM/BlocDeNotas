//
//  Note.swift
//  Bloc de Notas
//
//  Created by Carlos Cardona on 03/06/20.
//  Copyright © 2020 D O G. All rights reserved.
//

import Foundation

struct Note {
    
    var docId:String
    var title:String
    var body:String
    var isStarred:Bool
    var createdAt:Date
    var lastUpdatedAt:Date?
}
