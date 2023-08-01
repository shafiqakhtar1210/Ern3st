//
//  VideoViewController.swift
//  Ern3st
//
//  Created by Muhammad Ali on 22/07/2023.
//

import UIKit
import DWAnimatedLabel

import AVFoundation
import AVKit
import SwiftUI

class VideoViewController: UIViewController {
    var playerController: AVPlayerViewController!
    var player: AVPlayer!
    var label:DWAnimatedLabel!
    var button:UIButton!
    var customOverlayView: UIView!
        override func viewDidLoad() {
            super.viewDidLoad()
            if let videoURL = Bundle.main.url(forResource: "measurements", withExtension: "mp4") {
               
                player = AVPlayer(url: videoURL)
                playerController = AVPlayerViewController()
                playerController.player = player
                addChild(playerController)
                view.addSubview(playerController.view)
                playerController.becomeFirstResponder()
                customOverlayView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 100))
                        customOverlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                        let font = UIFont(name: "PanamaMonospace-Regular", size: 20)!
                        let font_label = UIFont(name: "PanamaMonospace-Regular", size: 30)!                        // Create and configure the label
                       label = DWAnimatedLabel(frame: CGRect(x: 10, y: 100, width: view.bounds.width - 20, height: 100))
                        
                        
                        label.underlineWithCustomFont(text: "HOW TO TAKE CLEAN ACCURATE SCANS \n TAP TO PLAY VIDEO", font: font_label, underlineStyle: .single)
                
                        label.textColor = .black
                      
                        label.numberOfLines = 0 // Set the number of lines to 2 (or any other desired value)
                        label.textAlignment = .center
                        customOverlayView.addSubview(label)
                        let buttonWidth: CGFloat = view.bounds.width - 40
                        let buttonHeight: CGFloat = 50
                        let xPosition: CGFloat = (view.bounds.width - buttonWidth) / 2 // Center the button horizontally
                        let yPosition: CGFloat = view.bounds.height - 140
                        // Create and configure the button
                        button = UIButton(frame: CGRect(x: xPosition, y: yPosition, width: buttonWidth, height: buttonHeight))
                        button.layer.cornerRadius = 8
                        
                        button.underlineTextWithCustomFont(text: "SKIP", font: font, underlineStyle: .single)
                        button.setTitleColor(.white, for: .normal)
                        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                        let buttonBackgroundColor = UIColor.black
                        let transparency: CGFloat = 0.6
                        button.backgroundColor = buttonBackgroundColor.withAlphaComponent(transparency)
                

                        customOverlayView.addSubview(button)
                

                        // Add the custom overlay view to the contentOverlayView
                        playerController.contentOverlayView?.addSubview(customOverlayView)
                        player.addObserver(self, forKeyPath: "rate", options: .new, context: nil)
                player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: .main) { [weak self] time in
                            let currentTimeInSeconds = CMTimeGetSeconds(time)
                            self?.updateCurrentTime(currentTimeInSeconds)
                        }
                NotificationCenter.default.addObserver(self, selector: #selector(videoDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
                
            } else {
                        print("Video file not found.")
                    }
            
           
            
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "showLoginPage" {
               // Check if the destination view controller is the correct type
               if let destinationVC = segue.destination as? ViewController {
                   // Set the data in the destination view controller
                   destinationVC.currentSegue = segue.identifier!
               }
           }
       }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
           if keyPath == "rate" {
               if let player = object as? AVPlayer {
                   if player.rate > 0.0 {
                       // Video is playing
                       
                       button.isHidden = true
                       print("Video is playing.")
                   } else {
                       button.isHidden = false
                       // Video is paused or stopped
                       print("Video is paused or stopped.")
                   }
               }
           }
       }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)

            guard let touch = touches.first else {
                return
            }

            let touchPoint = touch.location(in: customOverlayView)

            if button.frame.contains(touchPoint) {
                playerController.view.isUserInteractionEnabled = false
                
                // Pass the touch event to the button
                button.sendActions(for: .touchUpInside)
            }
        else{
            playerController.view.isUserInteractionEnabled = true
            player.play()
        }
        }
    func updateCurrentTime(_ timeInSeconds: Double) {
        print(timeInSeconds)
        if timeInSeconds > 1 && timeInSeconds < 2{
            label.text = "PUT YOUR PHONE AGAINST A SUPPORT"
            label.animationType = .shine
            label.startAnimation(duration: 3.0, nil)
            
        }
        if timeInSeconds > 4 && timeInSeconds < 5{
            label.text = "WEAR SOMETHING TIGHT"
            label.animationType = .shine
            label.startAnimation(duration: 3.0, nil)
            
        }
        if timeInSeconds > 7 && timeInSeconds < 8{
            label.text = "SCAN YOUR BODY WITH DIFFERENT ANGLES"
            label.animationType = .shine
            label.startAnimation(duration: 3.0, nil)
            
        }
    }
    @objc func videoDidFinishPlaying(notification: Notification) {
         // Video has finished playing
         print("Video has finished playing.")
        let font = UIFont(name: "PanamaMonospace-Regular", size: 20)!
        button.underlineTextWithCustomFont(text: "PROCEED", font: font, underlineStyle: .single)
        button.isHidden = false
     }
    @objc func buttonTapped() {
            // Handle button tap action
        self.performSegue(withIdentifier: "showLoginPage", sender: nil)
        print("skip button tapped")
        }
    deinit {
        playerController.player?.removeObserver(self, forKeyPath: "rate")
        NotificationCenter.default.removeObserver(self)
        
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
struct RepresentableVideoView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> VideoViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myViewController = storyboard.instantiateViewController(withIdentifier: "VideoVC") as! VideoViewController
        return myViewController

    }
    
    func updateUIViewController(_ uiViewController: VideoViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = VideoViewController
    
    
    
   

    

}
struct GetVideoView: PreviewProvider{
    static var previews: some View{
        RepresentableVideoView()
    }
    
    
    
}
