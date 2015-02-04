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

  5.dispatch_queue_t也可以自己定义，如果要定义queue，可以使用dispatch_queue_create方法，示例如下：  
  dispatch_queue_t urls_queue = dispatch_queue_create("blog.ddapps.tolly",NULL);  
  dispatch_async(urls_queue,^{  
	// your code  
});  
  dispatch_release(urls_queue);  

  6.GCD还有一些高级用法，例如让后台两个线程并行执行，然后等两个线程都结束后，再汇  总执行结果。这个可以用dispatch_group 、dispatch_group_async和dispatch_group_notify来实现，示例如下：  

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
