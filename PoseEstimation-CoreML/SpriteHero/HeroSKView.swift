//
//  HeroSKView.swift
//  GameSprite001
//
//  Created by CW on 2020/3/13.
//  Copyright © 2020 CW. All rights reserved.
//

import Foundation
import SpriteKit

class HeroSKView: SKView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: scene
    private var heroScene: HeroScene!
    
    func setup()  {
        self.backgroundColor = UIColor.clear
        self.ignoresSiblingOrder = true
        self.showsFPS = false
        self.showsNodeCount = true
        
        setupScene()
    }
    
    func setupScene() {
        heroScene = HeroScene(size: CGSize(width:self.frame.size.width, height: self.frame.size.height))
        heroScene.scaleMode = .aspectFit
        presentScene(heroScene)
    }
}

extension HeroSKView : PosePosionDelegate{
    
    func poseDidCheckedPosion(leftWrist: CGPoint, rightWrist: CGPoint, referView: UIWindow) {
        print(leftWrist,rightWrist)
        
        heroScene.updateBoomPositon(point: leftWrist)
    }
    
}
