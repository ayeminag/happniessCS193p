//
//  HappinessViewController.swift
//  happiness
//
//  Created by Aye Min Aung on 26/5/15.
//  Copyright (c) 2015 Aye Min Aung. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource
{
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }
    var happiness: Int = 75 {
        didSet{
            happiness = min(max(happiness, 0), 100)
            updateUI()
        }
    }
    
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 2
    }
    @IBAction func changeHappiness(sender: UIPanGestureRecognizer) {
        switch sender.state {
            case .Ended: fallthrough
            case .Changed:
                let translation = sender.translationInView(faceView)
                var happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
                if happinessChange != 0 {
                    happiness += happinessChange
                    sender.setTranslation(CGPointZero, inView: faceView)
                }
            default: break
        }
        
    }
    
    func updateUI()
    {
        faceView.setNeedsDisplay()
    }
    
    func smilenessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50)/50
    }
    
    
}
