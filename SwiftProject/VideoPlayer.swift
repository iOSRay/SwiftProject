//
//  VideoPlayer.swift
//  SwiftProject
//
//  Created by Waley on 6/20/22.
//

import Foundation
import UIKit
import AVFoundation
import AVKit
import MediaPlayer

class VideoPlayer: UIViewController {
    
    var audioPlayer: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let videoButton = UIButton()
        videoButton.setTitle("Play Video", for: .normal)
        videoButton.setTitleColor(.blue, for: .normal)
        videoButton.frame = CGRect(x: 50, y: 50, width: 100, height: 50)
        videoButton.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        self.view.addSubview(videoButton)
        
        let audioPlayButton = UIButton()
        audioPlayButton.setTitle("Play Audio", for: .normal)
        audioPlayButton.setTitleColor(.red, for: .normal)
        audioPlayButton.frame = CGRect(x: 50, y: 150, width: 100, height: 50)
        audioPlayButton.addTarget(self, action: #selector(playAudio), for: .touchUpInside)
        self.view.addSubview(audioPlayButton)
        
        let audioPauseButton = UIButton()
        audioPauseButton.setTitle("Pause Audio", for: .normal)
        audioPauseButton.setTitleColor(.red, for: .normal)
        audioPauseButton.frame = CGRect(x: 50, y: 250, width: 100, height: 50)
        audioPauseButton.addTarget(self, action: #selector(pauseAudio), for: .touchUpInside)
        self.view.addSubview(audioPauseButton)
        
        
    }
    
    func initAudio() {
        let audioPath = Bundle.main .path(forResource: "live", ofType: "mp3")
        let audioUrl = URL(fileURLWithPath: audioPath!)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
        } catch {
            audioPlayer = nil
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("error")
        }
    }
    
    func initForLockScreen() {
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPMediaItemPropertyTitle: "皇后大道东",
            MPMediaItemPropertyArtist: "罗大佑",
            MPMediaItemPropertyArtwork: MPMediaItemArtwork.init(boundsSize: .zero, requestHandler: { size in
                return UIImage(named: "thumb.jpg")!
            }),
            MPMediaItemPropertyPlaybackDuration: audioPlayer?.duration ?? 0.25,
            MPNowPlayingInfoPropertyPlaybackRate: 1.0,
            MPNowPlayingInfoPropertyElapsedPlaybackTime: audioPlayer?.currentTime ?? 0
        ]
    }
    
    @objc func playVideo() {
        let videoUrl = URL(string: "http://down.treney.com/mov/test.mp4")
        let player = AVPlayer(url: videoUrl!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true)
    }
    
    @objc func playAudio() {
        audioPlayer?.play()
    }
    
    @objc func pauseAudio() {
        audioPlayer?.pause()
    }
}
