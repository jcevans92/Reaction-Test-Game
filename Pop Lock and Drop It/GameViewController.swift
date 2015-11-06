//
//  GameViewController.swift
//  Pop Lock and Drop It
//
//  Created by Jeremy Evans on 11/5/15.
//  Copyright (c) 2015 Jeremy Evans. All rights reserved.
//

import UIKit
import SpriteKit
import iAd



class GameViewController: UIViewController, GameDelegate {

    
    var continueMode = Bool?()
    var newImage: UIImage?
    
    @IBOutlet weak var shareButton: UIButton!
    
    
    @IBAction func didTapMenuBtn(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didTapShare(sender: AnyObject) {
        
        if let image = newImage {
            share(image)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIViewController.prepareInterstitialAds()
        self.interstitialPresentationPolicy = .Manual
        
        shareButton.hidden = true
        
        let scene = GameScene(size: view.bounds.size)
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
            
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        if let continueIsTrue = continueMode {
            
            scene.continueMode = continueIsTrue
            
        }
        
        scene.gameDelegate = self
        
        skView.presentScene(scene)
        
    }
    
    func gameStarted() {
        shareButton.hidden = true
    }
    
    func gameFinished() {
        snapPic()
        shareButton.hidden = false
        self.requestInterstitialAdPresentation()
    }

 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    func share(image: UIImage) {
        
        let avc = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        presentViewController(avc, animated: true, completion: nil)
        
    }
    
    func snapPic() {
        
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, false, 1.0)
        self.view.drawViewHierarchyInRect(CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height), afterScreenUpdates: false)
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        
    }

   
}
