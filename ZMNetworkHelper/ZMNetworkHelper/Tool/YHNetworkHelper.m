//
//  ZMNetworkHelper.m
//  ZMBCY
//
//  Created by Brance on 2017/11/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "YHNetworkHelper.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "YHCacheHelper.h"

@implementation YHNetworkHelper

static AFHTTPSessionManager *_sessionManager = nil ;

#pragma mark - GET请求

+ (void)requestGETWithRequestURL:(NSString *)requestURLString parameters:(id)parameters success:(YHHttpRequestSuccess)success failure:(YHHttpRequestFailed)failure{
    
    [_sessionManager GET:requestURLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        failure(error);
    }];
}

#pragma mark - post请求

+ (void)requestPOSTWithRequestURL:(NSString *)requestURLString parameters:(id)parameters success:(YHHttpRequestSuccess)success failure:(YHHttpRequestFailed)failure{
    
    [_sessionManager POST:requestURLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        failure(error);
    }];
}



#pragma mark -上传单/多张图片

+(void)uploadImagesWithURL:(NSString *)URLString parameters:(NSDictionary *)parameters fileModelArray:(NSArray<WYFileModel *> *)modelArray progress:(YHHttpProgress)progress success:(YHHttpRequestSuccess)success failure:(YHHttpRequestFailed)failure{
    
    
    [_sessionManager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < modelArray.count; i++)
        {
            @autoreleasepool {
                
                WYFileModel *fileModel = modelArray[i];
                [formData appendPartWithFileData:fileModel.fileData name:fileModel.fileName fileName:fileModel.fileName mimeType:fileModel.mimeType];
                fileModel.fileData = nil;
                fileModel = nil;
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if(progress) {progress(uploadProgress);}
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {success(responseObject);}
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {failure(error);}
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
    
}



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
+ (NSURLSessionDownloadTask *)downLoadWithURL:(NSURL *)downloadUrl fileSavePath:(NSString *)filePath progress:(YHHttpProgress)progress success:(YHDownLoadSuccess)success failure:(YHHttpRequestFailed)failure {
    
    
    // 下载任务
    /**
     * 第一个参数 - request：请求对象
     * 第二个参数 - progress：下载进度block
     *      其中： downloadProgress.completedUnitCount：已经完成的大小
     *            downloadProgress.totalUnitCount：文件的总大小
     * 第三个参数 - destination：自动完成文件剪切操作
     *      其中： 返回值:该文件应该被剪切到哪里
     *            targetPath：临时路径 temp NSURL
     *            response：响应头
     * 第四个参数 - completionHandler：下载完成回调
     *      其中： filePath：真实路径 == 第三个参数的返回值
     *            error:错误信息
     */
    
    NSURLRequest *request = [NSURLRequest requestWithURL:downloadUrl];

    NSLog(@"request ==  %@ URLString == %@",request,downloadUrl);

    NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {progress(downloadProgress);}
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //拼接缓存目录
        NSString *downloadPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:filePath.length > 0 ? filePath : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadPath withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadPath stringByAppendingPathComponent:response.suggestedFilename];
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {failure(error);}
        else {success(response, filePath);}
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
    //开始启动任务
    [downloadTask resume];
    
    return downloadTask;
}


/**
 *  下载文件(继续下载)
 *  @param downloadTask    下载任务NSURLSessionDownloadTask的实例
 */
+ (void)downloadTaskResume:(NSURLSessionDownloadTask *)downloadTask {
    
    [downloadTask resume];
}

/**
 *  下载文件(暂停下载)
 *  @param downloadTask    下载任务NSURLSessionDownloadTask的实例
 */
+ (void)downloadTaskSuspend:(NSURLSessionDownloadTask *)downloadTask {
    
    [downloadTask suspend];
}

/**
 *  下载文件(停止下载，会释放downloadTask)
 *  @param downloadTask    下载任务NSURLSessionDownloadTask的实例
 */
+ (void)downloadTaskStop:(NSURLSessionDownloadTask *)downloadTask {
    
    [downloadTask suspend];
    downloadTask = nil;
}

#pragma mark - 初始化AFHTTPSessionManager相关属性

/**
 开始监测网络状态
 */
+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}


/**
 *  所有的HTTP请求共享一个AFHTTPSessionManager
 */
+ (void)initialize {
    _sessionManager = [AFHTTPSessionManager manager];
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    [_sessionManager.requestSerializer setValue:@"text/html;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    //关闭缓存，避免干扰调试
    _sessionManager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;

    _sessionManager.requestSerializer.timeoutInterval = 20;
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain",@"text/json", @"text/javascript",@"text/html" ,nil];
}

#pragma mark - 重置AFHTTPSessionManager相关属性
+ (void)setAFHTTPSessionManagerProperty:(void (^)(AFHTTPSessionManager *))sessionManager {
    sessionManager ? sessionManager(_sessionManager) : nil;
}

+ (void)setRequestSerializer:(YHRequestSerializer)requestSerializer {
    _sessionManager.requestSerializer = requestSerializer==YHRequestSerializerHTTP ? [AFHTTPRequestSerializer serializer] : [AFJSONRequestSerializer serializer];
}

+ (void)setResponseSerializer:(YHResponseSerializer)responseSerializer {
    _sessionManager.responseSerializer = responseSerializer==YHResponseSerializerHTTP ? [AFHTTPResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
}

+ (void)setRequestTimeoutInterval:(NSTimeInterval)time {
    _sessionManager.requestSerializer.timeoutInterval = time;
}

+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

+ (void)openNetworkActivityIndicator:(BOOL)open {
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:open];
}

+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName {
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    // 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 如果需要验证自建证书(无效证书)，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    // 是否需要验证域名，默认为YES;
    securityPolicy.validatesDomainName = validatesDomainName;
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
    
    [_sessionManager setSecurityPolicy:securityPolicy];
}

@end


