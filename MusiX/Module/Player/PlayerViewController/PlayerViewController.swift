//
//  PlayerViewController.swift
//  MusiX
//
//  Created by Timofey on 14.07.24.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController, AVAudioPlayerDelegate {
    
    var audioPlayer: AVAudioPlayer?
    var songTimer: Timer?
    var currentTrackIndex: Int = 0
    
    var tracks: [String?] = [
        String("haunted4"),
        String("The Beatles - Baby, You're A Rich Man")
        
    ]
    
    //MARK: -- UI Elements
    
    //setup play/pause button
    private lazy var playerButton: UIButton = {
        let playBtn = UIButton(type: .system)
        playBtn.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        playBtn.tintColor = .black
        playBtn.translatesAutoresizingMaskIntoConstraints = false
        playBtn.addTarget(self, action: #selector(playPauseMusic), for: .touchUpInside)
        return playBtn
    }()
    
    //setup nextButton
    private lazy var nextButton: UIButton = {
        let next = UIButton(type: .system)
        next.setBackgroundImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        next.tintColor = .black
        next.translatesAutoresizingMaskIntoConstraints = false
        next.addTarget(self, action: #selector(nextButtonTap), for: .touchUpInside)
        return next
    }()
    
    //setup pastButton
    private lazy var pastButton: UIButton = {
        let past = UIButton(type: .system)
        past.setBackgroundImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        past.tintColor = .black
        past.translatesAutoresizingMaskIntoConstraints = false
        past.addTarget(self, action: #selector(pastButtonTap), for: .touchUpInside)
        return past
    }()
    
    //setup trackLabel
    private lazy var songLabel: UILabel = {
        let label = UILabel()
        label.text = "Track name"
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    //setup playerLabel
//    private lazy var playerTitle: UILabel = {
//        let lbl = UILabel()
//        lbl.text = "Player"
//        lbl.textColor = .black
//        lbl.font = UIFont.systemFont(ofSize: 25, weight: .bold)
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        return lbl
//    }()
    
    //setup slider
    private lazy var musicSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0.0
        slider.value = 0.0
        slider.maximumValue = 1.0
        slider.isContinuous = true
        slider.tintColor = AppColors.mainRed
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    //setup trackImage
    private lazy var trackImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "music.note")
        image.tintColor = AppColors.Gray
        image.backgroundColor = .green
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // setup trackTimers
    private lazy var trackStartTimer: UILabel = {
        let label = UILabel()
        label.text = "0:00"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var trackEndTimer: UILabel = {
        let label = UILabel()
        label.text = "0:00"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

//MARK: -- Setup Layer
private extension PlayerViewController {
    func setup() {
        view.backgroundColor = AppColors.lightGrayMain
        setupConstraints()
        setupAudioPlayer()
        
    }
    //setupConstraints
    func setupConstraints() {
        
//        view.addSubview(playerTitle)
        view.addSubview(musicSlider)
        view.addSubview(playerButton)
        view.addSubview(songLabel)
        view.addSubview(nextButton)
        view.addSubview(pastButton)
        view.addSubview(trackStartTimer)
        view.addSubview(trackEndTimer)
        view.addSubview(trackImage)
        
        NSLayoutConstraint.activate([
            
            // setup constraints for playerTitle
//            playerTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
//            playerTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
//            playerTitle.heightAnchor.constraint(equalToConstant: 40),
            
            // setup constraints for play/pause button
            playerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerButton.bottomAnchor.constraint(equalTo: musicSlider.topAnchor, constant: -20),
            playerButton.heightAnchor.constraint(equalToConstant: 40),
            playerButton.widthAnchor.constraint(equalToConstant: 35),
            
            // setup constraints for musicSlider
            musicSlider.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            musicSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            musicSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            musicSlider.heightAnchor.constraint(equalToConstant: 40),
            
            // setup constraints for trackLabel
            songLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            songLabel.bottomAnchor.constraint(equalTo: playerButton.topAnchor, constant: -50),
            
            // setup constraints for next/past button
            nextButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 70),
            nextButton.bottomAnchor.constraint(equalTo: musicSlider.topAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 40),
            nextButton.widthAnchor.constraint(equalToConstant: 40),
            
            pastButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -70),
            pastButton.bottomAnchor.constraint(equalTo: musicSlider.topAnchor, constant: -20),
            pastButton.heightAnchor.constraint(equalToConstant: 40),
            pastButton.widthAnchor.constraint(equalToConstant: 40),
            
            // setup constraints for trackTimers
            trackStartTimer.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -160),
            trackStartTimer.bottomAnchor.constraint(equalTo: musicSlider.topAnchor, constant: -5),
            trackEndTimer.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 160),
            trackEndTimer.bottomAnchor.constraint(equalTo: musicSlider.topAnchor, constant: -5),
            
            // setup constraints for trackImage
            trackImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            trackImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            trackImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            trackImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300)
            
        ])
    }
    
}

//MARK: -- Setup Audio Player
extension PlayerViewController {
    private func setupAudioPlayer() {
        
        guard currentTrackIndex >= 0, currentTrackIndex < tracks.count else { return }
        guard let trackName = tracks[safe: currentTrackIndex] else { return }
        guard let url = Bundle.main.url(forResource: trackName, withExtension: "mp3") else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.delegate = self
            songLabel.text = trackName
        } catch {
            print("Error initializing player \(error)")
        }
        
    }
    
    // setup track switching
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            currentTrackIndex = (currentTrackIndex + 1) % tracks.count
            setupAudioPlayer()
            audioPlayer?.play()
            playerButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
}


//MARK: -- OBJC
private extension PlayerViewController {
    
    //setup play/pause music function
    @objc private func playPauseMusic() {
        if audioPlayer?.isPlaying == true {
            audioPlayer?.pause()
            playerButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            stopSongTimer()
            
        } else {
            
            audioPlayer?.play()
            playerButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            startSongTimer()
            
        }
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        audioPlayer?.currentTime = TimeInterval(sender.value) * audioPlayer!.duration
    }
    
    @objc private func updateSliderValue() {
        
        guard let audioPlayer = audioPlayer else { return }
        musicSlider.value = Float(audioPlayer.currentTime / audioPlayer.duration)
        let startTime = audioPlayer.currentTime
        let endTime = audioPlayer.duration
        let startTimeString = String(format: "%2d:%02d", Int(startTime) / 60, Int(startTime) % 60)
        let endTimeString = String(format: "%2d:%02d", Int(endTime) / 60, Int(endTime) % 60)
        
        // setup track time
        trackStartTimer.text = "\(startTimeString)"
        trackEndTimer.text = "\(endTimeString)"
    }
    
    //setup next/past button functions
    @objc private func nextButtonTap(_ sender: UISlider) {
        if audioPlayer?.isPlaying == true {
            
            currentTrackIndex = (currentTrackIndex + 1) % tracks.count
            setupAudioPlayer()
            audioPlayer?.play()
            playerButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            currentTrackIndex = (currentTrackIndex + 1) % tracks.count
            setupAudioPlayer()
            audioPlayer?.pause()
            playerButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    @objc private func pastButtonTap() {
        if audioPlayer?.isPlaying == true {
            
            currentTrackIndex = (currentTrackIndex - 1) % tracks.count
            setupAudioPlayer()
            audioPlayer?.play()
            playerButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            currentTrackIndex = (currentTrackIndex - 1) % tracks.count
            setupAudioPlayer()
            audioPlayer?.pause()
            playerButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    private func startSongTimer() {
        songTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSliderValue), userInfo: nil, repeats: true)
    }
    
    private func stopSongTimer() {
        songTimer?.invalidate()
        songTimer = nil
        
    }
}

#Preview { PlayerViewController() }
#Preview { TabBarViewController() }
