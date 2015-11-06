//
//  MenuViewController.swift
//  Pop Lock and Drop It
//
//  Created by Jeremy Evans on 11/5/15.
//  Copyright © 2015 Jeremy Evans. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func didTapPlay(sender: AnyObject) {
        
        let gvc = storyboard?.instantiateViewControllerWithIdentifier("gameViewController") as! GameViewController
            gvc.continueMode = false
            presentViewController(gvc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func didTapContinue(sender: AnyObject) {
        
        let gvc = storyboard?.instantiateViewControllerWithIdentifier("gameViewController") as! GameViewController
        gvc.continueMode = true
        presentViewController(gvc, animated: true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
