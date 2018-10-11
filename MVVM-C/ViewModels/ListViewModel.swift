//
//  ListViewModel.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2018 Diligent Robot Ltd. All rights reserved.
//

import Foundation

protocol ListViewModelViewDelegate: class
{
    func itemsDidChange(viewModel: ListViewModel)
}

protocol ListViewModelCoordinatorDelegate: class
{
    func listViewModelDidSelectData(_ viewModel: ListViewModel, data: DataItem)
}

protocol ListViewModel
{
    var model: ListModel? { get set }
    var viewDelegate: ListViewModelViewDelegate? { get set }
    var coordinatorDelegate: ListViewModelCoordinatorDelegate? { get set}
    
    var title: String { get }
    
    var numberOfItems: Int { get }
    func item(atIndex index: Int) -> DataItem?
    func useItem(atIndex index: Int)
}
