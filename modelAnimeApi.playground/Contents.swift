//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import WebKit


struct AnimeList: Decodable {
    var data: [Anime]
}
struct Anime {
    let title: (String, String)
    let synopsis: String
    let poster: URL
    let id: String
}

extension Anime: Decodable {
    enum Keys: String, CodingKey {
        case id
        case attributes
    }
    
    enum TitleKeys: String, CodingKey {
        case english = "en"
        case japanese = "ja_jp"
    }
    
    enum PosterKeys: String, CodingKey {
        case poster = "small"
    }
    
    enum AttributeKeys: String, CodingKey {
        case title = "titles"
        case posterImage
        case synopsis
    }
    
    init(from decoder: Decoder) throws {
        
        // top level container
        let container = try? decoder.container(keyedBy: Keys.self)
        
        
        let id = try? container?.decodeIfPresent(String.self, forKey: .id)
        
        
        //key up the attributes container
        let attributesContainer = try? container?.nestedContainer(keyedBy: AttributeKeys.self, forKey: .attributes)
        
        
        //key up the titles container
        let titlesInContainer = try? attributesContainer??.nestedContainer(keyedBy: TitleKeys.self, forKey: .title)
        
        //titles
        let englishTitle = try titlesInContainer??.decodeIfPresent(String.self, forKey: .english) ?? "anime name"
        let japaneseTitle = try titlesInContainer??.decodeIfPresent(String.self, forKey: .japanese) ?? "アニメ　名前"
        
        
        //images
        let moviePosterContainer = try? attributesContainer??.nestedContainer(keyedBy: PosterKeys.self, forKey: .posterImage)
        
        
        let moviePoster = try? moviePosterContainer??.decode(URL.self, forKey: .poster)
        
        //synopsis
        let description = try? attributesContainer??.decode(String.self, forKey: .synopsis)
        
        
        self.init(title: (englishTitle, japaneseTitle), synopsis: description!!, poster: moviePoster!!, id: id!!)
    }
}


class animeNetwork {
    let session = URLSession.shared
    let baseUrl = URL(string: "https://kitsu.io/api/edge/anime")!
    
    func getAnime(id: String, completion: @escaping ([Anime]) -> Void) {
        var request = URLRequest(url: baseUrl)
        request.httpMethod = "GET"
        
        session.dataTask(with: request, completionHandler: {(data, response, error) in
            
            if let data = data {
                let animeList = try? JSONDecoder().decode(AnimeList.self, from: data)
                
                guard let animes = animeList?.data else {return}
                completion(animes)
            }
        }).resume()
    }
    
}

var network = animeNetwork()
//network.getAnime(id: "1") {(result) in
//    print(result)
//}

class animeFrames: UIViewController, WKUIDelegate {
    
    var network = animeNetwork()
    var webView = WKWebView()
    
    override func loadView() {
        let animeView = UIView()
        
        //create title label
        let animeTitle = UILabel()
        animeTitle.frame = CGRect(x: 10, y: 10, width: 300, height: 20)
        animeTitle.textColor = .white
        
        
        //test label
        let animeSynopsis = UILabel()
        animeSynopsis.frame = CGRect(x: 10, y: 350, width: 200, height: 30)
        animeSynopsis.textRect(forBounds: animeSynopsis.frame, limitedToNumberOfLines: 30)
        animeSynopsis.textColor = .white
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: CGRect(x: 10, y: 40, width: 200, height: 300), configuration: webConfiguration)
        
        
        network.getAnime(id: "1") {(result) in
            let request = URLRequest(url: result[1].poster)
            self.webView.load(request)
            animeTitle.text = result[1].title.0
            animeSynopsis.text = result[1].synopsis
        }
        
        animeView.addSubview(webView)
        animeView.addSubview(animeTitle)
        animeView.addSubview(animeSynopsis)
        self.view = animeView
    }
}




// Present the view controller in the Live View window
PlaygroundPage.current.liveView = animeFrames() as PlaygroundLiveViewable
PlaygroundPage.current.needsIndefiniteExecution = true
