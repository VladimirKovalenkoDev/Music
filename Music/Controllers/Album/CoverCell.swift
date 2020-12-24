//
//  RecordCompanyCell.swift
//  Music
//
//  Created by Владимир Коваленко on 22.12.2020.
//

import UIKit

class CoverCell: UITableViewCell {
    static let reuseIdentifier = "CoverCell"
    lazy var albumName: UILabel = {
        let label = UILabel()
        label.text = "Album Name"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    lazy var artistName: UILabel = {
        let label = UILabel()
        label.text = "Artist Name"
        label.textAlignment = .center
        label.textColor = .systemRed
        return label
    }()
    lazy var cover: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    lazy var advisoryRating: UILabel = {
        let label = UILabel()
        label.text = "advisory"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .systemGray
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpElements()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpElements(){
        addSubview(cover)
        addSubview(albumName)
        addSubview(artistName)
        addSubview(advisoryRating)
        cover.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(218)
            make.width.equalTo(241)
        }
        albumName.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(212)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(241)
        }
        artistName.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(250)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
            make.width.equalTo(241)
        }
        advisoryRating.snp.makeConstraints { (make) in
            make.top.equalTo(artistName.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
    }
    
}
