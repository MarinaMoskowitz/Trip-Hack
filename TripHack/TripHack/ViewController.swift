//
//  ViewController.swift
//  TripHack
//
//  Created by Richard Kim on 3/7/15.
//  Copyright (c) 2015 MarinaLLC. All rights reserved.
//

import UIKit
import CoreLocation
import Parse

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
    var card2 : UIView = UIView()
    var card3 : UIView = UIView()
    var card4 : UIView = UIView()
    var card5 : UIView = UIView()
    var flightButton : UIButton = UIButton()
    var wrongButton : UIButton = UIButton()
    var detailsLabel : UILabel = UILabel()
    var imageArray : Array<UIImage> = []
    var flightLabel : UILabel = UILabel()
    var extraPicture : UIImageView = UIImageView()
    
    var flightURL : String = "http://www.tripadvisor.com/CheapFlights?geo=255122&pax0=a&travelers=1&cos=0&nonstop=no&airport0=BOS&nearby0=no&airport1=ZQN&nearby1=no&date0=20150321&time0=0024&date1=20150328&time1=0024&provider0=Expedia&provider1=Travelocity&cr=0"
    var activityURL : String = "http://www.tripadvisor.com/Attractions-g255122-Activities-Queenstown_Otago_Region_South_Island.html"

    var picturePVC : UIPageViewController = UIPageViewController()
    var height : CGFloat = 0.00
    var coverPhotoCenterY : CGFloat = 0.00

    var darkImage : UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkenCoverPhoto()
        applyPlainShadow(profileBackground)
        setupPlacement()
        scrollView.contentSize = self.view.frame.size
        
        // Do any additional setup after loading the view.
        showIntroAlert()
    }
    
    func showIntroAlert() {
        let alertController = UIAlertController(title: "Oh Hey, you're back from New Zealand!", message: "Here's something you totally forgot to do in New Zealand", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "continue", style: .Cancel) { (action) in
        println(action)
        }
        
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true) {
        
        }
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, height)
        coverPhotoCenterY = coverPhoto.center.y
    }
    
    
//ENTRYPOINTS
    func setCoverPhoto(image: UIImage) {
    //let url = NSURL(string: image.url)
    //let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
    //imageURL.image = UIImage(data: data!)
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
    
    func setExtraImage(image: UIImage) {
        extraPicture.image = image
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
        let defaults = NSUserDefaults.standardUserDefaults()
        let sysLat = defaults.doubleForKey("latitude")
        let sysLong = defaults.doubleForKey("longitude")
        self.makeReviewCard("Loading...", description:"...", rating: 5, numRatings: 184)
            PFCloud.callFunctionInBackground("getTripData", withParameters:["locationData": ["oldCoord": [sysLat, sysLong], "newCoord": [sysLat,sysLong]]], block: { (results:AnyObject!, error:NSError!) -> Void in
                if error != nil {
                    
                } else {
                    println(results)
                    defaults.setObject(results["description"], forKey:"description")
                    defaults.setObject(results["title"], forKey:"title")
                    defaults.setObject(results["location"], forKey:"location")
                    println(defaults.stringForKey("title")!)
                    self.setTitle(defaults.stringForKey("title")!)
                    self.setDetails(defaults.stringForKey("location")!, details: defaults.stringForKey("description")!)
                }
            })

        
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
        scrollView.addSubview(card2)
        
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
        scrollView.addSubview(card3)
        makeCard(card3)
        card3.backgroundColor = UIColor.whiteColor()
        
        extraPicture = UIImageView(image: images[0])
        extraPicture.frame = CGRectMake(0, 0, card3.frame.size.width - (2 * X_BUFFER), card3.frame.size.height - (2 * Y_BUFFER))
        extraPicture.center = CGPointMake(card3.frame.size.width/2, card3.frame.size.height/2)
        extraPicture.contentMode = UIViewContentMode.ScaleAspectFit
        
        card3.addSubview(extraPicture)
        
        updateContentViewWith(card3)
    }

    func makeLamenessCard() {
        card4 = UIView(frame: CGRectMake(X_BUFFER, card3.frame.size.height + card3.frame.origin.y + Y_BUFFER, self.view.frame.size.width - (2 * X_BUFFER), 170))
        scrollView.addSubview(card4)
        makeCard(card4)
        card4.backgroundColor = UIColor.whiteColor()
        
        var label = UILabel(frame: CGRectMake(X_BUFFER, Y_BUFFER, card4.frame.size.width - (2 * Y_BUFFER), 50))
        label.text = "Compared to your friends, \nyou are this lame:"
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
        scrollView.addSubview(card5)
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
        scrollView.addSubview(flightButton)
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
        scrollView.addSubview(wrongButton)
        wrongButton.addTarget(self, action: "youreWrongTouchUpInside", forControlEvents: UIControlEvents.TouchUpInside)
        
        updateContentViewWith(wrongButton)
        
        
    }
    
    func updateContentViewWith(view:UIView) {
        height = view.frame.size.height + view.frame.origin.y + Y_BUFFER
    }
    
    func darkenCoverPhoto() {
        darkImage = UIImageView(image: UIImage(named:"fadeView"))
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
        var offset = scrollView.contentOffset.y
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity

        if offset < 0 {
         
             let headerScaleFactor:CGFloat = -(offset) / coverPhoto.bounds.height
             let headerSizevariation = ((coverPhoto.bounds.height * (1.0 + headerScaleFactor)) - coverPhoto.bounds.height)/2.0
             headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
             headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
         
             coverPhoto.layer.transform = headerTransform
            coverPhoto.center = CGPointMake(coverPhoto.center.x, coverPhotoCenterY + offset)
        }
    }
    
    // BUTTON FUNCTIONS
    
    @IBAction func flyBackTouchUpInside(sender: AnyObject) {
        self.performSegueWithIdentifier("toWebView", sender: flightURL)
    }
    @IBAction func shareTouchUpInside(sender: AnyObject) {

        let alertController = UIAlertController(title: "Share", message: "That you totally missed this awesome experience", preferredStyle: .ActionSheet)

        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
        }
        alertController.addAction(cancelAction)

        let OKAction = UIAlertAction(title: "Twitter", style: .Default) { (action) in
        }
        alertController.addAction(OKAction)

        let OKAction2 = UIAlertAction(title: "Facebook", style: .Default) { (action) in
        }
        alertController.addAction(OKAction2)

        let OKAction3 = UIAlertAction(title: "TripAdvisor", style: .Default) { (action) in
        }
        alertController.addAction(OKAction3)

        self.presentViewController(alertController, animated: true) {
        }
    }
    @IBAction func addToBucketTouchUpInside(sender: AnyObject) {
        let alertController = UIAlertController(title: "Added to BucketList", message: "We'll remind you sometime before you die", preferredStyle: .Alert)

        let cancelAction = UIAlertAction(title: "whoop whoop", style: .Cancel) { (action) in
            println(action)
        }

        let destroyAction = UIAlertAction(title: "undo", style: .Destructive) { (action) in
            println(action)
        }
        alertController.addAction(destroyAction)
        alertController.addAction(cancelAction)

        self.presentViewController(alertController, animated: true) {

        }
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
