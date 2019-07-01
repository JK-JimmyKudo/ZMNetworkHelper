//
//  ZMNetworkHelper.m
//  ZMBCY
//
//  Created by Brance on 2017/11/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZYNetworkHelper.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "ZYCacheHelper.h"

@implementation ZYNetworkHelper

static AFHTTPSessionManager *manager = nil ;

static ZYNetworkHelper *httpRequest = nil;
+ (ZYNetworkHelper *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (httpRequest == nil) {
            httpRequest = [[self alloc] init];
        }
    });
    return httpRequest;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (httpRequest == nil) {
            httpRequest = [super allocWithZone:zone];
        }
    });
    return httpRequest;
}
- (instancetype)copyWithZone:(NSZone *)zone
{
    return httpRequest;
}



+ (AFHTTPSessionManager *)sessionManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"text/html;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
        //关闭缓存，避免干扰调试
        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;

        manager.requestSerializer.timeoutInterval = 20;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain",@"text/json", @"text/javascript",@"text/html" ,nil];
    });
    return manager;
}

- (void)requestGETWithRequestURL:(NSString *)requestURLString parameters:(id)parameters success:(Success)success failure:(Failure)failure{
    
    [[ZYNetworkHelper sessionManager] GET:requestURLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        failure(error);
    }];
}

- (void)requestPOSTWithRequestURL:(NSString *)requestURLString parameters:(id)parameters success:(Success)success failure:(Failure)failure{
    [[ZYNetworkHelper sessionManager] POST:requestURLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id request = [ZYCacheHelper getResponseCacheForKey:@"kkkk"];
        
//        NSLog(@"request ==  %@",request);
        
        
        [ZYCacheHelper saveResponseCache:responseObject forKey:@"kkkk"];
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        failure(error);
    }];
}


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
-(void)requestPOSTWithRequestURL:(NSString *)URLString parameters:(NSDictionary *)parameters fileModelArray:(NSArray<WYFileModel *> *)modelArray progress:(Progress)progress success:(Success)success failure:(Failure)failure{
    
    
    AFHTTPSessionManager *mannger = [ZYNetworkHelper sessionManager];
    
    [mannger POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
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
 *  POST单个文件上传(如图片、MP3、MP4等)
 *
 *  @param URLString    请求的链接
 *  @param parameters   请求的参数
 *  @param fileModel    待上传文件的模型
 *  @param progress     进度的回调
 *  @param success      上传成功的回调
 *  @param failure      上传失败的回调
 */

-(void) requestPOSTWithRequestURL:(NSString *)URLString parameters:(NSDictionary *)parameters fileModel:(WYFileModel *)fileModel progress:(Progress)progress success:(Success)success failure:(Failure)failure{
    
    AFHTTPSessionManager *mannger = [ZYNetworkHelper sessionManager];

    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"file"] = @"picture";
    param[@"userId"] = @"1132912043533783041";
    
    
    [mannger POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
//        NSData *fileData = UIImageJPEGRepresentation(fileModel.fileImage, 0.05);

        if (fileModel.fileData != nil) {
            [formData appendPartWithFileData:fileModel.fileData name:fileModel.folderName fileName:fileModel.fileName mimeType:fileModel.mimeType];
        }else{
            
        }
        
        fileModel.fileData = nil;
        
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
- (NSURLSessionDownloadTask *)downLoadWithURL:(NSString *)URLString fileSavePath:(NSString *)filePath progress:(Progress)progress success:(DownLoadSuccess)success failure:(Failure)failure {
    
    AFHTTPSessionManager *mannger = [ZYNetworkHelper sessionManager];
    
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
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    NSURLSessionDownloadTask *downloadTask = [mannger downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
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



@end


