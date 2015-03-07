//
//  ViewController.swift
//  TripHack
//
//  Created by Richard Kim on 3/7/15.
//  Copyright (c) 2015 MarinaLLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var coverPhoto: UIImageView!
    @IBOutlet weak var profileBackground: UIView!
    @IBOutlet weak var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkenCoverPhoto()
        applyPlainShadow(profileBackground)
        scrollView.contentSize = self.view.frame.size
        // Do any additional setup after loading the view.
    }
    
    func darkenCoverPhoto() {
        var darkImage = UIImageView(image: UIImage(named:"fadeView"))
        darkImage.frame = coverPhoto.frame
        coverPhoto.addSubview(darkImage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func applyPlainShadow(view: UIView) {
        var layer = view.layer
        
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 2
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
