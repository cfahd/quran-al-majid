//
//  HikingTrails.swift
//  FahdsApp-P1
//
//  Created by Fahd on 3/10/21.
//

import Foundation
import UIKit

class DGRGItems{
    
    var ItemName:String = ""
    var ItemNumber:String = ""
    var ItemTranslation1:String = ""
    var ItemTranslation2:String = ""
    var ItemDuration:String = "00:00"
    var ItemImage = ""
    var ItemDifficulty = ""
    var ItemSite = ""
    var ItemSound = ""
    
    init(){}
    init(ItemName:String, ItemNumber:String, ItemTranslation1:String, ItemTranslation2:String, ItemDuration:String, ItemImage:String, ItemDifficulty:String, ItemSite:String, ItemSound:String){
        self.ItemName = ItemName
        self.ItemNumber = ItemNumber
        self.ItemTranslation1 = ItemTranslation1
        self.ItemTranslation2 = ItemTranslation2
        self.ItemDuration = ItemDuration
        self.ItemImage = ItemImage
        self.ItemDifficulty = ItemDifficulty
        self.ItemSite = ItemSite
        self.ItemSound = ItemSound
    }
}
