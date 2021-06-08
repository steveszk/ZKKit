//
//  SZKKitConfig.swift
//  client
//
//  Created by 盛子康 on 2021/6/3.
//
import CocoaLumberjack
import IQKeyboardManagerSwift
import SVProgressHUD
import Kingfisher

public struct SZKKitConfig {
    
    public static var codeKey:String = "code"
    public static var dataKey:String = "data"
    public static var messageKey:String = "message"
    public static var successCode:Int = 200
    public static var tokenInvalidateCode:Int = 0
    public static var timeout:TimeInterval = 15.0
    
    public static func configPods(){
        
        //DDLog
        //日志，debug打印所有，release不打印,file的loger先不打印,只打印控制台,可以自定义loger和manager，也可以改变文件的位置，让其可见而不是cache里。
        #if DEBUG
        //        let file = DDFileLogger()
        //        file?.rollingFrequency = 60*60*24
        //        file?.logFileManager.maximumNumberOfLogFiles = 7
        //        DDLog.add(file!)
        dynamicLogLevel = .verbose
        let console = DDTTYLogger.sharedInstance
        console?.logFormatter = logFormatter()
        DDLog.add(console!)
        #else
        dynamicLogLevel = .off
        #endif
        
        //键盘设置
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        //加载框
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark) //背景色黑色
        SVProgressHUD.setMinimumDismissTimeInterval(1.5) //最短消失时间
        SVProgressHUD.setImageViewSize(CGSize(width: 0, height: -10))
        
        //图片加载
        KingfisherManager.shared.downloader.downloadTimeout = 10
        KingfisherManager.shared.cache.diskStorage.config.expiration = .days(5)
    }
    
    public static func configRequestValue(codeKey:String,dataKey:String,messageKey:String,successCode:Int,tokenInvalidateCode:Int,timeout:TimeInterval){
        self.codeKey = codeKey
        self.dataKey = dataKey
        self.messageKey = messageKey
        self.successCode = successCode
        self.tokenInvalidateCode = tokenInvalidateCode
        self.timeout = timeout
    }
}

//                              \\//
//                            _ooOoo_
//                         { o8888888o }                           .::::,,;;,                                  .,;;:,,....:i:                             _.._
//                           88" . "88                             :i,.::::,;i:.      ....,,:::::::::,....   .;i:,.  ......;i.                         ,'      `.
//                           (| -_- |)                             :;..:::;::::i;,,:::;:,,,,,,,,,,..,.,,:::iri:. .,:irsr:,.;i.                        /  __) __` \
//                            O\ = /O                              ;;..,::::;;;;ri,,,.                    ..,,:;s1s1ssrr;,.;r,                       (  (`-`(-')  )
//                        ____/`---'\____                          :;. ,::;ii;:,     . ...................     .;iirri;;;,,;i,                       /)  \  = /  (
//                      .   ' \\| |// `.                           ,i. .;ri:.   ... ............................  .,,:;:,,,;i:                      /'    |--' .  \
//                       / \\||| 盛 |||// \      ,------------.    :s,.;r:... ....................................... .::;::s;                     (  ,---|  `-.)__`
//                     / _||||| -:- |||||- \    ( 盛子康 🐂 B! )    ,1r::. .............,,,.,,:,,........................,;iir;                      )(  `-.,--'   _`-.
//                       | | \\\ 子 /// | |      `-,----------'    ,s;...........     ..::.,;:,,.          ...............,;1s                     '/,'          (  Uu",
//                     | \_| ''\---/'' | |                  '-._  :i,..,.              .,:,,::,.          .......... .......;1,                    (_       ,    `/,-' )
//                      \ .-\__ `康` ___/-. /                     ir,....:rrssr;:,       ,,.,::.     .r5S9989398G95hr;. ....,.:s,                   `.*__, : `*-'/ /`--'
//                   ___`. .' /--.--\ `. . __                    ;r,..,s9855513XHAG3i   .,,,,,,,.  ,S931,.,,.;s;s&BHHA8s.,..,..:r:                   |     `--'  |
//                ."" '< `.___\_<|>_/___.' >'"".                :r;..rGGh,  :SAG;;G@BS:.,,,,,,,,,.r83:      hHH1sXMBHHHM3..,,,,.ir.                  `   `-._   /
//               | | : `- \`.;`\ 🐂 /`;.`/ - ` : | |           ,si,.1GS,   sBMAAX&MBMB5,,,,,,:,,.:&8       3@HXHBMBHBBH#X,.,,,,,,rr                   \        (
//                 \ \ `-. \_ __\ /__ _/ .-` / /               ;1:,,SH:   .A@&&B#&8H#BS,,,,,,,,,.,5XS,     3@MHABM&59M#As..,,,,:,is,                  /\ .      \.
//         ======`-.____`-.___\__逼__/___.-`____.-'======      .rr,,,;9&1   hBHHBB&8AMGr,,,,,,,,,,,:h&&9s;   r9&BMHBHMB9:  . .,,,,;ri.               / |` \     ,-\
//                            `=---='                          :1:....:5&XSi;r8BMBHHA9r:,......,,,,:ii19GG88899XHHH&GSr.      ...,:rs.              /  \| .)   /   \
//                        !!!!永无BUG!!!!                      ;s.     .:sS8G8GG889hi.        ....,,:;:,.:irssrriii:,.        ...,,i1,              ( ,'|\    ,'     :
//               bug虐我千百遍          我待bug如初恋             ;1,         ..,....,,isssi;,        .,,.                      ....,.i1,              | \,`.`--"/      }
//         .............................................      ;h:               i9HHBMBBHAX9:         .                     ...,,,rs,              `,'    \B|,'    /
//                  佛祖镇楼                  BUG辟易            ,1i..            :A#MBBBBMHB##s                             ....,,,;si.            / "-._   `-/      |
//          佛曰:                                              .r1,..        ,..;3BMBBBHBB#Bh.     ..                    ....,,,,,i1;             "-.   "-.,'|       ;
//                  写字楼里写字间，写字间里程序员；                  :h;..       .,..;,1XBMMMMBXs,.,, .. :: ,.               ....,,,,,,ss.            /       _/ ["---'""]
//                  程序人员写程序，又拿程序换酒钱。                   ih: ..    .;;;, ;;:s58A3i,..    ,. ,.:,,.             ...,,,,,:,s1,            :        /  |"-     '
//                  酒醒只在网上坐，酒醉还来网下眠；                    .s1,....   .,;sh,  ,iSAXs;.    ,.  ,,.i85            ...,,,,,,:i1;            '           |      /
//                  酒醉酒醒日复日，网上网下年复年。                     .rh: ...     rXG9XBBM#M#MHAX3hss13&&HHXr         .....,,,,,,,ih;
//                  但愿老死电脑间，不愿鞠躬老板前；                      .s5: .....    i598X&&A&AAAAAA&XG851r:       ........,,,,:,,sh;
//                  奔驰宝马贵者趣，公交自行程序员。                       . ihr, ...  .         ..                    ........,,,,,;11:.
//                  别人笑我忒疯癫，我笑自己命太贱；                        ,s1i. ...  ..,,,..,,,.,,.,,.,..       ........,,.,,.;s5i.
//                  不见满街漂亮妹，哪个归得程序员？                         .:s1r,......................       ..............;shs,
//                                                                       . .:shr:.  ....                 ..............,ishs.
//                                                                        .,issr;,... ...........................,is1s;.
//                                                                         .,is1si;:,....................,:;ir1sr;,
//                                                                          ..:isssssrrii;::::::;;iirsssssr;:..
//                                                                               .,::iiirsssssssssrri;;:.

