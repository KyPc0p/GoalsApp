//
//  GoalsListViewController.swift
//  TrainingApp
//
//  Created by Артём Харченко on 24.07.2022.
//

import Foundation

import UIKit

protocol GoalsListViewControllerInputProtocol: AnyObject {
    func setGoals(with goals: [String])
}

protocol GoalsListViewControllerOutputProtocol {
    init(view: GoalsListViewController)
    func viewDidLoad()
}

class GoalsListViewController: UITableViewController {

    var goals: [String] = []
    
    var presenter: GoalsListViewControllerOutputProtocol!
    private let configarator: GoalsListConfiguratorInputProtocol = GoalsListConfigurator()
    
    @IBOutlet weak var addGoalButton: UIBarButtonItem!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configarator.configure(with: self)
        presenter.viewDidLoad()

    }
    
 //MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        goals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let goal = goals[indexPath.row]
    
        var content = cell.defaultContentConfiguration()
        content.text = goal
        cell.contentConfiguration = content
        
        return cell
    }
    
// MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
// MARK: - GoalsListViewControllerInputProtocol
extension GoalsListViewController: GoalsListViewControllerInputProtocol {
    func setGoals(with goals: [String]) {
        self.goals = goals
    }
}
