//
//  ViewController.swift
//  MPDebug
//
//  Created by manhpham90vn on 04/06/2020.
//  Copyright (c) 2020 manhpham90vn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        URLSession.shared.dataTask(with: URL(string: "https://httpbin.org/get")!) { (data, response, error) in
            print(data?.count ?? 0)
        }
        .resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

