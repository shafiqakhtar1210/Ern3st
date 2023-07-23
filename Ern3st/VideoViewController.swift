//
//  VideoViewController.swift
//  Ern3st
//
//  Created by Muhammad Ali on 22/07/2023.
//

import UIKit

import AVFoundation
import AVKit

class VideoViewController: UIViewController {
    var playerController: AVPlayerViewController!
        var player: AVPlayer!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            if let videoURL = Bundle.main.url(forResource: "measurements", withExtension: "mp4") {
               
                player = AVPlayer(url: videoURL)
                playerController = AVPlayerViewController()
                playerController.player = player
                addChild(playerController)
                view.addSubview(playerController.view)
                let overlayView = OverlayView()
                           overlayView.player = player
                           playerController.contentOverlayView?.addSubview(overlayView)
                playerController.becomeFirstResponder()
                
            } else {
                        print("Video file not found.")
                    }
            
           
            
        }
  





    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
