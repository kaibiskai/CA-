//
//  ViewController.m
//  树叶进度效果
//
//  Created by PengXiaodong on 16/1/27.
//  Copyright © 2016年 Tomy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) CGFloat rate;
@property (nonatomic,strong) UIImageView *imageV;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(100, 300, 20, 20)];
    _imageV.image = [UIImage imageNamed:@"leaf"];
    [self.view addSubview:_imageV];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //删除之前的动画重新创建
    [_imageV.layer removeAnimationForKey:@"a"];
    
    //设置x轴旋转
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 3.5];
    
    //设置z轴旋转
    CABasicAnimation* basic = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basic.toValue = [NSNumber numberWithFloat:M_PI * 3];
    
    //设置y轴旋转
    CABasicAnimation *rotaionY = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotaionY.toValue = [NSNumber numberWithFloat:M_PI*3];
    

    
    CALayer *leafLayer = [CALayer layer];
    leafLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"leaf"].CGImage);
    leafLayer.bounds = _imageV.bounds;
    
    //这里的x,y用的图片坐标的xy
    int x = 100;
    int y = 300;
    //锚点
    leafLayer.position = CGPointMake(x,y);
    NSLog(@"%d",arc4random_uniform(15));
    
    //关键帧动画,会一个一个走(个人理解)
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *p1 = [NSValue valueWithCGPoint:leafLayer.position];
    NSValue *p2 = [NSValue valueWithCGPoint:CGPointMake(x+40+arc4random_uniform(15),y-20)];
    NSValue *p3 = [NSValue valueWithCGPoint:CGPointMake(x+85+arc4random_uniform(15),y)];
    NSValue *p4 = [NSValue valueWithCGPoint:CGPointMake(x+120+arc4random_uniform(15),y+30)];
    NSValue *p5 = [NSValue valueWithCGPoint:CGPointMake(x+160+arc4random_uniform(15),y+10)];
    keyAnimation.values = @[p1, p2, p3, p4, p5];
    
    
    //动画合集,把之前创建的全部包含,好比dispatch_group_t一样
    CAAnimationGroup  *group = [CAAnimationGroup animation];
    group.animations = @[basic, keyAnimation,rotaionY];
    group.duration = 8;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    //执行动画
    [_imageV.layer addAnimation:group forKey:@"a"];
    

}

@end







