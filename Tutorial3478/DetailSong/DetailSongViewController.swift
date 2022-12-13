//
//  DetailSongViewController.swift
//  Tutorial3478
//
//  Created by Duy Thái on 13/12/2022.
//

import UIKit

class DetailSongViewController: UIViewController {
    @IBOutlet weak var imgSong: UIImageView!
    @IBOutlet weak var progressSong: UIProgressView!
    @IBOutlet weak var nameSong: UILabel!
    @IBOutlet weak var previousSongBtn: CircleUIButton!
    @IBOutlet weak var playSongBtn: CircleUIButton!
    @IBOutlet weak var nextSongBtn: CircleUIButton!
    @IBOutlet weak var artistSong: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail Screen"
        progressSong.layer.cornerRadius = 8.0
        progressSong.clipsToBounds = true
    }
    var isPaused = true


    @IBAction func previousSongTapped(_ sender: Any) {
        print("previous")
    }

     
    @IBAction func playSongTapped(_ sender: Any) {
        isPaused = !isPaused
        if isPaused {
            playSongBtn.setImage(UIImage(systemName: "play.fill"), for: .normal)
            print("pause")
           
        }else{
            playSongBtn.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            print("play")

            
        }
        
    }
    
    
    @IBAction func nextSongTapped(_ sender: Any) {
        print("next")
    }
    
    
}
