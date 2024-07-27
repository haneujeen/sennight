//
//  Symptom.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import Foundation

enum Symptom: Int, CaseIterable, Identifiable {
    case craving = 1
    case irritability
    case anxiety
    case restlessness
    case difficultyConcentrating
    case depression
    case increasedAppetite
    case insomnia
    case excessiveSleep
    case headaches
    case coughing
    case constipation
    case dizziness
    case fatigue
    case tinglingInHandsFeet
    case sweating

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .craving: return "Craving"
        case .irritability: return "Irritability"
        case .anxiety: return "Anxiety"
        case .restlessness: return "Restlessness"
        case .difficultyConcentrating: return "Difficulty Concentrating"
        case .depression: return "Depression"
        case .increasedAppetite: return "Increased Appetite"
        case .insomnia: return "Insomnia"
        case .excessiveSleep: return "Excessive Sleep"
        case .headaches: return "Headaches"
        case .coughing: return "Coughing"
        case .constipation: return "Constipation"
        case .dizziness: return "Dizziness"
        case .fatigue: return "Fatigue"
        case .tinglingInHandsFeet: return "Tingling in Hands/Feet"
        case .sweating: return "Sweating"
        }
    }

    var description: String {
        switch self {
        case .craving: return "Intense and repetitive urges to smoke, with or without being triggered by certain activities, emotions, or environments associated with smoking."
        case .irritability: return "Increased irritability, frustration, or anger as a result of the body craving nicotine."
        case .anxiety: return "Feelings of anxiety or nervousness due to the lack of nicotine’s calming effects."
        case .restlessness: return "Feeling fidgety or having trouble sitting still."
        case .difficultyConcentrating: return "Trouble focusing or maintaining attention."
        case .depression: return "Feelings of sadness or depression occur, often peaking within the first week after quitting."
        case .increasedAppetite: return "Nicotine suppresses appetite, so its absence can lead to increased hunger and potential weight gain."
        case .insomnia: return "Difficulty falling or staying asleep."
        case .excessiveSleep: return "Increased fatigue and desire to sleep as the body adjusts to the absence of nicotine."
        case .headaches: return "Frequent headaches or migraines from body adjusting to the absence of nicotine."
        case .coughing: return "Coughing and throat irritation from lungs begin to clear out mucus and other debris."
        case .constipation: return "Digestive issues arise as the body adjusts to the absence of nicotine, which affects gut motility."
        case .dizziness: return "Dizziness from body adjusting to the absence of nicotine."
        case .fatigue: return "Feeling tired or drained of energy as the body adjusts to functioning without nicotine."
        case .tinglingInHandsFeet: return "Improved circulation after quitting cause a tingling sensation in hands and feet."
        case .sweating: return "Excessive sweating (especially at night)."
        }
    }
}
