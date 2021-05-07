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
    private String PrintLabel(String ip,String bundleQty,String routeno,String qr, String fgpart,String cutLength,
                        String cablePart,String wireGauge,String terminalFrom,String terminalto ){
        String status="";
        String op = TscEthernetDll.openport(ip, 9100);
        System.out.println(ip);
        System.out.println(bundleQty);
        System.out.println(routeno);
        System.out.println(qr);
        System.out.println(fgpart);
        System.out.println(cutLength);
        System.out.println(cablePart);
        System.out.println(wireGauge);
        System.out.println(terminalFrom);
        System.out.println(terminalto);
        if (op == "1") {
            TscEthernetDll.downloadpcx("UL.PCX");
            TscEthernetDll.downloadbmp("Triangle.bmp");
            TscEthernetDll.setup(101, 50 , 4, 4, 0, 3, 0);
            TscEthernetDll.clearbuffer();
            TscEthernetDll.sendcommand("SET TEAR ON\n");
            TscEthernetDll.sendcommand("CLS\n");
            TscEthernetDll.sendcommand("BITMAP 403,1,1,400,1,ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ\n");
            TscEthernetDll.sendcommand("QRCODE 753,378,L,9,A,180,M2,S7,\""+qr+"\"\n");
            TscEthernetDll.sendcommand("CODEPAGE 1252\n");
            TscEthernetDll.sendcommand("TEXT 773,100,\"0\",180,9,9,\"ROUTE NO\"\n");
            TscEthernetDll.sendcommand("TEXT 773,69,\"0\",180,9,9,\""+routeno+"\"\n");
            TscEthernetDll.sendcommand("TEXT 773,40,\"0\",180,9,9,\"\"\n");
            TscEthernetDll.sendcommand("TEXT 298,384,\"0\",180,9,9,\"FG PART NO:\"\n");
            TscEthernetDll.sendcommand("TEXT 298,69,\"0\",180,9,9,\"TERMINAL P/N \\[\"]TO\\[\"]:\"\n");
            TscEthernetDll.sendcommand("TEXT 298,325,\"0\",180,9,9,\"PO NO:\"\"\n");
            TscEthernetDll.sendcommand("TEXT 298,292,\"0\",180,9,9,\"CUT LENGTH:\"\n");
            TscEthernetDll.sendcommand("TEXT 298,196,\"0\",180,9,9,\"WIRE GAUGE:\"\n");
            TscEthernetDll.sendcommand("TEXT 298,131,\"0\",180,9,9,\"TERMINAL P/N \\[\"] FROM\\[\"]:\"\n");
            TscEthernetDll.sendcommand("TEXT 298,260,\"0\",180,9,9,\"CABLE PART#:\"\n");
            TscEthernetDll.sendcommand("TEXT 298,356,\"0\",180,9,9,\""+fgpart+"\"\n");
            TscEthernetDll.sendcommand("TEXT 298,37,\"0\",180,9,9,\""+wireGauge+"\"\n");
            TscEthernetDll.sendcommand("TEXT 152,292,\"0\",180,9,9,\""+cutLength+"\"\n");
            TscEthernetDll.sendcommand("TEXT 298,168,\"0\",180,9,9,\""+cablePart+"\"\n");
            TscEthernetDll.sendcommand("TEXT 298,103,\"0\",180,9,9,\""+terminalFrom+"\"\n");
            TscEthernetDll.sendcommand("TEXT 298,231,\"0\",180,9,9,\""+terminalto+"\"\n");
            TscEthernetDll.sendcommand("TEXT 773,130,\"0\",180,9,9,\"BUNDLE QTY:\"\n");
            TscEthernetDll.sendcommand("TEXT 614,130,\"0\",180,9,9,\""+bundleQty+"\"\n");
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
                                String ip = call.argument("ipaddress");
                                String qr = call.argument("qr");
                                String bundleqty = call.argument("bundleQty");
                                String routenumber = call.argument("routenumber1");
                                String fgpartnumber =call.argument("fgPartNumber");
                                String cutlength =call.argument("cutlength");
                                String cablepart =call.argument("cutpart");
                                String wireGauge =call.argument("wireGauge");
                                String terminalfrom =call.argument("terminalfrom");
                                String terminalto =call.argument("terminalto");
                                
                                String status = PrintLabel(ip,bundleqty,routenumber,qr,fgpartnumber,cutlength,cablepart,wireGauge,terminalfrom,terminalto);
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
