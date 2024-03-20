//
//  ViewController.swift
//  AppNetworkManager
//
//  Created by guoshuai.cheng@holla.world on 03/19/2024.
//  Copyright (c) 2024 guoshuai.cheng@holla.world. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        BaseProtocol.AppInfoGetConfig.request()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

