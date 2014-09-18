//
//  MailboxViewController.swift
//  ios8_mailbox
//
//  Created by Stanley Ng on 9/16/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController, RescheduleViewControllerDelegate, ListViewControllerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var helpImageView: UIImageView!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var archiveIconImageView: UIImageView!
    @IBOutlet weak var laterIconImageView: UIImageView!
    var positions = [String: [String: CGPoint]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println("MailboxViewController - viewDidLoad")
        setupPositions()
        setupScrollView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupPositions() {
        positions["message"] = [
            "init": messageImageView.frame.origin,
            "left": CGPoint(x: -messageImageView.frame.size.width, y: messageImageView.frame.origin.y),
            "right": CGPoint(x: messageImageView.frame.size.width, y: messageImageView.frame.origin.y)
        ]
        positions["later_icon"] = [
            "init": laterIconImageView.frame.origin
        ]
    }

    func setupScrollView() {
        
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
            
            // ICON:LATER
            positions["later_icon"]!["init"]! = laterIconImageView.frame.origin
            laterIconImageView.alpha = 0
            
            // ICON:ARCHIVE
            archiveIconImageView.alpha = 0

        }
        else if sender.state == UIGestureRecognizerState.Changed {
        
            println("MailboxViewController - onMessagePan - Changed")
            
            // MESSAGE
            var pos = positions["message"]!["init"]!
            pos.x = pos.x + translation.x
            messageImageView.frame.origin.x = pos.x
            println("message.pos.x: \(pos.x)")
            
            // ICON:LATER
            /*
            if (translation.x < 0) {
                pos = positions["later_icon"]!["init"]!

                // moving left
                println("moving left")
                if (abs(translation.x) <= 60) {
                    
                }
                else {
                    // LaterIcon: changing pos
                    pos.x = pos.x + translation.x + 60
                    laterIconImageView.frame.origin.x = pos.x
                }
                //println("later.icon.pos.x: \(pos.x)")
            }
            else {
                // moving right
                println("moving right")
            }
            */
            
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            
            println("MailboxViewController - onMessagePan - Ended")
            
            // MESSAGE
            UIView.animateWithDuration(0.4, animations:
                { () -> Void in
                
                    if (abs(translation.x) <= 60) {
                        
                        println("|translation.x| <= 60")
                        
                        // INITIAL POSITION
                        self.messageImageView.frame.origin = self.positions["message"]!["init"]!
                        
                    }
                    else if (translation.x < -60) {
                        
                        println("translation.x < -60")
                        
                        // GO LEFT
                        self.messageImageView.frame.origin = self.positions["message"]!["left"]!
                        
                    }
                    else if (translation.x > 60) {
                        
                        println("translation.x > 60")
                        
                        // GO RIGHT
                        self.messageImageView.frame.origin = self.positions["message"]!["right"]!
                        
                    }
                    
                }, completion: { (done: Bool) -> Void in

                    if translation.x <= 0 {
                        
                        // CASE 1: x <= -220, SHOW LIST OPTIONS
                        if translation.x <= -220 {
                            println("SHOW LIST OPTIONS")
                            self.performSegueWithIdentifier("listFromMailbox", sender: self)
                        }
                
                        // CASE 2: -220 < x <= -60, SHOW RESCHEDULE OPTIONS
                        else if translation.x > -220 && translation.x <= -60 {
                            println("SHOW RESHEDULE OPTIONS")
                            self.performSegueWithIdentifier("rescheduleFromMailbox", sender: self)
                        }
                        
                        // CASE 3: -60 < x <= 0, DO NOTHING
                        if translation.x > -60 {
                            
                        }
                        
                    }
                    else {
                        
                        // CASE 1: x > 0 && x <= 60, DO NOTHING
                        if translation.x > 0 && translation.x <= 60 {
                            
                        }
                
                        // CASE 2: x > 60, ARCHIVE MESSAGE
                        else if translation.x > 60 {
                            println("ARCHIVE MESSAGE")
                        }
                        
                    }

            })
        }
    }
    
    func slideRightMessage() {
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            self.messageImageView.frame.origin.x = self.positions["message"]!["init"]!.x
            
            }, completion: nil)
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
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
