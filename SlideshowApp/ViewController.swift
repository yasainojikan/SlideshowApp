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
    
        let slideImage = UIImage(named: "1.jpg")
        imageView.image = slideImage
    }
    
    //画像を拡大したものを変数に格納する
    func cropThumbnailImage(image :UIImage, w:CGFloat, h:CGFloat) ->UIImage
    {
        // リサイズ処理
        let origRef    = image.cgImage
        let origWidth  = CGFloat(origRef!.width)
        let origHeight = CGFloat(origRef!.height)
        var resizeWidth:CGFloat = 0, resizeHeight:CGFloat = 0
        
        if (origWidth < origHeight) {
            resizeWidth = w
            resizeHeight = origHeight * resizeWidth / origWidth
        } else {
            resizeHeight = h
            resizeWidth = origWidth * resizeHeight / origHeight
        }
        
        let resizeSize = CGSize.init(width: CGFloat(resizeWidth), height: CGFloat(resizeHeight))
        
        UIGraphicsBeginImageContext(resizeSize)
        
        image.draw(in: CGRect.init(x: 0, y: 0, width: CGFloat(resizeWidth), height: CGFloat(resizeHeight)))
        
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // 切り抜き処理
        
        let cropRect  = CGRect.init(x: CGFloat((resizeWidth - w) / 2), y: CGFloat((resizeHeight - h) / 2), width: CGFloat(w), height: CGFloat(h))
        let cropRef   = resizeImage!.cgImage!.cropping(to: cropRect)
        let cropImage = UIImage(cgImage: cropRef!)
        
        return cropImage
    }
    
    // updateTimerの定義　呼び出されるたびに何をするか記述
    @objc func updateTimer(_ timer: Timer) {
        dispImageNo += 1
        displayImage()
    }
    
//ボタンを接続していく
    @IBAction func next(_ sender: Any) {
        //dispImageNoをプラス1してimageView.imageを呼び出す
        //timerがnilの時だけ押せる
        if timer == nil {
            dispImageNo += 1
            displayImage()
        }
    }
    
    @IBAction func previous(_ sender: Any) {
        if timer == nil {
        dispImageNo -= 1
        displayImage()
        }
    }
    
    @IBOutlet weak var startOrStop: UIButton!
    @IBAction func startOrStop(_ sender: Any) {
        if timer == nil {
        //timerが動き出す。2秒ごとに、updateTimerを呼び出し続ける
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateTimer(_: )), userInfo: nil, repeats: true)
            startOrStop.setTitle("停止", for: .normal)
        }
        
        else {
            //timerを止めて、nilで上書きする
            timer.invalidate()
            timer = nil
            displayImage()
            startOrStop.setTitle("再生", for: .normal)
        }
    //もっとスマートな書き方はないか聞く
    }
    
    
}


