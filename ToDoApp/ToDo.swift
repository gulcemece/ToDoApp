/*
 See LICENSE folder for this sample’s licensing information.
 */

import Foundation

struct ToDo {
    var title: String
    var noteList: [Note]? = nil
    
}

struct Note {
    var noteText: String
    var isComplete: Bool = false
}

struct ToDoManager {
    static var mainData:[ToDo] = []
}

//#if DEBUG
//extension ToDo {
//    static var xx = [
//        ToDo(
//            title: "Submit reimbursement report", dueDate: Date().addingTimeInterval(800.0),
//            notes: ["Don't forget about taxi receipts.Don't forget about taxi receipts.Don't forget about taxi receipts"]),
//        ToDo(
//            title: "Code review", dueDate: Date().addingTimeInterval(14000.0),
//            notes: ["Check tech specs in shared folder"], isComplete: true),
//        ToDo(
//            title: "Pick up new contacts", dueDate: Date().addingTimeInterval(24000.0),
//            notes: ["Optometrist closes at 6:00PM"]),
//        ToDo(
//            title: "Add notes to retrospective", dueDate: Date().addingTimeInterval(3200.0),
//            notes: ["Collaborate with project manager"], isComplete: true),
//        ToDo(
//            title: "Interview new project manager candidate",
//            dueDate: Date().addingTimeInterval(60000.0), notes: ["Review portfolio"]),
//        ToDo(
//            title: "Mock up onboarding experience", dueDate: Date().addingTimeInterval(72000.0),
//            notes: ["Think different"]),
//        ToDo(
//            title: "Review usage analytics", dueDate: Date().addingTimeInterval(83000.0),
//            notes: ["Discuss trends with management"]),
//        ToDo(
//            title: "Confirm group reservation", dueDate: Date().addingTimeInterval(92500.0),
//            notes: ["Ask about space heaters"]),
//        ToDo(
//            title: "Add beta testers to TestFlight", dueDate: Date().addingTimeInterval(101000.0),
//            notes: ["v0.9 out on Friday", "xxxxxx", "yyyyyy"])
//    ]
//}
//#endif
