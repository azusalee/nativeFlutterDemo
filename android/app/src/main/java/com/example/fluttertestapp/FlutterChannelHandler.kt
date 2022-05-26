package com.example.fluttertestapp
import android.util.Log
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import org.json.JSONObject

/// 用于处理与Flutter通信的类
object FlutterChannelHandler {

    /// 方法通道
    private var methodChannel: MethodChannel? = null
    /// 消息通道
    private var messageChannel: BasicMessageChannel<Any>? = null

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
                val dict: Map<String, Any> = call.arguments as Map<String, Any>
                val page: Int = dict["page"] as Int
                val pageSize: Int = dict["page_size"] as Int

                val string = this.requestList(page, pageSize)

                result.success(string)
            }
            else {
                result.notImplemented()
            }

        }
    }

    /// 创建消息字符串
    private fun createMessage(messageName: String, data: Any): String {
        val dict: Map<String, Any> = mapOf(
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
    private fun requestList(page: Int, pageSize: Int): String {
        val array = mutableListOf<JSONObject>()
        for (i in 0 until pageSize) {
            val dict: Map<String, String> = mapOf(
                "title" to "标题 $page - $i",
                "time" to "2022-04-04 08:08:08"
            )
            array.add(JSONObject(dict))
        }
        val string = array.toString()
        Log.println(Log.INFO, "Test_Info", string)
        return string
    }

}