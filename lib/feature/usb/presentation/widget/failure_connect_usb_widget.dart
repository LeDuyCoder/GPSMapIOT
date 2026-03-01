import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpsmapiot/core/theme/app_color.dart';
import 'package:gpsmapiot/feature/usb/presentation/widget/connect_ripple.dart';

class FailureConnectUsbWidget extends StatefulWidget{
  final void Function() onTap;

  const FailureConnectUsbWidget({super.key, required this.onTap});

  @override
  State<StatefulWidget> createState() => _FailureConnectUsbWidgetState();
}

class _FailureConnectUsbWidgetState extends State<FailureConnectUsbWidget>{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        children: [
          SizedBox(height: 150,),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(color: AppColor.errorColor.withOpacity(0.5), blurRadius: 25),
              ],
            ),
            child: Center(
              child: Image.asset("assets/images/pic3.png"),
            ),
          ),
          SizedBox(height: 50,),
          Text("Lỗi Kết Nối", style: TextStyle(color: AppColor.errorColor, fontSize: 35, fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Text("Không tìm thấy thiết bị.", style: TextStyle(color: Colors.grey, fontSize: 22),),
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
                    "Thử Lại",
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