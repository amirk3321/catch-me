package com.c4coding.catch_me;

import android.content.Context;

import io.flutter.app.FlutterApplication;
import androidx.multidex.MultiDex;

public class App extends FlutterApplication {
    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        MultiDex.install(this);
    }
}
