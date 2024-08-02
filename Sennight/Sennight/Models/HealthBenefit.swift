//
//  HealthBenefit.swift
//  Sennight
//
//  Created by 한유진 on 7/26/24.
//

import SwiftUI

enum HealthBenefit: String, CaseIterable {
    case heartRate = "Heart rate"
    case bloodPressure = "Blood pressure"
    case oxygenLevel = "Oxygen level"
    case nicotineLevel = "Nicotine level"
    case carbonMonoxide = "Carbon monoxide"
    case mucus = "Mucus"
    case smellAndTaste = "Smell and taste"
    case breathing = "Breathing"
    case circulation = "Circulation"
    case lungFunction = "Lung function"
    case coughing = "Coughing"
    case cardiovascularSystem = "Cardiovascular system"
    case stroke = "Stroke"
    case mouthAndThroatCancer = "Mouth and throat cancer"
    case bladderAndKidneyCancer = "Bladder and kidney cancer"
    case lungCancer = "Lung cancer"
    case heartDisease = "Heart disease"
    
    var id: Int {
        switch self {
        case .heartRate: return 1
        case .bloodPressure: return 2
        case .oxygenLevel: return 3
        case .nicotineLevel: return 4
        case .carbonMonoxide: return 5
        case .mucus: return 6
        case .smellAndTaste: return 7
        case .breathing: return 8
        case .circulation: return 9
        case .lungFunction: return 10
        case .coughing: return 11
        case .cardiovascularSystem: return 12
        case .stroke: return 13
        case .mouthAndThroatCancer: return 14
        case .bladderAndKidneyCancer: return 15
        case .lungCancer: return 16
        case .heartDisease: return 17
        }
    }
    
    var timeInterval: TimeInterval {
        switch self {
        case .heartRate: return 1_200 // 20 minutes
        case .bloodPressure: return 1_200 // 20 minutes
        case .oxygenLevel: return 28_800 // 8 hours
        case .nicotineLevel: return 172_800 // 48 hours
        case .carbonMonoxide: return 172_800 // 48 hours
        case .mucus: return 172_800 // 48 hours
        case .smellAndTaste: return 172_800 // 48 hours
        case .breathing: return 259_200 // 72 hours
        case .circulation: return 4_838_400 // 8 weeks
        case .lungFunction: return 7_257_600 // 12 weeks
        case .coughing: return 15_552_000 // 6 months
        case .cardiovascularSystem: return 31_536_000 // 1 year
        case .stroke: return 157_680_000 // 5 years
        case .mouthAndThroatCancer: return 220_752_000 // 7 years
        case .bladderAndKidneyCancer: return 315_360_000 // 10 years
        case .lungCancer: return 378_432_000 // 12 years
        case .heartDisease: return 473_385_600 // 15 years
        }
    }
    
    var timeIntervalString: String {
            switch self {
            case .heartRate: return "20 minutes"
            case .bloodPressure: return "20 minutes"
            case .oxygenLevel: return "8 hours"
            case .nicotineLevel: return "48 hours"
            case .carbonMonoxide: return "48 hours"
            case .mucus: return "48 hours"
            case .smellAndTaste: return "48 hours"
            case .breathing: return "72 hours"
            case .circulation: return "8 weeks"
            case .lungFunction: return "12 weeks"
            case .coughing: return "6 months"
            case .cardiovascularSystem: return "1 year"
            case .stroke: return "5 years"
            case .mouthAndThroatCancer: return "7 years"
            case .bladderAndKidneyCancer: return "10 years"
            case .lungCancer: return "12 years"
            case .heartDisease: return "15 years"
            }
        }
    
    var description: String {
        switch self {
        case .heartRate:
            return "Nicotine stimulates the release of adrenaline, which increases heart rate. Once you stop smoking, the absence of nicotine allows your heart rate to decrease to its normal rate."
        case .bloodPressure:
            return "Nicotine constricts blood vessels, raising blood pressure. Quitting smoking relaxes the blood vessels, reducing blood pressure."
        case .oxygenLevel:
            return "Carbon monoxide from smoking binds to hemoglobin in red blood cells more effectively than oxygen does, reducing oxygen transport. As carbon monoxide levels decrease, more oxygen is allowed to be carried by the blood."
        case .nicotineLevel:
            return "Nicotine has a half-life of 1-2 hours, so it takes about two days for it to leave the body. This reduces dependence and withdrawal symptoms."
        case .carbonMonoxide:
            return "Carbon monoxide levels in the blood decrease, improving the blood’s capacity to carry oxygen, which enhances overall cellular function."
        case .mucus:
            return "Without the constant irritation from smoke, the production of mucus decreases and cilia (tiny hair-like structures in the lungs) starts to clear out mucus."
        case .smellAndTaste:
            return "Smoking damages the sensory receptors in the nose and mouth. After quitting, these receptors begin to heal, enhancing your ability to taste and smell."
        case .breathing:
            return "The bronchial tubes, which constrict due to the irritation from smoke, begin to relax. This reduces resistance in the airways, making breathing easier and increasing oxygen intake."
        case .circulation:
            return "Smoking damages the lining of blood vessels, leading to poor circulation. Quitting allows these vessels to heal, improving blood flow and reducing the risk of clotting."
        case .lungFunction:
            return "Lung capacity and function improve as the inflammation in the airways decreases and the cilia in the lungs recover their ability to clear out mucus and debris."
        case .coughing:
            return "The lungs continue to heal, and the cilia recover further, resulting in decreased coughing and shortness of breath and better overall lung health."
        case .cardiovascularSystem:
            return "Risk of heart disease is halved compared to a smoker. The cardiovascular system significantly heals, reducing the risk factors associated with heart disease such as high blood pressure and abnormal heart rhythms."
        case .stroke:
            return "Blood vessels continue to heal, and the risk of blood clots (which can cause strokes) diminishes. Your stroke risk can decrease to that of a non-smoker."
        case .mouthAndThroatCancer:
            return "Your risk of cancers of the mouth, throat, and voice box (larynx) is cut in half. The damaged cells are replaced with healthy ones over time, reducing cancer risk."
        case .bladderAndKidneyCancer:
            return "Carcinogens in tobacco (which contribute to cancer development) are eliminated from your body. Your risk of cancer of the bladder, esophagus, and kidney starts to decrease."
        case .lungCancer:
            return "The risk of lung cancer decreases as the exposure to carcinogens in smoke stops, and lung cells regenerate, reducing the likelihood of malignant transformations."
        case .heartDisease:
            return "Risk of coronary heart disease is equivalent to that of someone who has never smoked. Long-term cessation allows the cardiovascular system to fully recover, eliminating the additional risk imposed by smoking."
        }
    }
}
