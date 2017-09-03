#AR初探
###什么是 AR?

> 增强现实技术（Augmented Reality，简称 AR），是一种实时地计算摄影机影像的位置及角度并加上相应图像、视频、3D模型的技术，这种技术的目标是在屏幕上把虚拟世界套在现实世界并进行互动。这种技术1990年提出。随着随身电子产品CPU运算能力的提升，预期增强现实的用途将会越来越广。[百度百科](https://baike.baidu.com/item/%E5%A2%9E%E5%BC%BA%E7%8E%B0%E5%AE%9E/1889025?fr=aladdin&fromid=3404706&fromtitle=ar)

###ARKit是什么?

>iOS 11 introduces ARKit, a new framework that allows you to easily create unparalleled augmented reality experiences for iPhone and iPad. By blending digital objects and information with the environment around you, ARKit takes apps beyond the screen, freeing them to interact with the real world in entirely new ways.

>翻译就是 ios11 苹果推出的一个好用 AR 框架来实现 AR 的应用,增加一个全新的用户交互方式

###我所理解的 AR

>我所理解的 AR 就是把现实场景通过镜头记录到屏幕中(或者说程序中)通过图像处理来改变屏幕中的场景,活添加或修改或删除,人们通过屏幕来获取图像信息.来改变我们眼中的世界!

#ARKit

###1.    视觉惯性测量

>ARKit使用视觉惯性测距（VIO）来精确跟踪周围的世界。VIO将摄像头传感器数据与CoreMotion数据进行融合。这两个输入允许设备以高精确度感测房间内的移动方式，并且不需要额外的校准。

###2. 场景理解和照明估计

> 使用ARKit，iPhone和iPad可以分析相机视图呈现的场景，并在房间中找到水平面。ARKit可以检测水平平面，如桌子和地板，并且可以跟踪和放置较小特征点上的对象。ARKit还利用相机传感器来估计场景中可用光量的总量，并将正确数量的照明应用于虚拟对象。

###3. 高性能硬件和渲染优化

>ARKit运行在Apple A9和A10处理器上。这些处理器提供突破性的性能，可实现快速场景理解，并可让您在现实世界场景之上构建详尽而引人注目的虚拟内容。您可以利用Metal，SceneKit以及Unity和虚幻引擎等第三方工具中的ARKit优化。


#AR 初探
>1. 准备工作 Xcode9 以上版本
>2. ios11 以上版本系统
>3. 硬件必须是 a9以上的处理器
>4. [官方下载地址 https://developer.apple.com/download/](https://developer.apple.com/download/)

打开 Xcode 创建一个 AR 工程

####1. 创建场景(类似于创建一个视图)
* 最开始先创建一个视图容器来存放我们的场景.

```
- (ARSCNView *)sceneView {
if (!_sceneView) {
_sceneView = [[ARSCNView alloc]initWithFrame:[UIScreen mainScreen].bounds];
_sceneView.delegate = self;
_sceneView.showsStatistics = YES;
SCNScene *scene = [[SCNScene alloc]init];
_sceneView.scene = scene;
}
return _sceneView;
}
```


* 注意要添加需要访问摄像头的权限, Xcode9创建 AR 项目帮我们自动添加了;

####2. 创建一个模型
```
//创建模型
SCNBox *box = [SCNBox boxWithWidth:0.1 height:0.1 length:0.1 chamferRadius:0];
//创建渲染
SCNMaterial *boxMaterial = [SCNMaterial material];
//设置渲染
boxMaterial.diffuse.contents = [UIColor yellowColor];
// 添加渲染
box.materials = @[boxMaterial];
```
####3. 添加模型
```
//创建节点
SCNNode *boxNode = [SCNNode nodeWithGeometry:box];
//把模型根据节点的位置添加到场景之中
boxNode.position = SCNVector3Make(0, 0, - 0.2);
//设置模型的根节点 也就相当于吧这个东西添加到场景中响应的位置当中
[self.sceneView.scene.rootNode addChildNode:boxNode];
```
####4. 添加交互方式
```
//创建点击手势
UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizer:)];
//添加手势
[self.sceneView addGestureRecognizer:tap];
```

* 操作模型 实现互动


