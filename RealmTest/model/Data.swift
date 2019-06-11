//
//  Data.swift
//  Realm
//
//  Created by Yon Thiri Aung on 6/11/19.
//  Copyright © 2019 Yon Thiri Aung. All rights reserved.
//

import Foundation
import RealmSwift

class Data : Object{
    
    @objc dynamic var name : String = ""
    @objc dynamic var occupation : String = ""
    @objc dynamic var age : String = ""
    @objc dynamic var id : Int = 0
    
    func IncrementaID() -> Int{
        let realm = try! Realm()
        if let retNext = realm.objects(Data.self).sorted(byKeyPath: "id").first?.id {
            return retNext + 1
        }else{
            return 1
        }
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
