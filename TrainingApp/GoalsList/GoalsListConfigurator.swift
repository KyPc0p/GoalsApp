//
//  GoalsListConfigurator.swift
//  TrainingApp
//
//  Created by Артём Харченко on 24.07.2022.
//

import Foundation

protocol GoalsListConfiguratorInputProtocol {
    func configure(with view: GoalsListViewController)
}

class GoalsListConfigurator: GoalsListConfiguratorInputProtocol {
    func configure(with view: GoalsListViewController) {
        let presenter = GoalsListPresenter(view: view)
        let interactor = GoalsListInteractor(presenter: presenter)
        
        view.presenter = presenter
        presenter.interactor = interactor
    }
    
    
}
