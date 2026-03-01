import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:gpsmapiot/core/services/usb_service.dart' hide UsbState;
import 'package:gpsmapiot/feature/usb/bloc/usb_bloc.dart';
import 'package:gpsmapiot/feature/usb/bloc/usb_event.dart';
import 'package:gpsmapiot/feature/usb/bloc/usb_state.dart';
import 'package:gpsmapiot/feature/usb/presentation/widget/failure_connect_usb_widget.dart';
import 'package:gpsmapiot/feature/usb/presentation/widget/success_connect_usb_widget.dart';
import 'package:gpsmapiot/feature/usb/presentation/widget/waiting_connect_usb_widget.dart';

class UsbPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => UsbBloc(UsbService()),
        child: BlocBuilder<UsbBloc, UsbState>(
          builder: (context, state) {
            if(state is UsbInitial){
              return Scaffold(
                body: WaitingConnectUsbWidget(
                  onTap: () {
                    context.read<UsbBloc>().add(UsbConnect());
                  },
                )
              );
            }

            if (state is UsbConnecting) {
              return const CircularProgressIndicator();
            }

            if (state is UsbFailure) {
              return Container(
                child: FailureConnectUsbWidget(
                  onTap: (){
                    context.read<UsbBloc>().add(UsbConnect());
                  },
                ),
              );
            }

            if(state is UsbConnected){
              return SuccessConnectUsbWidget(onTap: (){});
            }

            if(state is UsbDataLoaded){
              return Container();
            }

            return SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Chưa kết nối USB'),
                  SizedBox(height: 50,),
                  GestureDetector(
                    onTap: (){
                      context.read<UsbBloc>().add(UsbConnect());
                    },
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(
                        child: Text("Connect USB", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      )
    );
  }

}