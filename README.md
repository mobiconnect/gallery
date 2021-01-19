# NEWS

Most good apps need some form of content, be it news or stories etc. Use the NEWS feature to publish content. You can feature particular news and include images, links to video with varying call to actions.

# Customization parameters available 

| Attribute          |      Type     |
| -------------      | ------------- |
| name*          | String |
| shortDescription*  | String  |
| longDescription            | String  |
| newsDate*           | date  |
| endDate*           | date  |
| moreInfo        | String  |
| moreInfoButtonText    | String  |
| youtubeUrl  | String    |
| enabled            | boolean  |
| sendAsNotification           | boolean  |
| featured           | boolean  |
| categoryIds | array of integers  |
| scheduled           | boolean  |
| image    | String  |

# How to try
To use this sample code you should have already registered with AOtomot platform. Once you register you will have your worksmapce name and apikey available, place then in Url.swift file in "workspaceName" and "apiKey" and run your code.
```
struct Urls {

  static let workspaceName = ""
  static let apiKey = ""
  static let baseUrl = "https://\(workspaceName).aotomot.com/api/"
  
  // Onboarding
  static let onboarding = "\(baseUrl)onboarding?apiKey=\(apiKey)"

}
```

# Where can I find my apikey
Log into our [licensing manager](https://aotomot.com/login/) with your registered username and password. You can find the workspace name and apik under your project.
![apiKey](https://user-images.githubusercontent.com/54090983/63316567-ac7b3100-c352-11e9-8038-ff91c287be7f.png)

# API documentation
You can checkout our api documentation and try them [here](https://docs.aotomot.com/reference/news-overview) 
