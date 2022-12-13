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
        title = "Music Player"
        listSong.delegate = self
        listSong.dataSource = self
        listSong.backgroundColor = .black
//        addHeaderListSong()
        
    }
    func addHeaderListSong(){
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.listSong.frame.width, height: 50))
        headerView.backgroundColor = .black
        let labelHeader = UILabel(frame: headerView.bounds)
        labelHeader.text = "Music Player"
        labelHeader.font = .systemFont(ofSize: 32, weight: .heavy)
        headerView.addSubview(labelHeader)
        self.listSong.tableHeaderView = headerView
    }
    

    @IBOutlet weak var listSong: UITableView!
    
}

extension ListOfSongViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell") as! SongTableViewCell
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
}
