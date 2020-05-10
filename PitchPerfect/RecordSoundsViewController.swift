//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Alexandr Grigoryev on 29/04/2020.
//  Copyright © 2020 Alexandr Grigoryev. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: RecordSoundsViewController: UIViewController
class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
   
    // MARK: Properties
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    // MARK: Properties for audio
    var audioRecorder: AVAudioRecorder!
    let secondVC = "stopRecording"
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }
    
    // happens right before the root view appears on the screen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // is called immediately after the view appears on the screen
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK:  Buttons for rec.
    @IBAction func recordAudio(_ sender: AnyObject) {
        //change title if app record voice
        isRecordingTitle(recording: true)
    
        //statement for appear rec. & stop button
        setStopAndRecordButtonsEnabled(stop: true, record: false)
        
        //grabs app documentDirectory and stores as a string in dirPath
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) [0] as String
        //name for recording file
        let recordingName = "recordedVoice.wav"
        //combine both the directory path and recordingName to create full path to file
        let pathArray = [dirPath, recordingName]
        print(pathArray as Any)
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath as Any)
        //set up Audio session, return  the shared audio session instance.
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: .defaultToSpeaker)
       
        //create audio recorder
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        //delegate object for the audio recorder for himself
        audioRecorder.delegate = self
        //audio level metering on
        audioRecorder.isMeteringEnabled = true
        //creates an audio file and prepares the system for recording
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
    }
    
    // MARK:  Button for stop rec.
    @IBAction func stopRecording(_ sender: AnyObject) {
        //change title if app doesn't record voice
        isRecordingTitle(recording: false)
        
        //statement for appear rec. & stop button
        setStopAndRecordButtonsEnabled(stop: false, record: true)
        
        //Stops recording and closes the audio file.
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)

    }
    
   /* audioRecorderDidFinishRecording:successfully: is called when a recording has been finished or stopped. This method is NOT called if the recorder is stopped due to an interruption. */
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        /*if recording has fail, write it on the screen*/
        if flag {
            /*Initiates the segue with the specified identifier from the
             current view controller's storyboard file.*/
            performSegue(withIdentifier: secondVC, sender: audioRecorder.url)
        } else { recordingLabel.text = "recording was not successful"}
    }
    
    /*try to understand this later !!!!!!!!!! it's very important */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == secondVC {
            let playSoundVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    
    /// Change title on first screen depends on state of recording
    /// - Parameter recording: if app record voice sent true
    func isRecordingTitle(recording: Bool) {
        if !recording { recordingLabel.text = "Tap to record"}
        else { recordingLabel.text = "Recording in progress" }
    }
    
    func setStopAndRecordButtonsEnabled(stop: Bool, record: Bool) {
        stopRecordingButton.isEnabled = stop
        recordingButton.isEnabled = record
    }
}

