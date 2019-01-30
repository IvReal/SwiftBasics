// Иванов Вадим, СПб, Россия
//
//  main.swift
//  Lesson1
//
//  Created by Iv on 30/01/2019.
//  Copyright © 2019 Iv. All rights reserved.
//

import Foundation

// Task: Решить квадратное уравнение
// Функция нахождения корней квадратного уравнения
// ax2 + bx + c = 0, a != 0
func PrintQuadraticRoots(a: Int, b: Int, c: Int)
{
    var msg = "Quadratic a=\(a), b=\(b), c=\(c) "
    if a != 0
    {
        var roots = Set<Double>()
        let D = b * b - (a * c * 4)
        if D >= 0
        {
            if D == 0
            {
                roots.insert(Double(-b) / (2.0 * Double(a)))
            }
            else
            {
                roots.insert((Double(-b) + sqrt(Double(D))) / (2.0 * Double(a)))
                roots.insert((Double(-b) - sqrt(Double(D))) / (2.0 * Double(a)))
            }
        }
        msg += "has \(roots.count) root(s)"
        if (roots.count > 0) { msg += ": \(roots)" }
    }
    else
    {
        msg += "is not quadratic at all"
    }
    print(msg)
}

// Task: Даны катеты прямоугольного треугольника, найти площадь, петриметр и гипотенузу треугольника
// Функция нахождения площади, периметра и гипотенузы прямоугольного треугольника
func PrintRightTriangleParams(leg1: Float, leg2: Float)
{
    if (leg1 >= 0 && leg2 >= 0)
    {
        let Area : Float = leg1 * leg2 / 2.0
        let Hypotenuse : Float = sqrt(leg1 * leg1 + leg2 * leg2)
        let Perimeter : Float = Hypotenuse + leg1 + leg2
        print("Right triangle with legs \(leg1) and \(leg2) has area \(Area), hypotenuse \(Hypotenuse) and perimeter \(Perimeter)")
    }
    else
    {
        print("Right triangle with legs \(leg1) and \(leg2) is not real")
    }
}

// Task: Пользователь вводит сумму вклада в банк и годовой процент, найти сумму вклвдв через 5 лет
// Функция расчета суммы вклада
func HowMyMoneyGrows(deposit: Float, percent: Float, period: Int) -> Float
{
    var money = deposit
    for _ in 1...period
    {
        money += money * percent / 100.0
    }
    return money
}

// Проверим
print("Quadratic roots test")
print("\nExpected 2 roots [3, -1]")
PrintQuadraticRoots(a: 1, b: -2, c: -3)
print("\nExpected 1 root [-6]")
PrintQuadraticRoots(a: 1, b: 12, c: 36)
print("\nExpected no roots")
PrintQuadraticRoots(a: 5, b: 3, c: 7)
print("\nIncomplete c=0, expected 2 roots [0, 7]")
PrintQuadraticRoots(a: 1, b: -7, c: 0)
print("\nIncomplete b=0, expected no roots")
PrintQuadraticRoots(a: 5, b: 0, c: 30)
print("\nIncomplete b=0, expected 2 roots [1.5, -1.5]")
PrintQuadraticRoots(a: 4, b: 0, c: -9)
print("\nIncomplete b=0, c=0, expected 1 root [0]")
PrintQuadraticRoots(a: 1, b: 0, c: 0)
print("\nInvalid coefficient")
PrintQuadraticRoots(a: 0, b: 3, c: 7)

print("\nRight triangle test")
PrintRightTriangleParams(leg1: 10, leg2: 12.5)
PrintRightTriangleParams(leg1: 0, leg2: -100)

print("\nMoney-money test")
let dep: Float = 15000.0
let perc: Float = 5.0
let money = HowMyMoneyGrows(deposit: dep, percent: perc, period: 5)
print("If I deposit \(dep) UE and bank pays \(perc)%, in 5 year I will have \(money) UE")


