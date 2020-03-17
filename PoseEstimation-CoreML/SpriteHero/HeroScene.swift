//
//  HeroScene.swift
//  GameSprite001
//
//  Created by CW on 2020/3/13.
//  Copyright © 2020 CW. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

let enemyCategory: UInt32 = 0x1 << 0
let fistCategory: UInt32 = 0x1 << 1

class HeroScene: SKScene {
    
    var fistNode: SKSpriteNode!
    var floorNode:SKSpriteNode!
    var score: NSInteger = 0
    
    override func didMove(to view: SKView) {
        
        setupScene()
        
        addScoreLable()
        
        addfistNode()
        
        repeatEnemy()
    
    }
    
    func setupScene() {
        self.backgroundColor = SKColor(red: 80.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        self.backgroundColor = SKColor.clear
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -1.3)
        self.physicsWorld.contactDelegate = self
    }
    
    // 声音
    var audioPlayer : AVAudioPlayer = {
         var player : AVAudioPlayer?
         let mp3Path = Bundle.main.path(forResource: "11970", ofType: "mp3")   //bgm自己放一首进去就好
         let pathURL = NSURL.fileURL(withPath: mp3Path!)
         try? player = AVAudioPlayer(contentsOf: pathURL)
         return player!
     }()
    
    func playMusic() {
        audioPlayer.numberOfLoops = 1
        audioPlayer.play()
    }
    
    // 分数
    lazy var scoreLabelNode:SKLabelNode = {
        let label = SKLabelNode(fontNamed: "MarkerFelt-Wide")
        label.zPosition = 100
        label.text = "0"
        return label
    }()
    
    func addScoreLable() {
        score = 0
        scoreLabelNode.text = String(score)
        self.addChild(scoreLabelNode)
        scoreLabelNode.position = CGPoint(x: self.frame.size.width - 30, y: self.frame.size.height - 50)
    }
    
    func scorePlus() {
        score += 1
        scoreLabelNode.text = "\(score)" + "分"
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
        enemy.physicsBody?.categoryBitMask = enemyCategory
        enemy.physicsBody?.contactTestBitMask = fistCategory
        enemy.physicsBody?.collisionBitMask = fistCategory
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
        
        fistNode.physicsBody?.categoryBitMask = fistCategory
        fistNode.physicsBody?.contactTestBitMask = enemyCategory
        fistNode.physicsBody?.collisionBitMask = enemyCategory
        
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
        playMusic()
        
        if contact.bodyA.node == fistNode ||
            contact.bodyB.node == fistNode{
            scorePlus()
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.node != fistNode{
            contact.bodyA.node?.removeFromParent()
        }
        if contact.bodyB.node != fistNode{
            contact.bodyB.node?.removeFromParent()
        }
    }
}



