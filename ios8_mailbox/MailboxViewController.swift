//
//  MailboxViewController.swift
//  ios8_mailbox
//
//  Created by Stanley Ng on 9/16/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController, RescheduleViewControllerDelegate, ListViewControllerDelegate {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var menuScrollView: UIScrollView!
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var helpImageView: UIImageView!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var archiveIconImageView: UIImageView!
    @IBOutlet weak var laterIconImageView: UIImageView!
    @IBOutlet weak var listIconImageView: UIImageView!
    @IBOutlet weak var deleteIconImageView: UIImageView!
    var positions = [String: [String: CGPoint]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println("MailboxViewController - viewDidLoad")
        setupPositions()
        setupMailboxScrollView()
        setupMenuScrollView()
        setupScreenEdgePanGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupScreenEdgePanGesture() {
        var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onScreenEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        contentView.addGestureRecognizer(edgeGesture)
    }
    
    func setupPositions() {
        positions["mailbox"] = [
            "open": CGPoint(x: 285, y: 0),
            "close": CGPoint(x: 0, y: 0)
        ]
        positions["feed"] = [
            "init": feedImageView.frame.origin
        ]
        positions["message"] = [
            "init": messageImageView.frame.origin,
            "left": CGPoint(x: -messageImageView.frame.size.width, y: messageImageView.frame.origin.y),
            "right": CGPoint(x: messageImageView.frame.size.width, y: messageImageView.frame.origin.y)
        ]
        positions["later_icon"] = [
            "init": laterIconImageView.frame.origin
        ]
        positions["list_icon"] = [
            "init": listIconImageView.frame.origin
        ]
        positions["archive_icon"] = [
            "init": archiveIconImageView.frame.origin
        ]
        positions["delete_icon"] = [
            "init": deleteIconImageView.frame.origin
        ]
    }

    func setupMailboxScrollView() {
        
        // Calculate content size
        var size = CGSize(
            width: contentView.frame.size.width,
            height: helpImageView.frame.size.height +
                    searchImageView.frame.size.height +
                    messageImageView.frame.size.height +
                    feedImageView.frame.size.height)
        contentView.frame.size = size
        
        println("contentView.frame.size: \(contentView.frame.size)")
        
        // Set the content size
        scrollView.contentSize = contentView.frame.size
    }
    
    func setupMenuScrollView() {
        menuScrollView.contentSize = menuImageView.frame.size
    }
    
    @IBAction func onMenu(sender: UIButton) {
        println("MailboxViewController - onMenu")
        toggleMenu()
    }
    
    @IBAction func onMessagePan(sender: UIPanGestureRecognizer) {
        //println("MailboxViewController - onMessagePan")
        
        var location = sender.locationInView(view)
        println("location.x: \(location.x)")
        
        var translation = sender.translationInView(view)
        println("translation.x: \(translation.x)")
        
        if sender.state == UIGestureRecognizerState.Began {
            
            println("MailboxViewController - onMessagePan - Began")
            
            // MESSAGE
            positions["message"]!["init"]! = messageImageView.frame.origin

        }
        else if sender.state == UIGestureRecognizerState.Changed {
        
            println("MailboxViewController - onMessagePan - Changed")
            
            // MESSAGE
            var pos = positions["message"]!["init"]!
            pos.x = pos.x + translation.x
            messageImageView.frame.origin.x = pos.x
            println("message.pos.x: \(pos.x)")
            
            // BG: BROWN
            if translation.x <= -235 {
                messageView.backgroundColor = UIColor.brownColor()
            }
            // BG: YELLOW
            else if translation.x > -235 && translation.x <= -70 {
                messageView.backgroundColor = UIColor.yellowColor()
            }
            // BG: LIGHT GRAY
            else if translation.x > -70 && translation.x <= 70 {
                messageView.backgroundColor = UIColor.lightGrayColor()
            }
            // BG: GREEN
            else if translation.x > 70 && translation.x <= 235 {
                messageView.backgroundColor = UIColor.greenColor()
            }
            // BG: RED
            else if translation.x > 235 {
                messageView.backgroundColor = UIColor.redColor()
            }
            
            // ICON: LIST (BROWN)
            if translation.x <= -235 {
                deleteIconImageView.alpha = 0
                archiveIconImageView.alpha = 0
                laterIconImageView.alpha = 0
                listIconImageView.alpha = 1
                
                var d = translation.x + 70
                listIconImageView.frame.origin.x = positions["list_icon"]!["init"]!.x + d
            }
            // ICON: LATER (YELLOW)
            else if translation.x > -235 && translation.x <= -70 {
                deleteIconImageView.alpha = 0
                archiveIconImageView.alpha = 0
                laterIconImageView.alpha = 1
                listIconImageView.alpha = 0
                
                var d = translation.x + 70
                laterIconImageView.frame.origin.x = positions["later_icon"]!["init"]!.x + d
            }
            // ICON: LATER (LIGHT GRAY)
            else if translation.x > -70 && translation.x <= 0 {
                deleteIconImageView.alpha = 0
                archiveIconImageView.alpha = 0
                laterIconImageView.alpha = abs(translation.x) / 70
                listIconImageView.alpha = 0
            }
            // ICON: ARCHIVE (LIGHT GRAY)
            else if translation.x > 0 && translation.x <= 70 {
                deleteIconImageView.alpha = 0
                archiveIconImageView.alpha = abs(translation.x) / 70
                laterIconImageView.alpha = 0
                listIconImageView.alpha = 0
            }
            // ICON: ARCHIVE (GREEN)
            else if translation.x > 70 && translation.x <= 235 {
                deleteIconImageView.alpha = 0
                archiveIconImageView.alpha = 1
                laterIconImageView.alpha = 0
                listIconImageView.alpha = 0
                
                var d = translation.x - 70
                archiveIconImageView.frame.origin.x = positions["archive_icon"]!["init"]!.x + d
            }
            // ICON: DELETE (RED)
            else if translation.x > 235 {
                deleteIconImageView.alpha = 1
                archiveIconImageView.alpha = 0
                laterIconImageView.alpha = 0
                listIconImageView.alpha = 0

                var d = translation.x - 70
                deleteIconImageView.frame.origin.x = positions["delete_icon"]!["init"]!.x + d
            }
            
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            
            println("MailboxViewController - onMessagePan - Ended")
            
            // MESSAGE
            UIView.animateWithDuration(0.4, animations:
                { () -> Void in
                
                    if (abs(translation.x) <= 70) {
                        
                        println("|translation.x| <= 70")
                        
                        // INITIAL POSITION
                        self.messageImageView.frame.origin = self.positions["message"]!["init"]!
                        
                    }
                    else if (translation.x < -70) {
                        
                        println("translation.x < -70")
                        
                        // GO LEFT
                        self.messageImageView.frame.origin = self.positions["message"]!["left"]!
                        
                        // ICON: LATER
                        self.laterIconImageView.frame.origin.x = 20

                        // ICON: LIST
                        self.listIconImageView.frame.origin.x = 20
                    }
                    else if (translation.x > 70) {
                        
                        println("translation.x > 70")
                        
                        // GO RIGHT
                        self.messageImageView.frame.origin = self.positions["message"]!["right"]!
                     
                        // ICON: ARCHIVE
                        self.archiveIconImageView.frame.origin.x = self.positions["message"]!["right"]!.x - 50
                        
                        // ICON: DELETE
                        self.deleteIconImageView.frame.origin.x = self.positions["message"]!["right"]!.x - 50
                    }
                    
                }, completion: { (done: Bool) -> Void in

                    // HIDE ICONS
                    self.deleteIconImageView.alpha = 0
                    self.archiveIconImageView.alpha = 0
                    self.laterIconImageView.alpha = 0
                    self.listIconImageView.alpha = 0
                    
                    if translation.x <= 0 {
                        
                        // CASE 1: x <= -220, SHOW LIST OPTIONS
                        if translation.x <= -220 {
                            println("SHOW LIST OPTIONS")
                            self.performSegueWithIdentifier("listFromMailbox", sender: self)
                        }
                
                        // CASE 2: -220 < x <= -70, SHOW RESCHEDULE OPTIONS
                        else if translation.x > -220 && translation.x <= -70 {
                            println("SHOW RESHEDULE OPTIONS")
                            self.performSegueWithIdentifier("rescheduleFromMailbox", sender: self)
                        }
                        
                        // CASE 3: -70 < x <= 0, DO NOTHING
                        if translation.x > -70 {
                            
                        }
                        
                    }
                    else {
                        
                        // CASE 1: x > 0 && x <= 70, DO NOTHING
                        if translation.x > 0 && translation.x <= 70 {
                            
                        }
                
                        // CASE 2: x > 70 && x <= 235, ARCHIVE MESSAGE
                        else if translation.x > 70 && translation.x <= 235 {
                            println("ARCHIVE MESSAGE")
                            self.slideupFeed()
                        }
                        
                        // CASE 3: x > 235, DELETE MESSAGE
                        else if translation.x > 235 {
                            println("DELETE MESSAGE")
                            self.slideupFeed()
                        }
                    }

            })
        }
    }
    
    func onScreenEdgePan(sender: UIScreenEdgePanGestureRecognizer) {
        println("MailboxViewController - onScreenEdgePan")
        
        var location = sender.locationInView(view)
        println("location.x: \(location.x)")
        
        var translation = sender.translationInView(view)
        println("translation.x: \(translation.x)")
        
        if sender.state == UIGestureRecognizerState.Began {
            // MAILBOX
        }
        else if sender.state == UIGestureRecognizerState.Changed {
            // MAILBOX
            var pos = positions["mailbox"]!["close"]!
            pos.x = pos.x + translation.x
            mainView.frame.origin.x = pos.x
            println("mailbox.pos.x: \(pos.x)")
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            // MAILBOX
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                if translation.x >= 125 {
                    self.mainView.frame.origin = self.positions["mailbox"]!["open"]!
                }
                else {
                    self.mainView.frame.origin = self.positions["mailbox"]!["close"]!
                }
            })
        }
    }
    
    @IBAction func onValueChanged(sender: UISegmentedControl) {
        println("MailboxViewController - onValueChanged")
        println(sender.selectedSegmentIndex)
        // CASE 1: 0 -> 1
        // CASE 2: 0 -> 2
        // CASE 3: 1 -> 0
        // CASE 4: 1 -> 2
        // CASE 5: 2 -> 0
        // CASE 6: 2 -> 1
    }

    func toggleMenu() {
        println("MailboxViewController - toggleMenu")
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            if (self.mainView.frame.origin == self.positions["mailbox"]!["open"]!) {
                self.mainView.frame.origin = self.positions["mailbox"]!["close"]!
            }
            else {
                self.mainView.frame.origin = self.positions["mailbox"]!["open"]!
            }
        })
    }
    
    func slideRightMessage() {
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            self.messageImageView.frame.origin.x = self.positions["message"]!["init"]!.x
            
            }, completion: nil)
    }
    
    func slideupFeed() {
        UIView.animateWithDuration(0.4, animations: { () -> Void in

        self.feedImageView.frame.origin.y = self.searchImageView.frame.origin.y + self.searchImageView.frame.size.height - 1
            
        }, completion: nil)
    }
    
    func slidedownFeedAndMessage() {
        
        messageImageView.frame.origin.x = positions["message"]!["init"]!.x
        messageImageView.frame.origin.y = positions["message"]!["init"]!.y - messageImageView.frame.height
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.messageImageView.frame.origin = self.positions["message"]!["init"]!
            self.feedImageView.frame.origin.y = self.positions["feed"]!["init"]!.y
        })
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {

        if motion == UIEventSubtype.MotionShake {
            // User was shaking the device
            println("Shaking")
            
            if (messageImageView.frame.origin != positions["message"]!["init"]!) {
                println("Slide down feed and message")
                slidedownFeedAndMessage()
            }
        }
    
    }
    
    // MARK: - RescheduleViewControllerDelegate
    
    func dismissReschedule(message: String) {

        println("MailboxViewController - dismissReschedule")
        slideRightMessage()
        
    }

    // MARK: - ListViewControllerDelegate
    
    func dismissList(message: String) {
        
        println("MailboxViewController - dismissList")
        slideRightMessage()
    
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.destinationViewController is RescheduleViewController {
            var controller = segue.destinationViewController as RescheduleViewController
            controller.delegate = self
        }
        else if segue.destinationViewController is ListViewController {
            var controller = segue.destinationViewController as ListViewController
            controller.delegate = self
        }
    }
}
