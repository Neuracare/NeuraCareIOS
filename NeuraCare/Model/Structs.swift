//
//  Structs.swift
//  NeuraCare
//
//  Created by yajurva shrotriya on 11/11/23.
//

import Foundation

struct Message: Codable {
    var id: String
    var transcript: String
}


struct Todo: Codable {
    var id: String
    var query: String
}

struct TodoItem: Codable{
    var date: String
    var time: Int
    var title: String
}

struct patientData: Codable{
    var id: String
    var respiratoryRate: Int
    var location: [String:Double]
    var heartRate: Int
    var bloodOxygen: Int
    
}

struct summary: Codable{
    var text: [String]
}
