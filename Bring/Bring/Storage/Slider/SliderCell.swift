//
//  SliderCell.swift
//  Bring
//
//  Created by 오예진 on 2022/11/18.
//

import UIKit

class SliderCell: UICollectionViewCell {
    
    @IBOutlet var emotionLabel: UILabel!
    @IBOutlet var emotionCard: UIImageView!
    @IBOutlet var lyrics: UILabel!
    
    @IBOutlet var storageBtn: UIButton!
    @IBOutlet var playBtn: UIButton!
    
    // 데이터 연결
    func configure(_ emotionCards: EmotionSlider) {
        
        emotionLabel.text = emotionCards.title
        
        var cardImg: UIImage?
        cardImg = UIImage(named: emotionCards.card)
        emotionCard.image = cardImg
        
        lyrics.text = emotionCards.lyrics
        
        var storageBtnImg: UIImage?
        storageBtnImg = UIImage(named: emotionCards.storageBtn)
        storageBtn.setImage(storageBtnImg, for: .normal)
        
        var playBtnImg: UIImage?
        playBtnImg = UIImage(named: emotionCards.playBtn)
        playBtn.setImage(playBtnImg, for: .normal)
    }
    
    @IBAction func ByEmojiTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ByEmoji", bundle: nil)
        let ByEmoji = storyboard.instantiateViewController(withIdentifier: "ByEmojiViewController") 
        if let vc = self.next(ofType: UIViewController.self) {
            vc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            vc.modalPresentationStyle = .fullScreen
            vc.present(ByEmoji, animated: true, completion: nil)
        }

        
//        let childVC = ByEmojiViewController()
//        let parentVC = StorageViewController()
//
//        childVC.view.backgroundColor = .yellow
//
//        // currentContext 테스트
//        childVC.modalPresentationStyle = .currentContext
//
//        parentVC.present(childVC, animated: true, completion: nil)
//
    }
    
}

