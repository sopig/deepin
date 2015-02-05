iOS开发进阶
==========


####工具
1. 项目依赖管理工具 CocoaPods   **这里是[安装和使用说明](http://code4app.com/article/cocoapods-install-usage)**
2. 应用内测分发 [蒲公英](http://www.pgyer.com/) 和 [Fir.im](fir.im)
3. 网络抓包分析工具 [Charles](http://www.charlesproxy.com/)
4. 界面调试工具 [Reveal](http://revealapp.com/)  支持模拟器和真机调试。具体使用教程可以自行Google
5. 崩溃日志记录工具 [Crashlytics]()
6. 移动统计工具 [Flurry]()
7. App Store统计工具 [App Annie]()
8. Xcode插件   
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

 1. 代码片段管理在Xcode整个界面的右下角，可以通过快捷键 `cmd + opt + ctrl + 2` 调出来   
 2.代码片段管理如下图所示 ：   
     
 ![icon](http://ww4.sinaimg.cn/large/759d343bgw1eoym0jhlxzj20c508q3zh.jpg)  

####如何提高iOS开发技能
  >1.猿题库大神唐巧大大整理的[国内优秀开发者博客](https://github.com/tangqiaoboy/iOSBlogCN)  
  >2.[objc.io](http://www.objc.io/)  
  >3.[RayWenderlich](http://www.raywenderlich.com)  
  >4.[iOS Developer Tips](http://iosdevelopertips.com)  
  >5.[iOS Dev Weekly](http://iosdevweekly.com)  
  >6.[NSHipster](http://nshipster.com)  
  >7.[bartosz Ciechanowski](http://ciechanowski.me)  
  >8.[Big Nerd Ranch Blog](http://blog.bignerdranch.com)   
  >9.[Nils Hayat](http://nilsou.com/)  

  
####GCD的深入使用
  * 为了方便的使用GCD，苹果提供了一些方法方便我们将block放在主线程或后台线程执，  
或者延后执行。主要由如下几种：  
  1. 后台执行：  
   dispatch_async(dispatch_get_global_queue(0,0),^{  
	//something
});  
  2. 主线程执行：  
  dispatch_async(dispatch_get_main_queue(),^{
	//something  
});  
  3. 一次性执行：  
  static dispatch_once_t onceToken;    
  dispatch_once(&onceToken,^{  
  //code to be executed  
});  
  4. 延迟2秒执行：  
  double delayInseconds = 2.0f;  
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW,delayInseconds * NSEC_PER_SEC);  
  dispatch_after(popTime,dispatch_get_main_queue(),^(void){  
  //code to be executed on the main queue after delay  
})  
  5. dispatch_queue_t也可以自己定义，如果要定义queue，可以使用dispatch_queue_create方法，示例如下：  
  dispatch_queue_t urls_queue = dispatch_queue_create("blog.ddapps.tolly",NULL);  
  dispatch_async(urls_queue,^{  
	// your code  
});  
  dispatch_release(urls_queue);  
  6. GCD还有一些高级用法，例如让后台两个线程并行执行，然后等两个线程都结束后，再汇  总执行结果。这个可以用dispatch_group 、dispatch_group_async和dispatch_group_notify来实现，示例如下：  
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


####TODO
