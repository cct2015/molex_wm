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
            TscEthernetDll.setup(101, 50 , 4, 4, 0, 3, 0);
            TscEthernetDll.clearbuffer();
            TscEthernetDll.sendcommand("SET TEAR ON\n");
            TscEthernetDll.sendcommand("CLS\n");
            TscEthernetDll.sendcommand("BITMAP 403,1,1,400,1,ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ\n");
            TscEthernetDll.sendcommand("QRCODE 753,378,L,9,A,180,M2,S7,\"A67BDVYTUOBDHSJCV16977367945345WSG74273V1064\"\n");
            TscEthernetDll.sendcommand("CODEPAGE 1252\n");
            TscEthernetDll.sendcommand("TEXT 773,100,\"0\",180,9,9,\"ROUTE NO\"\n");
            TscEthernetDll.sendcommand("TEXT 773,69,\"0\",180,9,9,\"01-02-03-04-10-09-08-07-\"\n");
            TscEthernetDll.sendcommand("TEXT 773,40,\"0\",180,9,9,\"06-05-11-12-13-14-15-15\"\n");
            TscEthernetDll.sendcommand("TEXT 298,384,\"0\",180,9,9,\"FG PART NO:\"\n");
            TscEthernetDll.sendcommand("TEXT 298,69,\"0\",180,9,9,\"TERMINAL P/N \\[\"]TO\\[\"]:\"\n");
            TscEthernetDll.sendcommand("TEXT 298,325,\"0\",180,9,9,\"PO NO:\"\"\n");
            TscEthernetDll.sendcommand("TEXT 298,292,\"0\",180,9,9,\"CUT LENGTH:\"\n");
            TscEthernetDll.sendcommand("TEXT 298,196,\"0\",180,9,9,\"WIRE GAUGE:\"\n");
            TscEthernetDll.sendcommand("TEXT 298,131,\"0\",180,9,9,\"TERMINAL P/N \\[\"] FROM\\[\"]:\"\n");
            TscEthernetDll.sendcommand("TEXT 298,260,\"0\",180,9,9,\"CABLE PART#:\"\n");
            TscEthernetDll.sendcommand("TEXT 298,356,\"0\",180,9,9,\"ABCDE1234567890\"\n");
            TscEthernetDll.sendcommand("TEXT 298,37,\"0\",180,9,9,\"ABCDE1234567890\"\n");
            TscEthernetDll.sendcommand("TEXT 298,37,\"0\",180,9,9,\"ABCDE1234567\"\n");
            TscEthernetDll.sendcommand("TEXT 152,292,\"0\",180,9,9,\"1234\"\n");
            TscEthernetDll.sendcommand("TEXT 298,168,\"0\",180,9,9,\"ABCDEF123456\"\n");
            TscEthernetDll.sendcommand("TEXT 298,103,\"0\",180,9,9,\"ABCDE1234567890\"\n");
            TscEthernetDll.sendcommand("TEXT 298,231,\"0\",180,9,9,\"ABCDE1234567890\"\n");
            TscEthernetDll.sendcommand("TEXT 773,130,\"0\",180,9,9,\"BUNDLE QTY:\"\n");
            TscEthernetDll.sendcommand("TEXT 614,130,\"0\",180,9,9,\"1234\"\n");
            TscEthernetDll.sendcommand("PRINT 1,1\"\n");
            TscEthernetDll.sendcommand("PUTBMP 100,520,\"Triangle.bmp\"\n");
            status = TscEthernetDll.printerstatus();
            TscEthernetDll.printlabel(1, 1);
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
