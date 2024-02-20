//
//  FeedBackViewController.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class FeedBackViewController : UIViewController {
    private let disposeBag = DisposeBag()
    private let feedBackViewModel = FeedBackViewModel()
    //타이틀
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "피드백 보내기"
        label.textColor = .pointColor
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.backgroundColor = .white
        label.textAlignment = .left
        return label
    }()
    //설명
    private let descriptionLabel : UITextView = {
        let text = UITextView()
        text.text = "앱을 사용하는 중에 불편하신 점이 있으시면, 자유롭게 피드백 해주세요!"
        text.textColor = .gray
        text.textAlignment = .left
        text.font = UIFont.boldSystemFont(ofSize: 15)
        return text
    }()
    //이미지
    private let logoimage : UIImageView = {
        let view = UIImageView(image: UIImage(named: "LogoShadow"))
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFit
        return view
    }()
    //폼 이동 버튼
    private let FormBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("피드백 보내기 >", for: .normal)
        btn.setTitleColor(.pointColor, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setLayout()
        setBinding()
    }
}
//MARK: - 레이아웃
extension FeedBackViewController {
    private func setLayout() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(logoimage)
        self.view.addSubview(FormBtn)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(self.view.frame.height / 8.5)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(30)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(100)
        }
        logoimage.snp.makeConstraints { make in
            make.center.equalToSuperview().offset(-60)
            make.height.equalTo(200)
            make.leading.trailing.equalToSuperview().inset(0)
        }
        FormBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(30)
            make.top.equalTo(logoimage.snp.bottom).offset(150)
        }
    }
}
//MARK: - 바인딩
extension FeedBackViewController {
    private func setBinding() {
        FormBtn.rx.tap
            .subscribe(onNext: { _ in
                self.feedBackViewModel.input.onNext(())
            })
            .disposed(by: disposeBag)
    }
}
