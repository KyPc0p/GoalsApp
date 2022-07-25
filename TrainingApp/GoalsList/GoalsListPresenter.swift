//
//  GoalsListPresenter.swift
//  TrainingApp
//
//  Created by Артём Харченко on 24.07.2022.
//

import Foundation

struct GoalsDataStore {
    let goalsData: [String]
}

class GoalsListPresenter: GoalsListViewControllerOutputProtocol {
    
    unowned private let view: GoalsListViewControllerInputProtocol
    var interactor: GoalsListInteractorInputProtocol!
    
    required init(view: GoalsListViewController) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.fetchGoals()
    }
    
    
}

extension GoalsListPresenter: GoalsListInteractorOututProtocol {
    func goalsDidRecieve(with goals: GoalsDataStore) {
        view.setGoals(with: goals.goalsData)
    }
    
}
