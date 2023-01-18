//
//  ExpandableCell.swift
//  ExpandableCell
//
//  Created by 소하 on 2023/01/17.
//

import UIKit

class ExpandableCell: UITableViewCell {
    // 각각의 셀 뷰
    @IBOutlet weak var defaultView: UIView!
    @IBOutlet weak var ExpandedView: UIView!
    //
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var btnArrow: UIButton!
    @IBOutlet weak var labelPhone: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func initUI() {
        // 폰트 및 색상 설정
        labelName.font = UIFont.systemFont(ofSize: 15)
        labelName.textColor = .black
        labelPhone.font = UIFont.systemFont(ofSize: 15)
        labelPhone.textColor = .black
        // 화살표 이미지 및 기타 설정
        btnArrow.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        btnArrow.tintColor = .black
        btnArrow.contentMode = .center
        btnArrow.isUserInteractionEnabled = false
    }
    
    func inputCell(isExpand:Bool, name:String, phone:String) {
        // 셀 종류에 따른 컨트롤
        controllCell(isExpand: isExpand)
        // 텍스트 입력
        labelName.text = name
        labelPhone.text = phone
    }
    
    private func controllCell(isExpand:Bool) {
        defaultView.isHidden = isExpand
        ExpandedView.isHidden = !isExpand
    }
}
