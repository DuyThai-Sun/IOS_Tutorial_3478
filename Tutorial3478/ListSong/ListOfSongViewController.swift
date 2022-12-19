//
//  ListOfSongViewController.swift
//  Tutorial3478
//
//  Created by Duy Thái on 13/12/2022.
//

import UIKit

class ListOfSongViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        title = "Music Player"
        listSong.delegate = self
        listSong.dataSource = self
        listSong.backgroundColor = .black
    }
   
    let songs = [
        Song(name: "Hãy trao cho anh", albumName: "VN", artistName: "Sơn Tùng MTP", imageName: "Hay-Trao-Cho-Anh", trackName: "HayTraoChoAnh-SonTungMTPSnoopDogg-6010660"),
        Song(name: "Sao cũng được", albumName: "VN", artistName: "Thành Đạt x Đông Thiên Đức", imageName: "SaoCungDuoc", trackName: "saoCungDc"),
    
       Song(name: "StarBoy", albumName: "US/UK", artistName: "The Weekend", imageName: "StarBoy", trackName: "StarBoy"),
        Song(name: "Cơn mưa ngang qua", albumName: "VN", artistName: "Sơn Tùng MTP", imageName: "ConMuaNgangQua", trackName: "ConMuaNgangQua"),
        Song(name: "Hãy trao cho anh", albumName: "VN", artistName: "Sơn Tùng MTP", imageName: "Hay-Trao-Cho-Anh", trackName: "HayTraoChoAnh-SonTungMTPSnoopDogg-6010660"),
        Song(name: "Sao cũng được", albumName: "VN", artistName: "Thành Đạt x Đông Thiên Đức", imageName: "SaoCungDuoc", trackName: "saoCungDc"),
    
       Song(name: "StarBoy", albumName: "US/UK", artistName: "The Weekend", imageName: "StarBoy", trackName: "StarBoy"),
        Song(name: "Cơn mưa ngang qua", albumName: "VN", artistName: "Sơn Tùng MTP", imageName: "ConMuaNgangQua", trackName: "ConMuaNgangQua"),
        Song(name: "Hãy trao cho anh", albumName: "VN", artistName: "Sơn Tùng MTP", imageName: "Hay-Trao-Cho-Anh", trackName: "HayTraoChoAnh-SonTungMTPSnoopDogg-6010660"),
        Song(name: "Sao cũng được", albumName: "VN", artistName: "Thành Đạt x Đông Thiên Đức", imageName: "SaoCungDuoc", trackName: "saoCungDc"),
    
       Song(name: "StarBoy", albumName: "US/UK", artistName: "The Weekend", imageName: "StarBoy", trackName: "StarBoy"),
        Song(name: "Cơn mưa ngang qua", albumName: "VN", artistName: "Sơn Tùng MTP", imageName: "ConMuaNgangQua", trackName: "ConMuaNgangQua"),
    ]
    
    @IBOutlet weak var listSong: UITableView!
    
}

extension ListOfSongViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell") as! SongTableViewCell
        cell.configSong(song: songs[indexPath.row])
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailScreen = storyBoard.instantiateViewController(withIdentifier: "DetailSongScreen") as! DetailSongViewController
        detailScreen.setUpView(song: songs[indexPath.row], listSong: songs, indexOfSong: indexPath.row)
        self.navigationController?.pushViewController(detailScreen, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    
}
