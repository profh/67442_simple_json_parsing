
import Foundation

let githubURL: NSURL = NSURL(string: "https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc")!

let data = NSData(contentsOfURL: githubURL)!

var logins = [String]()

do {
  let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
  
  // Doing it the painful way first...
  
  if let items = json["items"] as? [NSDictionary] {
    for item in items {
//      print("Optional Binding: \(item)")
      if let ownerData = item["owner"] as? NSDictionary {
//        print("Optional Binding: \(ownerData)")
        for ownerItem in ownerData {
//          print("Optional Binding: \(ownerItem)")
          if let lhdata = ownerItem.0 as? String {
            if lhdata == "login" {
              if let rhdata = ownerItem.1 as? String {
                logins.append(rhdata)
              }
            }
          }
        }
      }
    }
  }
} catch {
  print("error serializing JSON: \(error)")
}

print(logins)



// =========================================
//
// Using SwiftyJSON is much less painful ...
//
// In this case, SwiftyJSON has been added directly to Sources folder
// and automatically included by the playground, so I can call on its
// methods directly.

let swiftyjson = JSON(data: data)

if let owner_login = swiftyjson["items"][0]["owner"]["login"].string {
  print(owner_login)
}




// =====================================================
// A simple looping in-class exercise (prep for midterm)

var owner_logins = [String]()
for i in 0..<5 {
  if let owner_login = swiftyjson["items"][i]["owner"]["login"].string {
    owner_logins.append(owner_login)
  }
}
print(owner_logins)




