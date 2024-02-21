//
//  LoginViewController.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import SwiftKeychainWrapper
class LoginViewController : UIViewController {
    private let disposeBag = DisposeBag()
    private let loginViewModel = LoginViewModel(loginService: LoginService())
    //로고 이미지
    private let logo : UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "LogoShadow")
        return view
    }()
    //로딩인디케이터
    private let loadingIndicator : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = .gray
        view.style = .large
        return view
    }()
    //아이디
    private let idText : UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.placeholder = "학번 (ID No.)"
        text.textColor = .black
        text.textAlignment = .center
        text.font = UIFont.boldSystemFont(ofSize: 15)
        text.layer.cornerRadius = 10
        text.layer.borderColor = UIColor.lightGray.cgColor
        text.layer.borderWidth = 1
        return text
    }()
    //비밀번호 뷰
    private let passwordView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    //비밀번호
    private let passwordText : UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.placeholder = "비밀번호 (Password)"
        text.isSecureTextEntry = true
        text.textColor = .black
        text.textAlignment = .right
        text.font = UIFont.boldSystemFont(ofSize: 15)
        return text
    }()
    //비밀번호 보이기
    private let passwordShow : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setImage(UIImage(systemName: "lock"), for: .normal)
        btn.tintColor = .black
        btn.snp.makeConstraints { make in make.width.height.equalTo(30) }
        return btn
    }()
    //비밀번호 찾기 버튼
    private let findBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("비밀번호를 잊으셨나요?", for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(.pointColor, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.backgroundColor = .white
        return btn
    }()
    //로그인버튼
    private let loginBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign in", for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = .pointColor
        return btn
    }()
    //아이디 일치 여부
    private let confirmText : UITextField = {
        let text = UITextField()
        text.text = ""
        //학번 또는 비밀번호가 일치하지 않습니다.
        text.textAlignment = .center
        text.font = UIFont.boldSystemFont(ofSize: 15)
        text.textColor = .pointColor
        return text
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setLayout()
        setBinding()
    }
}
//MARK: - 오토레이아웃
extension LoginViewController {
    func setLayout() {
        self.view.addSubview(logo)
        self.view.addSubview(loadingIndicator)
        self.view.addSubview(idText)
        passwordView.addSubview(passwordText)
        passwordView.addSubview(passwordShow)
        passwordText.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(0)
            make.width.equalToSuperview().dividedBy(1.5)
        }
        passwordShow.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(0)
            make.leading.equalTo(passwordText.snp.trailing).offset(0)
        }
        self.view.addSubview(passwordView)
        self.view.addSubview(findBtn)
        self.view.addSubview(loginBtn)
        self.view.addSubview(confirmText)
        
        logo.snp.makeConstraints { make in
            make.center.equalToSuperview().offset(-60)
            make.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(200)
        }
        loadingIndicator.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(0)
            make.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(30)
        }
        idText.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
            make.top.equalTo(loadingIndicator.snp.bottom).offset(0)
        }
        passwordView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
            make.top.equalTo(idText.snp.bottom).offset(20)
        }
        findBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalTo(passwordText.snp.bottom).offset(20)
            make.height.equalTo(20)
        }
        loginBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(60)
            make.top.equalTo(findBtn.snp.bottom).offset(30)
        }
        confirmText.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(20)
            make.top.equalTo(loginBtn.snp.bottom).offset(10)
        }
    }
}
//MARK: - 바인딩
extension LoginViewController {
    func setBinding() {
        passwordShow.rx.tap
            .subscribe(onNext: {[weak self] in
                guard let self = self else { return }
                self.passwordText.isSecureTextEntry.toggle()
            })
            .disposed(by: disposeBag)
        loginBtn.rx.tap
            .subscribe(onNext: {[weak self] in
                guard let self = self else { return }
                self.loadingIndicator.startAnimating()
                self.confirmText.text = ""
                self.loginViewModel.inputTrigger.onNext(LoginServiceModel(id: idText.text ?? "", pw: passwordText.text ?? ""))
            })
            .disposed(by: disposeBag)
        findBtn.rx.tap
            .subscribe(onNext: { _ in
                self.loginViewModel.findTrigger.onNext(())
            })
            .disposed(by: disposeBag)
        loginViewModel.outputResult
            .subscribe(onNext: { [weak self] loginModel in
                guard let self = self else { return }
                print("로그인 성공 : \(loginModel)")
                // 로그인 성공 시 다음 화면으로 이동
                if loginModel.status == 200 {
                    if let accessToken = loginModel.result?.accessToken, let refreshToken = loginModel.result?.refreshToken, let majorId = loginModel.result?.majorId, let majorName = loginModel.result?.majorName, let role = loginModel.result?.role, let userId = loginModel.result?.userId{
                        KeychainWrapper.standard.set(accessToken, forKey: "JWTaccessToken")
                        KeychainWrapper.standard.set(refreshToken, forKey: "JWTrefreshToken")
                        UserDefaults.standard.setValue(majorId, forKey: "majorId")
                        UserDefaults.standard.setValue(majorName, forKey: "majorName")
                        UserDefaults.standard.setValue(role, forKey: "role")
                        UserDefaults.standard.setValue(userId, forKey: "userId")
                        self.loadingIndicator.stopAnimating()
                        self.navigationController?.pushViewController(TabBarViewController(), animated: true)
                        self.confirmText.text = ""
                    } else {
                        print("로그인 JWT토큰 - error")
                    }
                }
            })
            .disposed(by: disposeBag)
        loginViewModel.errorOccured
            .subscribe(onNext: { error in
                self.confirmText.text = "학번 또는 비밀번호가 맞지 않습니다."
                self.idText.text = ""
                self.passwordText.text = ""
                self.loadingIndicator.stopAnimating()
            })
            .disposed(by: disposeBag)
    }
}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
