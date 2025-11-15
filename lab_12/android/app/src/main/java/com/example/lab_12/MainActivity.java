package com.example.lab_12; // <- change to your actual package name

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Bundle;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StringCodec;

public class MainActivity extends FlutterActivity {
    private static final String METHOD_CHANNEL = "samples.flutter.dev/platform_methods";
    private static final String BASIC_CHANNEL = "samples.flutter.dev/basic";
    private static final String EVENT_CHANNEL = "samples.flutter.dev/charging";

    private BroadcastReceiver chargingStateChangeReceiver;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        // MethodChannel
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), METHOD_CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("getBatteryLevel")) {
                        int batteryLevel = getBatteryLevel();

                        if (batteryLevel != -1) {
                            result.success(batteryLevel);
                        } else {
                            result.error("UNAVAILABLE", "Battery level not available.", null);
                        }
                    } else {
                        result.notImplemented();
                    }
                });

        // BasicMessageChannel (StringCodec)
        final BasicMessageChannel<String> basicMessageChannel =
                new BasicMessageChannel<>(flutterEngine.getDartExecutor().getBinaryMessenger(),
                        BASIC_CHANNEL, StringCodec.INSTANCE);

        basicMessageChannel.setMessageHandler((message, reply) -> {
            // Here Android receives a String from Flutter
            if (message == null) {
                reply.reply("Android received null");
                return;
            }
            // Example: log or do work, then reply:
            String response = "Android received: \"" + message + "\"";
            // Optionally reply synchronously:
            reply.reply(response);
            // If you want to proactively send messages later, you can keep a reference
            // to the channel and call basicMessageChannel.send("msg") from elsewhere.
        });

        // EventChannel for charging state
        new EventChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), EVENT_CHANNEL)
                .setStreamHandler(new EventChannel.StreamHandler() {
                    @Override
                    public void onListen(Object arguments, EventChannel.EventSink events) {
                        // Register receiver
                        chargingStateChangeReceiver = createChargingReceiver(events);
                        IntentFilter filter = new IntentFilter();
                        filter.addAction(Intent.ACTION_BATTERY_CHANGED);
                        registerReceiver(chargingStateChangeReceiver, filter);
                    }

                    @Override
                    public void onCancel(Object arguments) {
                        if (chargingStateChangeReceiver != null) {
                            unregisterReceiver(chargingStateChangeReceiver);
                            chargingStateChangeReceiver = null;
                        }
                    }
                });
    }

    private BroadcastReceiver createChargingReceiver(final EventChannel.EventSink events) {
        return new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                if (intent == null) return;
                int status = intent.getIntExtra(BatteryManager.EXTRA_STATUS, -1);
                boolean isCharging = status == BatteryManager.BATTERY_STATUS_CHARGING ||
                        status == BatteryManager.BATTERY_STATUS_FULL;
                // Send a simple string "charging" or "discharging"
                if (events != null) {
                    if (isCharging) {
                        events.success("charging");
                    } else {
                        events.success("discharging");
                    }
                }
            }
        };
    }

    private int getBatteryLevel() {
        int batteryLevel = -1;
        if (android.os.Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
            if (batteryManager != null) {
                batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
            }
        } else {
            Intent intent = new Intent(Intent.ACTION_BATTERY_CHANGED);
            Intent batteryStatus = registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            if (batteryStatus != null) {
                int level = batteryStatus.getIntExtra(BatteryManager.EXTRA_LEVEL, -1);
                int scale = batteryStatus.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
                if (level >= 0 && scale > 0) {
                    batteryLevel = (int) ((level / (float) scale) * 100);
                }
            }
        }
        return batteryLevel;
    }
}
