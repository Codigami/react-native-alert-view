import { NativeModules, processColor } from 'react-native';

const { RNAlertView } = NativeModules;

export default {
  /*
   *  config:
   *  {
   *    title(string)     // ios/android
   *    message(string)   // ios/android
   *    preferredStyle(one of actionSheet/alert) // (ios supports both. android supports only alert)
   *    textAlignment(one of left/right/center)   // (ios supports all. android no support. Defaults to left)
   *    buttons(object): {
   *      title(string)     // ios/android
   *      style(one of default/cancel/destructive)   // (ios supports all. android defaults to positive for first button and negative for second button)
   *      alignment(one of justified(default)/right/left/center) // (ios only. android no support. Defaults to justified.)
   *      backgroundColor(one of supported formats: https://facebook.github.io/react-native/docs/colors.html), // ios/android
   *      textColor(one of supported formats: https://facebook.github.io/react-native/docs/colors.html), // ios/android
   *    }
   *  }
   *
   *  calback: Returns the index of the button clicked as the first argument
   *
   */
  show(config, callback) {
    config.buttons = config.buttons.map((button) => {
      const { backgroundColor = 'white', textColor = 'white', ...rest } = button;
      return {
        backgroundColor: processColor(backgroundColor),
        textColor: processColor(textColor),
        ...rest
      };
    });
    RNAlertView.show(config, callback);
  }
};
