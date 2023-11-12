//
//  HealthKit.swift
//  NeuraCare
//
//  Created by yajurva shrotriya on 11/12/23.
//

import Foundation
import HealthKit



class HealthKitData{
    
    public let healthStore = HKHealthStore()
    public var respiratoryRateData: Int = 0
    public var bloodOxygenData: Int = 0
    public var heartRateData: Int = 0
    var timer: Timer?
    
    public func requestHealthKitAuthorization() {
        // Specify the types of data you want to read
        let typesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.quantityType(forIdentifier: .respiratoryRate)!,
            HKObjectType.quantityType(forIdentifier: .oxygenSaturation)!,
            // Add more types as needed
        ]

        // Request authorization
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { (success, error) in
            if success {
                print("HealthKit authorization granted.")
                // Now you can start reading health data
                    self.readRecentHeartRate()
                    self.readRecentRespiratoryRate()
                    self.readRecentOxygenSaturation()
                
            } else {
                print("HealthKit authorization denied. \(String(describing: error))")
            }
        }
    }
    
    public func readRecentHeartRate() {
        // Specify the type of data to query (heart rate)
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
            print("Heart rate data type not available.")
            return
        }

        // Build the query to get the most recent heart rate sample
        let query = HKSampleQuery(sampleType: heartRateType,
                                  predicate: nil,
                                  limit: 1,
                                  sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)]) { (query, results, error) in
            if let sample = results?.first as? HKQuantitySample {
                // Extract the heart rate value
                let heartRate = sample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
                
                self.heartRateData = Int(heartRate)
                print("Most recent heart rate: \(heartRate) bpm")
            } else {
                print("Error reading heart rate: \(String(describing: error))")
            }
        }

        // Execute the query
        healthStore.execute(query)
    }

    public func readRecentRespiratoryRate() {
        // Specify the type of data to query (respiratory rate)
        guard let respiratoryRateType = HKObjectType.quantityType(forIdentifier: .respiratoryRate) else {
            print("Respiratory rate data type not available.")
            return
        }

        // Build the query to get the most recent respiratory rate sample
        let query = HKSampleQuery(sampleType: respiratoryRateType,
                                  predicate: nil,
                                  limit: 1,
                                  sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)]) { (query, results, error) in
            if let sample = results?.first as? HKQuantitySample {
                // Extract the respiratory rate value
                let respiratoryRate = sample.quantity.doubleValue(for: HKUnit.init(from: "count/min"))
                
                self.respiratoryRateData = Int(respiratoryRate)
                print("Most recent respiratory rate: \(respiratoryRate) breaths per minute")
            } else {
                print("Error reading respiratory rate: \(String(describing: error))")
            }
        }

        // Execute the query
        healthStore.execute(query)
    }

    public func readRecentOxygenSaturation() {
        // Specify the type of data to query (oxygen saturation)
        guard let oxygenSaturationType = HKObjectType.quantityType(forIdentifier: .oxygenSaturation) else {
            print("Oxygen saturation data type not available.")
            return
        }

        // Build the query to get the most recent oxygen saturation sample
        let query = HKSampleQuery(sampleType: oxygenSaturationType,
                                  predicate: nil,
                                  limit: 1,
                                  sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)]) { (query, results, error) in
            if let sample = results?.first as? HKQuantitySample {
                // Extract the oxygen saturation value
                let oxygenSaturation = sample.quantity.doubleValue(for: HKUnit.percent())
                self.bloodOxygenData = Int(oxygenSaturation * 100)
                print("Most recent oxygen saturation: \(oxygenSaturation)%")
            } else {
                print("Error reading oxygen saturation: \(String(describing: error))")
            }
        }

        // Execute the query
        healthStore.execute(query)
    }
}
