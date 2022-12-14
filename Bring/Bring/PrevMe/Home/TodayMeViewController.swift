//
//  TodayMeViewController.swift
//  Bring
//
//  Created by 오예진 on 2022/11/06.
//

import UIKit
//import Foundation
import PanModal

class TodayMeViewController: UIViewController {
    
    @IBOutlet var emotionView: UIView!
    @IBOutlet var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var selectImage: UIImageView!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var recordView: UIView!
    
    
    @IBOutlet var tiredBtn: UIButton!
    @IBOutlet var crazyBtn: UIButton!
    @IBOutlet var sadBtn: UIButton!
    @IBOutlet var angryBtn: UIButton!
    @IBOutlet var loveBtn: UIButton!
    @IBOutlet var smileBtn: UIButton!
    
    @IBOutlet var saveBtn: UIButton!
    
    var trackResult: [TrackResult] = TrackResult.tracks

    var record: Record?
    
    var music: Bool = false
    var emoji: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
    
        searchBar.delegate = self
        searchBar.text = PrevmeData.data.music
        
        tableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")

        setButton(smileBtn)
        setButton(crazyBtn)
        setButton(sadBtn)
        setButton(angryBtn)
        setButton(loveBtn)
        setButton(tiredBtn)
        
    }
    
    
    @IBAction func smileTapped(_ sender: Any) {
        setTapped(smileBtn)
        reset(loveBtn)
        reset(angryBtn)
        reset(sadBtn)
        reset(crazyBtn)
        reset(tiredBtn)
        record?.emotion = "HAPPY"
    }
    @IBAction func loveTapped(_ sender: Any) {
        setTapped(loveBtn)
        reset(smileBtn)
        reset(angryBtn)
        reset(sadBtn)
        reset(crazyBtn)
        reset(tiredBtn)
        record?.emotion = "LOVELY"
    }
    @IBAction func angryTapped(_ sender: Any) {
        setTapped(angryBtn)
        reset(smileBtn)
        reset(loveBtn)
        reset(sadBtn)
        reset(crazyBtn)
        reset(tiredBtn)
        record?.emotion = "ANGRY"
    }
    @IBAction func sadTapped(_ sender: Any) {
        setTapped(sadBtn)
        reset(smileBtn)
        reset(loveBtn)
        reset(angryBtn)
        reset(crazyBtn)
        reset(tiredBtn)
        record?.emotion = "SAD"
    }
    @IBAction func crazyTapped(_ sender: Any) {
        setTapped(crazyBtn)
        reset(smileBtn)
        reset(loveBtn)
        reset(sadBtn)
        reset(angryBtn)
        reset(tiredBtn)
        record?.emotion = "EXPLODE"
    }
    @IBAction func tiredTapped(_ sender: Any) {
        setTapped(tiredBtn)
        reset(smileBtn)
        reset(loveBtn)
        reset(sadBtn)
        reset(angryBtn)
        reset(crazyBtn)
        record?.emotion = "TIRED"
    }
    
    func reset(_ btn: UIButton) {
        btn.layer.borderColor = UIColor(named: "LyricsBoxBorder")?.cgColor
        btn.backgroundColor = UIColor.white
    }
    
    func setButton(_ btn: UIButton) {
        btn.layer.borderColor = UIColor(named: "LyricsBoxBorder")?.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 10
    }
    
    func setTapped(_ btn: UIButton) {
        btn.layer.borderColor = UIColor(named: "prevMain")?.cgColor
        btn.backgroundColor = UIColor(named: "prevMainSoft")
        emoji = true
        if (music && emoji) {
            saveBtn.isEnabled = true
        }
    }
    
    
    @IBAction func recordBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Record", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RecordModalController") as! RecordModalController
        
        vc.record = record
        presentPanModal(vc)
    }

    
    func setUI() {
        
        photoView.layer.shadowOffset = CGSize(width: 0, height: 3)
        photoView.layer.shadowOpacity = 0.15
        photoView.layer.borderColor = UIColor(named: "boxLightGray")?.cgColor
        selectImage.layer.cornerRadius = 10
        
        
        recordBtn.layer.borderColor = UIColor(named: "boxLightGray")?.cgColor
        recordBtn.layer.borderWidth = 1
        recordBtn.layer.cornerRadius = 10
        
        searchBar.searchTextField.backgroundColor = UIColor.white
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 11)

        saveBtn.isEnabled = false
    }

    // MARK: 서버로 기록 POST & 캘린더 뷰로 이동
    @IBAction func saveTapped(_ sender: Any) {
        
        print("save tapped")
        // 캘린더 뷰로 이동
        let storyboard = UIStoryboard(name: "Calendar", bundle: nil)
        guard let Calendar = storyboard.instantiateViewController(withIdentifier: "CalendarViewController") as? CalendarViewController else {return}
    
        self.navigationController?.pushViewController(Calendar, animated: true)
        
    }
    
}

extension TodayMeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell else { return UITableViewCell() }
        cell.exLabel.text = trackResult[indexPath.row].track
        if cell.exLabel.text != "" {
            tableView.layer.borderColor = UIColor(named: "boxLightGray")?.cgColor
               tableView.layer.borderWidth = 1
               tableView.layer.cornerRadius = 10
          
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let title = trackResult[indexPath.row].track
        searchBar.text = title
        tableView.reloadData()
        return nil
    }
    
    
}

extension TodayMeViewController: UISearchBarDelegate {
    
    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let track = searchBar.text!
        GetTrack(track ?? "") { json in
            self.trackResult = json.result
        }
        
        self.record = Record(userIdx: 1, date: "", emotion: "", season: "", weather: [""], lyrics: "", placeNickname: "", place: "", imageURL: "", record: "", track: track, artist: "", friendList: [""], options: 0)
        
        music = true
        if (music && emoji) {
            saveBtn.isEnabled = true
        }
    }
}
