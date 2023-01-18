//
//  ViewController.swift
//  ExpandableCell
//
//  Created by 소하 on 2023/01/17.
//

import UIKit

class ViewController: UIViewController {
    // TableView
    @IBOutlet weak var phoneTable: UITableView!
    
    // 전화번호부 데이터
    let dataList:[UserData] = [
        UserData(name: "김하나", category: .Friend, phone: "010-1111-1111"),
        UserData(name: "이두울", category: .Family, phone: "010-2222-2222"),
        UserData(name: "박세엣", category: .Coworker, phone: "010-3333-3333"),
        UserData(name: "윤네엣", category: .Friend, phone: "010-4444-4444"),
        UserData(name: "김다섯", category: .Family, phone: "010-5555-5555"),
        UserData(name: "이여섯", category: .Friend, phone: "010-6666-6666"),
        UserData(name: "박일곱", category: .Family, phone: "010-7777-7777"),
        UserData(name: "김여덟", category: .Friend, phone: "010-8888-8888"),
        UserData(name: "이아홉", category: .Coworker, phone: "010-9999-9999"),
        UserData(name: "박여얼", category: .Friend, phone: "010-0000-0000")
    ]
    // 카테고리 데이터
    let categoryList:[Category] = [
        .Family,
        .Friend,
        .Coworker
    ]
    // 열린 셀 정보
    var openedIndex:IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TableView 설정
        phoneTable.dataSource = self
        phoneTable.delegate = self
        // Custom Cell 등록
        registerCell()
        // TableView UI 세팅
        phoneTable.separatorInsetReference = .fromCellEdges
        phoneTable.separatorInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        phoneTable.sectionHeaderTopPadding = 18
    }
    
    private func registerCell() {
        // Nib 등록
        phoneTable.register(UINib(nibName: "ExpandableCell", bundle: nil), forCellReuseIdentifier: "ExpandableCell")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // 섹션 수
    func numberOfSections(in: UITableView) -> Int {
        return categoryList.count
    }
    // 섹션 당 행 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = categoryList[section]
        // 해당 카테고리에 부합하는 행의 수
        let count = dataList.filter({$0.category == category}).count
        // 열린 셀이 있을 경우
        if let openedIndex = openedIndex {
            // 열린 셀의 섹션에 해당하는 경우엔 행을 하나 더 추가한다
            return openedIndex.section == section ? count + 1 : count
        }
        return count
    }
    // 셀 정보
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableCell", for: indexPath) as? ExpandableCell else {
            return UITableViewCell()
        }
        // 셀 설정을 위한 인덱스
        var index = indexPath
        var isExpand = false
        // 셀 상태 체크
        if let openedIndex = openedIndex { // 열려 있는 셀이 존재
            if index.section == openedIndex.section && index.row > openedIndex.row {
                if index.row == openedIndex.row + 1 {
                    isExpand = true
                }
                index = IndexPath(row: index.row-1, section: index.section)
            }
        }
        let category = categoryList[index.section]
        let item = dataList.filter({ $0.category == category })[index.row]
        cell.inputCell(isExpand: isExpand, name: item.name, phone: item.phone)
        return cell
    }
    // 행 선택 시 이벤트
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //선택 된 셀을 열린 인덱스로 지정
        openedIndex = openedIndex == nil ? indexPath : nil
        tableView.reloadData()
    }
    //MARK: - Size
    // 행 높이
    func tableView(_ tableView: UITableView, heightForRowAt: IndexPath) -> CGFloat {
        return 45
    }
    // 헤더 높이
    func tableView(_ tableView: UITableView, heightForHeaderInSection: Int) -> CGFloat {
        return 60
    }
    //푸터 높이
    func tableView(_ tableView: UITableView, heightForFooterInSection: Int) -> CGFloat {
        return 18
    }
    
    //MARK: - Custom
    // 커스텀 헤더
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        headerView.backgroundColor = .lightGray.withAlphaComponent(0.1)
        let labelHeader = UILabel(frame: CGRect(x: 18, y: 15, width: 300, height: 45))
        let category = categoryList[section]
        labelHeader.text = category.rawValue
        labelHeader.font = UIFont.boldSystemFont(ofSize: 18)
        labelHeader.textColor = .black
        headerView.addSubview(labelHeader)
        return headerView
    }
    //커스텀 푸터
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 18))
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 9))
        footerView.addSubview(lineView)
        lineView.backgroundColor = .lightGray.withAlphaComponent(0.1)
        return footerView
    }
}

