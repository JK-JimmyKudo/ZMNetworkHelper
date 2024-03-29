//
//  ZYCacheHelper.m
//  ZMNetworkHelper
//
//  Created by power on 2019/6/27.
//  Copyright © 2019 Henan XinKangqiao. All rights reserved.
//

#import "YHCacheHelper.h"
#import <YYCache.h>

@implementation YHCacheHelper
static NSString *const NetworkResponseCache = @"NetworkResponseCache";
static YYCache *_dataCache;
static YYKVStorage *_diskCache;


+ (void)initialize
{
    _dataCache = [YYCache cacheWithName:NetworkResponseCache];
    NSString *downloadDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    _diskCache  = [[YYKVStorage alloc] initWithPath:downloadDir type: YYKVStorageTypeFile];
    
}

+ (void)saveResponseCache:(id)responseCache forKey:(NSString *)key
{
    //异步缓存,不会阻塞主线程
    [_dataCache setObject:responseCache forKey:key withBlock:nil];
}

+ (id)getResponseCacheForKey:(NSString *)key
{
    return [_dataCache objectForKey:key];
}

+(void)removeCacheForKey:(NSString *)key
{
    [_dataCache removeObjectForKey:key];
}
+(void)removAllCache
{
    [_dataCache removeAllObjects];
}

+(NSString *)saveFileWithKey:(NSString *)key file:(id)file fileName:(NSString *)fileName
{
    NSLog(@"%@",fileName);
    
    
    [_diskCache saveItemWithKey:key value:file filename:fileName extendedData:nil];
    
    return _diskCache.path;
    
}
+(id)getFileWithKey:(NSString *)key
{
    return  [_diskCache getItemForKey:key];
}
+(NSString *)getFilePath

{
    return _diskCache.path;
}


@end
