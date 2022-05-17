//
//  CellAction.swift
//  Teacher
//
//  Created by edy on 2022/5/17.
//

public enum CellAction {
    case insert(animate:UITableView.RowAnimation)
    case delete(animate:UITableView.RowAnimation)
    case refresh(animate:UITableView.RowAnimation)
}
