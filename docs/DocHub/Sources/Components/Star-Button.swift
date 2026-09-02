import Raptor

struct StarButton: HTML {
    let owner: String
    let repo: String
    
    var body: some HTML {
        Include("star-button.html")
        Tag("github-star")
            .attribute("owner", owner)
            .attribute("repo", repo)
    }
}
