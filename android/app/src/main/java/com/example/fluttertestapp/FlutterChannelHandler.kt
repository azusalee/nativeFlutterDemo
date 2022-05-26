package com.example.fluttertestapp
import android.util.Log
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import org.json.JSONObject

object FlutterChannelHandler {

    var methodChannel: MethodChannel? = null
    var messageChannel: BasicMessageChannel<Any>? = null

    /// 设置与flutter通信的channel
    fun setupEngine(engine: FlutterEngine) {
        // 消息通道
        messageChannel = BasicMessageChannel(
            engine.dartExecutor.binaryMessenger,
            "/app/message",
            StandardMessageCodec()
        )
        messageChannel!!.setMessageHandler { message, reply ->
            Log.println(Log.INFO, "Test_Info", message.toString())
            reply.reply("native已收到")
        }

        // 方法通道
        methodChannel = MethodChannel(
            engine.dartExecutor.binaryMessenger,
            "/app/method"
        )
        methodChannel!!.setMethodCallHandler { call, result ->
            Log.println(Log.INFO, "Test_Info", call.method)
            if (call.method == FlutterMethods.getLocalizeName) {
                result.success(call.arguments)
            } else if (call.method == FlutterMethods.requestMessageList) {
                var dict: Map<String, Any> = call.arguments as Map<String, Any>
                var page: Int = dict["page"] as Int
                var pageSize: Int = dict["page_size"] as Int

                var string = this.requestList(page, pageSize)

                result.success(string)
            }
            else {
                result.notImplemented()
            }

        }
    }

    /// 创建消息字符串
    fun createMessage(messageName: String, data: Any): String {
        var dict: Map<String, Any> = mapOf(
            "message" to messageName,
            "data" to data
        )

        return JSONObject(dict).toString()
    }

    /// 让flutter更换根页面
    fun changeFlutterRootRoute(routeName: String) {
        this.messageChannel?.send(this.createMessage(FlutterMessages.changeRootRoute, routeName))
    }

    /// 请求列表数据(模拟请求，生成假数据返回)
    fun requestList(page: Int, pageSize: Int): String {
        var array = mutableListOf<JSONObject>()
        for (i in 0 until pageSize) {
            var dict: Map<String, String> = mapOf(
                "title" to "标题 $i",
                "time" to "2022-04-04 08:08:08"
            )
            array.add(JSONObject(dict))
        }
        var string = array.toString()
        Log.println(Log.INFO, "Test_Info", string)
        return string
    }

}