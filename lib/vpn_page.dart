import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vpn/flutter_vpn.dart';
import 'package:flutter_vpn/state.dart';
import 'package:lottie/lottie.dart';

class VpnPage extends StatefulWidget {
  const VpnPage({Key? key}) : super(key: key);

  @override
  State<VpnPage> createState() => _VpnPageState();
}

class _VpnPageState extends State<VpnPage> with TickerProviderStateMixin {
  final _switchNotifier =
      ValueNotifier<FlutterVpnState>(FlutterVpnState.disconnected);

  @override
  void initState() {
    super.initState();
    FlutterVpn.prepare();
    FlutterVpn.onStateChanged.listen((event) {
      _switchNotifier.value = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(
          'assets/images/logo-nero-vpn-hor.png',
          height: 34,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      LottieBuilder.asset(
                        'assets/animations/logo.json',
                      ),
                      Image.asset(
                        'assets/images/logo-nero-vpn.png',
                        height: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  ValueListenableBuilder(
                    valueListenable: _switchNotifier,
                    builder: (context, value, _) => Column(
                      children: [
                        Transform.scale(
                          scale: 2,
                          child: CupertinoSwitch(
                            value: value == FlutterVpnState.connected,
                            activeColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            onChanged: (value) {
                              if (value) {
                                FlutterVpn.connectIkev2EAP(
                                  server: 'vpn2.nerolab.dev',
                                  username: 'vpn@nerolab.dev',
                                  password: 'free',
                                );
                              } else {
                                FlutterVpn.disconnect();
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          value == FlutterVpnState.connected
                              ? 'Connected'
                              : value == FlutterVpnState.connecting
                                  ? 'Connecting...'
                                  : value == FlutterVpnState.disconnecting
                                      ? 'Disconnecting'
                                      : 'Disconnected',
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 6),
                        if (value == FlutterVpnState.connected ||
                            value == FlutterVpnState.connecting)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 30,
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 0.6,
                                  ),
                                  image: const DecorationImage(
                                      image: AssetImage('assets/images/sg.png'),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Singapore',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(
              children: [
                Text(
                  'Powered by',
                  style: Theme.of(context).textTheme.caption,
                ),
                const SizedBox(height: 8),
                Image.asset(
                  'assets/images/logo-nerolab.png',
                  height: 30,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
