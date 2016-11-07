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



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"buyao.caf" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    SystemSoundID systemSound;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &systemSound);
    // 播放
    AudioServicesPlaySystemSound(systemSound);
    
}

    
    
    



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
