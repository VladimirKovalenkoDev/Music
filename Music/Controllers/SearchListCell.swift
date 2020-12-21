//
//  SearchListCell.swift
//  Music
//
//  Created by Владимир Коваленко on 21.12.2020.
//

import UIKit

class SearchListCell: UICollectionViewCell {
    static let id = "SearchListCell"
    let albumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .cyan
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let albumName: UILabel = {
        let label = UILabel()
        label.text = "Album Name"
        return label
    }()
    let artistName: UILabel = {
        let label = UILabel()
        label.text = "Artist Name"
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
        layer.borderWidth = 0

        albumImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
