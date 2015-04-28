//
//  recplaysnd.h
//  recplaysnd
//  音频通信sdk接口
//  Created by 余涛  on 12-7-11.
//  phone:15910823985
//  emai:tonyy@itron.com.cn
//  Copyright (c) 2012年 Itron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVAudioSession.h>
#import <MediaPlayer/MediaPlayer.h>


#define  ERROR -1
#define  ERROR_FAIL_TO_START -2
#define  ERROR_FAIL_TO_GET_KSN  -3
#define  ERROR_DUPLICATE_SWIPER -4
#define  ERROR_AUDIO_INITIALIZATION_FAIL -5
#define  ERROR_AUDIO_SESSION_SET_FAIL -6

//#import "vcomEvt.h"
#define YLOG
/*
 101 2012-9-28 修改了录音和放音格式，在ios4.3.2系统上的问题。
 */
#define  VCOM_VER  101
//命令和子命令的位置
#define CMD_POS 4
#define SUBCMD_POS 5
#define CMD_RES_POS 6
//通讯模式定义
#define  VCOM_TYPE_F2F 0
#define  VCOM_TYPE_FSK 1

#define NOTIFY_CHECKMIC @"NOTIFY_CHECKMIC"
#define NOTIFY_RECORDDATA @"NOTIFY_RECORDDATA"

extern bool recflag;
extern char ppdata[20][800];
//char ppdataCnt=0;
extern int  ppDataPos;


typedef struct{
    //数据结果
    int res;
    //psam卡号码
    char psamno[10];
    int  psamnoLen;
    
    //pan码
    char pan[20];
    int  panLen;
    
    //硬件序列号
    char hardNo[40];
    int  hardNoLen;
    
    //卡号明文
    char cardMinWen[50];
    char cardMinWenLen;
    
    //卡号密文
    char cardMiWen[50];
    char cardMiWenLen;
    
    //磁道密文
    char ciDaoMiWen[200];
    int  ciDaoMiWenLen;
    
    //磁道明文
    char ciDaoMingWen[200];
    int ciDaoMingWenLen;
    
    //pin密文
    char pinMiWen[20];
    int  pinMiWenLen;
    
    //mac计算结果
    char macres[100];
    int macresLen;
    
    //mac验证结果
    bool macvalres;
    
    //商户号码
    char shnoInPsam[200];
    int shnoInPsamLen;
    
    //终端号码
    char zdnoInPsam[100];
    int  zdnoInPsamLen;
    
    
    //用户输入数据
    char userInput[100];
    int userInputLen;
    
    
    /*爱刷数据*/
    char cd1[100]; //磁道1
    char cd2[200]; //磁道2
    char cd3[200]; //磁道3
    char rand[20]; //随机数
    char seq[20];  //序列号
    char cdno[40];  //卡号码
    char cdmw[500]; //磁道密文
    int cd1len,cd2len,cd3len,randlen,seqlen,cdnolen,cdmwlen;
    char ksn[40];  //硬件号码
    int ksnlen;
    char ver[20];  //程序版本
    int verlen;
    char mac[8];
    int maclen;
    char carddate[4]; //卡有效期
    //加密指令放回数据
    char Return_DataEnc[100];
    int Return_DataEnclen;
}vcom_Result;

/*!
 @enum
 @abstract 刷卡驱动的内部运行状态
 @constant CSwiperControllerStateIdle 闲置状态
 @constant CSwiperControllerStateWaitingForDevice 等待设备就绪状态
 @constant CSwiperControllerStateRecording 录音状态
 @constant CSwiperControllerStateDecoding 解码状态
 */
typedef enum {
    CSwiperControllerStateIdle,
    CSwiperControllerStateWaitingForDevice,
    CSwiperControllerStateRecording,
	CSwiperControllerStateDecoding
} CSwiperControllerState;

/*!
 @enum
 @abstract 刷卡驱动解码失败原因
 @constant CSwiperControllerDecodeResultSwipeFail 刷卡失败
 @constant CSwiperControllerDecodeResultCRCError CRC校验错误
 @constant CSwiperControllerDecodeResultCommError 通信错误
 @constant CSwiperControllerDecodeResultUnknownError 位置错误
 */
typedef enum {
	CSwiperControllerDecodeResultSwipeFail,
	CSwiperControllerDecodeResultCRCError,
	CSwiperControllerDecodeResultCommError,
	CSwiperControllerDecodeResultUnknownError
} CSwiperControllerDecodeResult;


@protocol CSwiperControllerDelegate;


@interface ICCSwiperController:NSObject
{
    BOOL detectDeviceChange;
    
    short* mbuf;
    int mbuflen;
    //返回数据指针和长度
    char* retdata;
    int retdatalen;
    
    id<CSwiperControllerDelegate> delegate;
}

/*!
 @property delegate
 @abstract 要从MSR NLSwiperController中获取通知信息如插入设备提示、卡信息回馈，需赋值delegate，实现CSwiperControllerDelegate的方法。
 */
@property (nonatomic, assign) NSObject<CSwiperControllerDelegate> *delegate;
/*!
 @property detectDeviceChange
 @abstract 设置是否响应onDevicePlugged和onDeviceUnPlugged事件
 */
@property (nonatomic, assign)BOOL detectDeviceChange;
/*!
 @property swipeTimeout
 @abstract 设置刷卡超时时间。单位为秒。
 */
@property (nonatomic, assign) double swipeTimeout;



@property(retain,nonatomic) NSTimer *itTimer;
@property(nonatomic) char* retdata;
@property(nonatomic) int retdatalen;
//@property(nonatomic,retain) id<CSwiperControllerDelegate> eventListener;

//得到音频对象的全局变量
/*!
 @method
 @abstract 获取实例对象
 @discussion 不要自己实例化该驱动对象，直接从这个方法获取实例对象。该实例对象是线程安全的。
 @result 返回实例对象
 */
+ (id)sharedInstance;


/*!
 @method
 @abstract 判断当前是否有设备
 @discussion 如果未插上设备或设备未插好，将返回NO，否则返回YES。只有YES的时候，程序才能进入正常刷卡流程。
 @result 是否检测到设备
 */
- (BOOL)isDevicePresent;

/*!
 @method
 @abstract 启动刷卡程序
 @discussion 启动刷卡程序，将进入刷卡流程如判断设备是否插上，启动是否成功等。
 */
- (void)startCSwiper;

/*!
 @method
 @abstract 停止刷卡程序
 @discussion 停止刷卡程序，使之暂停刷卡服务。
 */
- (void)stopCSwiper;


/*!
 @method
 @abstract 卸载刷卡驱动
 @discussion 卸载刷卡驱动，使之停止并移除刷卡服务。
 */
- (void)deleteCSwiper;

/*!
 @method
 @abstract 获取运行状态
 @discussion 获取当前刷卡程序内部运行状态。状态值范围定义在NLSwiperControllerState枚举类型中。
 @result 运行状态
 */
- (CSwiperControllerState)getCSwiperState;

/*!
 @method
 @abstract 获得刷卡器系列好
 @discussion 刷卡器KSN中的左边14位BCD码，可以判断刷卡器是否合法设备
 刷卡器KeySet（4位BCD）＋10位系列号BCD码，共14个字符
 */
- (void)getCSwiperKsn;

//放音音量控制,该函数暂时没有用处，100最大，0最小
-(void)setVloumn:(NSInteger )vol;

//启动录音，启动数据接收
-(void) StartRec;

//停止录音，停止数据接收
-(void)StopRec;

//返回结果报文解析函数
//返回 -1-报文错误 0-报文格式正确 其他，错误的结果
-(int)ParseResult:(unsigned char*)buf bufLen:(int)_bufLen res:(vcom_Result*)_res;

//私有函数
//播放内存的语音。内部调用。
-(void) playVocBuf:(short*)buf Len:(int)buflen;

//是否耳机插入,返回1-耳机插入 0-耳机未插入，内部调用函数
- (int)hasHeadset;

char* HexToBin(char* hex);
char* BinToHex(char* bin,int off,int len);

//发送指令数据
//cmd-从协议版本字段到数据的十六进制值
//0-ok -1 失败
-(int) playCmd:(char*)cmdstr;

@end


/*!
 @protocol
 @abstract NLSwiperController的protocol，用于获取NLSwiperController运行过程的信息通知。
 @discussion NLSwiperController运行过程中信息通知回馈外部程序的接口。通知信息的内容或时机包括检测设备的状态，内部运行状态，刷卡成功后的卡信息以及错误信息等。
 */
@protocol CSwiperControllerDelegate <NSObject>

/*!
 @method
 @abstract 检测到刷卡动作
 @discussion 刷卡后将接收到该通知
 */
- (void)onCardSwipeDetected;

/*!
 @method
 @abstract 通知监听器解码刷卡器输出数据完毕。
 @discussion
 @param formatID
 @param ksn       	       刷卡器设备编码
 @param encTracks          加密的磁道资料。1，2，3的十六进制字符
 @param track1Length       磁道1的长度（没有加密数据为0）
 @param track2Length       磁道2的长度（没有加密数据为0）
 @param track3Length       磁道3的长度（没有加密数据为0）
 @param randomNumber
 @param maskedPANString    基本账号号码。
 卡号的一种格式“ddddddddXXXXXXXXdddd”(隐藏卡号的中间的几位数字)d 数字   X 影藏字符
 @param expiryDate         到期日，格式ＹＹＭＭ
 @param cardHolderName
 */
-(void) onDecodeCompleted:(NSString*)formatID
					  ksn:(NSString*)ksn
				encTracks:(NSString*)encTracks
			 track1Length:(int)track1Length
			 track2Length:(int)track2Length
			 track3Length:(int)track3Length
			 randomNumber:(NSString *)randomNumber
				maskedPAN:(NSString*)maskedPANString
			  expiryDate :(NSString*)expiryDate
		   cardHolderName:(NSString *)cardHolderName;

/*!
 @method
 @abstract 解码失败
 @discussion 刷卡及启动中解码出错
 @param decodeState 解码失败原因
 */
- (void)onDecodeError:(CSwiperControllerDecodeResult)decodeState;

/*!
 @method
 @abstract 解码开始
 @discussion 刷卡后开始解码
 */
- (void)onDecodingStart;

/*!
 @method
 @abstract 错误提示
 @discussion 出现错误。可能偶然的错误，设备与手机的适配问题，或者设备与驱动不符。
 @param errorCode 错误代码。
 @param errorMessage 错误信息。
 */
- (void)onError:(int)errorCode ErrorMessage:(NSString *)errorMessage;

/*!
 @method
 @abstract 中断提示
 @discussion 由于设备拔出或者其它错误导致刷卡器中断
 */
- (void)onInterrupted;

/*!
 @method
 @abstract 启动未检测到设备提示
 @discussion 在启动程序后指定时间内没有检测到刷卡器
 */
- (void)onNoDeviceDetected;

/*!
 @method
 @abstract 超时提示
 @discussion 主要针对刷卡指令，在特定的时间内未刷卡，该方法被调用。对于电池版本刷卡器，这可以避免刷卡器误用导致电池无谓损耗。
 */
- (void)onTimeout;

/*!
 @method
 @abstract 等待刷卡提示
 @discussion 已经检测到刷卡器，进入等待刷卡或者其它指令状态
 */
- (void)onWaitingForCardSwipe;

/*!
 @method
 @abstract 等待插入设备提示
 @discussion 设备未插入时启动刷卡器会得到这个事件通知
 */
- (void)onWaitingForDevice;

/*!
 @method
 @abstract 通知ksn
 @discussion 正常启动刷卡器后，将返回ksn
 @param ksn 取得的ksn
 */
- (void)onGetKsnCompleted:(NSString *)ksn;

@optional
/*!
 @method
 @abstract 设备插入
 @discussion 刷卡设备准备就绪，提示用户已插入设备
 */
- (void)onDevicePlugged;

/*!
 @method
 @abstract 设备被拔出
 @discussion 刷卡中断，提示用户插入设备
 */
- (void)onDeviceUnplugged;


@end


//
////打开音频收发数据功能
//-(void)open;
////关闭音频收发数据功能
//-(void)close;
////初始化,一般在viewDidLoad函数中创建对象后调用一次，
//- (id)init;
//
////工具函数,返回bin二进制数据，长度为binlen的十六进制字符串
//-(NSString*) HexValue:(char*)bin Len:(int)binlen;
////工具函数，打印二进制缓冲区内容
//-(void)HexPrint:(char*)data Len:(int)_len;
//
////放音音量控制,该函数暂时没有用处，100最大，0最小
//-(void)setVloumn:(NSInteger )vol;
//
////启动录音，启动数据接收
//-(void) StartRec;
//
////停止录音，停止数据接收
//-(void)StopRec;
//
////设置通讯模式，发送和接收采用fsk还是f2f，VCOM_TYPE_F2F和VCOM_TYPE_FSK
//-(void) setMode:(int)smode recvMode:(int)rmode;
//
////得到发送的模式，fsk或者f2f
//-(int) getSendMode;
//
////得到接收的模式，fsk或者f2f
//-(int) getRecvMode;
//

////*****************************************************
////fsk发送指令封装
////播放内存的语音。内部调用。
////获取ksn
//-(void) Request_GetKsn;
//
////扩展获取ksn
//-(void) Request_GetExtKsn;
//
////获取随机数
//-(void) Request_GetRandom:(int)randLen;
//
////获取psam卡上保存的商户号码和终端号
//-(void) Request_VT;
//
////退出
//-(void) Request_Exit;
//
////获取电池电量
//-(void) Request_BatLevel;
//
////获取打印机状态
//-(void) Request_PrtState;
//
////重传指令
//-(void) Request_ReTrans;
//
////获取磁卡卡号明文
//-(void) Request_GetCardNo:(int)timeout;
//
////获取磁道信息明文
//-(void) Request_Gard:(int)timeout;
//
//// 拉卡拉请刷卡指令
//-(void)startDetector:(int)desMode
//              random:(char*)_random
//           randomLen:(int)_randomLen
//                data:(char*)_data
//             datalen:(int)_datalen
//                time:(int)_time;
//// 停止刷卡指令
//-(void)stopDetector;
//// 显示刷卡器状态
//-(int)getCSwiperState;
//
////获取磁道密文数据
//-(void) Request_GetDes:(int)desMode
//              keyIndex:(int)_keyIndex
//                random:(char*) _random
//             randomLen:(int)_randomLen
//                  time:(int)_time;
//
////获取pin密文数据
//-(void) Request_GetPin:(int)pinMode
//              keyIndex:(int)_keyIndex
//                  cash:(char*)_cash cashLen:(int)_cashLen
//                random:(char*)_random randomLen:(int)_randdomLen
//               panData:(char*)_panData pandDataLen:(int)_panDataLen
//                  time:(int)_time;
////获取计算mac的数据
////对mac数据进行处理,尾部加0到8的整数，然后每8个字节异或
//-(void) Request_GetMac:(int)macMode
//              keyIndex:(int)_keyIndex
//                random:(char*)_random randomLen:(int)_randomLen
//                  data:(char*)_data dataLen:(int)_dataLen;
//
////请求psam卡mac计算
//-(void) Request_CheckMac:(int)macMode
//                keyIndex:(int)_keyIndex
//                  random:(char*)_random randomLen:(int)_randomLen
//                    data:(char*)_data dataLen:(int)_dataLen;
////请求psam卡mac计算
//-(void) Request_CheckMac2:(int)macMode
//                keyIndex:(int)_keyIndex
//                  random:(char*)_random randomLen:(int)_randomLen
//                    data:(char*)_data dataLen:(int)_dataLen
//                    mac:(char*)_mac maclen:(int)_maclen;
////请求pasm卡mac校验
//-(void) Request_CheckMacEx:(int)macMode keyIndex:(int)_keyIndex random:(char *)_random randomLen:(int)_randomLen data:(char *)_data dataLen:(int)_dataLen mac:(char*)_mac maclen:(int)_maclen;
//
////扩展请求连续操作2  0293
//-(void) Request_ExtCtrlConOper:(int)mode
//                   PINKeyIndex:(int)_PINKeyIndex
//                    DESKeyInex:(int)_DESKeyIndex
//                   MACKeyIndex:(int)_MACKeyIndex
//                      CtrlMode:(char)_CtrlMode
//               ParameterRandom:(char*)_ParameterRandom ParameterRandomLen:(int)_ParameterRandomLen
//                          cash:(char*)_cash cashLen:(int)_cashLen
//                    appendData:(char*)_appendData appendDataLen:(int)_appendDataLen
//                          time:(int)_time;
//
//
//
//
//
//
///*
// 请求用户输入
// 输入参数:
// Ctrlmode: 控制模式
// bit0－bit4表示模式：
// 0：表示银行卡卡号输入，
// 1：表示数字类输入
// 2：表示支持字母数字输入
// Bit5 =0/1 无二次输入/有二次输入
// Bit6=0/1 密钥索引是否启用
// Bit7 =0/1 数据是否加密
// 
// _tout: 超时时间(秒）
// minvalue:允许输入的最小长度
// maxvalue:允许输入的最大长度
// kindex: 加密时使用的密钥索引
// _random: 参与加密的随机数
// _title: 用户输入时显示的提示信息
// */
//-(void)Get_Userinput:(int)ctrlmode
//             timeout:(unsigned char)_tout
//                 min:(unsigned char)minvalue
//                 max:(unsigned char)maxvalue
//            keyindex:(unsigned char)kindex
//              random:(char*)_random randomLen:(int)_randdomLen
//               title:(char*)_title titleLen:(int)_titleLen;
////显示信息
////info信息内容
////timer-显示时间（秒）
//-(void) display:(NSString*) strinfo  timer:(int)_time;
//
////返回结果报文解析函数
////返回 -1-报文错误 0-报文格式正确 其他，错误的结果
//-(int)ParseResult:(unsigned char*)buf bufLen:(int)_bufLen res:(vcom_Result*)_res;
//
//
////解析加密后的Pin密文数据
////参数
////输入
////buf:返回数据缓冲
////_bufLen:返回数据缓冲长度
////输出
////_pin:加密的pin缓冲
////返回值:
////_pin缓冲长度
//-(int) GetEnPinData:(char*) buf bufLen:(int)_bufLen pin:(char*)_pin;
//
///*
// 解析返回结果的2，3磁道数据
// 输入数据:
// buf,_bufLen:返回数据指针和长度
// 输出数据:
// _cdbuf,_cdbufLen：2，3磁道加密数据和长度
// _pan:输出的pan数据
// */
///*
// -(void)getEn23CiDao:(char*) buf bufLen:(int)_bufLen
// cdbuf:(char*)_cdbuf cdbufLen:(int*)_cdbufLen
// pan:(char*)_pan
// rand:(char*)_rand randLen:(int*)_randLen;
// */
//
///*
// 解析获取扩展卡号取的返回数据
// psamno8bytes:8字节psam卡号码
// hardno10bytes:10字节的硬件序列号
// */
///*
// -(void)GetExtKsnRetData:(char*) psamno8bytes
// hardNo:(char*)hardno10bytes;
// */
////*****************************************************

//
///*
// f2f指令封装
// */
////读取ksn号码
//-(void)f2f_getksn;
//
////密文刷卡指令
////ctrlFlag-控制标志
////rand randLen-随机数和随机数长度
////fjLen fjData-附件数据长度和附加数据
//-(void)f2f_getMiWenCiKa:(char) ctrlFlag tiemout:(char)tout  randLen:(int)_randLen rand:(char*)_rand
//                  fjLen:(int) _fjLen fjData:(char*)_fjData;
//
//
//
//
//char* HexToBin(char* hex);
//char* BinToHex(char* bin,int off,int len);
//
//@end


