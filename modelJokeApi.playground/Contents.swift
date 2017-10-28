//: Playground - noun: a place where people can play

import Foundation
import PlaygroundSupport


struct JokeList {
    var jokes: [Joke]
}

struct Joke {
    var id: Int
    var type: String
    var setup: String
    var punchline: String
}

extension Joke: Decodable {
    enum jokeKeys: CodingKey {
        case id
        case type
        case setup
        case punchline
    }
    
    init(from decoder: Decoder) throws {
        let container  = try? decoder.container(keyedBy: jokeKeys.self)
        
        let id = try? container?.decode(Int.self, forKey: jokeKeys.id)
        let type = try? container?.decode(String.self, forKey: jokeKeys.type)
        let setup = try? container?.decode(String.self, forKey: jokeKeys.setup)
        let punchline = try? container?.decode(String.self, forKey: jokeKeys.punchline)
        
        self.init(id: id!!, type: type!!, setup: setup!!, punchline: punchline!!)
    }
}

let url = URL(string: "https://08ad1pao69.execute-api.us-east-1.amazonaws.com/dev/random_ten")!

var request = URLRequest(url: url)
request.httpMethod = "GET"
typealias JSON = [String: Any]
let session = URLSession.shared

let task = session.dataTask(with: request) { (data, response, error) in
    
    let data = try? JSONDecoder().decode([Joke].self, from: data!)
    for jokes in data! {
        print("Type of joke: \(jokes.type)")
        print("Setup: \(jokes.setup)")
        print("Punchline: \(jokes.punchline)\n\n")
    }
}

// Don't forget to resume task
task.resume()






















PlaygroundSupport.PlaygroundPage.current.needsIndefiniteExecution = true
