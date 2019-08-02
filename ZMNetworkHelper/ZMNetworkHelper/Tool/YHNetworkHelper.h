//
//  ZMNetworkHelper.h
//  ZMBCY
//
//  Created by Brance on 2017/11/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "WYFileModel.h"


typedef NS_ENUM(NSUInteger, YHNetworkStatusType) {
    /// 未知网络
    YHNetworkStatusUnknown,
    /// 无网络
    YHNetworkStatusNotReachable,
    /// 手机网络
    YHNetworkStatusReachableViaWWAN,
    /// WIFI网络
    YHNetworkStatusReachableViaWiFi
};

typedef NS_ENUM(NSUInteger, YHRequestSerializer) {
    /// 设置请求数据为JSON格式
    YHRequestSerializerJSON,
    /// 设置请求数据为二进制格式
    YHRequestSerializerHTTP,
};

typedef NS_ENUM(NSUInteger, YHResponseSerializer) {
    /// 设置响应数据为JSON格式
    YHResponseSerializerJSON,
    /// 设置响应数据为二进制格式
    YHResponseSerializerHTTP,
};














/// 请求成功的Block
typedef void(^YHHttpRequestSuccess)(id _Nullable  responseObject);

/// 请求失败的Block
typedef void(^YHHttpRequestFailed)(NSError * _Nullable error);

/// 缓存的Block
typedef void(^YHHttpRequestCache)(id _Nullable responseCache);

/// 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小
typedef void (^YHHttpProgress)(NSProgress * _Nullable progress);

/// 网络状态的Block
//typedef void(^YHNetworkStatus)(YHNetworkStatusType status);

///下载成功的Blcok
typedef void (^ _Nullable YHDownLoadSuccess)(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath);

@class AFHTTPSessionManager;




@interface YHNetworkHelper : NSObject



#pragma mark - GET请求
/**
 *  GET请求
 *
 *  @param requestURLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void) requestGETWithRequestURL:(NSString *_Nullable) requestURLString
                       parameters:(id _Nullable )parameters
                          success:(YHHttpRequestSuccess _Nullable )success
                          failure:(YHHttpRequestFailed _Nullable )failure;

#pragma mark - POST请求
/**
 *  POST请求
 *
 *  @param requestURLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void) requestPOSTWithRequestURL:(NSString *_Nullable) requestURLString
                        parameters:(id _Nullable )parameters
                           success:(YHHttpRequestSuccess _Nullable )success
                           failure:(YHHttpRequestFailed _Nullable )failure;












/**
 *  POST上传单/多张图片(如图片、MP3、MP4等)
 *
 *  @param URLString    请求的链接
 *  @param parameters   请求的参数
 *  @param modelArray   存放待上传文件模型的数组
 *  @param progress     进度的回调
 *  @param success      上传成功的回调
 *  @param failure      上传失败的回调
 */
+ (void)uploadImagesWithURL:(NSString *_Nullable)URLString parameters:(NSDictionary *_Nullable)parameters fileModelArray:(NSArray<WYFileModel *>*_Nullable)modelArray progress:(YHHttpProgress _Nullable )progress success:(YHHttpRequestSuccess _Nullable )success failure:(YHHttpRequestFailed _Nullable )failure;






/**
 *  下载文件
 *
 *  @param URLString   请求的链接
 *  @param filePath    文件存储目录(默认存储目录为Download)
 *  @param progress    进度的回调
 *  @param success     下载成功的回调
 *  @param failure     下载失败的回调
 *
 *  返回NSURLSessionDownloadTask实例，可用于暂停下载、继续下载、停止下载，暂停调用suspend方法，继续下载调用resume方法
 */
+ (NSURLSessionDownloadTask *_Nullable)downLoadWithURL:(NSURL *_Nullable)downloadUrl fileSavePath:(NSString *_Nullable)filePath progress:(YHHttpProgress _Nullable )progress success:(YHDownLoadSuccess)success failure:(YHHttpRequestFailed _Nullable )failure;


/**
 *  下载文件(继续下载)
 *  @param downloadTask    下载任务NSURLSessionDownloadTask的实例
 */
+ (void)downloadTaskResume:(NSURLSessionDownloadTask *_Nullable)downloadTask;

/**
 *  下载文件(暂停下载)
 *  @param downloadTask    下载任务NSURLSessionDownloadTask的实例
 */
+ (void)downloadTaskSuspend:(NSURLSessionDownloadTask *_Nullable)downloadTask;

/**
 *  下载文件(停止下载，会释放downloadTask)
 *  @param downloadTask    下载任务NSURLSessionDownloadTask的实例
 */
+ (void)downloadTaskStop:(NSURLSessionDownloadTask *_Nullable)downloadTask;



#pragma mark - 设置AFHTTPSessionManager相关属性
/**
 在开发中,如果以下的设置方式不满足项目的需求,就调用此方法获取AFHTTPSessionManager实例进行自定义设置
 @param sessionManager AFHTTPSessionManager的实例
 */
+ (void)setAFHTTPSessionManagerProperty:(void(^_Nullable)(AFHTTPSessionManager * _Nullable sessionManager))sessionManager;

/**
 *  设置网络请求参数的格式:默认为二进制格式
 *
 *  @param requestSerializer PPRequestSerializerJSON(JSON格式),PPRequestSerializerHTTP(二进制格式),
 */
+ (void)setRequestSerializer:(YHRequestSerializer)requestSerializer;

/**
 *  设置服务器响应数据格式:默认为JSON格式
 *
 *  @param responseSerializer PPResponseSerializerJSON(JSON格式),PPResponseSerializerHTTP(二进制格式)
 */
+ (void)setResponseSerializer:(YHResponseSerializer)responseSerializer;

/**
 *  设置请求超时时间:默认为30S
 *
 *  @param time 时长
 */
+ (void)setRequestTimeoutInterval:(NSTimeInterval)time;

/// 设置请求头
+ (void)setValue:(NSString *_Nullable)value forHTTPHeaderField:(NSString *_Nullable)field;

/**
 *  是否打开网络状态转圈菊花:默认打开
 *
 *  @param open YES(打开), NO(关闭)
 */
+ (void)openNetworkActivityIndicator:(BOOL)open;

/**
 配置自建证书的Https请求, 参考链接: http://blog.csdn.net/syg90178aw/article/details/52839103
 
 @param cerPath 自建Https证书的路径
 @param validatesDomainName 是否需要验证域名，默认为YES. 如果证书的域名与请求的域名不一致，需设置为NO; 即服务器使用其他可信任机构颁发
 的证书，也可以建立连接，这个非常危险, 建议打开.validatesDomainName=NO, 主要用于这种情况:客户端请求的是子域名, 而证书上的是另外
 一个域名。因为SSL证书上的域名是独立的,假如证书上注册的域名是www.google.com, 那么mail.google.com是无法验证通过的.
 */
+ (void)setSecurityPolicyWithCerPath:(NSString *_Nullable)cerPath validatesDomainName:(BOOL)validatesDomainName;


@end
