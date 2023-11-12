//
//  HTTP.swift
//  NeuraCare
//
//  Created by yajurva shrotriya on 11/11/23.
//

import Foundation

class HTTP {
    private static var apiDomain = "https://backend.neuracare.tech/patient/todo"
    
    public static func createSpeechText(id: String, transcript: String) -> Data?{
        let codableMessage = Message(id: id, transcript: transcript)
        
        do {
            let encodedData = try JSONEncoder().encode(codableMessage)
            return encodedData
        } catch{
            return nil
        }
        
    }
    
    
    public static func createTodo(id: String, query: String) -> Data?{
        
        let codableMessage = Todo(id: id, query: query)
        
        do {
            let encodedData = try JSONEncoder().encode(codableMessage)
            return encodedData
        } catch{
            return nil
        }
    }
    
    
    public static func createPatientData(id: String, respiratoryRate: Int, location: [String:Double], heartRate: Int, bloodOxygen: Int)-> Data?{
        
        let codableMessage = patientData(id: id, respiratoryRate: respiratoryRate, location: location, heartRate: heartRate, bloodOxygen: bloodOxygen)
        
        do {
            let encodedData = try JSONEncoder().encode(codableMessage)
            return encodedData
        } catch{
            return nil
        }
        
    }
    
    
    
    
}
