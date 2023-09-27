actor ProgressMonitor {
    let searchTerm: String
    private(set) var total = 0
    private(set) var downloaded = 0
    
    init(for searchTerm: String) {
        self.searchTerm = searchTerm
    }
}

extension ProgressMonitor {
    func reset(total: Int) {
        self.total = total
        downloaded = 0
    }
    
    func registerImageDownload(for appName: String) async {
        downloaded += 1
        try? await Task.sleep(for: .seconds(0.001))
        print("downloaded \(downloaded) / \(total) = \(appName)")
    }
}
