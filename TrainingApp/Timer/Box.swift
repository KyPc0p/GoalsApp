//
//  Box.swift
//  TrainingApp
//
//  Created by Артём Харченко on 04.08.2022.
//

import Foundation



class Box<T> {
    //имя для клоужера
    typealias Listiner = (T) -> ()
    
    var value: T {
        didSet {
            listiner?(value)
        }
    }
    
    var listiner: Listiner?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listiner: Listiner?){
        self.listiner = listiner
    }
    
    func removeBind(){
        self.listiner = nil
    }
}
