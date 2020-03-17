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
    
    var fistNode: SKSpriteNode!

    override func didMove(to view: SKView) {
        
        setupUI()
        
        addScore()
        
        repeatEnemy()
        
        addfistNode()
    }
    
    func setupUI() {
        self.backgroundColor = SKColor(red: 80.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        self.backgroundColor = SKColor.clear
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -1)
        self.physicsWorld.contactDelegate = self
    }
    
    /// 分数
    var score: NSInteger = 0
    ///分数Label
    lazy var scoreLabelNode:SKLabelNode = {
        let label = SKLabelNode(fontNamed: "MarkerFelt-Wide")
        label.zPosition = 100
        label.text = "0"
        return label
    }()
    
    func addScore() {
        score = 0
        scoreLabelNode.text = String(score)
        self.addChild(scoreLabelNode)
        scoreLabelNode.position = CGPoint(x: self.frame.size.width - 30, y: self.frame.size.height - 50)
    }
    
    // 添加一个敌人
    func addEnemy() {
        let enemy = SKSpriteNode(texture: SKTexture(imageNamed: "hero"))
        enemy.size = CGSize(width: 60, height: 60)
        
        // 出现位置横坐标随机
        let winSize:CGSize = self.size
        let minX = enemy.size.width / 2
        let maxX = winSize.width - enemy.size.width/2
        let rangeX = maxX - minX
        let randomX = (arc4random()%UInt32(rangeX)) + UInt32(minX);
        
        // 初始位置
        enemy.position = CGPoint(x:CGFloat(randomX),y:winSize.height + enemy.size.height/2);
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)

        // 进场
        addChild(enemy)
    }
    
    // 重复添加敌人
    func repeatEnemy() {
        let actionAddEnemy = SKAction.run {
            self.addEnemy()
        }
        let actionWaitNextEnemy = SKAction.wait(forDuration: 1)
        run(SKAction.repeatForever(SKAction.sequence([actionAddEnemy,actionWaitNextEnemy])))
    }
    
    // 添加拳头
    func addfistNode() {
        fistNode = SKSpriteNode(texture: SKTexture(imageNamed: "fist"))
        fistNode.size = CGSize(width: 40, height: 40)
        fistNode.physicsBody = SKPhysicsBody(circleOfRadius: fistNode.size.width)
        fistNode.physicsBody?.affectedByGravity = false
        fistNode.physicsBody?.allowsRotation = false
        fistNode.physicsBody?.isDynamic = false
        
        addChild(fistNode)
    }
}

// 更新拳头位置
extension HeroScene{
   func updatefistNodePositon(point:CGPoint)  {
        if point.x > 0 && point.x < self.size.width
        && point.y > 0 && point.y < self.size.height{
         fistNode.position = point
        }else{
         print(point)
        }
    }
}

extension HeroScene: SKPhysicsContactDelegate{
    
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
}


