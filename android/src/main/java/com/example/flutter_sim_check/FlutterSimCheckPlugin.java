package com.example.flutter_sim_check;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.Log;
import android.widget.Toast;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class FlutterSimCheckPlugin implements MethodCallHandler {
    private final Registrar mRegistrar;

    FlutterSimCheckPlugin(Registrar registrar) {
        mRegistrar = registrar;
    }

    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_sim_check");
        channel.setMethodCallHandler(new FlutterSimCheckPlugin(registrar));
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("check_sim_exist")) {
            TelephonyManager manager = (TelephonyManager) mRegistrar.activeContext().getSystemService(mRegistrar.activity().getApplicationContext().TELEPHONY_SERVICE);
            if (manager != null) {
                String countryId = manager.getSimCountryIso();
                if (countryId != null && !TextUtils.isEmpty(countryId)) {
                    result.success(true);
                    return;
                }
            }
            result.success(false);
        } else if (call.method.equals("check_is_simulator")) {
            String url = "tel:" + "123456";
            Intent intent = new Intent();
            intent.setData(Uri.parse(url));
            intent.setAction(Intent.ACTION_DIAL);
            // 是否可以处理跳转到拨号的 Intent
            boolean canCallPhone = intent.resolveActivity(mRegistrar.activity().getApplicationContext().getPackageManager()) != null;
            boolean isSimulator = Build.FINGERPRINT.startsWith("generic") || Build.FINGERPRINT.toLowerCase()
                    .contains("vbox") || Build.FINGERPRINT.toLowerCase()
                    .contains("test-keys") || Build.MODEL.contains("google_sdk") || Build.MODEL.contains("Emulator") || Build.MODEL
                    .contains("MuMu") || Build.MODEL.contains("virtual") || Build.SERIAL.equalsIgnoreCase("android") || Build.MANUFACTURER
                    .contains("Genymotion") || (Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith("generic")) || "google_sdk"
                    .equals(Build.PRODUCT) || ((TelephonyManager) mRegistrar.activeContext()
                    .getSystemService(Context.TELEPHONY_SERVICE)).getNetworkOperatorName()
                    .toLowerCase()
                    .equals("android") || !canCallPhone;
            result.success(isSimulator);
        } else {
            result.notImplemented();
        }
    }
}
