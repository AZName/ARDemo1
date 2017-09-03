//
//  ViewController.m
//  ARDemo1
//
//  Created by 徐振 on 2017/9/3.
//  Copyright © 2017年 徐振. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <ARSCNViewDelegate>

@property (nonatomic, strong)ARSCNView *sceneView;


@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建模型
    SCNBox *box = [SCNBox boxWithWidth:0.1 height:0.1 length:0.1 chamferRadius:0];
    //创建渲染
    SCNMaterial *boxMaterial = [SCNMaterial material];
    //设置渲染
    boxMaterial.diffuse.contents = [UIColor yellowColor];
    // 添加渲染
    box.materials = @[boxMaterial];
    //创建节点
    SCNNode *boxNode = [SCNNode nodeWithGeometry:box];
    //把模型根据节点的位置添加到场景之中
    boxNode.position = SCNVector3Make(0, 0, - 0.2);
    //设置模型的根节点 也就相当于吧这个东西添加到场景中响应的位置当中
    [self.sceneView.scene.rootNode addChildNode:boxNode];
    //创建点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizer:)];
    //添加手势
    [self.sceneView addGestureRecognizer:tap];
    
}
///  操作模型
- (void)tapGestureRecognizer:(UITapGestureRecognizer *)recognizer {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Create a session configuration
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
    
    // Run the view's session
    [self.sceneView.session runWithConfiguration:configuration];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Pause the view's session
    [self.sceneView.session pause];
}


#pragma mark - ARSCNViewDelegate


- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    // Present an error message to the user
    
}

- (void)sessionWasInterrupted:(ARSession *)session {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
}

- (ARSCNView *)sceneView {
    if (!_sceneView) {
        _sceneView = [[ARSCNView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _sceneView.delegate = self;
        _sceneView.showsStatistics = YES;
        _sceneView.scene = [[SCNScene alloc]init];
    }
    return _sceneView;
}


@end

