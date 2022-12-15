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

extension ListOfSongViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell") as! SongTableViewCell
        cell.nameOfSong.text = songs[indexPath.row].name
        cell.authorOfSong.text = songs[indexPath.row].artistName
        cell.songImageView.image = UIImage(named: songs[indexPath.row].imageName)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
}
