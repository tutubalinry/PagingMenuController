//
//  PagingMenuControllerOptions.swift
//  PagingMenuControllerDemo
//
//  Created by Yusuke Kita on 6/9/16.
//  Copyright © 2016 kitasuke. All rights reserved.
//

import Foundation
import PagingMenuController

class MenuItem: MenuItemViewCustomizable {
    private var _displayMode: MenuItemDisplayMode = .Text(title: MenuItemText())
    
    var displayMode: MenuItemDisplayMode {
        set { _displayMode = newValue }
        get { return _displayMode }
    }
}

class MenuOptions: MenuViewCustomizable {
    private var _displayMode: MenuDisplayMode = .Standard(widthMode: .Flexible, centerItem: false, scrollingMode: .PagingEnabled)
    private var _focusMode: MenuFocusMode = .None
    private var _itemsOptions: [MenuItemViewCustomizable] = [MenuItem()]
    
    var displayMode: MenuDisplayMode {
        get { return _displayMode }
        set { _displayMode = newValue }
    }
    var focusMode: MenuFocusMode {
        get { return _focusMode }
        set { _focusMode = newValue }
    }
    var height: CGFloat {
        return 60
    }
    var itemsOptions: [MenuItemViewCustomizable] {
        get { return _itemsOptions }
        set { _itemsOptions = newValue }
    }
}

class PagingMenuOptions: PagingMenuControllerCustomizable {
    private var _componentType: ComponentType = .All(menuOptions: MenuOptions(), pagingControllers: [UIViewController()])
    
    var componentType: ComponentType {
        get { return _componentType }
        set { _componentType = newValue }
    }
    var lazyLoadingPage: LazyLoadingPage {
        return .Three
    }
}
