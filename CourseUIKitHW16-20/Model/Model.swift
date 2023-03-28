//
//  Model.swift
//  CourseUIKitHW16-20
//
//  Created by Денис Курлыков on 27.03.2023.
//

import Foundation

struct Model {
    let name: String
    let description: String
    let coast: String
    let imageName: String
    
    static func getModel() -> [Model] {
        [
            Model(
                name: """
Чехол Incase
Flat для ноутбука
MacBook Pro 13"
""",
                description: "Чехол Incase Flat для ноутбука MacBook Pro 13",
                coast: "3990",
                imageName: "Case"
            ),
            Model(
                name: """
Спортивный ремешок
Activ для APPLE Watch 38/40 mm
""",
                description: "Спортивный ремешок Activ для APPLE Watch 38/40 mm",
                coast: "2990",
                imageName: "BlackUnity"
            ),
            Model(
                name: """
кожаный чехол для MacBook
Air и MacBook Pro 13
""",
                description: "Кожаный чехол для MacBook Air и MacBook Pro 13",
                coast: "8990",
                imageName: "LeatherCase"
            )
        ]
    }
}
