//
//  RescheduleViewController.swift
//  ios8_mailbox
//
//  Created by Stanley Ng on 9/17/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

import UIKit

protocol RescheduleViewControllerDelegate {
    func dismissReschedule(message: String)
}

class RescheduleViewController: UIViewController {

    var delegate: RescheduleViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println("RescheduleViewController - viewDidLoad")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        println("RescheduleViewController - onTap")
        dismissViewControllerAnimated(true, completion: { () -> Void in

            println("RescheduleViewController - done")
            self.delegate?.dismissReschedule("message from RescheduleViewController")
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
