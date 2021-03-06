//
//  PracticeViewController.swift
//  iosdApp
//
//  Created by Bhavin on 22/04/18.
//  Copyright © 2018 Bhavin. All rights reserved.
//

import UIKit
import AVKit

class PracticeViewController: UIViewController{

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var flag: Int?
    var player : AVPlayer!
    var playerLayer: AVPlayerLayer!
    var currentRepCount: Int?
    var currentExercise: Exercise?
    var currentExerciseIndex: Int?
    var maxExercises: Int?
    var isPlayerMuted: Bool?
    var item: AVPlayerItem?
    var countDone: Int?
    var time: CMTime?
    
    let prevButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 58/255, green: 128/255, blue: 188/255, alpha: 0)
        button.setTitle("prev", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 58/255, green: 128/255, blue: 188/255, alpha: 0)
        button.setTitle("next", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 58/255, green: 128/255, blue: 188/255, alpha: 0)
        button.setTitle("play", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(handlePlay), for: .touchUpInside)
        return button
    }()
    
    let stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 58/255, green: 128/255, blue: 188/255, alpha: 0)
        button.setTitle("stop", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(handleStop), for: .touchUpInside)
        return button
    }()
    
    let muteButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1)
        button.setTitle("", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(handleMute), for: .touchUpInside)
        return button
    }()
    
    let VideoPlayerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
        
    }()
    
    let controlView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
        
    }()
    
    let testView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
        
    }()
    
    let repCountLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        lbl.textColor = UIColor.white
        lbl.textAlignment = .center
        lbl.backgroundColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let strengthLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Set 1/12 rep"
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        lbl.textColor = UIColor.white
        lbl.textAlignment = .center
        lbl.backgroundColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let timerLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "0:00"
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        lbl.textAlignment = .right
        lbl.textColor = UIColor.white
        lbl.textAlignment = .center
        lbl.backgroundColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let mute = UserDefaults.standard.value(forKey: "isMute") as? Bool{
            if mute{
                
                muteButton.setTitle("Unmute", for: .normal)
            }else{
                muteButton.setTitle("Mute", for: .normal)
            }
        }else{
            UserDefaults.standard.set(false, forKey: "isMute")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = true
        
        flag = 0
        isPlayerMuted = false
        currentExerciseIndex = 0
        countDone = 0
        
        view.addSubview(VideoPlayerView)
        let tapped = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        let videoPlayerFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(controlView)
        view.addSubview(muteButton)
        view.addGestureRecognizer(tapped)
        view.addSubview(repCountLabel)
        view.addSubview(strengthLabel)
        view.addSubview(timerLabel)
        view.isUserInteractionEnabled = true
        
        controlView.addSubview(playButton)
        controlView.addSubview(stopButton)
        controlView.addSubview(prevButton)
        controlView.addSubview(nextButton)
        
        controlView.isHidden = true
        
        VideoPlayerView.frame = videoPlayerFrame
        print("HI there")
        setupPlayerWithUrl(currentExercise?.repUrl!)
        
        item = player.currentItem
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleRepeat), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: item)

        
        controlView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        controlView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        controlView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        controlView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        print((view.frame.width))
        prevButton.topAnchor.constraint(equalTo: controlView.topAnchor, constant: 8).isActive = true
        prevButton.leftAnchor.constraint(equalTo: controlView.leftAnchor, constant: 8).isActive = true
        prevButton.rightAnchor.constraint(equalTo: controlView.rightAnchor, constant: -(3*((view.frame.width)/4) + 8)).isActive = true
        prevButton.bottomAnchor.constraint(equalTo: controlView.bottomAnchor, constant: -8).isActive = true
        
        playButton.topAnchor.constraint(equalTo: controlView.topAnchor, constant: 8).isActive = true
        playButton.leftAnchor.constraint(equalTo: prevButton.rightAnchor, constant: 8).isActive = true
        playButton.rightAnchor.constraint(equalTo: controlView.rightAnchor, constant: -(2*((view.frame.width)/4) + 8)).isActive = true
        playButton.bottomAnchor.constraint(equalTo: controlView.bottomAnchor, constant: -8).isActive = true
        
        stopButton.topAnchor.constraint(equalTo: controlView.topAnchor, constant: 8).isActive = true
        stopButton.leftAnchor.constraint(equalTo: playButton.rightAnchor, constant: 8).isActive = true
        stopButton.rightAnchor.constraint(equalTo: controlView.rightAnchor, constant: -(1*((view.frame.width)/4) + 8)).isActive = true
        stopButton.bottomAnchor.constraint(equalTo: controlView.bottomAnchor, constant: -8).isActive = true
        
        nextButton.topAnchor.constraint(equalTo: controlView.topAnchor, constant: 8).isActive = true
        nextButton.leftAnchor.constraint(equalTo: stopButton.rightAnchor, constant: 8).isActive = true
        nextButton.rightAnchor.constraint(equalTo: controlView.rightAnchor, constant: -8).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: controlView.bottomAnchor, constant: -8).isActive = true
        
        //muteButton.topAnchor.constraint(equalTo: VideoPlayerView.bottomAnchor, constant: 10).isActive = true
        muteButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        muteButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        muteButton.bottomAnchor.constraint(equalTo: controlView.topAnchor, constant: -8).isActive = true
        muteButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        repCountLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        repCountLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 380).isActive = true
        repCountLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -200).isActive = true
        repCountLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        strengthLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        strengthLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -150).isActive = true
        strengthLabel.bottomAnchor.constraint(equalTo: controlView.topAnchor, constant: -8).isActive = true
        strengthLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        timerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        timerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 200).isActive = true
        timerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        timerLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        print("current rep count \(currentRepCount!)")
        
        repCountLabel.text = "\(countDone!)/\(currentRepCount!) REPS"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //playerLayer.frame = VideoPlayerView.bounds
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer){
        player.pause()
        controlView.isHidden = false
    }
    
    @objc func handlePrevious(){
        print("reg")
    }
    
    @objc func handlePlay(){
        player.play()
        controlView.isHidden = true
        print("reg")
    }
    
    @objc func handleStop(){
        player.pause()
        showAlertForStop("Do you want to finish this workout?")
        print("reg")
    }
    
    @objc func handleNext(){
        showAlert("Do you want to perform more exercises and save the current or finish and save the workout")
        
    }
    
    @objc func handleMute(){
        if let mute = UserDefaults.standard.value(forKey: "isMute") as? Bool{
            if mute{
                player.isMuted = false
                muteButton.setTitle("Mute", for: .normal)
                UserDefaults.standard.set(false, forKey: "isMute")
            }else{
                player.isMuted = true
                muteButton.setTitle("Unmute", for: .normal)
                UserDefaults.standard.set(true, forKey: "isMute")
            }
        }else{
            UserDefaults.standard.set(false, forKey: "isMute")
        }
    }
    
    fileprivate func setupPlayerWithUrl(_ urlString: String!){
        if let videoUrl = URL(string: urlString){
            player = AVPlayer(url: videoUrl)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer.videoGravity = .resize
            VideoPlayerView.layer.addSublayer(playerLayer)
            playerLayer.frame = VideoPlayerView.bounds
            //viewDidLayoutSubviews()
            //playerLayer.frame = VideoPlayerView.frame
            if let mute = UserDefaults.standard.value(forKey: "isMute") as? Bool{
                if mute{
                    player.isMuted = true
                    muteButton.setTitle("Unmute", for: .normal)
                }else{
                    player.isMuted = false
                    muteButton.setTitle("Mute", for: .normal)
                }
            }else{
                UserDefaults.standard.set(false, forKey: "isMute")
            }
            player.play()
        }
        
    }
    
    @objc func handlePerform(action: UIAlertAction){
        print("perform")
        let logViewController = ExerciseLogViewController()
        logViewController.name = currentExercise?.name!
        logViewController.count = countDone!
        present(logViewController, animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func handleSaveWorkout(action: UIAlertAction){
        let vc = ExerciseLogViewController()
        vc.name = currentExercise?.name!
        vc.count = countDone!
        present(vc, animated: true) {
            let saveViewController = LogWorkoutViewController()
            self.navigationController?.pushViewController(saveViewController, animated: true)
        }
        print("save")
    }
    
    @objc func handleRepeat(note: NSNotification){
        print("fired")
        countDone = countDone! + 1
        repCountLabel.text = "\(countDone!)/\(currentRepCount!) REPS"
        if(countDone == currentRepCount){
            playerLayer.removeFromSuperlayer()
            playerLayer = nil
            player = nil
            showAlert("Do you want to perform more exercises and save the current or finish and save the complete workout")
            
        }else{
            time = CMTimeMake(0, 10)
            player.seek(to: time!)
            repCountLabel.text = "\(countDone!)/\(currentRepCount!) REPS"
            player.play()
        }
    }
    
    @objc func handleYes(action: UIAlertAction){
        player.pause()
        playerLayer.removeFromSuperlayer()
        playerLayer = nil
        player = nil
        //dismiss(animated: true, completion: nil)
        let vc = ExerciseLogViewController()
        vc.name = currentExercise?.name!
        vc.count = countDone!
        present(vc, animated: true) {
            let saveViewController = LogWorkoutViewController()
            self.navigationController?.pushViewController(saveViewController, animated: true)
        }
        print("Handle yes")
    }
    
    func showAlert(_ msg: String){
        let alert = UIAlertController(title: "Workout", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Perform", style: .default, handler: handlePerform))
        alert.addAction(UIAlertAction(title: "Save Workout", style: .default, handler: handleSaveWorkout))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertForStop(_ msg: String){
        let alert = UIAlertController(title: "Workout", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: handleYes))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
