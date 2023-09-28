@globalActor
actor ProgressMonitor {
    static let shared = ProgressMonitor()
    private(set) var searchTerm = ""
    private(set) var total = 0
    private(set) var downloaded = 0
    
    private init() {}
}

extension ProgressMonitor {
    func reset(total: Int, for searchTerm: String) {
        self.total = total
        downloaded = 0
        self.searchTerm = searchTerm
        header()
    }
    
    func header() {
        seporator()
        print("\(searchTerm) has \(total) results")
        seporator()
    }
    
    nonisolated
    func seporator() {
        print("=====")
    }
    
    func registerImageDownload(for appName: String)  {
        downloaded += 1
        status(for: appName)
    }
    
    func status(for appName: String) {
        print("\(downloaded) / \(total) = \(appName)")
    }
}


