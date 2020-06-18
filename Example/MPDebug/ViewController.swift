//
//  ViewController.swift
//  MPDebug
//
//  Created by manhpham90vn on 04/06/2020.
//  Copyright (c) 2020 manhpham90vn. All rights reserved.
//

import UIKit
import MPDebug

class ViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func callApiButtonTapped(_ sender: Any) {
        URLSession.shared.dataTask(with: URL(string: "https://httpbin.org/json")!) { (data, response, error) in
            print("Total", data?.count ?? 0)
        }
        .resume()
        
        URLSession.shared.dataTask(with: URL(string: "https://github.com/manhpham90vn")!) { (data, response, error) in
            print("Total", data?.count ?? 0)
        }
        .resume()
        
        URLSession.shared.dataTask(with: URL(string: "https://avatars0.githubusercontent.com/u/40340023?s=460&u=69c65610ce3b47ac8d4eef6be8e79ee0dbd6211b&v=4")!) { (data, response, error) in
            print("Total", data?.count ?? 0)
        }
        .resume()
    }
    
    @IBAction func sendMessageButtonTapped(_ sender: Any) {
        guard let message = messageTextField.text, !message.isEmpty else { return }
        MPDebugLog.share.log(message: message)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

