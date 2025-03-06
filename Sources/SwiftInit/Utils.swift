//
//  Help.swift
//  CoreKit
//
//  Created by yungui chen on 2024/10/10.
//

extension String {
    
    func camelToSnakeCase(_ input: String) -> String {
        let components = input.split(separator: ".")
        let lastComponent = components.last ?? ""
        var snakeCase = ""
        for (index, character) in lastComponent.enumerated() {
            if character.isUppercase {
                if index > 0 {
                    snakeCase.append("_")
                }
                snakeCase.append(character.lowercased())
            } else {
                snakeCase.append(character)
            }
        }
        return snakeCase
    }

    package func variableName() -> String {
        let snake = camelToSnakeCase(self)
        let last = snake.split(separator: "_").last ?? ""
        return String(last)
    }
}
