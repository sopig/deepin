Awesome tutorials in iOS [More Deep in iOS Study] 
==========

####Awesome tutorials   
  >1.[国内优秀开发者博客](https://github.com/tangqiaoboy/iOSBlogCN)  
  >2.[objc.io](http://www.objc.io/)  
  >3.[RayWenderlich](http://www.raywenderlich.com)  
  >4.[iOS Developer Tips](http://iosdevelopertips.com)  
  >5.[iOS Dev Weekly](http://iosdevweekly.com)  
  >6.[NSHipster](http://nshipster.com)  
  >7.[bartosz Ciechanowski](http://ciechanowski.me)  
  >8.[Big Nerd Ranch Blog](http://blog.bignerdranch.com)  
  >9.[Nils Hayat](http://nilsou.com/)    
  >10.[swift](https://github.com/ddapps/Swift)  
  >11.[开发资源整理](https://github.com/lyfeyaj/awesome-resources)  

####工具
* [项目依赖管理工具CocoaPods](http://code4app.com/article/cocoapods-install-usage)   
* [项目依赖管理工具Carthage](http://www.isaced.com/post-265.html)  
* 应用内测分发 [蒲公英](http://www.pgyer.com/) 和 [Fir.im](fir.im)
* 网络抓包分析工具 [Charles](http://www.charlesproxy.com/)
* 界面调试工具 [Reveal](http://revealapp.com/)  支持模拟器和真机调试。具体使用教程可以自行Google
* 崩溃日志记录工具 [Crashlytics]()
* 移动统计工具 [Flurry]()
* App Store统计工具 [App Annie]()
*  Xcode插件   
  >1.[KSImageNamed]()  
  >2.[XVim]()  
  >3.[FuzzyAutocompletePlugin]()  
  >4.[XToDo]()  
  >5.[BBUDebuggerTuckAway]()  
  >6.[SCXcodeSwitchExpander]()  
  >7.[deriveddata-exterminator]()  
  >8.[VVDocumentor]()  
  >9.[ClangFormat]()  
  >10.[ColorSense]()  
  >11.[XcodeBoost]()

####Notice
* 不要在init 和 dealloc里面使用点语法
* [提升UITableView性能-复杂页面的优化](http://tutuge.me/2015/02/19/%E6%8F%90%E5%8D%87UITableView%E6%80%A7%E8%83%BD-%E5%A4%8D%E6%9D%82%E9%A1%B5%E9%9D%A2%E7%9A%84%E4%BC%98%E5%8C%96/)  

####命令行工具
* [nomad](http://nomad-cli.com/) nomad是一个方便你操作苹果开发者中心的命令行工具

####关于白盒测试
  1. 可以具体了解AppleScript     **TODO**

####Xcode使用技巧  
  1. Xcode常用的快捷键如下：  
     `cmd + shift + o`     **快速查找类，可以快速跳到指定类的源码中**  
     `ctrl + 6`                          **列出当前文件中的所有方法**  
     `cmd + 1`                            **切换成Project Navigator**  
     `cmd + ctrl + up`                       **在.h和.m文件之间切换**   
     `cmd + enter`                          **切换成standard editor**  
     `cmd + opt + enter`          **切换成 assistant editor**  
     `cmd + shift + y`            **切换console View的现实或隐藏**  
     `cmd + 0`                  **隐藏左边得导航区**   
     `cmd +opt + 0`             **隐藏右边的工具区**  
     `cmd + ctrl + Left/Right `    **到上/下一次编辑的位置**    
     `cmd + opt +j`            **跳转到文件过滤区**     
     `cmd + shift +F`       ** 在工程中查找**     
     `cmd + R `              **运行**   
     `cmd + b`               **编译**   
     `cmd +shift + k `        **清空编译好的文件**   
     `cmd + .`              **结束本次调试**    
     `ESC`                  **调出代码补全功能**   
     `cmd + t`              **新建一个tab栏**  
     `cmd + shift + [`       **在tab栏之间切换**    
     `cmd + 单击`            **查看该方法的实现**   
     `opt + 单击`            **查看该方法的实现**  
  
####为工程增加Daily Build

 1. 增加Daily Build的步骤和好处，这里有一篇[详细文章](http://blog.devtang.com/blog/2012/02/16/apply-daily-build-in-ios-project/)        
 2. **TODO**  


####管理代码片段

 1. 代码片段管理在Xcode整个界面的右下角，可以通过快捷键 `cmd + opt + ctrl + 2` 调出  
 2.代码片段管理如下图所示 ：   
     
 ![icon](http://ww4.sinaimg.cn/large/759d343bgw1eoym0jhlxzj20c508q3zh.jpg)  
  
 3. 这里是常用的代码片段管理[代码片段](https://github.com/ddapps/xcode_tool)  


  
####GCD的深入使用
  * 为了方便的使用GCD，苹果提供了一些方法方便我们将block放在主线程或后台线程执，  
或者延后执行。主要由如下几种：  
  1. 后台执行：
    
```swift
   dispatch_async(dispatch_get_global_queue(0,0),^{  
	//something
}); 
``` 
  2. 主线程执行：  

```swift 
 dispatch_async(dispatch_get_main_queue(),^{
	//something  
});  
```
 3. 一次性执行：  

```objective-C
  static dispatch_once_t onceToken;    
  dispatch_once(&onceToken,^{  
  //code to be executed  
});  
```
  4. 延迟2秒执行：  

```objective-C
  double delayInseconds = 2.0f;  
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW,delayInseconds * NSEC_PER_SEC);  
  dispatch_after(popTime,dispatch_get_main_queue(),^(void){  
  //code to be executed on the main queue after delay  
})  
```
  5. dispatch_queue_t也可以自己定义，如果要定义queue，可以使用dispatch_queue_create方法，示例如下：  

```objective-C  
	dispatch_queue_t urls_queue = dispatch_queue_create("blog.ddapps.tolly",NULL);  
  dispatch_async(urls_queue,^{  
	// your code  
});  
  dispatch_release(urls_queue);
```
  
  6. GCD还有一些高级用法，例如让后台两个线程并行执行，然后等两个线程都结束后，再汇  总执行结果。这个可以用dispatch_group 、dispatch_group_async和dispatch_group_notify来实现，示例如下：  
```objective-C
	dispatch_group_t group = dispatch_group_create();  
	dispatch_group_async(group,dispatch_get_global_queue(0,0),^{  
	//并行执行的线程一  
})；  
	dispatch_group_async(group,dispatch_get_globale_queue(0,0),^{  
        //并行执行的线程二  
})；    
	dispatch_group_notify(group,dispatch_get_global_queue(0,0),^{  
	//汇总结果  
})  
```

####Ipa重新签名
* [Ipa重新签名](http://blog.csdn.net/cdztop/article/details/17334487)  

####数据处理  
* [Getting Started with JSONModel](http://code.tutsplus.com/tutorials/getting-started-with-jsonmodel--cms-19840)  
* [Magical Data Modelling Framework for JSON](https://github.com/icanzilb/JSONModel/blob/master/README.md#magical-data-modelling-framework-for-json)  
* [JSONModel](https://github.com/icanzilb/JSONModel)
* [NJExtension](https://github.com/CoderMJLee/MJExtension)这种映射方式须待整理，**TODO**

####HighLevel复杂网络处理封装
* [AlamoNetwork](https://github.com/ddapps/AlamoNetwork)  

####UITableView性能优化
* 高度缓存，防止重复计算cell高度，[UITableView-FDTemplateLayoutCell](https://github.com/forkingdog/UITableView-FDTemplateLayoutCell) 

####CoreText排版
1. [DTCoreText源码解析1](http://blog.cnbang.net/tech/2630/)  
    `DTCoreText步骤原理： 1.解析HTML生成DOM树  2.解析CSS，合并得到每个DOM节点对应的样式  3. 生成NSAttributeString`  


####相机照片处理相关
1. [AVFoundation 和 GPUImage](http://wang9262.github.io/blog/2014/08/26/avfoundation-related/)


####产品
1. [原型设计工具](https://墨刀.com)
