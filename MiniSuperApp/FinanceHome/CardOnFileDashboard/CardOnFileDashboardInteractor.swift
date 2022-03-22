//
//  CardOnFileDashboardInteractor.swift
//  MiniSuperApp
//
//  Created by YoungsunMoon on 2022/03/06.
//

import ModernRIBs
import Combine

protocol CardOnFileDashboardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol CardOnFileDashboardPresentable: Presentable {
    var listener: CardOnFileDashboardPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    
    func update(with viewModels: [PaymentMethodViewModel])
}

protocol CardOnFileDashboardListener: AnyObject {
    func cardOnFileDashboardDidTapAddPaymentMethod()
}

protocol CardOnFileDashboardInteractorDependency {
    var cardOnFileRepository: CardOnFileRepository { get }
}

final class CardOnFileDashboardInteractor: PresentableInteractor<CardOnFileDashboardPresentable>, CardOnFileDashboardInteractable, CardOnFileDashboardPresentableListener {

    weak var router: CardOnFileDashboardRouting?
    weak var listener: CardOnFileDashboardListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
   
    private let dependency: CardOnFileDashboardInteractorDependency
    
    private var cancellables: Set<AnyCancellable>
    
    init(presenter: CardOnFileDashboardPresentable,
         dependency: CardOnFileDashboardInteractorDependency) {
        self.dependency = dependency
        self.cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        
        dependency.cardOnFileRepository.cardOnFile.sink { methods in
            let viewModels = methods.prefix(3).map(PaymentMethodViewModel.init)
            self.presenter.update(with: viewModels)
        }.store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
        
        // sink 클로져안에서 [weak self]를 해주지 않아서 쓰는 코드
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    func didTapAddPaymentMethod() {
        // 강사: CardOnFileDashboard는 화면에 극히 일부분만 담당하기 때문에 홈화면 전체를 담당하는 FinanceHome에서 띄우는게 합리적
        listener?.cardOnFileDashboardDidTapAddPaymentMethod()
    }
}
