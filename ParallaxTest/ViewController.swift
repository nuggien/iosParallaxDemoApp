//
//  ViewController.swift
//  ParallaxTest
//
//  Created by Duc Nguyen on 8/4/16.
//  Copyright © 2016 Duc Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView = UITableView()
    var imageView = UIImageView()
    var topConstraint = NSLayoutConstraint()
    var bottomConstraint = NSLayoutConstraint()
    var heightConstraint = NSLayoutConstraint()
    var widthConstraint = NSLayoutConstraint()
    var containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[view]-0-|", options: [], metrics: nil, views: ["view": containerView]))
        topConstraint = NSLayoutConstraint(item: containerView, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 0)
        bottomConstraint = NSLayoutConstraint(item: containerView, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0)
        view.addConstraint(topConstraint)
        view.addConstraint(bottomConstraint)
        
        containerView.addSubview(tableView)
        containerView.addSubview(imageView)
        
        containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[view]", options: [], metrics: nil, views: ["view": imageView]))
        containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[view]-0-|", options: [], metrics: nil, views: ["view": imageView]))
        containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[table]-0-|", options: [], metrics: nil, views: ["table": tableView]))
        containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[table]-0-|", options: [], metrics: nil, views: ["table": tableView]))
        heightConstraint = NSLayoutConstraint(item: imageView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 200)
        widthConstraint = NSLayoutConstraint(item: imageView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: view.frame.size.width)
        containerView.addConstraint(heightConstraint)
        containerView.addConstraint(widthConstraint)

        
        
        imageView.image = UIImage(named: "steph")!
        imageView.clipsToBounds = true
        tableView.contentInset.top = 200
        tableView.backgroundColor = UIColor.blackColor()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        let offsetY = -scrollView.contentOffset.y
        heightConstraint.constant = max(offsetY, 200)
        
        let factor = offsetY/200.0
        widthConstraint.constant = max(factor * self.view.frame.size.width, self.view.frame.size.width)
        
        let frameOffsetY = -(scrollView.contentInset.top + scrollView.contentOffset.y)
        let frameY = frameOffsetY > 0 ? 0 : max(frameOffsetY, -150)
        topConstraint.constant = frameY
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 500
    }
    
    func tableView(tv: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tv.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

