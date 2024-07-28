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
    
    var strategy: String {
        switch self {
        case .craving: 
            return "Nicotine binds to receptors in the brain, releasing dopamine, which reinforces the urge to smoke. Cravings become less frequent and intense after 2-4 weeks, though occasional urges may persist for several months. Distract yourself with activities, use nicotine replacement therapy (NRT) like patches or gum, and practice mindfulness or deep breathing techniques."
        case .irritability:
            return "The brain’s dopamine levels drop without nicotine, leading to temporary mood swings. Feelings of frustration or anger subside significantly as brain chemistry stabilizes. Engage in physical activities, practice relaxation techniques."
        case .anxiety:
            return "Nicotine withdrawal can lead to an imbalance in brain chemicals, increasing anxiety. Anxiety gradually decreases over several weeks or months. Exercise regularly, practice meditation or yoga, and use NRT if necessary."
        case .restlessness:
            return "The body and mind are adjusting to functioning without nicotine. This improves as the body adjusts. Keep busy with hobbies, take short walks, or practice deep breathing exercises to help calm your nerves."
        case .difficultyConcentrating:
            return "Nicotine affects neurotransmitters that help with focus and attention. Your focusing gets better as the brain adjusts to the absence of nicotine. Break tasks into smaller steps, take regular breaks, and use focus-enhancing techniques like the Pomodoro Technique."
        case .depression:
            return "Withdrawal from nicotine can lead to decreased dopamine levels, affecting mood. Feelings of sadness or depression often peak during the early phase of quitting. And significant progress happens over the next months. Engage in activities that bring you joy and satisfaction."
        case .increasedAppetite:
            return "Nicotine suppresses appetite, so its absence can lead to hunger. Noticeable increase in appetite during the early phase of quitting, stabilizing over the next weeks or months. Eat healthy snacks, drink plenty of water, and try to maintain a balanced diet with regular meals."
        case .insomnia:
            return "Nicotine withdrawal can disrupt sleep patterns. Some medication can also affect sleep. If difficulty falling or staying asleep persists for more than a month, consider consulting a healthcare professional. Establish a bedtime routine, avoid caffeine and electronics before bed, and create a calm sleep environment."
        case .excessiveSleep:
            return "The body may feel fatigued and need more rest as it heals. Your energy levels will gradually stabilize. Allow yourself to rest when needed, but try to maintain a regular sleep schedule."
        case .headaches:
            return "The body adjusts to the absence of nicotine, which can cause tension headaches. Stay hydrated and practice relaxation techniques."
        case .coughing:
            return "The lungs begin to clear out mucus and debris accumulated from smoking. Drink plenty of fluids, use cough drops, and consider a humidifier to ease throat irritation."
        case .constipation:
            return "Nicotine affects gut motility, and its absence can slow down digestion. Increase fiber intake, drink lots of water, and stay active to help regulate bowel movements."
        case .dizziness:
            return "The body adjusts to improved oxygen levels and blood flow. Move slowly when changing positions, stay hydrated, and ensure you are eating regularly."
        case .fatigue:
            return "The body is adjusting to functioning without nicotine and healing from its effects. Get plenty of rest, engage in light exercise, and maintain a balanced diet to boost energy levels."
        case .tinglingInHandsFeet:
            return "Improved circulation after quitting smoking can cause a tingling sensation. This usually subsides within a few weeks as circulation improves. Gentle stretching and massage can help, as well as staying active to improve circulation."
        case .sweating:
            return "The body expels toxins and adjusts to the absence of nicotine, which can cause excessive sweating. This will decrease as the body detoxifies and adjusts. Stay cool, wear breathable clothing, and practice good hygiene to manage discomfort."
        }
    }
}
