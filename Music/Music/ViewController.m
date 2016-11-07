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
// 音乐播放器
@property(nonatomic, strong)AVAudioPlayer *audioPlayer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}





- (IBAction)playMusic:(id)sender {
    [self.audioPlayer play];
}

- (IBAction)pauseMuic:(id)sender {
    [self.audioPlayer pause];
}

- (IBAction)stopMusic:(id)sender {
//    该方法也是音乐暂停，但是会继续缓冲
//    [self.audioPlayer stop];
    self.audioPlayer = nil;
}

- (IBAction)soundID:(id)sender {
    [self playSystemSoundWithFileName:@"buyao.caf"];
}


-(void)playSystemSoundWithFileName:(NSString *)fileName{
    //音效: 在iOS中定义音效为不超过30s的音乐 特点:使用频繁  优点:该音乐会转化为系统声音,播放时没有延迟
    //CoreFoundation类库是Foundation类库的底层实现,而且两个类库的类型可以通过桥接进行转换
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

#pragma mark - 懒加载播放器
-(AVAudioPlayer *)audioPlayer{
    if (_audioPlayer == nil) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"我爱你你却爱着她.mp3" ofType:nil];
        _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:filePath] error:nil];
//        装备播放
        [_audioPlayer prepareToPlay];
        
    }
    return _audioPlayer;
    
}

#pragma mark - 懒加载缓存
-(NSMutableDictionary *)soundIDCache{
    
    if (_soundIDCache == nil) {
        _soundIDCache = [[NSMutableDictionary alloc]init];
    }
    return _soundIDCache;
    
}



@end
