package com.example.fluttertestapp

import com.idlefish.flutterboost.FlutterBoost
import com.idlefish.flutterboost.FlutterBoostDelegate
import com.idlefish.flutterboost.FlutterBoostRouteOptions
import com.idlefish.flutterboost.containers.FlutterBoostActivity
import io.flutter.embedding.android.FlutterActivityLaunchConfigs

class MyBoostDelegate : FlutterBoostDelegate {
    // 跳原生页
    override fun pushNativeRoute(options: FlutterBoostRouteOptions?) {
        var pageName = options!!.pageName()

    }
    // 跳flutter页
    override fun pushFlutterRoute(options: FlutterBoostRouteOptions?) {
        var intent = FlutterBoostActivity.CachedEngineIntentBuilder(FlutterBoostActivity::class.java)
            .backgroundMode(FlutterActivityLaunchConfigs.BackgroundMode.transparent)
            .destroyEngineWithActivity(false)
            .uniqueId(options!!.uniqueId())
            .url(options!!.pageName())
            .urlParams(options!!.arguments())
            .build(FlutterBoost.instance().currentActivity())

        FlutterBoost.instance().currentActivity().startActivity(intent)
    }

}