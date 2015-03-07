//
//  WebViewController.swift
//  TripHack
//
//  Created by Richard Kim on 3/7/15.
//  Copyright (c) 2015 MarinaLLC. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    var linkURL : String!

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL (string: linkURL);
        let requestObj = NSURLRequest(URL: url!);
        webView.loadRequest(requestObj);
        println(linkURL)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonTouchUpInside(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
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
