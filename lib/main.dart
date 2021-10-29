// ignore_for_file: require_trailing_commas
// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'tabs_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Analytics Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home: MyHomePage(
        title: 'Firebase Analytics Demo',
        analytics: analytics,
        observer: observer,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required this.title,
    required this.analytics,
    required this.observer,
  }) : super(key: key);

  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _message = '';

  void setMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  Future<void> _sendAnalyticsEvent() async {
    // Force crashed the app using firebase crashlytics
    // FirebaseCrashlytics.instance.crash();
    await widget.analytics.logEvent(
      name: 'test_event',
      parameters: <String, dynamic>{
        'string': 'string oct 27 6:21pm wed Plangora',
        'int': 421,
        'long': 12345678910,
        'double': 42.0,
        // Only strings and numbers (ints & doubles) are supported for GA custom event parameters:
        // https://developers.google.com/analytics/devguides/collection/analyticsjs/custom-dims-mets#overview
        'bool': true.toString(),
      },
    );
    setMessage('logEvent succeeded');
  }

  Future<void> _testSetUserId() async {
    await widget.analytics.setUserId('some-user');
    setMessage('setUserId succeeded');
  }

  Future<void> _testSetCurrentScreen() async {
    await widget.analytics.setCurrentScreen(
      screenName: 'Analytics Demo',
      screenClassOverride: 'AnalyticsDemo',
    );
    setMessage('setCurrentScreen succeeded');
  }

  Future<void> _testSetAnalyticsCollectionEnabled() async {
    await widget.analytics.setAnalyticsCollectionEnabled(false);
    await widget.analytics.setAnalyticsCollectionEnabled(true);
    setMessage('setAnalyticsCollectionEnabled succeeded');
  }

  Future<void> _testSetSessionTimeoutDuration() async {
    await widget.analytics.android?.setSessionTimeoutDuration(200000);
    setMessage('setSessionTimeoutDuration succeeded');
  }

  Future<void> _testSetUserProperty() async {
    await widget.analytics.setUserProperty(name: 'regular', value: 'indeed');
    setMessage('setUserProperty succeeded');
  }

  Future<void> _testAllEventTypes() async {
    await widget.analytics.logAddPaymentInfo();
    await widget.analytics.logAddToCart(
      currency: 'USD',
      value: 123,
      itemId: 'test item id by plangora',
      itemName: 'test item name by plangora',
      itemCategory: 'test item category by plangora',
      quantity: 5000,
      price: 2400,
      origin: 'test origin by plangora',
      itemLocationId: 'test location id by plangora',
      destination: 'test destination by plangora',
      startDate: '2021-10-27',
      endDate: '2021-10-27',
    );
    await widget.analytics.logAddToWishlist(
      itemId: 'test item id by plangora',
      itemName: 'test item name by plangora',
      itemCategory: 'test item category by plangora',
      quantity: 5000,
      price: 2400,
      value: 123,
      currency: 'HKD',
      itemLocationId: 'test location id by plangora',
    );
    await widget.analytics.logAppOpen();
    await widget.analytics.logBeginCheckout(
      value: 123,
      currency: 'HKD',
      transactionId: 'test tx id by plangora',
      numberOfNights: 2000,
      numberOfRooms: 3000,
      numberOfPassengers: 4000,
      origin: 'test origin by plangora',
      destination: 'test destination by plangora',
      startDate: '2021-10-27',
      endDate: '2021-10-27',
      travelClass: 'test travel class by plangora',
    );
    await widget.analytics.logCampaignDetails(
      source: 'test source by plangora',
      medium: 'test medium by plangora',
      campaign: 'test campaign by plangora',
      term: 'test term by plangora',
      content: 'test content by plangora',
      aclid: 'test aclid by plangora',
      cp1: 'test cp1 by plangora',
    );
    await widget.analytics.logEarnVirtualCurrency(
      virtualCurrencyName: 'bitcoin by plangora',
      value: 345.66,
    );
    await widget.analytics.logEcommercePurchase(
      currency: 'HKD',
      value: 432.45,
      transactionId: 'test tx id by plangora',
      tax: 3.45,
      shipping: 5.67,
      coupon: 'test coupon by plangora',
      location: 'test location by plangora',
      numberOfNights: 3,
      numberOfRooms: 4,
      numberOfPassengers: 5,
      origin: 'test origin by plangora',
      destination: 'test destination by plangora',
      startDate: '2021-10-27',
      endDate: '2021-10-27',
      travelClass: 'test travel class by plangora',
    );
    await widget.analytics.logGenerateLead(
      currency: 'HKD',
      value: 123.45,
    );
    await widget.analytics.logJoinGroup(
      groupId: 'test group id by plangora',
    );
    await widget.analytics.logLevelUp(
      level: 5,
      character: 'witch doctor by plangora',
    );
    await widget.analytics.logLogin();
    await widget.analytics.logPostScore(
      score: 1000000,
      level: 70,
      character: 'tiefling cleric by plangora',
    );
    await widget.analytics.logPresentOffer(
      itemId: 'test item id by plangora',
      itemName: 'test item name by plangora',
      itemCategory: 'test item category by plangora',
      quantity: 6,
      price: 3.45,
      value: 67.8,
      currency: 'HKD',
      itemLocationId: 'test item location id by plangora',
    );
    await widget.analytics.logPurchaseRefund(
      currency: 'HKD',
      value: 45.67,
      transactionId: 'test tx id by plangora',
    );
    await widget.analytics.logSearch(
      searchTerm: 'hotel by plangora',
      numberOfNights: 2,
      numberOfRooms: 1,
      numberOfPassengers: 3,
      origin: 'test origin by plangora',
      destination: 'test destination by plangora',
      startDate: '2021-10-27',
      endDate: '2021-10-27',
      travelClass: 'test travel class by plangora',
    );
    await widget.analytics.logSelectContent(
      contentType: 'test content type by plangora',
      itemId: 'test item id by plangora',
    );
    await widget.analytics.logShare(
        contentType: 'test content type by plangora',
        itemId: 'test item id by plangora',
        method: 'facebook by plangora');
    await widget.analytics.logSignUp(
      signUpMethod: 'test sign up method',
    );
    await widget.analytics.logSpendVirtualCurrency(
      itemName: 'test item name by plangora',
      virtualCurrencyName: 'bitcoin by plangora',
      value: 34,
    );
    await widget.analytics.logTutorialBegin();
    await widget.analytics.logTutorialComplete();
    await widget.analytics.logUnlockAchievement(id: 'all Firebase API covered by plangora');
    await widget.analytics.logViewItem(
      itemId: 'test item id by plangora',
      itemName: 'test item name by plangora',
      itemCategory: 'test item category by plangora',
      itemLocationId: 'test item location id by plangora',
      price: 3.45,
      quantity: 6,
      currency: 'HKD',
      value: 67.8,
      flightNumber: 'test flight number by plangora',
      numberOfPassengers: 3,
      numberOfRooms: 1,
      numberOfNights: 2,
      origin: 'test origin by plangora',
      destination: 'test destination by plangora',
      startDate: '2015-09-14',
      endDate: '2015-09-15',
      searchTerm: 'test search term by plangora',
      travelClass: 'test travel class by plangora',
    );
    await widget.analytics.logViewItemList(
      itemCategory: 'test item category by plangora',
    );
    await widget.analytics.logViewSearchResults(
      searchTerm: 'test search term by plangora',
    );
    setMessage('All standard events logged successfully');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          MaterialButton(
            onPressed: _sendAnalyticsEvent,
            child: const Text('Test logEvent'),
          ),
          MaterialButton(
            onPressed: _testAllEventTypes,
            child: const Text('Test standard event types'),
          ),
          MaterialButton(
            onPressed: _testSetUserId,
            child: const Text('Test setUserId'),
          ),
          MaterialButton(
            onPressed: _testSetCurrentScreen,
            child: const Text('Test setCurrentScreen'),
          ),
          MaterialButton(
            onPressed: _testSetAnalyticsCollectionEnabled,
            child: const Text('Test setAnalyticsCollectionEnabled'),
          ),
          MaterialButton(
            onPressed: _testSetSessionTimeoutDuration,
            child: const Text('Test setSessionTimeoutDuration'),
          ),
          MaterialButton(
            onPressed: _testSetUserProperty,
            child: const Text('Test setUserProperty'),
          ),
          Text(_message,
              style: const TextStyle(color: Color.fromARGB(255, 0, 155, 0))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<TabsPage>(
              settings: const RouteSettings(name: TabsPage.routeName),
              builder: (BuildContext context) {
                return TabsPage(widget.observer);
              }));
        },
        child: const Icon(Icons.tab),
      ),
    );
  }
}