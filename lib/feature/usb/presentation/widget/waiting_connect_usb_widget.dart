import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpsmapiot/core/theme/app_color.dart';
import 'package:gpsmapiot/feature/usb/presentation/widget/connect_ripple.dart';

class WaitingConnectUsbWidget extends StatefulWidget{
  final void Function() onTap;

  const WaitingConnectUsbWidget({super.key, required this.onTap});

  @override
  State<StatefulWidget> createState() => _WaitingConnectUsbWidgetState();
}

class _WaitingConnectUsbWidgetState extends State<WaitingConnectUsbWidget>{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        children: [
          SizedBox(height: 100,),
          ConnectRipple(),
          SizedBox(height: 20,),
          Text("Chờ kết nối", style: TextStyle(color: AppColor.primaryColor, fontSize: 35, fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Text("USB-C ● Đang dò tìm...", style: TextStyle(color: Colors.grey, fontSize: 22),),
          SizedBox(height: 50,),
          Container(
            width: 240,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(60),
              border: Border.all(color: AppColor.primaryColor, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 20,),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(width: 20,),
                Text("Sẵn sàng kết nối", style: TextStyle(color: AppColor.primaryColor, fontSize: 14),),
                SizedBox(width: 20,),
              ],
            ),
          ),
          SizedBox(height: 100,),
          Material(
            color: AppColor.primaryColor.withOpacity(0.9),
            borderRadius: BorderRadius.circular(40),
            elevation: 0,
            child: InkWell(
              borderRadius: BorderRadius.circular(40),
              splashColor: Colors.white.withOpacity(0.25),
              highlightColor: Colors.white.withOpacity(0.1),
              onTap: widget.onTap,
              child: SizedBox(
                width: 240,
                height: 70,
                child: const Center(
                  child: Text(
                    "Tìm Thiết Bị",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}