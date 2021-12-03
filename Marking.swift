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
            v1 = 2 * drand48() - 1
            v2 = 2 * drand48() - 1
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

    var markArray = Array(
        repeating: Array(repeating: "0", count: numAssignments + 1),
        count: numStudents)

    for loop1 in 0..<numStudents {
        markArray[loop1][0] = students[loop1]

        for loop2 in 0..<numAssignments {

            let mark = Int(floor(nextGaussian() * 10 + 75))
            markArray[loop1][loop2 + 1] = String(mark)
        }
    }

    return markArray
}

// Collects CLI arguments, parses it into an array of strings and then into an
// array of ints.
let studentsFilename = CommandLine.arguments[1]
let studentsContents = try String(contentsOfFile: studentsFilename)
let studentsLines = studentsContents.split(separator: "\n")
var studentsArray = [String]()
studentsArray.reserveCapacity(studentsLines.count)

for line in studentsLines where !line.isEmpty {
    studentsArray.append(String(line))
}

let assignmentsFilename = CommandLine.arguments[2]
let assignmentsContents = try String(contentsOfFile: assignmentsFilename)
let assignmentsLines = assignmentsContents.split(separator: "\n")
var assignmentsArray = [String]()
assignmentsArray.reserveCapacity(assignmentsLines.count)

for line in assignmentsLines where !line.isEmpty {
    studentsArray.append(String(line))
}

let markArray = generateTable(students: studentsArray, assignments:
    assignmentsArray)

print(markArray)
