import Distributed

distributed actor Searcher {
  typealias ActorSystem = LocalTestingDistributedActorSystem
  
  let name: String
  let appStore: AppStore
  
  init(name: String,
       appStore: AppStore,
       actorSystem: ActorSystem) {
    self.name = name
    self.appStore = appStore
    self.actorSystem = actorSystem
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
