//
//  ViewController.swift
//  iosdApp
//
//  Created by Bhavin on 21/04/18.
//  Copyright © 2018 Bhavin. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    var urlString : String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black
        self.urlString = "https://firebasestorage.googleapis.com/v0/b/iosdapp-8dd28.appspot.com/o/videoplayback.mp4?alt=media&token=aa5fea98-fc59-4dc7-b2cc-0a1e6a4c480b"
        if let videoUrl = URL(string: urlString!){
            let player = AVPlayer(url: videoUrl)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player.play()
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var exercises = [Exercise]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exercises.append(appDelegate.ex1)
        exercises.append(appDelegate.ex2)
        let videoPlayerFrame = CGRect(x: 0, y: 30, width: view.frame.width, height: view.frame.height - 200)
        let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
        //videoPlayerView.urlString = appDelegate.ex1.tutorialUrl
        view.addSubview(videoPlayerView)
        print("HI there")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

