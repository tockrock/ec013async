actor Searcher {
    let name: String
    let appStore: AppStore
    
    init(name: String,
         appStore: AppStore) {
        self.name = name
        self.appStore = appStore
    }
}

extension Searcher {
    func search(for searchTerm: String) {
        // let the other searchers know abou our
    }
    
    func receive(_ searchTerm: String) {
        // update our list of current searches
    }
}
