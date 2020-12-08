//
//  NetManager.m
//  Spider67
//
//  Created by apple on 17/7/10.
//  Copyright © 2020 apple. All rights reserved.
//

#import "NetManager.h"

@implementation NetManager

+ (instancetype)shared{
    
    static NetManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [NetManager new];

    });
    return  instance;
}

// afn请求
- (void)afnNetUrl:(NSString *)url method:(NSString *)method parameters:(nullable id)parameters auth:(NSString *)auth  success:(void (^)(NSUInteger statuCode,id responseObject))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer.timeoutInterval = [[NSUserDefaults standardUserDefaults] floatForKey:@"httptimeout"];
    
    if (auth) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", auth]  forHTTPHeaderField:@"Authorization"];
    }
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                         @"application/json",
                                                         @"text/html",
                                                         @"text/json",
                                                         @"text/plain",
                                                         @"text/javascript", nil];
    
    if ([method isEqualToString:@"GET"]) {
        [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSURLResponse* resp = [task response];
            NSHTTPURLResponse* httpResp = (NSHTTPURLResponse *)resp;
            success(httpResp.statusCode,responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    }else if ([method isEqualToString:@"POST"]) {
        [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSURLResponse* resp = [task response];
            NSHTTPURLResponse* httpResp = (NSHTTPURLResponse *)resp;
            success(httpResp.statusCode,responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    }else if ([method isEqualToString:@"PATCH"]) {
        [manager PATCH:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSURLResponse* resp = [task response];
            NSHTTPURLResponse* httpResp = (NSHTTPURLResponse *)resp;
            success(httpResp.statusCode,responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    }
    
}

- (void)afnBodyNetUrl:(NSString *)url method:(NSString *)method Body:(id)body auth:(NSString *)auth  success:(void (^)(NSUInteger statuCode,id responseObject))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:method URLString:url parameters:nil error:nil];
    if (auth) {
        [request setValue:[NSString stringWithFormat:@"Bearer %@", auth]  forHTTPHeaderField:@"Authorization"];
    }
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 设置body
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:nil];
    [request setHTTPBody: jsonData];
    // 设置超时时间
    [request setTimeoutInterval:[[NSUserDefaults standardUserDefaults] floatForKey:@"httptimeout"]];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                         @"application/json",
                                                         @"text/html",
                                                         @"text/json",
                                                         @"text/plain",
                                                         @"text/javascript", nil];
    
    
    
    NSURLSessionDataTask *task = nil;
    
    task = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if(error){
            failure(error);
            
            if (error.code == -1001) {
                NSLog(@"请求超时");
                //                     [task cancel];
                //                    [task resume];
            }
//            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
//                    NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
//                    NSDictionary *json = [errResponse jsonDic];
//                    NSLog(@"%@", json);
            
        }else{
            NSHTTPURLResponse* httpResp = (NSHTTPURLResponse *)response;
            success(httpResp.statusCode,responseObject);
        }
    }];
    [task resume];
    
}


// 原生网络请求
- (void)NSURLSessionUrl:(NSString *)url method:(NSString *)method parameters:(nullable id)parameters success:(void (^)(NSUInteger statuCode,id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSString*encodedurl = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *nsurl = [NSURL URLWithString:encodedurl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurl];
    request.HTTPMethod = method;
    NSError *error = nil;
    if (parameters) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error];
        //把参数放到请求体内
        request.HTTPBody = jsonData;
    }
    
    //将需要的信息放入请求头
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];//token
    
    // 设置超时时间
    [request setTimeoutInterval:[[NSUserDefaults standardUserDefaults] floatForKey:@"httptimeout"]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        
        if (error) { //请求失败
            
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
            
        } else {  //请求成功
            
            dispatch_async(dispatch_get_main_queue(), ^{
                success(httpResponse.statusCode,data);
            });
        }
    }];
    [dataTask resume];
}
// 原生网络请求
- (void)NSURLSessionUrl:(NSString *)url method:(NSString *)method parameters:(nullable id)parameters auth:(NSString *)auth success:(void (^)(NSUInteger statuCode,id responseObject))success failure:(void (^)(NSError *error))failure
{
    
    NSURL *nsurl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurl];
    //如果想要设置网络超时的时间的话，可以使用下面的方法：
    //NSMutableURLRequest *mutableRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //设置请求类型
    request.HTTPMethod = method;
    
    //将需要的信息放入请求头 随便定义了几个
    [request setValue:[NSString stringWithFormat:@"Bearer %@",auth] forHTTPHeaderField:@"Authorization"];//token
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"text/json" forHTTPHeaderField:@"Content-Type"];
    NSLog(@"POST-Header:%@",request.allHTTPHeaderFields);
    
    if (parameters) {
//        NSString *postStr = [self convertToJsonData:parameters];
//        request.HTTPBody = [postStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&parseError];
        request.HTTPBody = jsonData;
    }
    
    // 设置超时时间
    [request setTimeoutInterval:[[NSUserDefaults standardUserDefaults] floatForKey:@"httptimeout"]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        
        if (error) { //请求失败
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
            
        } else {  //请求成功
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                success(httpResponse.statusCode,dic);
            });
            
        }
    }];
    
    [dataTask resume];  //开始请求
    
}

-(NSString*)convertToJsonData:(NSDictionary*)dict

{
    NSError*error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString*jsonString;
    if(!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
    
}



@end
