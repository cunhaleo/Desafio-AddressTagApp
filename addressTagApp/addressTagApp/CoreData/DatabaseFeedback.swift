//
//  DatabaseFeedback.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 07/09/25.
//

import UIKit

struct DatabaseFeedback {
    enum AlertType {
        case save
        case delete
        case update
    }
    
    static func alertDatabaseSuccess(type: AlertType) -> UIAlertController {
        var message = ""
        switch type {
        case .save:
            message = "Item salvo."
        case .delete:
            message = "O Item foi apagado."
        case .update:
            message = "O Item foi atualizado."
        }
        let alert = UIAlertController(title: "Sucesso",
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        return alert
    }
    
    static func alertDatabaseFailed(type: AlertType) -> UIAlertController {
        var message = ""
        switch type {
        case .save:
            message = "Não foi possível salvar."
        case .delete:
            message = "Não foi possível apagar."
        case .update:
            message = "Não foi possível atualizar."
        }
        let alert = UIAlertController(title: "Uma falha ocorreu.",
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        return alert
    }
}
