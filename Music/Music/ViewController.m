//
//  ViewController.m
//  Music
//
//  Created by HYY on 16/11/7.
//  Copyright © 2016年 abc_show. All rights reserved.
//

#import "ViewController.h"
// 导入音视频的类库
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

// 音频缓存
@property(nonatomic, strong)NSMutableDictionary *soundIDCache;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self playSystemSoundWithFileName:@"buyao.caf"];
    
    
}

-(void)playSystemSoundWithFileName:(NSString *)fileName{
//    从缓存取出
    SystemSoundID systemSound = [[self.soundIDCache valueForKey:fileName] unsignedIntValue];
    if (systemSound == 0) {
        
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    SystemSoundID systemSound;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &systemSound);
//        缓存
    [self.soundIDCache setValue:@(systemSound) forKey:fileName];
        
    }
    
    // 播放
    AudioServicesPlaySystemSound(systemSound);
    
}
    
    



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // 优化内存紧张
    for (NSNumber *soundId in self.soundIDCache.allValues) {
        // 销毁系统声音
        AudioServicesDisposeSystemSoundID([soundId unsignedIntValue]);
    }
    self.soundIDCache = nil;


}

#pragma mark - 懒加载缓存
-(NSMutableDictionary *)soundIDCache{
    
    if (_soundIDCache == nil) {
        _soundIDCache = [[NSMutableDictionary alloc]init];
    }
    return _soundIDCache;
    
}



@end
