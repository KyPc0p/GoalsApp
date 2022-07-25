//
//  GoalsListInteractor.swift
//  TrainingApp
//
//  Created by Артём Харченко on 24.07.2022.
//

import Foundation

protocol GoalsListInteractorInputProtocol {
    init(presenter: GoalsListInteractorOututProtocol)
    func fetchGoals()
}

protocol GoalsListInteractorOututProtocol: AnyObject {
    func goalsDidRecieve(with goals: GoalsDataStore)
}

class GoalsListInteractor: GoalsListInteractorInputProtocol {
    
    unowned private let presenter: GoalsListInteractorOututProtocol
    
    required init(presenter: GoalsListInteractorOututProtocol) {
        self.presenter = presenter
    }
    
    func fetchGoals() {
        let goals = ["Подтянуться","Отжаться"]
        let goalsDataStore = GoalsDataStore(goalsData: goals)
        presenter.goalsDidRecieve(with: goalsDataStore)
        
    }
    
    
    
}
