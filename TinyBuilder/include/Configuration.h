/******************************************************************
 文件名称: Configuration.h
 系统名称: 移动平台
 模块名称: 客户端
 类 名 称: Configuration
 软件版权: 杭州长亮金融信息服务有限公司
 功能说明:
 系统版本:
 开发人员: 
 开发时间: 11-4-16
 审核人员:
 相关文档:
 修改记录: 需求编号 修改日期 修改人员 修改说明
 201303010023 20130304  修改retina屏幕的判定方法
 201303060011 20130407  增加UA信息
 ******************************************************************/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//#import <sys/types.h>
#import <sys/sysctl.h>
//#import <sys/socket.h>
//#import <net/if.h>
//#import <net/if_dl.h>

#define kCustomerConfigVersion   @"CustomerConfig.Version"
#define SystemConfigurationDir @"System.plist"
#define CustomerConfigurationDir @"CustomerConfig.plist"
#define EmbedDir @"Embed.plist"
#define kDataDirectory @"dataCache"

#define kConfigurationVersion @"version"
#define kConfigurationTimeout @"timeout"
#define kConfigurationConnectTimeout @"connect-timeout"
#define kConfigurationList @"list"
#define kConfigurationParameters @"parameters"
#define kConfigurationSysClient @"sys-client"
#define kConfigurationSysVersion    @"sys-version"
#define kConfigurationIndex @"index"
#define kConfigurationAllowSavingSpot @"allow-saving-spot"
#define kConfigurationPasswordStrengthAlgorithmType @"strength-alhorithm-type"
#define kConfigurationSegmentStyle @"segment-style"
#define kConfigurationChecksum @"checksum"
#define kConfigurationAfhud @"afhud"
#define kConfigurationHue @"hue"
#define kConfigurationSplashAnimation @"splash-animation"
#define kConfigurationManifest @"manifestURL"
#define kConfigurationVoice @"voiceURL"
#define kConfigurationRemotePush @"remotePushURL"
#define kConfigurationResolution @"resolution"
#define kConfigurationActive @"net-active"
#define kConfigurationSplash @"splash-view"
#define kThirdApp   @"third-app"
#define kConfigurationGuideURL  @"guideURL"
#define kConfigurationRSADict   @"RSA"
#define kConfigurationUPPayScheme @"UPPayScheme"
#define kConfigurationUPPayMode   @"UPPayMode"
#define kConfigurationKeyboardSwitch    @"KeyboardSwitch"

//自定义配置项
#define kConfigurationShakeFlag @"shakeflag"
#define kConfigurationCSSPath   @"csspath"
#define kConfigurationBGTimer   @"BGTimer"
// 密码键盘视觉回显
#define kConfigurationKeyboardFeedback  @"keyboardfeedback"

//#define kMainCryptKey @"Sunline1"
#define kMainCryptKey @"Sunline1"//ipad上是Sunline1，不是Sunline1。
@interface Configuration : NSObject {
	NSMutableDictionary *_configuration;
	NSMutableDictionary *_breezeconfig;
    NSArray *_thirdApp;
	BOOL _isConnected2Server;
	//加密解密
	NSString *_mKey;
	NSString *_dKey;
	NSString *_sKey;
	NSString *_rKey;
	
    NSMutableArray* m_cssSources;
    
//    NSString *_remoteID;
    
    NSString *_userAgent;
    NSString *_clientVersion;
}

#pragma mark singleton
+ (Configuration *)configuration;

#pragma mark security
@property (nonatomic, readonly) CGFloat topOffset;
@property (nonatomic, readonly) NSString *mKey;
@property (nonatomic, assign) BOOL isConnected2Server;
@property (nonatomic, assign) BOOL bTemporarySavingSpot;
@property (nonatomic, readonly) BOOL isRetina;
@property (nonatomic, readonly) NSString *dKey;
@property (nonatomic, retain) NSString *sKey;
@property (nonatomic, retain) NSString *rKey;
@property (nonatomic, retain, readonly) NSArray *thirdApp;
//@property (nonatomic, retain) NSString *remoteID;
@property (nonatomic, retain, readonly) NSString *userAgent;
@property (nonatomic, retain, readonly) NSString *clientVersion;
#pragma mark read & write
//- (NSString*)valueForKey:(NSString*)key;
//- (void)setValue:(NSString*)value forKey:(NSString*)key;

#pragma mark info
- (NSString*)deviceID;
- (NSString *)preferredLanguage;
- (NSString*)versionNumber;
- (NSString *)voiceURL;
- (NSString *)guideURL;
- (BOOL)allowSavingSpot;
- (BOOL)isJailBreak;
- (BOOL)checksum;
- (BOOL)afhud;
- (BOOL)keyboardSwitchable;
- (float)deviceSystemVersion;
- (NSArray*)cssSources;
- (NSString*)platform;
- (int)pwdStrengthAlgorithmType;
//- (BOOL)splashAnimation; 
- (UISegmentedControlStyle)segmentStyle;
- (NSString*)manifestURL;
- (NSString*)sysClient;
- (NSString*)sysVersion;
- (NSArray*)resolution;
- (BOOL)netActive;
- (NSArray*)tipsPoint;
//- (NSString*)macaddress;
- (NSString *)remotePushURL;
- (NSDictionary *)RSADict;
- (int)BGTimer;


#pragma mark hue
//- (NSString*)hueInfo;
//- (void)setHueInfo:(NSString*)value;

#pragma mark UPPay
- (NSString*)uppayScheme;
- (NSString*)uppayMode;

#pragma mark CSS
//- (NSString*)backgroundFlag;
- (NSString*)backgroundCss;
//- (void)setBackgroundValue:(NSString*)value forKey:(NSString*)key;

#pragma mark network
- (int)timeout;
//- (int)connectTimeout;
- (NSArray*)stationList;
- (NSString*)parameters;
//- (NSString*)localIndex;
//- (void)clearRemoteID;
#pragma mark report
//- (void)addSentDataLength:(NSUInteger)length;
//- (void)addReceivedDataLength:(NSUInteger)length;

-(void)CustomerConfigsetObject:(id)object forKey:(id)key;
-(id)CustomerConfigObjectForKey:(id)key;

#pragma mark 摇动选项的开关
//-(void)setShake:(NSString*)state;
-(NSString*)getShakeState;
#pragma mark 键盘视觉回显
- (BOOL)getKeyboardVisualFeedback;
@end