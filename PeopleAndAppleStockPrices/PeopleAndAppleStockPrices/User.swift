//
//  User.swift
//  PeopleAndAppleStockPrices
//
//  Created by David Rifkin on 9/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct UserWrapper: Codable {
    let results: [User]
}

struct User: Codable {
    let name: Name
    let location: Location
    
    struct Name: Codable {
        let title: String?
        private let firstName: String?
        private let lastName: String?
        var fullName: String? {
            return "\(firstName ?? "a")) \(lastName ?? "b")"
        }
        
        private enum CodingKeys: String, CodingKey {
            case title
            case firstName = "first"
            case lastName = "last"
        }
    }
    
    struct Location: Codable {
        private let street: Street?
        private let city: String?
//        var address: String? {
//            return "\(street ?? ""), \(city ?? "")"
//        }
    }
    
    struct Street: Codable {
        private let number: Int?
        private let name: String?
    }
    
    
    static func getUsers() -> [User] {

        guard let fileName = Bundle.main.path(forResource: "userinfo", ofType: "json") else {fatalError()}
        let fileURL = URL(fileURLWithPath: fileName)
        do {
            let data = try Data(contentsOf: fileURL)
            let users = try JSONDecoder().decode(UserWrapper.self, from: data)
            return users.results
        } catch {
            print(error)
        }
        return [User]()
    }
}

//"results": [
//{
//    "gender": "male",
//    "name": {
//        "title": "Mr",
//        "first": "Kasper",
//        "last": "Petersen"
//    },
//    "location": {
//        "street": {
//            "number": 6732,
//            "name": "Udbyhøjvej"
//        },
//        "city": "St.Merløse",
//        "state": "Syddanmark",
//        "country": "Denmark",
//        "postcode": 53691,
//        "coordinates": {
//            "latitude": "-30.6942",
//            "longitude": "-110.9073"
//        },
//        "timezone": {
//            "offset": "-5:00",
//            "description": "Eastern Time (US & Canada), Bogota, Lima"
//        }
//    },
//    "email": "Kasper.Petersen@example.com",
//    "login": {
//        "uuid": "7c4aece7-e45e-4218-a15e-ed50daf50c69",
//        "username": "goldentiger896",
//        "password": "alexande",
//        "salt": "6tw5hfI6",
//        "md5": "b6e8c9ed437722dbeaab8113518202a9",
//        "sha1": "ca784452f8e7c6ea176fedd6553418c4f015ea7e",
//        "sha256": "2ab0dbace7c20be3a1bb4fbe0591189470c51e96a7f136a934494ef721ae45cd"
//    },
//    "dob": {
//        "date": "1988-11-15T08:00:01.283Z",
//        "age": 31
//    },
//    "registered": {
//        "date": "2008-07-22T09:31:56.835Z",
//        "age": 11
//    },
//    "phone": "86930845",
//    "cell": "15368167",
//    "id": {
//        "name": "CPR",
//        "value": "151188-6019"
//    },
//    "picture": {
//        "large": "https://randomuser.me/api/portraits/men/5.jpg",
//        "medium": "https://randomuser.me/api/portraits/med/men/5.jpg",
//        "thumbnail": "https://randomuser.me/api/portraits/thumb/men/5.jpg"
//    },
//    "nat": "DK"
//},
