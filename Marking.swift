//
//  Statistics.swift
//
//  Created by Ryan Chung
//  Created on 2021-11-25
//  Version 1.0
//  Copyright (c) 2021 Ryan Chung. All rights reserved.
//
//  This program calculates the mean, median and mode of a given dataset
//  located inside of a text file.
//

import Foundation

private var nextNextGaussian: Double? = {
    srand48(Int.random(in: 0...100))
    return nil
}()

func nextGaussian() -> Double {
    if let gaussian = nextNextGaussian {
        nextNextGaussian = nil
        return gaussian
    } else {
        var v1, v2, s: Double

        repeat {
            v1 = 2 * Double.random(in: 0.0...1.0) - 1
            v2 = 2 * Double.random(in: 0.0...1.0) - 1
            s = v1 * v1 + v2 * v2
        } while s >= 1 || s == 0

        let multiplier = sqrt(-2 * log(s)/s)
        nextNextGaussian = v2 * multiplier
        return v1 * multiplier
    }
}

func generateTable(students: [String], assignments: [String]) -> [[String]] {
    let numStudents = students.count
    let numAssignments = assignments.count

    var markArray: [[String]] = []

    for row in 0..<numStudents {
        markArray.append([String]())
        markArray[row].append(students[row])

        for _ in 0..<numAssignments {
            let mark = Int(floor(nextGaussian() * 10 + 75))
            markArray[row].append(String(mark))
        }
    }

    return markArray
}

func fileContentsToArray(fileName: String) throws -> [String] {
    do {
        let contents = try String(contentsOfFile: fileName)
        let lines = contents.split(separator: "\n")
        var stringArray = [String]()
        stringArray.reserveCapacity(lines.count)

        for line in lines where !line.isEmpty {
            stringArray.append(String(line))
        }

        return stringArray
    } catch {
        print("Something went wrong. Try again.")
        print("\nDone.")
        exit(001)
    }
}

let students = try fileContentsToArray(fileName: CommandLine.arguments[1])
let assignments = try fileContentsToArray(fileName: CommandLine.arguments[2])

print(generateTable(students: students, assignments:assignments))

print("\nDone.")
