// functions are placed at the top so that the code in the body application may be
// modularized

/*
 Takes in a array of players each represented by a dictionary and returns an int
 equal to the amount of true values that are associated with the key "experienced"
 in each dictionary
 */
func countExpPlayers(from players: [[String: String]]) -> Int {
    var expPlayers: Int = 0
    
    for player in players {
        let exp = player["experienced"]!
        if exp == "true"{
            expPlayers += 1
        }
    }
    
    return expPlayers
}


/*
 Takes in an array of players and sorts them by height
 */
func sortPlayersByHeight(players: [[String : String]]) -> [[String : String]] {
    var sortedHeights : [Double] = []
    var sortedPlayers : [[String : String]] = []
    
    // iterate through players and add the heights to sortedHeights
    for player in players {
        let height = Double(player["height"]!)!
        if sortedHeights.contains(height){
            continue
        } else {
        sortedHeights.append(height)
        }
    }
    
    sortedHeights.sort(by: >)
    
    // iterate through sortedHeights and assign the items in players
    // to sortedPlayers in the order that their height values match the values
    // in sortedHeights
    
    for height in sortedHeights {
        let strHeight = String(height)
        for player in players {
            if strHeight == player["height"]{
                sortedPlayers.append(player)
            }
        }
    }
    
    return sortedPlayers
    
    
}

/*
 Takes in a team and returns the average height
 */
func getAverageHeight(from team: [[String: String]]) -> Double {
    var average = 0.0
    for player in team{
        let height = player["height"]!
        average += Double(height)!
    }
    
    return average / Double(team.count)
}

/*
 takes in a string and returns a report of the average height of that team
 */
func reportAverageHeightFor(team: [[String : String]], name: String) -> String{
    let averageHeight = team[team.count - 1]["Average Height"]!
    
    return "Team \(name) = \(averageHeight)"
}

/*
 Takes in an Array of players each represented by a dictionary and returns
 a tuple containing three arrays each representing a team made from the players, such
 that each team contains the same number of experienced players
 */
func makeTeam(from players: [[String : String]]) -> ([[String : String]], [[String : String]],
                                                    [[String : String]]){
    var sharks: [[String: String]] = []
    var dragons: [[String: String]] = []
    var raptors: [[String: String]] = []
    
    var teamSwitch : Int = -1 /*-1, 0, and 1 represent sharks, dragons and raptors
                                respectively
                              */
    
    for player in players {
        // distribute the experienced players
        let experienced = player["experienced"]!
        if  experienced == "true"{
            switch teamSwitch {
            case -1:sharks.append(player); teamSwitch = 0
            case 0: dragons.append(player); teamSwitch = 1
            case 1: raptors.append(player); teamSwitch = -1
            default: teamSwitch = -1
 
            } } else {
            // the list of players is sorted based on height prior to
            // being input into this function so we do not check for heigth when
            // distributing the players
            switch teamSwitch {
            case -1: sharks.append(player); teamSwitch = 0
            case 0: dragons.append(player); teamSwitch = 1
            case 1: raptors.append(player); teamSwitch = -1
            default: teamSwitch = -1
            }
        }
    }
                                                        
    sharks.append(["Average Height" : String(getAverageHeight(from: sharks))])
    dragons.append(["Average Height" : String(getAverageHeight(from: dragons))])
    raptors.append(["Average Height" : String(getAverageHeight(from: raptors))])
 
                                                        
    return (sharks, dragons, raptors)
}




/*
 Takes a team name and a team, and iterates through the team to produce letters
 to the guardians of each player
 */

func composeLettersFrom(team: [[String : String]], for name: String) -> [String]{
    var letters: [String] = []
    switch name {
    case "Sharks":
        // Uses the half open range operator so that index will stop shy of
        // the last index for team since that index contains the dictionary that
        // holds the Average Height of the team and will result in an error
        for index in 0..<team.count - 1 {
            let sharkPlayer = team[index]
            let guardian = sharkPlayer["guardians"]!
            let playerName = sharkPlayer["name"]!
            let letter = "Dear \(guardian) your child \(playerName)"
                        + " is on team \(name) so their team meets for practice on " +
                        "March 17, 3pm"
            letters.append(letter)
        }
    case "Dragons":
        for index in 0..<team.count - 1 {
            let dragonPlayer = team[index]
            let guardian = dragonPlayer["guardians"]!
            let playerName = dragonPlayer["name"]!
            let letter = "Dear \(guardian) your child \(playerName)"
                + " is on team \(name) so their team meets for practice on " +
            "March 17, 1pm"
            letters.append(letter)
        }
    case "Raptors":
        for index in 0..<team.count - 1 {
            let raptorPlayer = team[index]
            let guardian = raptorPlayer["guardians"]!
            let playerName = raptorPlayer["name"]!
            let letter = "Dear \(guardian) your child \(playerName)"
                + " is on team \(name) so their team meets for practice on " +
            "March 18, 1pm"
            letters.append(letter)
        }
    default: return letters
        
    }
    // Strings are added to the front and back of the letters array so
    // that printing is easier later on
    letters.insert("-----------------\(name)-------------------", at: 0)
    letters.append("-------------------------------------------")
    return letters
}


/*
 Takes a tuple representing teams and returns a tuple
 containing arrays of letters to the guardians of each player
 based on the team the player is on
 */
func makeLetters(from teams: ([[String : String]], [[String : String]],[[String : String]]))
    -> ([String], [String], [String])
{
    
    let sharks = teams.0
    let dragons = teams.1
    let raptors = teams.2
    
    let sharkLetters : [String] = composeLettersFrom(team: sharks, for: "Sharks")
    let dragonLetters : [String] = composeLettersFrom(team: dragons, for: "Dragons")
    let raptorLetters : [String] = composeLettersFrom(team: raptors, for: "Raptors")
    
    return (sharkLetters, dragonLetters, raptorLetters)
    
}


/*
 Takes in a tuple containing letters and outputs them
 */
func outputLetters(letters : ([String], [String], [String])){
    let sharkLetters = letters.0
    let dragonLetters = letters.1
    let raptorLetters = letters.2
    
    for letter in sharkLetters{
        print(letter)
    }
    
    for letter in dragonLetters{
        print(letter)
    }
    
    for letter in raptorLetters{
        print(letter)
    }
}

/*
 Makes an array dictionaries that represent each player
 */
let players: [[String: String]] = [["name" : "Joe Smith", "height" : "42.0",
            "experienced" : "true", "guardians" : "Jim and Jan smith"],
            ["name": "Jill Tanner" , "height": "36.0", "experienced": "true" , "guardians": "Clara Tanner" ],
            ["name": "Bill Bon" , "height": "43.0", "experienced": "true" , "guardians": "Sara and Jenny Bon"],
            ["name": "Eva Gordon" , "height": "45.0", "experienced": "false", "guardians": "Wendy and Mike Gordon" ],
            ["name": "Matt Gill" , "height": "40.0", "experienced": "false" , "guardians": "Charles and Sylvia Gill"],
            ["name": "Kimmy Stein" , "height": "41.0", "experienced": "false" , "guardians": "Bill and Hillary Stein" ],
            ["name": "Sammy Adams", "height": "45.0", "experienced": "false" , "guardians": "Jeff Adams" ],
            ["name": "Karl Saygan" , "height": "42.0", "experienced": "true", "guardians": "Heather Bledsoe"],
            ["name": "Suzane Greenberg", "height": "44.0", "experienced": "true", "guardians": "Henrietta Dumas" ],
            ["name": "Sal Dall", "height": "41.0", "experienced": "false", "guardians": "Gala Dall"],
            ["name": "Joe Kavaller" , "height": "39.0", "experienced": "false", "guardians": "Sam and Elaine Kavaller" ],
            ["name": "Ben Finkelstein" , "height": "44.0", "experienced": "false" , "guardians": "Aaron and Jill Finkelstein" ],
            ["name": "Diego Soto" , "height": "41.0", "experienced": "true", "guardians": "Robin and Sarika Soto"],
            ["name": "Chole Alaska", "height": "47.0", "experienced": "false" , "guardians": "David and Jamie Alaska" ],
            ["name": "Arnold Willis" , "height": "43.0", "experienced": "false" , "guardians": "Clair Willis"],
            ["name": "Phillip Helm", "height": "44.0", "experienced": "true" , "guardians": "Thomas Helm and Eva Jones"],
            ["name": "Les Clay" , "height": "42.0", "experienced": "true", "guardians": "Wyonna Brown" ],
            ["name": "Herschel Krustofski", "height": "45.0", "experienced": "true", "guardians": "Hyman and Rachel Krustofski" ]]





// Main Application
let teams = makeTeam(from: sortPlayersByHeight(players: players))
let letters = makeLetters(from: teams)
let sharks = teams.0
let dragons = teams.1
let raptors = teams.2

// Output the letters of each team
outputLetters(letters: letters)

// Output the average height of each team
print("-----------------Average Heigth-------------------")
print(reportAverageHeightFor(team: sharks, name: "Sharks"))
print(reportAverageHeightFor(team: dragons, name: "Dragons"))
print(reportAverageHeightFor(team: raptors, name: "Raptors"))
