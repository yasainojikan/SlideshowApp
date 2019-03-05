//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 今冨友裕 on 2019/02/24.
//  Copyright © 2019年 yasainojikan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func tapToZoom(_ sender: Any) {
        performSegue(withIdentifier: "zoom", sender: nil)
        
        //タイマーが動いている時を区別する。停止ボタンを再生ボタンに切り替えておく。
        //もっといい書き方がある気がする。
        if timer != nil{
            timer.invalidate()
            timer = nil
            startOrStop.setTitle("再生", for: .normal)
            
            nextButtenLabel.isEnabled = true
            backButtenLabel.isEnabled = true
        }
    }
    
    @IBAction func backToViewController(_ segue: UIStoryboardSegue) {
    }
    
    var timer: Timer!
    
    var dispImageNo = 0
    
    func displayImage() {
        
        let imageNameArray = [
            "1.jpg",
            "2.jpg",
            "3.jpg",
            "4.jpg",
            "5.jpg",
            ]
        
        if dispImageNo < 0 {
            dispImageNo = 4
        }
        
        if dispImageNo > 4 {
            dispImageNo = 0
        }
        
        // slideImageはUIImageのインスタンスを格納した変数
        let slideImage = UIImage(named: imageNameArray[dispImageNo])
        imageView.image = slideImage
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //初期表示の定義
        let slideImage = UIImage(named: "1.jpg")
        imageView.image = slideImage
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueから遷移先のZoomViewControllerを取得する
        let zoomViewController:ZoomViewController = segue.destination as! ZoomViewController
        // 遷移先のzoomViewControllerで宣言しているzoomedSlideに値を代入して渡す
        zoomViewController.zoomedSlide = imageView.image
    }
    
    
    // updateTimerの定義　呼び出されるたびに何をするか記述
    @objc func updateTimer(_ timer: Timer) {
        dispImageNo += 1
        displayImage()
    }
    
    //ボタンを接続していく
    //進むボタン
    
    @IBOutlet weak var nextButtenLabel: UIButton!
    @IBOutlet weak var backButtenLabel: UIButton!
    
    @IBAction func next(_ sender: Any) {
        //dispImageNoをプラス1してimageView.imageを呼び出す
        //timerがnilの時だけ押せる
        if timer == nil {
            dispImageNo += 1
            displayImage()
        }
    }
    
    //戻るボタン
    @IBAction func previous(_ sender: Any) {
        if timer == nil {
            dispImageNo -= 1
            displayImage()
        }
    }
    
    //再生・停止切り替えボタン
    //もっといい書き方がある気がする。
    @IBOutlet weak var startOrStop: UIButton!
    @IBAction func startOrStop(_ sender: Any) {
        if timer == nil {
            //timerが動き出す。2秒ごとに、updateTimerを呼び出し続ける
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateTimer(_: )), userInfo: nil, repeats: true)
            startOrStop.setTitle("停止", for: .normal)
            
            nextButtenLabel.isEnabled = false
            backButtenLabel.isEnabled = false
        }
            
        else {
            //timerを止めて、nilで上書きする
            timer.invalidate()
            timer = nil
            displayImage()
            startOrStop.setTitle("再生", for: .normal)
            
            nextButtenLabel.isEnabled = true
            backButtenLabel.isEnabled = true
        }
    }
    
    
}


