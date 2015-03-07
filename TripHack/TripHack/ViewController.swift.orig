//
//  ViewController.swift
//  TripHack
//
//  Created by Richard Kim on 3/7/15.
//  Copyright (c) 2015 MarinaLLC. All rights reserved.
//

import UIKit
import CoreLocation

var X_BUFFER: CGFloat { return 10.0 }
var Y_BUFFER: CGFloat { return 10.0 }
var TRIP_COLOR: UIColor {
    return UIColor(red: 0.48, green: 0.75, blue: 0.42, alpha: 1) }
var WRONG_COLOR: UIColor {
    return UIColor(red: 0.99, green: 0.46, blue: 0.51, alpha: 1) }

class ViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var coverPhoto: UIImageView!
    @IBOutlet weak var profileBackground: UIView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var card1: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var friendsLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    var card2 : UIView = UIView()
    var card3 : UIView = UIView()
    var card4 : UIView = UIView()
    var card5 : UIView = UIView()
    var flightButton : UIButton = UIButton()
    var wrongButton : UIButton = UIButton()
    var detailsLabel : UILabel = UILabel()
    var imageArray : Array<UIImage> = []
    var flightLabel : UILabel = UILabel()
    
<<<<<<< HEAD
    var flightURL : String = "http://www.google.com"
    var activityURL : String = "http://www.tripadvisor.com"
=======
>>>>>>> origin/master
    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkenCoverPhoto()
        applyPlainShadow(profileBackground)
        setupPlacement()
        scrollView.contentSize = self.view.frame.size
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        scrollView.contentSize = contentView.frame.size
    }
    
    
//ENTRYPOINTS
    func setCoverPhoto(image: UIImage) {
        coverPhoto.image = image
    }
    
    func setProfilePhoto(image: UIImage) {
        profilePicture.image = image
    }
    
    func setTitle(text:NSString) {
        titleLabel.text = text
    }
    
    func setDetails(location: NSString, details:NSString) {
        detailsLabel.text = location + "\n\n" + details
    }
    
    func setImages(array: Array<UIImage>) {
        
    }
    
    func setFlightDate(dateString: NSString) {
        flightLabel.text = "Salvage your dignity and fly back on\n" + dateString
    }
    
    func setFlightURL(link: NSString) {
        flightURL = link
    }
    
    func setActivityURL(link: NSString) {
        activityURL = link
    }
    
    
    
    
    
    
    
    func setupPlacement() {
        makeCard(card1)
        scrollView.delegate = self
        
        coverPhoto.frame = CGRectMake(0, 0, self.view.frame.size.width, 200)
        profileBackground.frame = CGRectMake(X_BUFFER, coverPhoto.frame.size.height - 70, 100, 100)
        titleLabel.frame = CGRectMake(profileBackground.frame.size.width + profileBackground.frame.origin.x + 10, coverPhoto.frame.size.height - 30, self.view.frame.size.width - profileBackground.frame.size.width - profileBackground.frame.origin.x - 20, 24)
        friendsLabel.frame = CGRectMake(profileBackground.frame.size.width + profileBackground.frame.origin.x + 10, coverPhoto.frame.size.height, self.view.frame.size.width - profileBackground.frame.size.width - profileBackground.frame.origin.x - 20, 24)
        
        card1.frame = CGRectMake(X_BUFFER, profileBackground.frame.size.height + profileBackground.frame.origin.y + 10, self.view.frame.size.width - 20, 110);
        
        makeReviewCard("Queenstown, New Zealand", description: "Shotover Canyon Swing is an intense, undie staining, adrenalin stimulating activity achieved by launching yourself from a 109m high cliff-mounted platform. You’ll reach speeds of 150kph as you freefall for 60m. The ropes then smoothly pendulum you into a 200m swing.", rating: 5, numRatings: 184)
        
        var demo1 = UIImage(named: "demo1")
        var array = [demo1!]
        makePhotoCard(array)
        makeLamenessCard()
        makeFlightCards()
    }
    
    func makeReviewCard(location: String, description: String, rating: CGFloat, numRatings: Int) {
        card2 = UIView(frame: CGRectMake(X_BUFFER, card1.frame.size.height + card1.frame.origin.y + Y_BUFFER, self.view.frame.size.width - (2 * X_BUFFER), 200));
        card2.backgroundColor = UIColor.whiteColor()
        makeCard(card2)
        contentView.addSubview(card2)
        
        detailsLabel = UILabel(frame: CGRectMake(15, 10, card2.frame.size.width - (2 * 15), 170))
        detailsLabel.text = location + "\n\n" + description
        detailsLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        detailsLabel.numberOfLines = 8;
        detailsLabel.alpha = 0.8
        
        card2.addSubview(detailsLabel)
        updateContentViewWith(card2)
    }
    
    func makePhotoCard(images: Array<UIImage>) {
        if (images.count == 0) {
            return;
        }
        
        card3 = UIView(frame: CGRectMake(X_BUFFER,  card2.frame.size.height + card2.frame.origin.y + Y_BUFFER, self.view.frame.size.width - (2 * X_BUFFER), self.view.frame.size.height / 2))
        contentView.addSubview(card3)
        makeCard(card3)
        card3.backgroundColor = UIColor.whiteColor()
        
        var pic1:UIImageView = UIImageView(image: images[0])
        pic1.frame = CGRectMake(0, 0, card3.frame.size.width - (2 * X_BUFFER), card3.frame.size.height - (2 * Y_BUFFER))
        pic1.center = CGPointMake(card3.frame.size.width/2, card3.frame.size.height/2)
        pic1.contentMode = UIViewContentMode.ScaleAspectFit
        
        card3.addSubview(pic1)
        
        updateContentViewWith(card3)
    }
    
    func makeLamenessCard() {
        card4 = UIView(frame: CGRectMake(X_BUFFER, card3.frame.size.height + card3.frame.origin.y + Y_BUFFER, self.view.frame.size.width - (2 * X_BUFFER), 170))
        contentView.addSubview(card4)
        makeCard(card4)
        card4.backgroundColor = UIColor.whiteColor()
        
        var label = UILabel(frame: CGRectMake(X_BUFFER, Y_BUFFER, card4.frame.size.width - (2 * Y_BUFFER), 50))
        label.text = "Compared to your friends, \nyour lameness score is:"
        var lameness = UILabel(frame: CGRectMake(X_BUFFER, Y_BUFFER + label.frame.size.height + label.frame.origin.y, card4.frame.size.width - (2 * Y_BUFFER), 70))
        lameness.text = String(Int(arc4random_uniform(100)))
        lameness.textAlignment = NSTextAlignment.Center
        lameness.font = UIFont (name: "Helvetica Neue", size: 75)
        lameness.textColor = TRIP_COLOR
        card4.addSubview(label)
        card4.addSubview(lameness)
        label.textAlignment = NSTextAlignment.Center
        label.numberOfLines = 2

        updateContentViewWith(card4)
    }
    
    func makeFlightCards() {
        card5 = UIView(frame: CGRectMake(X_BUFFER, card4.frame.size.height + card4.frame.origin.y + Y_BUFFER, self.view.frame.size.width - (2 * X_BUFFER), 85))
        contentView.addSubview(card5)
        makeCard(card5)
        card5.backgroundColor = UIColor.whiteColor()
        
        flightLabel = UILabel(frame: CGRectMake(X_BUFFER, 0, card5.frame.size.width - (2 * Y_BUFFER), card5.frame.size.height))
        flightLabel.text = "Salvage your dignity and fly back on\n Tuesday, March 10th"
        card5.addSubview(flightLabel)
        flightLabel.textAlignment = NSTextAlignment.Center
        flightLabel.numberOfLines = 2
        
        flightButton = UIButton(frame: CGRectMake(
            card5.frame.origin.x,
            card5.frame.origin.y + card5.frame.size.height + 2,
            card5.frame.size.width,
            59))
        flightButton.backgroundColor = TRIP_COLOR
        flightButton.setTitle("Fly me back!", forState: .Normal)
        flightButton.titleLabel?.textColor = UIColor.whiteColor()
        makeCard(flightButton)
        contentView.addSubview(flightButton)
        flightButton.addTarget(self, action: "flyMeBackTouchUpInside", forControlEvents: UIControlEvents.TouchUpInside)
        
        wrongButton = UIButton(frame: CGRectMake(
            card5.frame.origin.x,
            flightButton.frame.origin.y + flightButton.frame.size.height + 2,
            card5.frame.size.width,
            59))
        wrongButton.backgroundColor = WRONG_COLOR
        wrongButton.setTitle("You're wrong, I've been here", forState: .Normal)
        wrongButton.titleLabel?.textColor = UIColor.whiteColor()
        makeCard(wrongButton)
        contentView.addSubview(wrongButton)
        wrongButton.addTarget(self, action: "youreWrongTouchUpInside", forControlEvents: UIControlEvents.TouchUpInside)
        
        updateContentViewWith(wrongButton)
        
        
    }
    
    func updateContentViewWith(view:UIView) {
        contentView.frame = CGRectMake(0, 0, self.view.frame.size.width, view.frame.size.height + view.frame.origin.y + Y_BUFFER)
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
    
    func makeCard(view: UIView) {
        applyPlainShadow(view)
        view.layer.cornerRadius = 2
    }
    
    func applyPlainShadow(view: UIView) {
        var layer = view.layer
        
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 2
    }

    func scrollViewDidScroll(scrollView: UIScrollView!) {

    }
    
    // BUTTON FUNCTIONS
    
    @IBAction func flyBackTouchUpInside(sender: AnyObject) {
    }
    @IBAction func shareTouchUpInside(sender: AnyObject) {
    }
    @IBAction func addToBucketTouchUpInside(sender: AnyObject) {
  
    }
    func flyMeBackTouchUpInside() {
        self.performSegueWithIdentifier("toWebView", sender: flightURL)
    }
    func youreWrongTouchUpInside() {
        self.performSegueWithIdentifier("toWebView", sender: activityURL)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toWebView") {
            var dvc = segue.destinationViewController as WebViewController
            dvc.linkURL = sender as String
        }
    }

}
