//
//  VarStore.swift
//  BLOO
//
//  Created by Caroline Umila on 4/19/22.
//

import SwiftUI
import UIKit
import Combine

final class VarStore: ObservableObject {
    
    init() {
        UserDefaults.standard.register(defaults: [
            "view.preferences.numOfHives": 3.0,
            "view.preferences.AGE": 0,
            "view.preferences.SEBB": 0,
            "view.preferences.TLOW": 0,
            "view.preferences.TMED": 0,
            "view.preferences.THIGH": 0,
            "view.preferences.GLOW": 0,
            "view.preferences.GMED": 0,
            "view.preferences.GHIGH": 0,
            "view.preferences.PEST": 0, // if there are thrips or GM, set to 1, otherwise 0
            "view.preferences.totalAcres": 0.0,
            
            "view.preferences.budgetFixedCosts": 100.00,
            "view.preferences.budgetVariableCosts": 100.00,
            "view.preferences.costPerHive": 0.0,
            "view.preferences.fertilizerCost": 0.0,
            "view.preferences.irrigationCost": 0.0,
            "view.preferences.insecticideCost": 0.0,
            
            "view.preferences.usesPesticides": 0,
            
            "view.preferences.totalProductionCosts": 0.0,
            "view.preferences.yield": 0.0,
            "view.preferences.pricePerLb": 0.00
        ])
    }
    
    @Published var numOfHives: Double = UserDefaults.standard.double(forKey: "view.preferences.numOfHives") {
        didSet {
            UserDefaults.standard.set(numOfHives, forKey: "view.preferences.numOfHives")
        }
    }
    
    @Published var AGE: Double = UserDefaults.standard.double(forKey: "view.preferences.AGE") {
        didSet {
            UserDefaults.standard.set(AGE, forKey: "view.preferences.AGE")
        }
    }
    
    @Published var SEBB: Double = UserDefaults.standard.double(forKey: "view.preferences.SEBB") {
        didSet {
            UserDefaults.standard.set(SEBB, forKey: "view.preferences.SEBB")
        }
    }
    
    @Published var TLOW: Double = UserDefaults.standard.double(forKey: "view.preferences.TLOW") {
        didSet {
            UserDefaults.standard.set(TLOW, forKey: "view.preferences.TLOW")
        }
    }
    
    @Published var TMED: Double = UserDefaults.standard.double(forKey: "view.preferences.TMED") {
        didSet {
            UserDefaults.standard.set(TMED, forKey: "view.preferences.TMED")
        }
    }
    
    @Published var THIGH: Double = UserDefaults.standard.double(forKey: "view.preferences.THIGH") {
        didSet {
            UserDefaults.standard.set(THIGH, forKey: "view.preferences.THIGH")
        }
    }
    
    @Published var GLOW: Double = UserDefaults.standard.double(forKey: "view.preferences.GLOW") {
        didSet {
            UserDefaults.standard.set(GLOW, forKey: "view.preferences.GLOW")
        }
    }
    
    @Published var GMED: Double = UserDefaults.standard.double(forKey: "view.preferences.GMED") {
        didSet {
            UserDefaults.standard.set(GMED, forKey: "view.preferences.GMED")
        }
    }
    
    @Published var GHIGH: Double = UserDefaults.standard.double(forKey: "view.preferences.GHIGH") {
        didSet {
            UserDefaults.standard.set(GHIGH, forKey: "view.preferences.GHIGH")
        }
    }
    
    @Published var PEST: Double = UserDefaults.standard.double(forKey: "view.preferences.PEST") {
        didSet {
            UserDefaults.standard.set(PEST, forKey: "view.preferences.PEST")
        }
    }
    
    @Published var totalAcres: Double = UserDefaults.standard.double(forKey: "view.preferences.totalAcres") {
        didSet {
            UserDefaults.standard.set(totalAcres, forKey: "view.preferences.totalAcres")
        }
    }
    
    @Published var budgetFixedCosts: Double = UserDefaults.standard.double(forKey: "view.preferences.budgetFixedCosts") {
        didSet {
            UserDefaults.standard.set(budgetFixedCosts, forKey: "view.preferences.budgetFixedCosts")
        }
    }
    
    @Published var budgetVariableCosts: Double = UserDefaults.standard.double(forKey: "view.preferences.budgetVariableCosts") {
        didSet {
            UserDefaults.standard.set(budgetVariableCosts, forKey: "view.preferences.budgetVariableCosts")
        }
    }
    
    @Published var costPerHive: Double = UserDefaults.standard.double(forKey: "view.preferences.costPerHive") {
        didSet {
            UserDefaults.standard.set(costPerHive, forKey: "view.preferences.costPerHive")
        }
    }
    
    @Published var fertilizerCost: Double = UserDefaults.standard.double(forKey: "view.preferences.fertilizerCost") {
        didSet {
            UserDefaults.standard.set(fertilizerCost, forKey: "view.preferences.fertilizerCost")
        }
    }
    
    @Published var irrigationCost: Double = UserDefaults.standard.double(forKey: "view.preferences.irrigationCost") {
        didSet {
            UserDefaults.standard.set(irrigationCost, forKey: "view.preferences.irrigationCost")
        }
    }
    
    @Published var insecticideCost: Double = UserDefaults.standard.double(forKey: "view.preferences.insecticideCost") {
        didSet {
            UserDefaults.standard.set(insecticideCost, forKey: "view.preferences.insecticideCost")
        }
    }
    
    @Published var usesPesticides: Int = UserDefaults.standard.integer(forKey: "view.preferences.usesPesticides") {
        didSet {
            UserDefaults.standard.set(usesPesticides, forKey: "view.preferences.usesPesticides")
        }
    }
    
    @Published var totalProductionCosts: Double = UserDefaults.standard.double(forKey: "view.preferences.totalProductionCosts") {
        didSet {
            UserDefaults.standard.set(totalProductionCosts, forKey: "view.preferences.totalProductionCosts")
        }
    }
    
    @Published var yield: Double = UserDefaults.standard.double(forKey: "view.preferences.yield") {
        didSet {
            UserDefaults.standard.set(yield, forKey: "view.preferences.yield")
        }
    }
    
    @Published var pricePerLb: Double = UserDefaults.standard.double(forKey: "view.preferences.pricePerLb") {
        didSet {
            UserDefaults.standard.set(pricePerLb, forKey: "view.preferences.pricePerLb")
        }
    }
    
    func loadStats() async -> Void {}

}




