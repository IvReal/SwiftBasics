// Иванов Вадим, СПб, Россия
//
//  main.swift
//  Lesson6
//
//  Created by Iv on 16/02/2019.
//  Copyright © 2019 Iv. All rights reserved.
//

import Foundation

/*
 1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
 2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
 3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
*/

struct Queue<T> where T : Comparable {
    private var items = [T]()
    var count: Int {
        return items.count
    }
    // add item to queue
    mutating func enqueue(_ item: T) {
        items.append(item)
    }
    // return first queue item, removing it
    mutating func dequeue() -> T? {
        return items.count > 0 ? items.removeFirst() : nil
    }
    // return first queue item, without removing it
    mutating func peek() -> T? {
        return items.first
    }
    // return item by index, or nil if index is out of range
    subscript (index: Int) -> T? {
        if (0..<items.count).contains(index) {
            return items[index]
        }
        return nil
    }
    // return sorted array, based on queue
    func sorted(closure: (T, T) -> Bool) -> [T] {
        return items.sorted(by: closure)
    }
    // do action with each queue item
    func forEach(closure: (T) -> Void) {
        items.forEach(closure)
    }
}

// Test classes, conform to Comparable protocol
class Area : Comparable, CustomStringConvertible {
    var area: Double {
        return GetArea()
    }
    func GetArea() -> Double {
        return 0.0;
    }
    static func == (a1: Area, a2: Area) -> Bool {
        return a1.area == a2.area
    }
    static func < (a1: Area, a2: Area) -> Bool {
        return a1.area < a2.area
    }
    static func > (a1: Area, a2: Area) -> Bool {
        return a1.area > a2.area
    }
    var description: String {
        return "Area=\(Decimal(area))"
    }
}

class Rectangle : Area {
    var sideA: Int = 0;
    var sideB: Int = 0;
    override func GetArea() -> Double {
        return Double(sideA * sideB)
    }
    init(_ side1: Int, _ side2: Int) {
        sideA = side1 ; sideB = side2
    }
    override var description: String {
        return "Rect" + super.description
    }
}

class Circle : Area {
    var radius: Int = 0;
    override func GetArea() -> Double {
        return (Double.pi * pow(Double(radius), 2)).rounded()
    }
    init(_ rad: Int) {
        radius = rad
    }
    override var description: String {
        return "Circle" + super.description
    }
}

// Test
var queue = Queue<Area>()
var area: Area?
// test enqueue
queue.enqueue(Rectangle(100, 150))
queue.enqueue(Rectangle(10, 15))
queue.enqueue(Rectangle(5, 25))
queue.enqueue(Circle(10))
queue.enqueue(Circle(5))
print("Initial queue with 5 items:\n\(queue)")
// test dequeue
area = queue.dequeue()
print("\nRemoved \(area!)")
print("Queue after 1 item dequeue:\n\(queue)")
// test foreach function
print("\nPrint each item:")
queue.forEach {
    item in print("Item \(item)")
}
// test sorting
var arr = queue.sorted { $0 > $1 }
print("\nAreas descending: \(arr)")
arr = queue.sorted { $0 < $1 }
print("\nAreas ascending: \(arr)")
// test access by index
area = queue[0]
print("\nOldest item: \(area!)")
area = queue[queue.count - 1]
print("\nNewest item: \(area!)")
area = queue[125]
if let a = area {
    print("\nUnexisted index item: \(a)")
} else {
    print("\nUnexisted index item: nil")
}
