//
//  OverlayView.swift
//  Ern3st
//
//  Created by Muhammad Ali on 22/07/2023.
//

import UIKit
import AVKit

class OverlayView: UIView {
    weak var player: AVPlayer?
     
     // Add your label, buttons, or any other UI elements here
     private lazy var topLabel: UILabel = {
         let label = UILabel()
         label.text = "Your Top Label"
         label.textColor = .black
        
         label.textAlignment = .center
         return label
     }()
     
     private lazy var playPauseButton: UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("Play/Pause", for: .normal)
         button.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
         return button
     }()
     
     private lazy var stopButton: UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("Stop", for: .normal)
         button.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
         return button
     }()
     
     // Customize and position your overlay elements as needed
     override func layoutSubviews() {
         super.layoutSubviews()
         print("sub layout called")
         
         // Add and position your label, buttons, or other elements in the overlay view
         addSubview(topLabel)
         addSubview(playPauseButton)
         addSubview(stopButton)
         
         // Set the frames for the elements
         let labelHeight: CGFloat = 44.0
         topLabel.frame = CGRect(x: 0, y: 20, width: frame.width, height: labelHeight)
         playPauseButton.frame = CGRect(x: 20, y: frame.height - 60, width: 100, height: 44)
         stopButton.frame = CGRect(x: frame.width - 120, y: frame.height - 60, width: 100, height: 44)
     }
     
     @objc private func playPauseButtonTapped() {
         if player?.rate == 0 {
             player?.play()
         } else {
             player?.pause()
         }
     }
     
     @objc private func stopButtonTapped() {
         player?.pause()
         player?.seek(to: .zero)
     }
  

}
