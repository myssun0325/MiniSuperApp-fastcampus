//
//  CardOnFileDashboardBuilder.swift
//  MiniSuperApp
//
//  Created by YoungsunMoon on 2022/03/06.
//

import ModernRIBs

protocol CardOnFileDashboardDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var cardsOnfFileRepository: CardOnFileRepository { get }
}

final class CardOnFileDashboardComponent: Component<CardOnFileDashboardDependency>, CardOnFileDashboardInteractorDependency {
    
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    var cardsOnfFileRepository: CardOnFileRepository { dependency.cardsOnfFileRepository }
}

// MARK: - Builder

protocol CardOnFileDashboardBuildable: Buildable {
    func build(withListener listener: CardOnFileDashboardListener) -> CardOnFileDashboardRouting
}

final class CardOnFileDashboardBuilder: Builder<CardOnFileDashboardDependency>, CardOnFileDashboardBuildable {
    
    override init(dependency: CardOnFileDashboardDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: CardOnFileDashboardListener) -> CardOnFileDashboardRouting {
        let component = CardOnFileDashboardComponent(dependency: dependency)
        let viewController = CardOnFileDashboardViewController()
        let interactor = CardOnFileDashboardInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        return CardOnFileDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
