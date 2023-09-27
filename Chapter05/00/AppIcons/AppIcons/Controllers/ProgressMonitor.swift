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
        print("\n \(appName) ...")
        try? await Task.sleep(for: .seconds(1))
        print("downloaded \(downloaded)/\(total)")
    }
}
