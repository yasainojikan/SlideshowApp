//
//  ZoomViewController.swift
//  SlideshowApp
//
//  Created by 今冨友裕 on 2019/02/26.
//  Copyright © 2019年 yasainojikan. All rights reserved.
//

import UIKit

class ZoomViewController: UIViewController {

    @IBOutlet weak var zoomedSlideImage: UIImageView!
    
    var zoomedSlide = UIImage(named: "1.jpg")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let result = zoomedSlide
        zoomedSlideImage.image = result
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
