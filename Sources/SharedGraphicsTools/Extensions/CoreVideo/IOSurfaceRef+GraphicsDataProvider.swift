import CoreVideoTools

extension IOSurfaceRef: GraphicsDataProvider {
    public func graphicsData() throws -> GraphicsData {
        self.lock(options: [], seed: nil)
        
        let width = self.width
        let height = self.height
        let baseAddress = self.baseAddress
        let bytesPerRow = self.bytesPerRow
        let bytesPerElement = self.bytesPerElement
        guard width > 0, height > 0, bytesPerRow > 0, bytesPerElement > 0
        else { throw GraphicsDataProviderError.missingData }
        
        let graphicsData = GraphicsData(
            width: UInt(width),
            height: UInt(height),
            baseAddress: baseAddress,
            bytesPerRow: UInt(bytesPerRow)
        )
        
        self.unlock(options: [], seed: nil)
        
        return graphicsData
    }
}
extension IOSurfaceRef: MultiplanarPlanarGraphicsDataProvider {
    public func graphicsData(of planeIndex: Int) throws -> GraphicsData {
        self.lock(options: [], seed: nil)
        
        guard planeIndex < self.planeCount
        else { throw GraphicsDataProviderError.missingDataOfPlane(planeIndex) }
        
        let width = self.widthOfPlane(at: planeIndex)
        let height = self.heightOfPlane(at: planeIndex)
        let baseAddress = self.baseAddressOfPlane(at: planeIndex)
        let bytesPerRow = self.bytesPerRowOfPlane(at: planeIndex)
        let bytesPerElement = self.bytesPerElementOfPlane(at: planeIndex)
        guard width > 0, height > 0, bytesPerRow > 0, bytesPerElement > 0
        else { throw GraphicsDataProviderError.missingDataOfPlane(planeIndex) }
        
        let graphicsData = GraphicsData(
            width: UInt(width),
            height: UInt(height),
            baseAddress: baseAddress,
            bytesPerRow: UInt(bytesPerRow)
        )
        
        self.unlock(options: [], seed: nil)
        
        return graphicsData
    }
}
