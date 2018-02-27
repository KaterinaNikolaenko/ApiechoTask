//
//  MainViewController.swift
//  ApiechoTask
//
//  Created by Katerina on 27.02.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //UI
    let tableView = UITableView()
    
    //Data Source
    var mainViewModel = MainViewModel()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setTableView()
        
        tableView.dataSource = self
        mainViewModel.getText { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - Private

extension MainViewController  {
    
    fileprivate func setUI() {
        self.title = "Character in the text"
        
        let logOutUIBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(logOutButtonAction))
        self.navigationItem.rightBarButtonItem  = logOutUIBarButtonItem

    }
    
    @objc func logOutButtonAction(){

        UserDefaults.standard.removeObject(forKey: "accessToken")
        self.dismiss(animated: true, completion: nil)
//        let logInViewController = LogInViewController()
//        logInViewController.view.backgroundColor = .white
//        logInViewController.isSignIn = true
//        self.present(logInViewController, animated: true, completion: nil)
    }
    
    fileprivate func setTableView() {
        
        tableView.frame = CGRect(x: 0, y: 50, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewModel.itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell
        cell.textLabel?.text = mainViewModel.itemsArray[indexPath.row]
        return cell
    }
}
