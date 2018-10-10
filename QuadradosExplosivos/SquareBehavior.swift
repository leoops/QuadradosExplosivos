//
//  SquareBehavior.swift
//  IOS_02_Aula_06_1
//
//  Created by HC2MAC16 on 25/04/2018.
//  Copyright © 2018 LS. All rights reserved.
//

import UIKit

class SquareBehavior: UIDynamicBehavior {
    
    private var gravity: UIGravityBehavior?
    private var collision: UICollisionBehavior?
    private var dynamicItemBehavior: UIDynamicItemBehavior?
    
    override init() {
        super.init()
        self.config()
    }
    
    public func addItem(_ item: UIDynamicItem) {
        gravity?.addItem(item)
        collision?.addItem(item)
        dynamicItemBehavior?.addItem(item)
    }
    
    public func removeItem(_ item: UIDynamicItem) {
        gravity?.removeItem(item)
        collision?.removeItem(item)
        dynamicItemBehavior?.removeItem(item)
    }
    
    public func config() {
        dynamicItemBehavior = UIDynamicItemBehavior(items: [])

        // definicao da elasticidade
        dynamicItemBehavior?.elasticity = 0
        // configuracao de gravidade
        gravity = UIGravityBehavior()
        gravity?.magnitude = 0.9807
        // configuracao de colisao
        collision = UICollisionBehavior()
        collision?.translatesReferenceBoundsIntoBoundary = true
        // inclusao de configuracao do objeto
        addChildBehavior(gravity!)
        addChildBehavior(collision!)
        addChildBehavior(dynamicItemBehavior!)
    }
}
