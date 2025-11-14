package com.lanqi.bakersoccer

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.widget.VideoView
import androidx.appcompat.app.AppCompatActivity
//启动页
class SplashActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // 使用代码创建VideoView，避免布局文件问题
        val videoView = VideoView(this)
        setContentView(videoView)

        try {
            // 方法1：使用资源ID
            val videoResourceId = R.raw.spread_video
            val uri = Uri.parse("android.resource://$packageName/$videoResourceId")
            videoView.setVideoURI(uri)

            videoView.setOnPreparedListener { mp ->
                mp.isLooping = false
                videoView.start()
            }

            videoView.setOnErrorListener { mp, what, extra ->
                // 如果视频播放出错，直接跳转
                goToMainActivity()
                true
            }

            videoView.setOnCompletionListener {
                goToMainActivity()
            }

        } catch (e: Exception) {
            e.printStackTrace()
            // 如果出现异常，直接跳转
            goToMainActivity()
            return
        }

        // 确保2秒后无论如何都跳转
        Handler(Looper.getMainLooper()).postDelayed({
            goToMainActivity()
        }, 2000)
    }

    private fun goToMainActivity() {
        try {
            val intent = Intent(this, MainActivity::class.java)
            startActivity(intent)
        } catch (e: Exception) {
            e.printStackTrace()
        } finally {
            finish()
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        // 确保释放资源
    }
}