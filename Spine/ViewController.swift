//
//  ViewController.swift
//  Spine
//
//  Created by Alex Persian on 10/29/16.
//  Copyright © 2016 alexpersian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var emojiDrawer: UIView!
    @IBOutlet weak var emojiDrawerHeight: NSLayoutConstraint!
    @IBOutlet weak var playPauseButton: UIButton!
    
    fileprivate let defaultDrawerHeight: CGFloat = 60
    fileprivate var bookData: AudioBook?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func setup() {
        
    }
    
    @IBAction func playPausePressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }

    @IBAction func expandEmojiDrawer(_ sender: UIButton) {
        switch emojiDrawerHeight.constant {
        case 60:
            setDrawerHeight(view.frame.height)
        default:
            setDrawerHeight(60)
        }
    }
    
    func setDrawerHeight(_ height: CGFloat) {
        self.emojiDrawerHeight.constant = height
        switch height {
        case 60:
            UIView.animate(withDuration: 0.5) {
                let eFrame = self.emojiDrawer.frame
                self.emojiDrawer.frame = CGRect(x: eFrame.minX, y: eFrame.minY, width: eFrame.width, height: height)
                
                self.view.setNeedsUpdateConstraints()
                self.view.setNeedsLayout()
                self.view.bringSubview(toFront: self.emojiDrawer)
            }
        default:
            UIView.animate(withDuration: 0.5) {
                self.emojiDrawer.frame = self.view.frame
                
                self.view.setNeedsUpdateConstraints()
                self.view.setNeedsLayout()
                self.view.bringSubview(toFront: self.emojiDrawer)
            }
        }
    }
    
    func getBookData(title: String, author: String) {
        let url = "https://bemyapp.herokuapp.com/book?title=Harry%20Potter%20and%20the%20Half-Blood%20Prince&author=J.K.%20Rowling"
        let request = NetworkRequest(method: .GET, url: url, headers: nil)
        let network = NetworkProvider()
    }
}

