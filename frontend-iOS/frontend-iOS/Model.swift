//
//  Model.swift
//  frontend-iOS
//
//  Created by Ashwin Vivek on 3/11/18.
//  Copyright © 2018 cs-m117. All rights reserved.
//

import Foundation

struct Games: Decodable {
    let teams: [String]
    let goals: [Int]
    let _id: String
    let game_id: String
    let _v: Int
    let active: String
    let game_time: Int
    let start_details: String
    
    enum CodingKeys: String, CodingKey {
        case teams
        case goals
        case _id
        case game_id
        case _v
        case active
        case game_time
        case start_details
    }
}


class Game: NSObject, NSCoding  {
    let team1: String
    let team2: String
    let date: String
    let game_id: String
    
    init(team1: String, team2: String, date: String, game_id: String) {
        self.team1 = team1
        self.team2 = team2
        self.date = date
        self.game_id = game_id
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let team1 = aDecoder.decodeObject(forKey: "team1") as! String
        let team2 = aDecoder.decodeObject(forKey: "team2") as! String
        let date = aDecoder.decodeObject(forKey: "date") as! String
        let game_id = aDecoder.decodeObject(forKey: "game_id") as! String
        self.init(team1: team1, team2: team2, date: date, game_id: game_id)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(team1, forKey: "team1")
        aCoder.encode(team2, forKey: "team2")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(game_id, forKey: "game_id")
    }
};

class Alarm: NSObject, NSCoding  {
    let team1: String
    let team2: String
    let game_id: String
    let numConditions: Int
    
    init(team1: String, team2: String, game_id: String, numConditions: Int) {
        self.team1 = team1
        self.team2 = team2
        self.game_id = game_id
        self.numConditions = numConditions
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let team1 = aDecoder.decodeObject(forKey: "team1") as! String
        let team2 = aDecoder.decodeObject(forKey: "team2") as! String
        let game_id = aDecoder.decodeObject(forKey: "game_id") as! String
        let numConditions = aDecoder.decodeInteger(forKey: "numConditions")
        self.init(team1: team1, team2: team2, game_id: game_id, numConditions: numConditions)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(team1, forKey: "team1")
        aCoder.encode(team2, forKey: "team2")
        aCoder.encode(game_id, forKey: "game_id")
        aCoder.encode(numConditions, forKey: "numConditions")
    }
};

class Condition: NSObject, NSCoding {
    let team: Int
    let game_id: String
    let condition_type: Int
    let time_option: Int
    let goal_option: Int
    
    init(team: Int = -1, game_id: String = "", condition_type: Int = -1, time_option: Int = -1, goal_option: Int = -1) {
        self.team = team
        self.game_id = game_id
        self.condition_type = condition_type
        self.time_option = time_option
        self.goal_option = goal_option
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let team = aDecoder.decodeInteger(forKey: "team")
        let game_id = aDecoder.decodeObject(forKey: "game_id") as! String
        let condition_type = aDecoder.decodeInteger(forKey: "condition_type")
        let time_option = aDecoder.decodeInteger(forKey: "time_option")
        let goal_option = aDecoder.decodeInteger(forKey: "goal_option")
        self.init(team: team, game_id: game_id, condition_type: condition_type, time_option: time_option, goal_option: goal_option)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(team, forKey: "team")
        aCoder.encode(game_id, forKey: "game_id")
        aCoder.encode(condition_type, forKey: "condition_type")
        aCoder.encode(time_option, forKey: "time_option")
        aCoder.encode(goal_option, forKey: "goal_option")
    }
};
