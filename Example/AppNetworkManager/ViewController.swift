//
//  ViewController.swift
//  AppNetworkManager
//
//  Created by guoshuai.cheng@holla.world on 03/19/2024.
//  Copyright (c) 2024 guoshuai.cheng@holla.world. All rights reserved.
//

import UIKit
import AppNetworkManager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let params: [String: Any] = ["token": "40b129db7c5e82f818d4227b08a8e7b6","page_cursor":0]
        BaseProtocol.getBlockList.request(parameter: params).json { [weak self] (response: App_Response<[String: Any]>) in
            guard let `self` = self else { return }
            switch response {
            case let .success(json):
                print("json = \(json)")
            case let .faile(error):
                print("error = \(error)")
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

