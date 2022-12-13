import Foundation

let headers = [
    "X-RapidAPI-Key": "96ab32899emsh5c3943e655729a0p1d3262jsn3193b081ca25",
    "X-RapidAPI-Host": "youtube-music1.p.rapidapi.com"
]
request.httpMethod = "GET"
request.allHTTPHeaderFields = headers
let request = NSMutableURLRequest(url: NSURL(string: "https://youtube-music1.p.rapidapi.com/v2/search?query=eminem")! as URL,
                                        cachePolicy: .useProtocolCachePolicy,
                                    timeoutInterval: 10.0)


let session = URLSession.shared
let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
    if (error != nil) {
        print(error)
    } else {
        let httpResponse = response as? HTTPURLResponse
        print(httpResponse)
    }
})

dataTask.resume()
