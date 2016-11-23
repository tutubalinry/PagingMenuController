//
//  RootViewController.swift
//  PagingMenuControllerDemo
//
//  Created by Yusuke Kita on 5/10/15.
//  Copyright (c) 2015 kitasuke. All rights reserved.
//

import UIKit
import PagingMenuController

private enum Section {
    case All(content: AllContent)
    case MenuView(content: MenuViewContent)
    case MenuController(content: MenuControllerContent)
    
    private enum AllContent: Int { case Standard, SegmentedControl, Infinite }
    private enum MenuViewContent: Int { case Underline, RoundRect }
    private enum MenuControllerContent: Int { case Standard }
    
    init?(indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, let row):
            guard let content = AllContent(rawValue: row) else { return nil }
            self = .All(content: content)
        case (1, let row):
            guard let content = MenuViewContent(rawValue: row) else { return nil }
            self = .MenuView(content: content)
        case (2, let row):
            guard let content = MenuControllerContent(rawValue: row) else { return nil }
            self = .MenuController(content: content)
        default: return nil
        }
    }
    
    var options: PagingMenuControllerCustomizable {
        let options: PagingMenuControllerCustomizable
        switch self {
        case .All(let content):
            switch content {
            case .Standard:
                options = PagingMenuOptions()
                let menuOptions = MenuOptions()
                menuOptions.itemsOptions = [MenuItem(), MenuItem(), MenuItem(), MenuItem()]
                options.componentType = .All(menuOptions: menuOptions, pagingControllers: [UsersViewController.instantiateFromStoryboard(), RepositoriesViewController.instantiateFromStoryboard(), GistsViewController.instantiateFromStoryboard(), OrganizationsViewController.instantiateFromStoryboard()])
            case .SegmentedControl:
                options = PagingMenuOptions()
                let menuOptions = MenuOptions()
                menuOptions.displayMode = .SegmentedControl
                menuOptions.itemsOptions = [MenuItem(), MenuItem(), MenuItem(), MenuItem()]
                options.componentType = .All(menuOptions: menuOptions, pagingControllers: [UsersViewController.instantiateFromStoryboard(), RepositoriesViewController.instantiateFromStoryboard(), GistsViewController.instantiateFromStoryboard(), OrganizationsViewController.instantiateFromStoryboard()])
            case .Infinite:
                options = PagingMenuOptions()
                let menuOptions = MenuOptions()
                menuOptions.displayMode = .Infinite(widthMode: .Flexible, scrollingMode: .ScrollEnabled)
                menuOptions.itemsOptions = [MenuItem(), MenuItem(), MenuItem(), MenuItem()]
                options.componentType = .All(menuOptions: menuOptions, pagingControllers: [UsersViewController.instantiateFromStoryboard(), RepositoriesViewController.instantiateFromStoryboard(), GistsViewController.instantiateFromStoryboard(), OrganizationsViewController.instantiateFromStoryboard()])
            }
        case .MenuView(let content):
            switch content {
            case .Underline:
                options = PagingMenuOptions()
                let menuOptions = MenuOptions()
                menuOptions.displayMode = .SegmentedControl
                menuOptions.focusMode = .Underline(height: 3, color: UIColor.blueColor(), horizontalPadding: 10, verticalPadding: 0)
                menuOptions.itemsOptions = [MenuItem(), MenuItem(), MenuItem(), MenuItem()]
                options.componentType = .All(menuOptions: menuOptions, pagingControllers: [UsersViewController.instantiateFromStoryboard(), RepositoriesViewController.instantiateFromStoryboard(), GistsViewController.instantiateFromStoryboard(), OrganizationsViewController.instantiateFromStoryboard()])
            case .RoundRect:
                options = PagingMenuOptions()
                let menuOptions = MenuOptions()
                menuOptions.displayMode = .Infinite(widthMode: .Flexible, scrollingMode: .PagingEnabled)
                menuOptions.focusMode = .RoundRect(radius: 12, horizontalPadding: 8, verticalPadding: 8, selectedColor: UIColor.lightGrayColor())
                menuOptions.itemsOptions = [MenuItem(), MenuItem(), MenuItem(), MenuItem()]
                options.componentType = .All(menuOptions: menuOptions, pagingControllers: [UsersViewController.instantiateFromStoryboard(), RepositoriesViewController.instantiateFromStoryboard(), GistsViewController.instantiateFromStoryboard(), OrganizationsViewController.instantiateFromStoryboard()])
            }
        case .MenuController(let content):
            switch content {
            case .Standard:
                options = PagingMenuOptions()
                options.componentType = .PagingController(pagingControllers: [UsersViewController.instantiateFromStoryboard(), RepositoriesViewController.instantiateFromStoryboard(), GistsViewController.instantiateFromStoryboard(), OrganizationsViewController.instantiateFromStoryboard()])
            }
        }
        return options
    }
}

class RootViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPathForCell(cell),
            let sectionType = Section(indexPath: indexPath),
            let viewController = segue.destinationViewController as? PagingMenuViewController else { return }
        
        viewController.title = cell.textLabel?.text
        viewController.options = sectionType.options
    }
}
