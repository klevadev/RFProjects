//
//  InboxViewController.swift
//  InboxScreenUI
//
//  Created by Lev Kolesnikov on 03.12.2019.
//  Copyright © 2019 SwiftOverflow. All rights reserved.
//

import UIKit

class InboxVС: UIViewController {
    
    let demoHistory = DemoHistory()
    let tableView = UITableView(frame: .zero, style: .grouped)
    let containerView: UIView = UIView()
    let gradientView: BackgroundGradientView = BackgroundGradientView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "История"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupGradientBackground()
        roundedCornersView()
        
        setupGradientNavigationBar()
        
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientView.frame = view.frame
    }
    
    /// Установка фона View в Градиент
    private func setupGradientBackground() {
        gradientView.startColor = ThemeManager.Color.startGradientColor
        gradientView.endColor = ThemeManager.Color.endGradientColor
        self.view.addSubview(gradientView)
    }
    
    /// Скругление Container View
    private func roundedCornersView() {
        containerView.backgroundColor = ThemeManager.Color.backgroundColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(containerView)
        containerView.setPosition(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        containerView.roundCorners(cornerRadius: ThemeManager.Corner.containerViewCornerRadius)
    }
    
    /// Установка градиента для NavigationBar
    
    private func setupGradientNavigationBar() {
        if let navigationBar = self.navigationController?.navigationBar {
            let gradient = CAGradientLayer()
            var bounds = navigationBar.bounds
            var statusBarHeight: CGFloat = 0.0
            
            if #available(iOS 13.0, *) {
                let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
                statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
            } else {
                statusBarHeight = UIApplication.shared.statusBarFrame.height
            }
            
            bounds.size.height += statusBarHeight
            
            gradient.frame = bounds
            gradient.colors = [ThemeManager.Color.startGradientColor.cgColor, ThemeManager.Color.endGradientColor.cgColor]
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 0, y: 0.7)
            
            if let image = getImageFrom(gradientLayer: gradient) {
                navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
            }
        }
    }
    
    /// Получение объекта UIImage из CAGradientLayer
    private func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
    
    // MARK: - Работа с таблицей
    /// Установка UITableView
    private func setupTableView() {
        tableView.contentInset.top = ConstraintsManager.InboxModule.InboxTableView.topInset
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        view.addSubview(tableView)
        
        setupConstraints()
        
        tableView.register(InboxTableViewCell.self, forCellReuseIdentifier: InboxTableViewCell.reuseId)
        
        tableView.register(FooterTableViewCell.self, forCellReuseIdentifier: FooterTableViewCell.reuseId)
    }
    
    /// Установка Constraint для UITableView
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.setPosition(top: view.topAnchor,
                              left: view.leftAnchor,
                              bottom: view.bottomAnchor,
                              right: view.rightAnchor,
                              paddingTop: 0,
                              paddingLeft: 0,
                              paddingBottom: 0,
                              paddingRight: 0,
                              width: 0,
                              height: 0)
    }
    
    private func setupHeaderView(date: String) -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        
        let title: UILabel = UILabel(frame: CGRect(x: 16, y: 4, width: tableView.frame.size.width, height: 14))
        
        title.font = UIFont.systemFont(ofSize: 12)
        title.text = date
        title.textColor = ThemeManager.Color.subtitleColor
        
        headerView.addSubview(title)
        
        return headerView
    }
}

// MARK: - Data Source Extension
extension InboxVС: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return demoHistory.generateFirstSection().count
        case 1:
            return demoHistory.generateSecondSection().count
        case 2:
            return demoHistory.generateThirdSection().count + 1
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 2 && indexPath.row == demoHistory.generateThirdSection().count {
            let cell = tableView.dequeueReusableCell(withIdentifier: FooterTableViewCell.reuseId, for: indexPath) as! FooterTableViewCell
            return cell
        } else if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: InboxTableViewCell.reuseId, for: indexPath) as! InboxTableViewCell
            
            let firstSection = demoHistory.generateFirstSection()
            
            cell.operationTypeLabel.text = firstSection[indexPath.row].operation
            cell.nameLabel.text = firstSection[indexPath.row].name
            cell.time.text = firstSection[indexPath.row].date
            
            return cell
            
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: InboxTableViewCell.reuseId, for: indexPath) as! InboxTableViewCell
            
            let secondSection = demoHistory.generateSecondSection()
            
            cell.operationTypeLabel.text = secondSection[indexPath.row].operation
            cell.nameLabel.text = secondSection[indexPath.row].name
            cell.time.text = secondSection[indexPath.row].date
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: InboxTableViewCell.reuseId, for: indexPath) as! InboxTableViewCell
            
            let thirdSection = demoHistory.generateThirdSection()
            
            cell.operationTypeLabel.text = thirdSection[indexPath.row].operation
            cell.nameLabel.text = thirdSection[indexPath.row].name
            cell.time.text = thirdSection[indexPath.row].date
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return setupHeaderView(date: "Сегодня")
        } else if section == 1 {
            return setupHeaderView(date: "21 декабря")
        } else {
            return setupHeaderView(date: "20 декабря")
        }
    }
}

extension InboxVС: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 14
    }
}
