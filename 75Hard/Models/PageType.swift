//
//  ItemModel.swift
//  75Hard
//
//  Created by Christine Luu on 3/20/23.
//

import Foundation
import SwiftUI

//Immutable struct
enum PageType: Int, Identifiable {
    case water
    case reading
    case workout
    case outsideWorkout
    case macros
    case photo
    case drink
    
    static let all: [PageType] = [.water, .reading, .workout, .outsideWorkout, .macros, .photo, .drink]
    
    func getInformation() -> String {
        switch self {
        case .water:
            return "1 Gallon of Water"
        case .reading:
            return "Read 10 Pages"
        case .workout:
            return "45 Min Workout"
        case .outsideWorkout:
            return "45 Min Workout - Outside"
        case .macros:
            return "Follow Macros"
        case .photo:
            return "Progress Photo"
        case .drink:
            return "Did not drink"
        }
    } 
    
    @ViewBuilder
    func getDestination(dayID: String) -> some View {
        switch self {
        case .water:
            WaterView(dayID: dayID)
        case .reading:
            PageView(dayID: dayID)
        case .workout:
            WorkoutView(dayID: dayID, isOutdoor: false)
        case .outsideWorkout:
            WorkoutView(dayID: dayID, isOutdoor: true)
        case .macros:
            MacroView(dayID: dayID)
        case .photo:
            PhotoView(dayID: dayID)
        case .drink:
            DrinkView(dayID: dayID)
        }
    }
}




