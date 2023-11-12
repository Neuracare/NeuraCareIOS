//
//  TaskManagerController.swift
//  NeuraCare
//
//  Created by yajurva shrotriya on 11/11/23.
//

import UIKit
import Speech


class TaskManagerController: UIViewController,SFSpeechRecognizerDelegate {

    @IBOutlet weak var RecordButton: UIButton!
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    var recordedAudio = ""
    
    var isRecording = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
                   // Handle different authorization states
                   switch authStatus {
                   case .authorized:
                       print("Speech recognition authorized")
                   case .denied, .restricted, .notDetermined:
                       print("Speech recognition not authorized")
                   @unknown default:
                       fatalError("Unknown authorization status")
                   }
               }
        
        RecordButton.layer.cornerRadius = RecordButton.frame.height / 2
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func startSpeechRecognition() {
        
        if recognitionTask != nil {
                    // Cancel the previous task if it's running
                    recognitionTask?.cancel()
                    self.recognitionTask = nil
                }
       
        let audioSession = AVAudioSession.sharedInstance()
               try! audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
               try! audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode

        guard let recognitionRequest = recognitionRequest else {
                    fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object")
                }
        
        // Configure request
                recognitionRequest.shouldReportPartialResults = true
        
        // Start recognition
                recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
                    var isFinal = false

                    if let result = result {
                        // Update your UI with the results
                        let bestString = result.bestTranscription.formattedString
                        print(bestString)
                        isFinal = result.isFinal
                        
                    }
                    
                    self.recordedAudio = result?.bestTranscription.formattedString ?? ""

                    if error != nil || isFinal {
                        // Stop the audio engine and recognition task
                        self.audioEngine.stop()
                        inputNode.removeTap(onBus: 0)
                        self.recognitionRequest = nil
                        self.recognitionTask = nil
                    }
                }
        
        // Prepare the audio recording
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                    self.recognitionRequest?.append(buffer)
                }
        
        audioEngine.prepare()
               try! audioEngine.start()

    }

    func stopSpeechRecognition() {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            audioEngine.inputNode.removeTap(onBus: 0)
        }
    
    
    @IBAction func StartRec(_ sender: Any) {
        
        if isRecording == false{
            startSpeechRecognition()
            print("Recognition started")
            isRecording = true
            RecordButton.backgroundColor = .blue
        } else{
            stopSpeechRecognition()
            print("Recognition stopped")
            isRecording = false
            sendData()
            RecordButton.backgroundColor = .lightGray
        }
        
    }
    
    
    func sendData() {
        var request = URLRequest(url: URL(string: "https://backend.neuracare.tech/patient/todo")!)
        
        // Configure POST Request
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = HTTP.createSpeechText(id: "rmadith@gmail.com", transcript: self.recordedAudio)
        //print(request.httpBody?)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                // Show error page
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                
            }
            print(data)
            
            
            // check if status code == 201
            // stop loading screen and continue with app stuff
                
        }
        // Start task
        task.resume()

    }
    
    
    
}


