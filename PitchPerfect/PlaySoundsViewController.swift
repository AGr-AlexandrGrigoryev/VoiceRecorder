//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Alexandr Grigoryev on 03/05/2020.
//  Copyright © 2020 Alexandr Grigoryev. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    // MARK:  Buttons in the second VC
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // MARK:  Properties for audio
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    // MARK:  Types for audio
    // enumeration 0 , 1 , 2 , 4 , 5 for case button tag(1,2,3,4,5)
    enum ButtonType: Int { case slow = 0, fast, chipmunk, vader, echo, reverb }
                 

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    // MARK:  Right before view appear on the screen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    // MARK:  Play sound for 6 buttons
    @IBAction func playSoundForButton(_ sender: UIButton){
        switch (ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)
    }
    
    // MARK:  Stop playing
    @IBAction func stopSoundForButton(_ sender: UIButton){
        stopAudio()
    }
}
