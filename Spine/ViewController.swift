//
//  ViewController.swift
//  Spine
//
//  Created by Alex Persian on 10/29/16.
//  Copyright © 2016 alexpersian. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var emojiDrawer: UIView!
    @IBOutlet weak var emojiDrawerHeight: NSLayoutConstraint!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var whiteWaveform: UIImageView!
    @IBOutlet weak var orangeWaveform: UIImageView!
    @IBOutlet weak var obscuredEmoji: UIImageView!
    @IBOutlet weak var finalEmoji: UIImageView!
    
    fileprivate let defaultDrawerHeight: CGFloat = 60
    fileprivate var bookData: AudioBook?
    fileprivate var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func setup() {
        loadAudioFile()
    }
    
    func loadAudioFile() {
        let soundURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: "harry-potter", ofType: "mp3")!)
        try? audioPlayer = AVAudioPlayer(contentsOf: soundURL as URL)
        audioPlayer.prepareToPlay()
    }
    
    @IBAction func playPausePressed(_ sender: UIButton) {
        if sender.isSelected {
            audioPlayer.stop()
            sender.isSelected = false
        } else {
            audioPlayer.play()
            sender.isSelected = true
            moveVisualizer()
        }
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
    
    func moveVisualizer() {
        UIView.animate(withDuration: 60.0, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
            let newWhiteRect = CGRect(x: self.whiteWaveform.frame.minX - self.whiteWaveform.frame.width, y: self.whiteWaveform.frame.minY, width: self.whiteWaveform.frame.width, height: self.whiteWaveform.frame.height)
            let newOrangeRect = CGRect(x: self.orangeWaveform.frame.minX - self.orangeWaveform.frame.width, y: self.orangeWaveform.frame.minY, width: self.orangeWaveform.frame.width, height: self.orangeWaveform.frame.height)
            self.whiteWaveform.frame = newWhiteRect
            self.orangeWaveform.frame = newOrangeRect
        }, completion: nil)
        
        UIView.animate(withDuration: 30.0, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
            let newWhiteRect = CGRect(x: self.obscuredEmoji.frame.minX - self.obscuredEmoji.frame.width, y: self.obscuredEmoji.frame.minY, width: self.obscuredEmoji.frame.width, height: self.obscuredEmoji.frame.height)
            let newOrangeRect = CGRect(x: self.finalEmoji.frame.minX - self.obscuredEmoji.frame.width, y: self.finalEmoji.frame.minY, width: self.finalEmoji.frame.width, height: self.finalEmoji.frame.height)
            self.obscuredEmoji.frame = newWhiteRect
            self.finalEmoji.frame = newOrangeRect
        }, completion: nil)
    }
}

