package com.impereal.molex;

import androidx.annotation.NonNull;

import com.example.tscdll.TscWifiActivity;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.impereal.dev/tsc";
    TscWifiActivity TscEthernetDll = new TscWifiActivity();
    private String Print(){
        String status="";
        String op = TscEthernetDll.openport("192.168.1.130", 9100);
        if (op == "1") {
            TscEthernetDll.downloadpcx("UL.PCX");
            TscEthernetDll.downloadbmp("Triangle.bmp");
            TscEthernetDll.setup(70, 110, 4, 4, 0, 0, 0);
            TscEthernetDll.clearbuffer();
            TscEthernetDll.sendcommand("SET TEAR ON\n");
            TscEthernetDll.sendcommand("SET COUNTER @1 1\n");
            TscEthernetDll.sendcommand("@1 = \"0001\"\n");
            TscEthernetDll.sendcommand("TEXT 100,300,\"3\",0,1,1,@1\n");
            TscEthernetDll.sendcommand("PUTPCX 100,300,\"UL.PCX\"\n");
            TscEthernetDll.sendcommand("PUTBMP 100,520,\"Triangle.bmp\"\n");
            TscEthernetDll.barcode(100, 100, "128", 100, 1, 0, 3, 3, "123456789");
            TscEthernetDll.printerfont(100, 250, "3", 0, 1, 1, "987654321");
            status = TscEthernetDll.printerstatus();
            TscEthernetDll.printlabel(2, 1);
            //TscEthernetDll.sendfile("zpl.txt");
            TscEthernetDll.closeport(5000);

        }else{
            status ="-1";
        }
        return status;


    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if(call.method.equals("Print")){
                                String status = Print();
                                if(status != "-1") {
                                    result.success(status);
                                }else{
                                    result.error("-1 not printed","Printer not available",null);
                                }
                            }else{
                                result.notImplemented();
                            }
                        }
                );
    }
}
