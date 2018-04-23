//
//  ViewController.swift
//  iosdApp
//
//  Created by Bhavin on 21/04/18.
//  Copyright © 2018 Bhavin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var flag: Int?
    var exercises = [Exercise]()
    var player : AVPlayer?
    var playerLayer: AVPlayerLayer!
    
    var currentExercise: Exercise?
    var currentExerciseIndex: Int?
    var maxExercises: Int?
    var isPlayerMuted: Bool?
    var time: CMTime?
    //var workout: Workout?
    
    let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1)
        button.setTitle("Skip Intro", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        button.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        return button
    }()
    
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
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        lbl.textColor = UIColor.white
        lbl.textAlignment = .center
        lbl.backgroundColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("exercises from view will appear view controller \(appDelegate.currentWorkout.exercises?.count)")
        print("workout count from view will appear view controller \(appDelegate.workouts.count)")
        self.navigationController?.isNavigationBarHidden = true
        
        if let mute = UserDefaults.standard.value(forKey: "isMute") as? Bool{
            if mute{
                muteButton.setTitle("Unmute", for: .normal)
                if let vidPlayer = player{
                    vidPlayer.isMuted = true
                }
            }else{
                if let vidPlayer = player{
                    vidPlayer.isMuted = false
                }
                muteButton.setTitle("Mute", for: .normal)
            }
        }else{
            UserDefaults.standard.set(false, forKey: "isMute")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("called view did load")
        view.backgroundColor = UIColor.white
        exercises.append(appDelegate.ex1)
        exercises.append(appDelegate.ex2)
        
        self.navigationController?.isNavigationBarHidden = true
        //workout = Workout()
        flag = 0
        isPlayerMuted = false
        maxExercises = exercises.count
        currentExerciseIndex = 0
        currentExercise = exercises[currentExerciseIndex!]
        nameLabel.text = currentExercise?.name!
        
        view.addSubview(VideoPlayerView)
        let tapped = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        let videoPlayerFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        view.addSubview(skipButton)
        view.addSubview(controlView)
        view.addSubview(muteButton)
        view.addSubview(nameLabel)
        view.addGestureRecognizer(tapped)
        view.isUserInteractionEnabled = true
        
        controlView.addSubview(playButton)
        controlView.addSubview(stopButton)
        controlView.addSubview(prevButton)
        controlView.addSubview(nextButton)
        
        controlView.isHidden = true
        
        VideoPlayerView.frame = videoPlayerFrame
        print("HI there")
        setupPlayerWithUrl(currentExercise?.tutorialUrl!)
        
        setupViews()
        
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
        player?.pause()
        controlView.isHidden = false
    }
    
    fileprivate func setupViews(){
        
        skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        skipButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        skipButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
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
        
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -190).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: controlView.topAnchor, constant: -8).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    @objc func handleSkip(){
        
        print("reg")
        player?.pause()
        time = CMTimeMake(0, 10)
        player?.seek(to: time!)
        player?.pause()
        let countViewController = RepCountViewController()
        countViewController.currentExercise = currentExercise!
        self.navigationController?.pushViewController(countViewController, animated: true)
        
    }
    
    @objc func handlePrevious(){
        playerLayer.removeFromSuperlayer()
        playerLayer = nil
        player = nil
        
        player = AVPlayer()
        playerLayer = AVPlayerLayer()
        
        var temp = currentExerciseIndex! - 1
        if(temp < 0){
            currentExerciseIndex = maxExercises! - 1
        }else{
            currentExerciseIndex = currentExerciseIndex! - 1
        }
        currentExercise = exercises[currentExerciseIndex!]
        nameLabel.text = currentExercise?.name!
        print(currentExercise?.name)
        setupPlayerWithUrl(currentExercise?.tutorialUrl)
        
        print("reg")
    }
    
    @objc func handlePlay(){
        player?.play()
        controlView.isHidden = true
        print("reg")
    }
    
    @objc func handleStop(){
        player?.pause()
        showAlertForStop("Do you want to finish this workout?")
        print("reg")
    }
    
    @objc func handleNext(){
        player?.pause()
        showAlertForNext("Do you want to skip this video? Your workout would not be complete without if you skip this video")
    }
    
    @objc func handleMute(){
        
        if let mute = UserDefaults.standard.value(forKey: "isMute") as? Bool{
            if mute{
                player?.isMuted = false
                muteButton.setTitle("Mute", for: .normal)
                UserDefaults.standard.set(false, forKey: "isMute")
            }else{
                player?.isMuted = true
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
            playerLayer.frame = VideoPlayerView.bounds
            //playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            VideoPlayerView.layer.addSublayer(playerLayer)
            
            //viewDidLayoutSubviews()
            //playerLayer.frame = VideoPlayerView.frame
            
            if let mute = UserDefaults.standard.value(forKey: "isMute") as? Bool{
                if mute{
                    player?.isMuted = true
                    muteButton.setTitle("Unmute", for: .normal)
                }else{
                    player?.isMuted = false
                    muteButton.setTitle("Mute", for: .normal)
                }
            }else{
                UserDefaults.standard.set(false, forKey: "isMute")
            }
            
            player?.play()
        }
        
    }
    @objc func handleYes(action: UIAlertAction){
        player?.pause()
        //dismiss(animated: true, completion: nil)
        playerLayer.removeFromSuperlayer()
        playerLayer = nil
        player = nil
        let saveViewController = LogWorkoutViewController()
        self.navigationController?.pushViewController(saveViewController, animated: true)
        //present(saveViewController, animated: true, completion: nil)
        //dismiss(animated: true, completion: nil)
        print("Handle yes")
        
    }
    
    @objc func handleNextPlay(action: UIAlertAction){
        
        player?.pause()
        playerLayer.removeFromSuperlayer()
        playerLayer = nil
        player = nil
        
        player = AVPlayer()
        playerLayer = AVPlayerLayer()
        
        currentExerciseIndex = (currentExerciseIndex! + 1)%maxExercises!
        currentExercise = exercises[currentExerciseIndex!]
        print(currentExercise?.name)
        nameLabel.text = currentExercise?.name!
        setupPlayerWithUrl(currentExercise?.tutorialUrl!)
        
    }
    
    
    func showAlertForStop(_ msg: String){
        let alert = UIAlertController(title: "Workout", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: handleYes))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertForNext(_ msg: String){
        let alert = UIAlertController(title: "Workout", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: handleNextPlay))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

