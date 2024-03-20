//
//  NFImageManage.m
//  nf_image_manage
//
//  Created by 刘晓晨 on 2024/3/18.
//

#import "NFImageManage.h"

static NFImageManage *_manage = nil;
static int kMaxCache = 1 << 4;
@interface NFImageManage ()


@property(nonatomic, weak) FlutterMethodChannel *channel;
@property(nonatomic, assign) int cacheCount;
@property(nonatomic, strong) NSMutableDictionary<NSString *, FlutterImageTaskItem *> *tasks;

/// 因为原生dict插入顺序与遍历顺序不一致,用数组来记录插入顺序
@property(nonatomic, strong) NSMutableArray *keysArr;

@end

@implementation NFImageManage

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manage = [[self alloc] init];
        _manage.tasks = [[NSMutableDictionary alloc] init];
        _manage.keysArr = [[NSMutableArray alloc] init];
    });
    return _manage;
}

+(void)setChannel:(FlutterMethodChannel *)channel {
    [self shared].channel = channel;
}

+(FlutterImageTaskItem *)getTaskWithKey:(NSString *)key {
    return [self shared].tasks[key];
}

-(FlutterImageTaskItem *)putTaskWithImageName:(NSString *)imageName callBack:(CallBack) callBack {
    FlutterImageTaskItem *item = [[FlutterImageTaskItem alloc] init];
    [item addTaskCallBackWithCallBack:callBack];
    [self addTask:item key:imageName];
    return item;
}

+(FlutterImageTaskItem *)getFlutterImageWithImageName:(NSString *)imageName
                                          packageName:(NSString *)packageName
                                          compression:(double) compression
                                             callBack:(CallBack) callBack{
    FlutterImageTaskItem *task = [[self shared] doCacheWithKey:imageName callBack:callBack];
    if (!task) {
        task = [[self shared] putTaskWithImageName:imageName callBack:callBack];
        NSMutableDictionary *arguments = [[NSMutableDictionary alloc] init];
        if (imageName) {
            [arguments setValue:imageName forKey:@"imageName"];
        }
        if (packageName) {
            [arguments setValue:imageName forKey:@"packageName"];
        }
        [arguments setValue:@(compression) forKey:@"compression"];
        [[self shared].channel invokeMethod:@"getFlutterImage" arguments:arguments];
    }
    return task;
}

/// 缓存检查,如果有直接执行
-(FlutterImageTaskItem *)doCacheWithKey:(NSString *)key callBack:(CallBack) callBack {
    FlutterImageTaskItem *task = self.tasks[key];
    if (task) {
        [task addTaskCallBackWithCallBack:callBack];
    }
    return task;
}

+(void)addCache {
    [self shared].cacheCount++;
    if ([self shared].cacheCount >= kMaxCache) {
      [[self shared] checkCache];
    }
}

-(void)addTask:(FlutterImageTaskItem *)task key:(NSString *)key {
    [self.tasks setValue:task forKey:key];
    [self.keysArr removeObject:key];
    [self.keysArr addObject:key];
}

-(void)removeTaskWithKey:(NSString *)key {
    [self.tasks removeObjectForKey:key];
    [self.keysArr removeObject:key];
    self.cacheCount--;
}

-(void)checkCache {
    NSArray *keys = [[NSArray alloc] initWithArray:self.keysArr];
    for(NSString *key in keys) {
      if (self.tasks[key].fullData) {
          [self removeTaskWithKey:key];
      }
        if (self.cacheCount == (kMaxCache >> 1)) break;
    }
  }

@end
