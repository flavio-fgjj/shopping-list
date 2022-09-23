//
//  RemoteConfigValues.swift
//  ShoppingList
//
//  Created by Usuário Convidado on 22/09/22.
//  Copyright © 2022 FIAP. All rights reserved.
//

import Foundation
import Firebase


class RemoteConfigValues {
    static let shared = RemoteConfigValues()
    private let remoteConfig = RemoteConfig.remoteConfig()

    let defaultMsg = "Copyright \(Calendar.current.component(.year, from: Date()).description) - FIAP"
    var copyrightMessage: String {
        remoteConfig.configValue(forKey: "copyrightMessage").stringValue ?? defaultMsg
    }
    
    private init() {
        loadDefaultValues()
    }
    
    private func loadDefaultValues() {
        let defaultValues: [String: Any] = [
            "copyrightMessage": defaultMsg
        ]
        remoteConfig.setDefaults(defaultValues as? [String: NSObject])
    }
    
    
    
    func fetch() {
        remoteConfig.fetchAndActivate { status, error in
            if let error = error {
                print("Erro ao fazer fetch", error.localizedDescription)
            } else {
                switch status {
                case .error:
                    print("Erro no fetch")
                case .successFetchedFromRemote:
                    print("Atualizou a partir da nuvem")
                case .successUsingPreFetchedData:
                    print("Atualizou com os dados em cache")
                }
            }
        }
    }
}
