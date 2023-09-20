//
//  UserDefaultsToDoStore.swift
//  SampleCRUD
//
//  Created by Lee Sam on 2023/09/07.
//

import Foundation

final class UserDefaultsToDoStore {
    
    private let userDefault = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "toDoKey"
    
    // 유저디폴트 생성..
    
    init() {}
    
    // 배열..?
    
    func add(_ todo: ToDo) {
        guard let data = try? encoder.encode(todo) else { return }
        userDefault.set(data, forKey: key)
    }
    
    //
    
    func load() -> ToDo? {
        guard let data = userDefault.data(forKey: key) else { return .none }
        
        guard let todo = try? decoder.decode(ToDo.self, from: data) else { return .none }
        return todo
    }
}
