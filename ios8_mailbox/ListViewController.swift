//
//  ListViewController.swift
//  ios8_mailbox
//
//  Created by Stanley Ng on 9/17/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

import UIKit

protocol ListViewControllerDelegate {
    func dismissList(message: String)
}

class ListViewController: UIViewController {

    var delegate: ListViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println("ListViewController - viewDidLoad")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {

        println("ListViewController - onTap")
        dismissViewControllerAnimated(true, completion: { () -> Void in
            println("ListViewController - done")
            self.delegate?.dismissList("message from ListViewController")
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
