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
        return label
    }()
    lazy var artistName: UILabel = {
        let label = UILabel()
        label.text = "Artist Name"
        label.textColor = .systemRed
        return label
    }()
    lazy var cover: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleToFill
        return imageView
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
        cover.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(218)
            make.width.equalTo(241)
        }
        albumName.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(212)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
        }
        artistName.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(242)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
        }
    }
    
}
