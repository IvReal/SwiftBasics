// Иванов Вадим, СПб, Россия
//
//  main.swift
//  Lesson2
//
//  Created by Iv on 03/02/2019.
//  Copyright © 2019 Iv. All rights reserved.
//

import Foundation

// Task: Написать функцию, которая определяет, четное число или нет
func IsNumberEven(_ number: Int) -> Bool
{
    return IsNumberDivideBy(number: number, by: 2)
}

// Task: Написать функцию, которая определяет, делится ли число без остатка на 3
func IsNumberDivideByThree(_ number: Int) -> Bool
{
    return IsNumberDivideBy(number: number, by: 3)
}

func IsNumberDivideBy(number dividend: Int, by divider: Int) -> Bool
{
    return dividend % divider == 0
}

// Task: Создать возрастающий массив из 100 чисел
//       Удалить из этого массива все четные числа и все числа, которые не делятся на 3
var NumberArray = Array(1...100)
for (index, value) in NumberArray.enumerated().reversed()
{
    if IsNumberEven(value) || !IsNumberDivideByThree(value)
    {
        NumberArray.remove(at: index)
    }
}
print("Odd numbers from 1 to 100 that divide by 3 are: \(NumberArray)")

// Task: Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов
func AddNewFibonacciNumber(array: inout [Double])
{
    let i = array.count
    if i < 2
    {
        array.append(Double(i))
    }
    else if (i < 300)
    {
        array.append(array[i - 2] + array[i - 1])
    }
}
var FibonacciArray = [Double]()
for _ in 0..<100
{
    AddNewFibonacciNumber(array: &FibonacciArray)
}
// 218922995834555169026
// 218922995834555203584
//let FibonacciArrayFormat = FibonacciArray.map({ String(format: "%.0f", $0) })
print ("\nApproximate values of first \(FibonacciArray.count) Fibonacci numbers are: \(FibonacciArray)\nFor exact values we need Int128 type or dancing with tambourine...")

/* Task:
 Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:
 a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
 b. Пусть переменная p изначально равна двум — первому простому числу.
 c. Зачеркнуть в списке числа от 2p до n, считая шагами по p (это будут числа, кратные p: 2p, 3p, 4p, ...).
 d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
 e. Повторять шаги c и d, пока возможно
*/
var PrimeNumberArray = [Int]()  // array for 100 prime numbers
var n = 1000        // todo: подумать сколько нужно взять целых чисел, чтобы в результате просеивания через решето Эратосфена получилось 100 простых
var arr = [Bool]()  // true - is not crossed out, false - is crossed out
for _ in (0...n)
{
    arr.append(true) // at start all numbers is not crossed out
}
var p = 2
while p < n && PrimeNumberArray.count < 100
{
    for i in stride(from: p * 2, to: n, by: p)
    {
        arr[i] = false // cross out
    }
    for i in (p...n)
    {
        if arr[i]
        {
            if (i > p)
            {
                p = i
                break
            }
            else
            {
                PrimeNumberArray.append(i)
            }
        }
    }
}
print("\nEratosthenes says that first \(PrimeNumberArray.count) prime numbers are: \(PrimeNumberArray)")


