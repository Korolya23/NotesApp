//
//  Model.swift
//  NotesApp
//
//  Created by Artem on 10.01.25.
//

import Foundation
import UserNotifications

var notesApp: [[String: Any]] {
    set {
        UserDefaults.standard.setValue(newValue, forKey: "NotesKey")
        UserDefaults.standard.synchronize()
    }
    
    get {
        if let keyForNotes = UserDefaults.standard.array(forKey: "NotesKey") as? [[String: Any]] {
            return keyForNotes
        } else {
            return []
        }
    }
}

func addItem(nameItem: String, status: Bool = false) {
    notesApp.append(["Name": nameItem, "Status": false])
    
    completedTaskBadge()
}

func removeItem(index: Int) {
    notesApp.remove(at: index)
    
    completedTaskBadge()
}

func changeStatus(item: Int) -> Bool {
    notesApp[item]["Status"] = !(notesApp[item]["Status"] as! Bool)
    
    completedTaskBadge()
    
    return notesApp[item]["Status"] as! Bool
}

func moveRow(fromIndex: Int, toIndex: Int) {
    let movedNote = notesApp[fromIndex]
    notesApp.remove(at: fromIndex)
    notesApp.insert(movedNote, at: toIndex)
}

func requestForNotification() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { isEnabled, error in }
}

func completedTaskBadge() {
    var quantityBadge = 0
    for task in notesApp {
        if task["Status"] as? Bool == false {
            quantityBadge = quantityBadge + 1
        }
    }
    UNUserNotificationCenter.current().setBadgeCount(quantityBadge)
}
