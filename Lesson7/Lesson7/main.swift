// Иванов Вадим, СПб, Россия
//
//  main.swift
//  Lesson7
//
//  Created by Iv on 20/02/2019.
//  Copyright © 2019 Iv. All rights reserved.
//

import Foundation

/* Task:
 1. Придумать класс, методы которого могут создавать непоправимые ошибки. Реализовать их с помощью try/catch.
 2. Придумать класс, методы которого могут завершаться неудачей. Реализовать их с использованием Error.
*/

enum AccessError: String, Error {
    case Unauthorized = "Authorization required"
    case NotFound = "Book not found"
    case NoContent = "Library is empty"
}

class BookServer {
    private var authorizedUsers = Set<String>()
    func authorize(_ user: String) {
        authorizedUsers.insert(user.lowercased())
    }
    private func isAuthorized(_ user: String) -> Bool {
        return authorizedUsers.contains(user.lowercased())
    }
    
    private var books = Dictionary<String, String>()
    init() {
        books["Толстой.Анна Каренина"] = "Все счастливые семьи похожи друг на друга, каждая несчастливая семья несчастлива по-своему."
        books["Достевский.Преступление и наказание"] = "В начале июля, в чрезвычайно жаркое время, под вечер, один молодой человек вышел из своей каморки, которую нанимал от жильцов в С — м переулке, на улицу и медленно, как бы в нерешимости, отправился к К — ну мосту."
        books["Пушкин.Евгений Онегин"] = "Мой дядя самых честных правил,\nКогда не в шутку занемог,\nОн уважать себя заставил\nИ лучше выдумать не мог."
        books["Лермонтов.Бородино"] = "- Скажи-ка, дядя, ведь не даром\nМосква, спаленная пожаром,\nФранцузу отдана?"
        books["Гоголь.Невский проспект"] = "Нет ничего лучше Невского проспекта, по крайней мере в Петербурге; для него он составляет все."
    }
    
    // return books list or throw exception
    private func GetBookList(user: String) throws -> [String] {
        guard isAuthorized(user) else {
            throw AccessError.Unauthorized
        }
        guard !books.isEmpty else {
            throw AccessError.NoContent
        }
        return [String](books.keys).sorted()
    }
    
    // return books list or error if is
    func SafeGetBookList(user: String) -> ([String]?, String) {
        var res: ([String]?, String) = (nil, "")
        do {
            res.0 = try GetBookList(user: user)
        } catch AccessError.Unauthorized {
            res.1 = AccessError.Unauthorized.rawValue
        } catch AccessError.NoContent {
            res.1 = AccessError.NoContent.rawValue
        } catch {
            res.1 = "Unexpected error"
        }
        return res
    }

    // return inquired book or throw exception
    func GetBook(user: String, bookname: String) throws -> String {
        guard isAuthorized(user) else {
            throw AccessError.Unauthorized
        }
        if let book = books[bookname] {
            return book
        } else {
            throw AccessError.NotFound
        }
    }
}



var bookserver = BookServer()
var username = "Incognito"
print("Unauthorized access")
var books = bookserver.SafeGetBookList(user: username)
if (books.0 != nil) {
    print(books.0!)
} else {
    print(books.1)
}
print("\nAuthorized access")
username = "Мамолькин"
bookserver.authorize(username)
books = bookserver.SafeGetBookList(user: username)
print("Пользователь \(username)")
if (books.0 != nil) {
    print(books.0!)
} else {
    print(books.1)
}
print("\nGet existing book")
var bookname = "?"
if books.0 != nil && books.0!.count > 3 {
    bookname = books.0![3]
}
if let book = try? bookserver.GetBook(user: username, bookname: bookname) {
    print(bookname)
    print(book)
}
print("\nGet not existing book")
bookname = "Пелевин.Чапаев и Пустота"
do {
    let book = try bookserver.GetBook(user: username, bookname: bookname)
    print(bookname)
    print(book)
} catch {
    print("Похоже, \(username), книги \"\(bookname)\" нет, сервер вернул \(error)")
}


