//
//  SearchListCell.swift
//  Music
//
//  Created by Владимир Коваленко on 21.12.2020.
//

import UIKit

class SearchListCell: UICollectionViewCell {
    static let id = "SearchListCell"
    lazy var albumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleToFill
        return imageView
    }()
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
    lazy var advisoryRating: UILabel = {
        let label = UILabel()
        label.text = "advisory"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .systemGray
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)

        setCell()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCell() {
        addSubview(albumImage)
        addSubview(albumName)
        addSubview(artistName)
        addSubview(advisoryRating)
        albumImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
        }
        albumName.snp.makeConstraints { (make) in
            make.top.equalTo(albumImage.snp.bottom)
            make.bottom.equalToSuperview().offset(-25)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        artistName.snp.makeConstraints { (make) in
            make.top.equalTo(albumName.snp.bottom)
            make.height.equalTo(10)
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
        }
        advisoryRating.snp.makeConstraints { (make) in
            make.top.equalTo(artistName.snp.bottom)
            make.height.equalTo(8)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
        }
    }
}
