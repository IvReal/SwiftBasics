// Иванов Вадим, СПб, Россия
//
//  main.swift
//  Lesson4
//
//  Created by Iv on 07/02/2019.
//  Copyright © 2019 Iv. All rights reserved.
//

import Foundation

/* Task:
 1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
 2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
 3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
 4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
 6. Вывести значения свойств экземпляров в консоль.
*/

enum Action {
    case engineOn
    case engineOff
    case doorOpen
    case doorClose
    case cargoLoad
    case cargoUnload
    case switchTurboMode
}

class Car {
    let brand: String
    let manufactureYear: Int
    var isEngineOn: Bool = false
    var isDoorOpen: Bool = false
    init(brand: String, year: Int) {
        self.brand = brand
        self.manufactureYear = year
    }
    func DoAction(action: Action) -> Bool {
        var result = true
        switch action {
            case .engineOn, .engineOff:
                isEngineOn = action == .engineOn
            case .doorOpen, .doorClose:
                isDoorOpen = action == .doorOpen
            default:
                result = false
        }
        return result
    }
    func DoAction(action: Action, actionParam: Int?) -> Bool {
        return DoAction(action: action)
    }
    func GetState() -> String {
        return brand + ": engine " + (isEngineOn ? "ON" : "OFF") + ", doors " + (isDoorOpen ? "OPENED" : "CLOSED")
    }
}

class TruckCar : Car {
    let capacity: Int  // weight capacity in kg
    var currentCargo: Int = 0
    static var TotalTransportedCargo: Int = 0
    init(brand: String, year: Int, capacity: Int) {
        self.capacity = capacity
        super.init(brand: brand, year: year)
    }
    override func DoAction(action: Action, actionParam: Int?) -> Bool {
        var result = false
        switch action {
            case .cargoLoad, .cargoUnload:
                if let weight = actionParam {
                    currentCargo += weight * (action == .cargoLoad ? 1 : -1)
                    if action == .cargoLoad {
                        TruckCar.TotalTransportedCargo += weight
                    }
                    result = true
                }
            default:
                result = super.DoAction(action: action, actionParam: nil)
                
        }
        return result
    }
    override func GetState() -> String {
        return super.GetState() + ", cargo " + String(currentCargo) + " kg"
    }
}

class SportCar : Car {
    let accelerationTime: Float  // acceleration time to 100 km/h in sec
    var turboMode: Bool = false
    init(brand: String, year: Int, accTime: Float) {
        self.accelerationTime = accTime
        super.init(brand: brand, year: year)
    }
    override func DoAction(action: Action) -> Bool {
        var result = false
        switch action {
            case .switchTurboMode:
                turboMode = !turboMode
                result = true
            default:
                result = super.DoAction(action: action)
            
            }
        return result
    }
    override func GetState() -> String {
        return super.GetState() + ", turbo mode " + (turboMode ? "ON" : "OFF")
    }}

func ApplyActionToObject(car: Car, action: Action, actionParam: Int? = nil)
{
    let result = car.DoAction(action: action, actionParam: actionParam)
    if (result) {
        print("Action \(action) for car \(car.brand) performed successfully")
        print("Car state: \(car.GetState())")
    } else {
        print("Action \(action) for car \(car.brand) failed")
    }
}

var truck1 = TruckCar(brand: "Volvo", year: 2014, capacity: 15000)
var truck2 = TruckCar(brand: "Kamaz", year: 2012, capacity: 4500)
var sport1 = SportCar(brand: "Ferrari", year: 2016, accTime: 4.9)
var sport2 = SportCar(brand: "Lamborghini", year: 2015, accTime: 4.3)
ApplyActionToObject(car: truck1, action: .cargoLoad, actionParam: 4700) // self action
ApplyActionToObject(car: truck1, action: .engineOn) // super class action
ApplyActionToObject(car: truck2, action: .doorOpen) // super class action
ApplyActionToObject(car: sport1, action: .switchTurboMode) // self action
ApplyActionToObject(car: sport1, action: .engineOn) // super class action
ApplyActionToObject(car: sport2, action: .cargoLoad, actionParam: 4700) // wrong action
