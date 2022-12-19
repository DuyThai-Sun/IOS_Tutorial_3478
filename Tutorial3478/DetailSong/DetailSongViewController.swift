//
//  DetailSongViewController.swift
//  Tutorial3478
//
//  Created by Duy Thái on 13/12/2022.
//

import UIKit
import AVFoundation
import MediaPlayer


final class DetailSongViewController: UIViewController {
    @IBOutlet private weak var songImageView: UIImageView!
    @IBOutlet private weak var nameSongLabel: UILabel!
    @IBOutlet private weak var previousSongButton: CircleUIButton!
    @IBOutlet private weak var playSongButton: CircleUIButton!
    @IBOutlet private weak var nextSongButton: CircleUIButton!
    @IBOutlet private weak var artistSongLabel: UILabel!
    @IBOutlet private weak var progressSongSlider: UISlider!
    @IBOutlet private weak var repeatSongButton: UIButton!
    @IBOutlet private weak var favoriteSongButton: UIButton!
    
    private var trackName: String?
    private var song = Song()
    private var listSong = [Song]()
    private var indexOfSong: Int = 0
    private var player: AVAudioPlayer?
    private var repeatFunctionUpadateSlider: Timer?
    private var repeatFunctionRepeatSong: Timer?
    private var isRepeated = false
    private var isFavorited = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        title = song.name
        self.songImageView?.image = UIImage(named: song.imageName)
        self.nameSongLabel?.text = song.name
        self.artistSongLabel?.text = song.artistName
        self.trackName = song.trackName
    }

    override func viewWillAppear(_ animated: Bool) {
        congfigSong()
    }
    
    private func congfigSong() {
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: ".mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            if #available(iOS 12.0, *) {
                      try  AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.voicePrompt)
                  } else {
                      try  AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
                  }
            guard let urlString = urlString else {
                return
            }
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            guard let player = player else {
                return
            }
            let timeOfSong = Float(player.duration)
            progressSongSlider.maximumValue = timeOfSong
            player.play()
            repeatFunctionUpadateSlider = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateprogressSongSlider), userInfo: nil, repeats: true)
            guard let image = UIImage(named: song.imageName) else {
                        return
                    }
            let artWork = MPMediaItemArtwork(boundsSize: image.size, requestHandler: {
                (size) -> UIImage in return image
            })
            MPNowPlayingInfoCenter.default().nowPlayingInfo = [
                MPMediaItemPropertyTitle: song.name,
                MPMediaItemPropertyArtist: song.artistName,
                MPMediaItemPropertyPlaybackDuration: player.duration,
                MPMediaItemPropertyArtwork: artWork
            ]
            UIApplication.shared.beginReceivingRemoteControlEvents()
            becomeFirstResponder()
        } catch  {
            let storyBoard = UIStoryboard(name: "PopUpScreen", bundle: nil)
            let popUpView = storyBoard.instantiateViewController(withIdentifier: "popUpView") as! PopUpControllerViewController
            self.addChild(popUpView)
            popUpView.setNotice(notice: "\(error)")
            popUpView.view.frame = self.view.frame
            self.view.addSubview(popUpView.view)
        }
    }
    
    private func changeSong() {
        self.song = listSong[indexOfSong]
        congfigSong()
        configView()
    }

    override func remoteControlReceived(with event: UIEvent?) {
        if let event = event {
            if event.type == .remoteControl {
                switch event.subtype {
                case.remoteControlPlay:
                    player?.play()
                case.remoteControlStop:
                    player?.stop()
                case.remoteControlPause:
                    player?.pause()
                case.remoteControlNextTrack:
                    if indexOfSong == listSong.count - 1 {
                        self.song = listSong[0]
                    } else {
                            indexOfSong += 1
                            changeSong()
                    }
                case.remoteControlPreviousTrack:
                    if indexOfSong == 0 {
                        self.song = listSong[listSong.count - 1]
                    } else {
                            indexOfSong -= 1
                            changeSong()
                    }
                default: break
                }
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let player = player, player.isPlaying {
            player.stop()
            repeatFunctionUpadateSlider?.invalidate()
        } else {
            return
        }
    }

    @IBAction private func progressSongAction(_ sender: Any) {
        let currentValue = progressSongSlider.value
        progressSongSlider.value = currentValue
        player?.currentTime = TimeInterval(currentValue)
    }
    
    @objc private func updateprogressSongSlider(){
        progressSongSlider.value = Float(player!.currentTime)
        if progressSongSlider.value >= Float(player!.duration - 0.1) {
            repeatFunctionUpadateSlider?.invalidate()
            playSongButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            player?.stop()
            progressSongSlider.value = 0
            if isRepeated {
                congfigSong()
                playSongButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            }
        }
    }
    
    @IBAction func previousSongTapped(_ sender: Any) {
        if indexOfSong == 0 {
            changeSong()
        } else {
            indexOfSong -= 1
            changeSong()
        }
    }
    
    @IBAction private func playSongTapped(_ sender: Any) {
        if player?.isPlaying == true {
            playSongButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            player?.pause()
            repeatFunctionUpadateSlider?.invalidate()
        } else {
            if progressSongSlider.value == 0 {
                congfigSong()
                playSongButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            } else {
                playSongButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                player?.play()
                repeatFunctionUpadateSlider = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateprogressSongSlider), userInfo: nil, repeats: true)
            }
        }
    }
    
    func setUpView(song: Song, listSong: [Song], indexOfSong: Int) {
        self.song = song
        self.listSong = listSong
        self.indexOfSong = indexOfSong
    }

    @IBAction private func nextSongTapped(_ sender: Any) {
        if indexOfSong == listSong.count - 1 {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let popUpView = storyBoard.instantiateViewController(withIdentifier: "popUpView") as! PopUpControllerViewController
            self.addChild(popUpView)
            popUpView.setNotice(notice: "Đây là bài cuối")
            popUpView.view.frame = self.view.frame
            self.view.addSubview(popUpView.view)

        } else {
                indexOfSong += 1
                changeSong()
        }
    }
    
    @IBAction private func reapeatSongTapped(_ sender: Any) {
        isRepeated = !isRepeated
        if isRepeated {
            repeatSongButton.tintColor = .red
        } else {
            repeatSongButton.tintColor = .white
        }
    }
    
    @IBAction private func favoritedSongTapped(_ sender: Any) {
        isFavorited = !isFavorited
        if isFavorited {
            favoriteSongButton.tintColor = .systemPink
        } else {
            favoriteSongButton.tintColor = .white
        }
    }
}
