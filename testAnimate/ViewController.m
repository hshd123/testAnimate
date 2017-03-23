//
//  ViewController.m
//  testAnimate
//
//  Created by Mac on 2017/3/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "NECircleAnimateView.h"

@interface ViewController ()
{
    NECircleAnimateView *_anit;
}

@property (weak, nonatomic) IBOutlet UISlider *slider;


@end

static int count = 0;

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NECircleAnimateView *anit = [[NECircleAnimateView alloc] initWithFrame:CGRectMake(50, 100, 70.0,70.0)];
    anit.layer.cornerRadius = 35.0;
    anit.clipsToBounds = YES;
    anit.layer.masksToBounds = YES;
    [self.view addSubview:anit];
    _anit = anit;
    self.slider.value = 0.0;
    count = 0;
}

- (IBAction)valueChange:(UISlider *)sender
{
    _anit.progress = sender.value * 360.0;
}
- (IBAction)btnClick:(id)sender {
    
    count += 1;
    self.slider.value = count / 10.0;
    _anit.progress = self.slider.value * 360.0;
    NSLog(@"slider -- %f -- %ld",self.slider.value,_anit.progress);

    
//    self.slider.value = 0.0;
//    static int i = 0;
//    [UIView animateWithDuration:1.0 animations:^{
//        NSLog(@"调用次数 ---- %d",i);
//        i += 1;
//    }];
//    _anit.progress = 1.0 * 360.0;
//    for (int i = 0 ; i < 10000; i++) {
//        _anit.progress = self.slider.value * 360.0;
//        self.slider.value += 1.0 / 10000.0;
//        NSLog(@"slider -- %f -- %ld",self.slider.value,_anit.progress);
//    }
//    while (self.slider.value != 1.0) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        });
//        NSLog(@"slider -- %f -- %ld",self.slider.value,_anit.progress);
//    }
//    _anit.progress = 0.5 * 360.0;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
