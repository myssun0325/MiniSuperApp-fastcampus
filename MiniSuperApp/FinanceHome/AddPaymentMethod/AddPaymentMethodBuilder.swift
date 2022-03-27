//
//  AddPaymentMethodBuilder.swift
//  MiniSuperApp
//
//  Created by mason on 2022/03/22.
//

import ModernRIBs

protocol AddPaymentMethodDependency: Dependency {
    var cardOnFileRepository: CardOnFileRepository { get }
}

final class AddPaymentMethodComponent: Component<AddPaymentMethodDependency>, AddPaymentMethodInteractorDependency {
    var cardOnFileRepository: CardOnFileRepository { dependency.cardOnFileRepository }
}

// MARK: - Builder

protocol AddPaymentMethodBuildable: Buildable {
    func build(withListener listener: AddPaymentMethodListener, closeButtonType: DismissButtonType) -> AddPaymentMethodRouting
}

final class AddPaymentMethodBuilder: Builder<AddPaymentMethodDependency>, AddPaymentMethodBuildable {

    override init(dependency: AddPaymentMethodDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: AddPaymentMethodListener, closeButtonType: DismissButtonType) -> AddPaymentMethodRouting {
        let component = AddPaymentMethodComponent(dependency: dependency)
        let viewController = AddPaymentMethodViewController(closeButtonType: closeButtonType)
        let interactor = AddPaymentMethodInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return AddPaymentMethodRouter(interactor: interactor, viewController: viewController)
    }
}
