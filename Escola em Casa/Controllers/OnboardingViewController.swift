//
//  OnboardingViewController.swift
//  Escola em Casa
//
//  Created by Miguel Pimentel on 04/10/20.
//  Copyright © 2020 Laércio Silva de Sousa Júnior. All rights reserved.
//

import UIKit
import SnapKit
import paper_onboarding

class OnboardingViewController: UIViewController {

    // MARK: - Properties

    lazy var onboardingView: OnboardingView = {
        let view = OnboardingView()
        view.delegate = self
        view.dataSource = self

        return view
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }

    // MARK: - Privete Methods

    private func setupLayout() {
        setupView()
        setupConstraints()

    }

    private func setupView() {
        view.addSubview(onboardingView)
        setupConstraints()
    }

    private func setupConstraints() {
        onboardingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension OnboardingViewController: PaperOnboardingDelegate { }

extension OnboardingViewController: PaperOnboardingDataSource {

    func onboardingItemsCount() -> Int {
        return 3
    }

    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return OnboardingItemInfo(
            informationImage: UIImage(),
            title: "Teste 1",
            description: "Some random description",
            pageIcon: UIImage(),
            color: .darkGray,
            titleColor: .green,
            descriptionColor: .red,
            titleFont: UIFont(descriptor: UIFontDescriptor(), size: 20),
            descriptionFont: UIFont(descriptor: UIFontDescriptor(), size: 16)
        )
    }
}
