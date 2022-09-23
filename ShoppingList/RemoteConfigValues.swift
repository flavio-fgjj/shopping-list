//
//  RemoteConfigValues.swift
//  ShoppingList
//
//  Created by Usuário Convidado on 22/09/22.
//  Copyright © 2022 FIAP. All rights reserved.
//

import Foundation
import Firebase
import GameController


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
        remoteConfig.fetch(withExpirationDuration: 1.0) { status, error in
            if let error = error {
                print("Erro ao fazer fetch", error.localizedDescription)
            } else {
                switch status {
                case .failure:
                    print("Erro no fetch")
                case .noFetchYet:
                    print("Não fez o fetch")
                case .throttled:
                    print("Ainda não deu 12 minutos")
                case .success:
                    print("Agora deve ir")
                    self.remoteConfig.activate()
                default:
                    print("Status desconhecido")
                }
                
            }
        }
    }
}
