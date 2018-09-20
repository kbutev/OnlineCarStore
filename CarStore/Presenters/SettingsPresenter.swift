//
//  SettingsPresenter.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import UIKit

protocol SettingsViewDelegate: AnyObject
{
    func update(dataSource: StoreViewDataSource?)
}

protocol SettingsPresenterDelegate: AnyObject
{
    func loadStore()
}

class SettingsPresenter
{
    
}
