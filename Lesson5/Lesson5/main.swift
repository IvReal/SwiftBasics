// Иванов Вадим, СПб, Россия
//
//  main.swift
//  Lesson5
//
//  Created by Iv on 11/02/2019.
//  Copyright © 2019 Iv. All rights reserved.
//

import Foundation

/* Task:
 1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
 2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
 3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
 4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
 6. Вывести сами объекты в консоль.
*/

enum EngineAction { case engineOn, engineOff }
enum DoorAction { case doorOpen, doorClose }
enum CargoAction { case cargoLoad, cargoUnload }
enum SpecAction {  case switchTurboMode }

protocol Car : AnyObject {
    var brand: String { get set }
    var manufactureYear: Int { get set }
    var isEngineOn: Bool { get set }
    var isDoorOpen: Bool { get set }
    func DoEngineAction(action: EngineAction) -> Bool
    func DoDoorAction(action: DoorAction) -> Bool
}

extension Car {
    func DoEngineAction(action: EngineAction) -> Bool {
        let result = action == .engineOn ? !isEngineOn : isEngineOn // return true if engine state really switched
        isEngineOn = action == .engineOn
        return result
    }
    func DoDoorAction(action: DoorAction) -> Bool {
        let result = action == .doorOpen ? !isDoorOpen : isDoorOpen // return true if door state really switched
        isDoorOpen = action == .doorOpen
        return result
    }
}

class TruckCar : Car {
    var brand: String
    var manufactureYear: Int
    var isEngineOn: Bool = false
    var isDoorOpen: Bool = false
    let capacity: Int  // weight capacity in kg
    var currentCargo: Int = 0
    init(brand: String, year: Int, capacity: Int) {
        self.brand = brand
        self.manufactureYear = year
        self.capacity = capacity
    }
    func DoCargoAction(action: CargoAction, weight: Int) -> Bool {
        var sum = currentCargo + weight * (action == .cargoLoad ? 1 : -1)
        if sum < 0 {
            sum = 0
        }
        let result = sum <= capacity
        if result {
            currentCargo = sum
        }
        return result
    }
}

class SportCar : Car {
    var brand: String
    var manufactureYear: Int
    var isEngineOn: Bool = false
    var isDoorOpen: Bool = false
    let accelerationTime: Float  // acceleration time to 100 km/h in sec
    var turboMode: Bool = false
    init(brand: String, year: Int, accTime: Float) {
        self.brand = brand
        self.manufactureYear = year
        self.accelerationTime = accTime
    }
    func DoTurboAction(action: SpecAction) -> Bool {
        turboMode = !turboMode
        return true
    }
}

extension TruckCar : CustomStringConvertible {
    var description: String {
        return "\(brand) (\(manufactureYear)) state: engine " + (isEngineOn ? "ON" : "OFF") + ", doors " +
            (isDoorOpen ? "OPENED" : "CLOSED") + ", cargo \(currentCargo) kg"
    }
}

extension SportCar : CustomStringConvertible {
    var description: String {
        return "\(brand) (\(manufactureYear)) state: engine " + (isEngineOn ? "ON" : "OFF") + ", doors " +
            (isDoorOpen ? "OPENED" : "CLOSED") + ", turbo mode " + (turboMode ? "ON" : "OFF")
    }
}

var truck1 = TruckCar(brand: "Volvo", year: 2014, capacity: 15000)
var truck2 = TruckCar(brand: "Kamaz", year: 2012, capacity: 4500)
var sport1 = SportCar(brand: "Ferrari", year: 2016, accTime: 4.9)
var sport2 = SportCar(brand: "Lamborghini", year: 2015, accTime: 4.3)

print("Try to load 4700 kg and set engine on")
var result = truck1.DoCargoAction(action: .cargoLoad, weight: 4700)
result = truck1.DoEngineAction(action: .engineOn)
print(truck1)
print("Try to load too hard cargo and open the door")
result = truck2.DoCargoAction(action: .cargoLoad, weight: 10000)
print(result ? "Cargo loaded successfully" : "Cargo load failed")
result = truck2.DoDoorAction(action: .doorOpen)
print(truck2)
print("Try to close the door, set engine on and set turbo mode")
result = sport1.DoDoorAction(action: .doorClose)
result = sport1.DoEngineAction(action: .engineOn)
result = sport1.DoTurboAction(action: .switchTurboMode)
print(sport1)
print("Second sportcar is in initial state")
print(sport2)

/*
 Резюме:
 Если придерживаться условий задачи, то в реализации получается много дублирующегося кода.
 В реальности я бы, наверное, совместил использование протоколов и наследование классов.
*/

