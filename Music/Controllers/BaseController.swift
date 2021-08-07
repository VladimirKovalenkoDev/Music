//
//  BaseController.swift
//  Music
//
//  Created by Владимир Коваленко on 17.03.2021.
//

import UIKit
import SnapKit
class BaseController: UIViewController {
    public let spinner = UIActivityIndicatorView(style: .medium)
    public lazy var navigation: UIView =  {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9354471564, green: 0.9298860431, blue: 0.9397215843, alpha: 1)
        return view
    }()
    public lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action:  #selector(goBackPressed), for: .touchUpInside)
        return button
    }()
    public lazy var navName: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    public lazy var loading: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto", size: 25)
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    private func setUpNavView(){
        view.addSubview(navigation)
        navigation.addSubview(navName)
        navigation.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.height.equalTo(88)
        }
        navName.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    @objc func goBackPressed(_ sender: UIButton!){
        navigationController?.popViewController(animated: true)
    }
}
