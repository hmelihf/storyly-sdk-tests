package com.hmelihf.kotlintest

import android.graphics.BitmapFactory
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.hmelihf.kotlintest.databinding.ActivityDetailedItemBinding


class DetailedItemActivity : AppCompatActivity() {
    private lateinit var binding: ActivityDetailedItemBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityDetailedItemBinding.inflate(layoutInflater)
        setContentView(binding.root)

//        sultan = intent.getSerializableExtra(INTENT_KEY) as Sultan
//
//        with(binding) {
//            name.text = sultan.name
//            reigned.text = "${sultan.reign()}\n${sultan.timeIn}"
//            details.text = sultan.notes
//
//        }

    }

    companion object {
//        const val INTENT_KEY = "SULTAN_DETAIL"
    }
}