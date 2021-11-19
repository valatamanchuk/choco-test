//
//  ChocoSession.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import Locksmith

struct ChocoSession: CreateableSecureStorable, ReadableSecureStorable, DeleteableSecureStorable {
    private static let tokenStorageKey: String = "token"
    private static let sessionUserAccountName: String = "chocoSession"
    
    let token: String
    var data: [String: Any] {
        return [
            ChocoSession.tokenStorageKey: token
        ]
    }
    
    static func currentSession() -> ChocoSession? {
        guard let dictionaryDataForUserAccount = Locksmith.loadDataForUserAccount(userAccount: ChocoSession.sessionUserAccountName) else { return nil }
        guard let token: String = dictionaryDataForUserAccount[ChocoSession.tokenStorageKey] as? String else { return nil }
        return ChocoSession(token: token)
    }
    
    func updateInSecureStore() throws {
        try Locksmith.updateData(data: data, forUserAccount: ChocoSession.sessionUserAccountName)
    }
    
    func createInSecureStore() throws {
        try Locksmith.saveData(data: data, forUserAccount: ChocoSession.sessionUserAccountName)
    }
    
    func deleteFromSecureStore() throws {
        try Locksmith.deleteDataForUserAccount(userAccount: ChocoSession.sessionUserAccountName)
    }
}
