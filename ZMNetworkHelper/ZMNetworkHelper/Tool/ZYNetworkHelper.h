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


/** 请求成功的Block */
typedef void(^ _Nullable Success)(id _Nullable responseObject);
/** 请求失败的Block */
typedef void(^ _Nullable Failure)(NSError * _Nullable error);
///上传或者下载进度Block
typedef void (^ _Nullable Progress)(NSProgress * _Nullable progress);

///下载成功的Blcok
typedef void (^ _Nullable DownLoadSuccess)(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath);

@interface ZYNetworkHelper : NSObject

//+ (AFHTTPSessionManager *_Nullable)sharedInstance;

+ (ZYNetworkHelper *_Nullable)sharedInstance;

#pragma mark - GET请求
/**
 *  GET请求
 *
 *  @param requestURLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void) requestGETWithRequestURL:(NSString *_Nullable) requestURLString
                       parameters:(id _Nullable )parameters
                          success:(Success)success
                          failure:(Failure)failure;

#pragma mark - POST请求
/**
 *  POST请求
 *
 *  @param requestURLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void) requestPOSTWithRequestURL:(NSString *_Nullable) requestURLString
                        parameters:(id _Nullable )parameters
                           success:(Success)success
                           failure:(Failure)failure;


/**
 *  POST多个文件上传(如图片、MP3、MP4等)
 *
 *  @param URLString    请求的链接
 *  @param parameters   请求的参数
 *  @param modelArray   存放待上传文件模型的数组
 *  @param progress     进度的回调
 *  @param success      上传成功的回调
 *  @param failure      上传失败的回调
 */
- (void)requestPOSTWithRequestURL:(NSString *_Nullable)URLString parameters:(NSDictionary *_Nullable)parameters fileModelArray:(NSArray<WYFileModel *>*_Nullable)modelArray progress:(Progress)progress success:(Success)success failure:(Failure )failure;


/**
 *  POST单个文件上传(如图片、MP3、MP4等)
 *
 *  @param URLString    请求的链接
 *  @param parameters   请求的参数
 *  @param fileModel    待上传文件的模型
 *  @param progress     进度的回调
 *  @param success      上传成功的回调
 *  @param failure      上传失败的回调
 */
- (void)requestPOSTWithRequestURL:(NSString *_Nullable)URLString parameters:(NSDictionary *_Nullable)parameters fileModel:(WYFileModel *_Nullable)fileModel progress:(Progress)progress success:(Success)success failure:(Failure)failure;



///**
// *  POST多个URL资源上传(根据本地文件URL路径上传图片、MP3、MP4等)
// *
// *  @param URLString        请求的链接
// *  @param parameters       请求的参数
// *  @param modelArray       存放待上传文件模型的数组
// *  @param progress         进度的回调
// *  @param success          上传成功的回调
// *  @param failure          上传失败的回调
// */
//- (void)POST:(NSString *_Nullable)URLString parameters:(NSDictionary *_Nullable)parameters urlFileModelArray:(NSArray <WYFileModel *>*_Nullable)modelArray progress:(Progress)progress success:(Success)success failure:(Failure)failure;
//
//
///**
// *  POST单个URL资源上传(根据本地文件URL路径上传图片、MP3、MP4等)
// *
// *  @param URLString        请求的链接
// *  @param parameters       请求的参数
// *  @param fileModel        上传的文件模型
// *  @param progress         进度的回调
// *  @param success          上传成功的回调
// *  @param failure          上传失败的回调
// */
//- (void)POST:(NSString *_Nullable)URLString parameters:(NSDictionary *_Nullable)parameters urlFileModel:(WYFileModel *_Nullable)fileModel progress:(Progress)progress success:(Success)success failure:(Failure)failure;


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
- (NSURLSessionDownloadTask *_Nullable)downLoadWithURL:(NSString *_Nullable)URLString fileSavePath:(NSString *_Nullable)filePath progress:(Progress)progress success:(DownLoadSuccess)success failure:(Failure)failure;


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

@end
