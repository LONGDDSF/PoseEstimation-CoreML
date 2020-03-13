//
//  HeroScene.swift
//  GameSprite001
//
//  Created by CW on 2020/3/13.
//  Copyright © 2020 CW. All rights reserved.
//

import Foundation
import SpriteKit

class HeroScene: SKScene {
    
//    var heroNode: SKSpriteNode!
//    var textture: SKTexture!
    private var boom: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor(red: 80.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        self.backgroundColor = SKColor.clear
//        let size = CGSize(width: 50, height: 50)
//        textture = SKTexture(imageNamed: "hero")
//        heroNode = SKSpriteNode.init(texture: textture )
//        heroNode.size = size
//        heroNode.position = CGPoint(x: self.size.width/2, y: heroNode.size.height/2)
//
//        addChild(heroNode)
        repeatEnemy()
        addBoom()
    }
    
    func addEnemy() {
        let enemy = SKSpriteNode(texture: SKTexture(imageNamed: "hero"))
        enemy.size = CGSize(width: 60, height: 60)
        
        //设定敌机的出现位置横坐标随机randomX
        let winSize:CGSize = self.size
        let minX = enemy.size.width / 2
        let maxX = winSize.width - enemy.size.width/2
        let rangeX = maxX - minX
        let randomX = (arc4random()%UInt32(rangeX)) + UInt32(minX);
        
        //设置敌机初始位置并添加敌机进场景
        enemy.position = CGPoint(x:CGFloat(randomX),y:winSize.height + enemy.size.height/2);
        addChild(enemy)
        
        //设定敌机飞向英雄的时间，随机来控制不同的敌机飞行速度
        let minDuration = 4.0;
        let maxDuration = 8.0;
        let rangeDuration = maxDuration - minDuration;
        let actualDuration = (arc4random() % UInt32(rangeDuration)) + UInt32(minDuration);
        
        //执行敌机从起始点飞向英雄的动作
        let actionMove = SKAction.move(to: CGPoint(x: CGFloat(randomX), y: enemy.size.height/2), duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.run {
            enemy.removeFromParent()
        }
        enemy.run(SKAction.sequence([actionMove,actionMoveDone]))
    }
    
    func repeatEnemy() {
        let actionAddEnemy = SKAction.run {
            self.addEnemy()
        }
        let actionWaitNextEnemy = SKAction.wait(forDuration: 1)
        run(SKAction.repeatForever(SKAction.sequence([actionAddEnemy,actionWaitNextEnemy])))
    }
    
    func addBoom() {
        boom = SKSpriteNode(texture: SKTexture(imageNamed: "boom"))
        boom.size = CGSize(width: 60, height: 60)
        addChild(boom)
    }
    
    func updateBoomPositon(point:CGPoint)  {
//        boom.position = point
        let action = SKAction.move(to: point, duration: 0)
        
//        boom.run(action);
        run(action)
    }
    
//    required init?(coder aDecoder: NSCoder) {
//
//    }
}


