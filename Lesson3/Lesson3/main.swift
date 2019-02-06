// Иванов Вадим, СПб, Россия
//
//  main.swift
//  Lesson3
//
//  Created by Iv on 06/02/2019.
//  Copyright © 2019 Iv. All rights reserved.
//

import Foundation

/* Task:
 1. Описать несколько структур – любой легковой автомобиль и любой грузовик.
 2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
 3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
 4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
 5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
 6. Вывести значения свойств экземпляров в консоль. */

struct Car
{
    let brand: String
    let manufactureYear: Int
    let trunkFullVolume: Int // in liters
    var trunkFilledVolume: Int = 0
    var isEngineOn: Bool = false
    var isWindowOpen: Bool = false
    // Action implementation var 1 (for truck see var 2 implementation)
    mutating func DoAction(action: Action)
    {
        switch action {
            case .doEngineOn:
                isEngineOn = true
            case .doEngineOff:
                isEngineOn = false
            case .openWindow:
                isWindowOpen = true
            case .closeWindow:
                isWindowOpen = false
            default:
                print("Can't do action \(action) by call DoAction method")
        }
    }
    mutating func DoCargoOperation(action: Action, volume: Int)
    {
        if (action != .loadCargo && action != .unloadCargo) {
            print("Can't do action \(action) by call DoCargoOperation method")
        }
        else {
            trunkFilledVolume = trunkFilledVolume + volume * (action == .loadCargo ? 1 : -1)
        }
    }
}

struct Truck
{
    let brand: String
    let manufactureYear: Int
    let carryingCapacity: Int // in kg
    var actualCapacity: Int = 0
    {
        willSet {
            if newValue < 0 || newValue > carryingCapacity {
                print("Incorrect cargo weight \(newValue) kg")
            }
        }
        /*didSet {
            if actualCapacity < 0 {
                actualCapacity = 0
            }
            else if actualCapacity > carryingCapacity {
                actualCapacity = carryingCapacity
            }
        }*/
    }
    var isEngineOn: Bool = false
    var isWindowOpen: Bool = false
    init(name: String, year: Int, tonnageInKg: Int) {
        brand = name
        manufactureYear = year
        carryingCapacity = tonnageInKg
    }
    // Action implementation var 2
    mutating func DoAction(action: Action, actionParam: Int? = nil)
    {
        switch action {
            case .doEngineOn:
                isEngineOn = true
            case .doEngineOff:
                isEngineOn = false
            case .openWindow:
                isWindowOpen = true
            case .closeWindow:
                isWindowOpen = false
            case .loadCargo, .unloadCargo:
                if let weight = actionParam {
                    actualCapacity = actualCapacity + weight * (action == .loadCargo ? 1 : -1)
                }
        }
    }
}

enum Action
{
    case doEngineOn
    case doEngineOff
    case openWindow
    case closeWindow
    case loadCargo
    case unloadCargo
}

// Let's test my car
var myCar = Car(brand: "BMW", manufactureYear: 2015, trunkFullVolume: 200, trunkFilledVolume: 0, isEngineOn: false, isWindowOpen: false)
print("My car before start: \(myCar)")
myCar.DoCargoOperation(action: .loadCargo, volume: 50)
myCar.DoAction(action: .doEngineOn)
myCar.DoAction(action: .openWindow)
print("Let's go to picnic: \(myCar)")
myCar.DoAction(action: .doEngineOff)
myCar.DoCargoOperation(action: .unloadCargo, volume: 40)
print("We arrived, unloaded and stay window open: \(myCar)")

// And now test our truck
var ourTruck = Truck(name: "Kamaz", year: 2012, tonnageInKg: 5000)
print("Truck before work: \(ourTruck)")
ourTruck.DoAction(action: .loadCargo, actionParam: 7000)
print("Too hard cargo: \(ourTruck)")
ourTruck.DoAction(action: .unloadCargo, actionParam: 2500)
ourTruck.DoAction(action: .doEngineOn)
print("Go! \(ourTruck)")

