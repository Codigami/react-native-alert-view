# React Native Alert View

React Native Alert View is a react native wrapper for [CFAlertViewController](https://github.com/Codigami/CFAlertViewController) iOS component that we use at [Crowdfire](https://crowdfireapp.com)

This library currently supports only iOS but android support is coming very soon.


# Installation

1. Install `react-native-alert-view` from npm

    `yarn add react-native-alert-view` OR `npm install --save react-native-alert-view`

2. Setup your project to use the installed library

    ## Install using Cocoapods (recommended)

    We assume that your Cocoapods is already configured. If you are new to Cocoapods, have a look at the [documentation](https://guides.cocoapods.org/)

    - Add `pod 'react-native-alert-view', :path => '../node_modules/react-native-alert-view'` to your Podfile.
      This will 
    - Install the pod(s) by running `pod install` in terminal (in folder where Podfile file is located).

    ## Install using source

    - Install `CFAlertViewController` in your project using the instructions here: https://github.com/Codigami/CFAlertViewController#install-using-source-file
    - Install `RNAlertView` in your project using the same instructions


# Options

React Native Alert View only supports a subset of functionalities provided by CFAlertViewController. It exposes a method `show` which can be used as:

```
ReactNativeAlertView.show(options, callback)
```


## Suported options

#### Alert options

| Option         | Type   | Allowed values                             | Default | Platform support                                                                                                                          |
|----------------|--------|--------------------------------------------|---------|-------------------------------------------------------------------------------------------------------------------------------------------|
| title          | string | Any string                                 | `''`    | Supported on iOS/Android                                                                                                                  |
| message        | string | Any string                                 | `''`    | Supported on iOS/Android                                                                                                                  |
| preferredStyle | string | One of `actionSheet`/`alert`               | `alert` | iOS: Supports both Android: Defaults to `alert`. Option is ignored                                                                        |
| textAlignment  | string | One of `left`/`right`/`center`             | `left`  | iOS: Supports all values Android: Defaults to `left`. Option is ignored                                                                   |
| buttons        | Array  | List of `button`'s                         | `[]`    | iOS: Supports multiple buttons Android: Requires 2 buttons. First button is used for a positive action. Second one for a positive action. |

#### Button options

| Option          | Type   | Allowed values                                                                       | Default     | Platform support                                                             |
|-----------------|--------|--------------------------------------------------------------------------------------|-------------|------------------------------------------------------------------------------|
| title           | string | Any string                                                                           | `''`        | Supported on iOS/Android                                                     |
| style           | string | One of `default`/`cancel`/`desctructive`                                             | `default`   | iOS: Supports all values Android: Defaults to `default`. Option is ignored   |
| alignment       | string | One of `left`/`right`/`center`/`justified`                                           | `justified` | iOS: Supports all values Android: Defaults to `justified`. Option is ignored |
| backgroundColor | string | Any color supported [here](https://facebook.github.io/react-native/docs/colors.html) | `white`     | Supported on iOS/Android                                                     |
| textColor       | string | Any color supported [here](https://facebook.github.io/react-native/docs/colors.html) | `white`     | Supported on iOS/Android                                                     |


# Usage 

```
import React from 'react';
import { Text, TouchableOpacity } from 'react-native';
import ReactNativeAlertView from 'react-native-alert-view'

const TestComponent = React.createClass({
  show() {
    ReactNativeAlertView.show({
      title: 'title',
      message: 'message',
      preferredStyle: 'actionSheet',
      textAlignment: 'center',
      buttons: [{
        title: 'string 1',
        style: 'destructive',
        alignment: 'center',
        backgroundColor: '#123456',
      }, {
        title: 'string 2',
        style: 'default',
        alignment: 'justified',
        backgroundColor: '#234989',
        textColor: 'yellow'
      }]
    }, (index) => {
      alert(`Button with index ${index} tapped`);
    });
  },

  render() {
    return (
      <TouchableOpacity onPress={this.show} style={{marginTop: 20}}>
        <Text>Click to show alert view</Text>
      </TouchableOpacity>
    );
  }
});

export default TestComponent;

```

# License

MIT © 2017 Crowdfire Inc.