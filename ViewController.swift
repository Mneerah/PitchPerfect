//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Mneerah Alkaldi on 14/09/2019.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate {

    //put (outlet) for the buttons and the label to be able to use it
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var startRecordingButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    //put var for an audio
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled=false
        print("didload......")
    }

    @IBAction func recordAudio(_ sender: UIButton) {
        recordingLabel.text = "recording in progress"
        stopRecordingButton.isEnabled=true
        startRecordingButton.isEnabled=false
        
        //recording code start
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        /*
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
 */
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        print(audioRecorder!)
        print("fiiiiiiind me رثص")
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        //recording code ends
    }
    @IBAction func stopRecording(_ sender: Any) {
        startRecordingButton.isEnabled=true
        stopRecordingButton.isEnabled=false
        recordingLabel.text = "Tap to record"
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("before segue")
            performSegue(withIdentifier: "stopRecord", sender: self.audioRecorder.url)
            print("after segue")
        } else {
            print("recording was NOT succesful")
            
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // if segue.identifier == "stopRecording" {
            let playSoundViewController = segue.destination as! playSoundsViewController
            //let recordedSoundURL:URL = sender as! URL
            let recordedSoundURL:URL = audioRecorder.url
            print("seeeeeeeeee......")
            print(recordedSoundURL)
            playSoundViewController.recordedAudioURL = recordedSoundURL
            print("seeeeeeeeee.222.....")
       //}
    }
}

