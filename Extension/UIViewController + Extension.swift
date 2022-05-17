//
//  UIViewController + Extension.swift
//  client
//
//  Created by 盛子康 on 2021/4/7.
//
import MapKit

public extension UIViewController{
    
    func alertMessage(title:String?,msg:String?,leftTitle:String = "取消",rightTitle:String = "确定",leftCallBack:((UIAlertAction) -> Void)? = nil,rightCallBack:((UIAlertAction) -> Void)? = nil){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: leftTitle, style: .cancel, handler: leftCallBack))
        alert.addAction(UIAlertAction(title: rightTitle, style: .destructive, handler: rightCallBack))
        present(alert, animated: true)
    }
    
    func sheetMessage(title:String?,msg:String?,actionTitles:[String],selectCallBack:((UIAlertAction) -> Void)?){
        let sheet = UIAlertController(title: title, message: msg, preferredStyle: .actionSheet)
        
        for item in actionTitles{
            sheet.addAction(UIAlertAction(title: item, style: .default, handler: selectCallBack))
        }
        
        sheet.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        
        present(sheet, animated: true)
    }
    
    func alertConfirmMessage(title:String?,msg:String?,confirmTitle:String = "确定",confirmCallBack:((UIAlertAction) -> Void)? = nil){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: confirmTitle, style: .destructive, handler: confirmCallBack))
        present(alert, animated: true)
    }
    
    ///push之后调用
    func removeSelf(){
        if let count = navigationController?.viewControllers.count{
            navigationController?.viewControllers.remove(at: count - 2)
        }
    }
    
    @objc func callAction(number:String){
        let phoneUrlStr = "telprompt://" + number
        guard let url = URL(string: phoneUrlStr) else{return}
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    var topPresented: UIViewController{
        if let presented = presentedViewController{
            return presented.topPresented
        }else{
            return self
        }
    }
    
    var currentTopViewController: UIViewController?{
        if let tabVc = self as? UITabBarController{
            return tabVc.selectedViewController?.currentTopViewController
        }else if let navi = self as? UINavigationController{
            return navi.topViewController?.currentTopViewController
        }else{
            return self
        }
    }
}

public extension UIViewController{
    
    func navigationAction(location:CLLocationCoordinate2D) {
        let canOpenBaidu = UIApplication.shared.canOpenURL(URL(string: "baidumap://")!)
        let canOpenGaode = UIApplication.shared.canOpenURL(URL(string: "iosamap://")!)
        let canOpenGoogle = UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!)
        
        let alertController = UIAlertController(title: "即将开始导航", message: "请选择导航方式",
                                                preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let appleAction = UIAlertAction(title: "Apple系统地图", style: .default) { (action) in
            let currentLocation = MKMapItem.forCurrentLocation()
            let toLocation = MKMapItem(placemark:MKPlacemark(coordinate:CLLocationCoordinate2DMake(location.latitude, location.longitude),addressDictionary:nil))
            toLocation.name = "发车人出发地"
            
            MKMapItem.openMaps(with: [currentLocation,toLocation], launchOptions: [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey:NSNumber(value: true)])
        }
        alertController.addAction(cancelAction)
        alertController.addAction(appleAction)
        ///https://lbsyun.baidu.com/index.php?title=uri/api/ios
        ///let common = BMKCoordTrans(location, BMK_COORD_TYPE.COORDTYPE_BD09LL,BMK_COORD_TYPE.COORDTYPE_COMMON)百度坐标与其他之间要转换
        if canOpenBaidu {
            let baiduAction = UIAlertAction(title: "百度地图", style: .default) { (action) in
                let urlString = "baidumap://map/navi?location=\(location.latitude),\(location.longitude)&coord_type=bd09ll&type=DEFAULT&src=bindleID"
                let url = URL(string:urlString.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)!)
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            }
            alertController.addAction(baiduAction)
        }
        
        if canOpenGaode {
            let gaodeAction = UIAlertAction(title: "高德地图", style: .default) { (action) in
                let urlString = "iosamap://navi?sourceApplication=APP名&backScheme=iosamap://&lat=\(location.latitude)&lon=\(location.longitude)&dev=0&style=2"
                let url = URL(string:urlString.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)!)
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            }
            alertController.addAction(gaodeAction)
        }
        
        if canOpenGoogle {
            let googleAction = UIAlertAction(title: "谷歌地图", style: .default, handler: { (action) in
                let urlString = "comgooglemaps://?x-source=app名&x-success=comgooglemaps://&saddr=&daddr=\(location.latitude),\(location.longitude)&directionsmode=driving"
                let url = URL(string:urlString.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)!)
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            })
            alertController.addAction(googleAction)
        }
        present(alertController, animated: true, completion: nil)
    }
}
