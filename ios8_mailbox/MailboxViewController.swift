//
//  MailboxViewController.swift
//  ios8_mailbox
//
//  Created by Stanley Ng on 9/16/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var helpImageView: UIImageView!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var feedImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println("MailboxViewController - viewDidLoad")
        setupScrollView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
