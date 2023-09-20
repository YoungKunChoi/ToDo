//
//  ToDoViewController.swift
//  SampleCRUD
//
//  Created by Lee Sam on 2023/09/07.
//

import UIKit

final class ToDoViewController: UIViewController {
    //class ToDoViewController 선언. final? 다른클래스에서 상속불가. 하면 private은 왜 씀?
    
    private var tableData: [ToDo] = [] {
        //private? tableData라는 변수는 class ToDoViewController 에서만 사용가능. 다른 객체들 사용불가?
        didSet { tableView.reloadData() }
    }
    //didSet? 옵저버?
    
    private let todoStore = UserDefaultsToDoStore()
    //UserDefaultsToDoStore 함수를 () 실행하는 let todoStore는 private 접근제어 다른객체에서는 사용불가?
    
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet 테이블뷰 코드로 연결
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        updateTableData()
    }
    //override func viewDidLoad() 어디서 가져오는거지? UIKit? 내장함수?
    //super.viewDidLoad() 가져온거 실행
    //tableView안에 내장되있는 것중 .하나 dataSource를 실행할게 = self는 무엇?
    
    @IBAction func didTapAddButton() {
        let newTodo = ToDo(title: "a title", date: Date())
        //let newnew = ToDo(from: <#T##Decoder#>)
        add(newTodo)
        updateTableData()
    }
    //@IBAction func didTapAddButton() 버튼을 액션으로 코드에 연결
    //여기서 자동완성은 ToDo파일에 미리 만들어놓은 구조체를 활용
    
    
    
    
    private func add(_ todo: ToDo) {
        todoStore.add(todo)
    }
    //private func add(_ todo: ToDo) add함수생성 파리미터생략 매서드는 todo
    
    private func updateTableData() {
        guard let todo = todoStore.load() else { return }
        tableData.append(todo)
    }
}

extension ToDoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableData.count
    }
    // ? extension 확장시켜서 ToDoViewController를 가져왔고 tableView를 생성?
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let cellData = tableData[indexPath.row]
        cell.textLabel?.text = cellData.title
        return cell
    }
    // ?
}
