//
//  UIImage.swift
//  client
//
//  Created by 盛子康 on 2021/4/13.
//

public extension UIImage{
    
    /// 获取指定尺寸的image data--用剪切图片的方式
    ///
    /// - Parameter valideSize: 指定尺寸，出来的data可能会稍大，单位kb
    /// - Returns: Data
    func imageDataForExpectSizeByShear(valideSize:CGFloat) -> Data?{
        guard let data = self.pngData() else{return nil}
        let dataSize = CGFloat(data.count) / 1024.0
        guard dataSize > valideSize else { //图片kb小于等于制定尺寸 返回原图
            return data
        }
        
        let ratio = dataSize / valideSize //判断图片尺寸是指定尺寸的倍数
        let ratioSize = CGSize(width: self.size.width / sqrt(ratio), height: self.size.height / sqrt(ratio)) //压缩的长宽size
        UIGraphicsBeginImageContext(ratioSize) //开始绘图
        self.draw(in: CGRect(x: 0, y: 0, width: ratioSize.width, height: ratioSize.height))
        let ratioImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return ratioImage?.pngData()
    }
    
    /// 获取指定尺寸image data--用图片压缩方式，图片会失帧，质量变差，大小不变,quality循环减少0.05
    ///
    /// - Parameter validateSize: 指定尺寸，单位kb
    /// - Returns: Data
    func imageDataForExpectSizeByCompression(validateSize:CGFloat) -> Data?{
        guard var data = self.pngData() else {return nil}
        let validate = validateSize * 1024.0
        var quality:CGFloat = 1.0
        while CGFloat(data.count) > validate {
            data = self.jpegData(compressionQuality: quality)!
            quality -= 0.05
        }
        return data
    }
    
    func toScaleImage(size:CGSize) -> UIImage?{
        
        UIGraphicsBeginImageContext(size)
        
        draw(in: CGRect(origin: .zero, size: size))
        
        let scaleImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return scaleImage
    }
}
