actor ProgressMonitor {
    private(set) var searchTerm: String
    private(set) var total = 0
    private(set) var downloaded = 0
    
    init(for searchTerm: String) {
        self.searchTerm = searchTerm
    }
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


