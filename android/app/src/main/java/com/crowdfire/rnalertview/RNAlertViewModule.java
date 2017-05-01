package com.crowdfire.rnalertview;

/**
 * Created by karanjthakkar on 02/05/17.
 */

import com.crowdfire.alertDialog.CFAlertDialog;
import com.crowdfire.alertDialog.CFAlertDialogButton;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.justunfollow.android.R;

public class RNAlertViewModule extends ReactContextBaseJavaModule {

    private CFAlertDialog alertDialog;
    private ReactApplicationContext context;

    @Override
    public String getName() {
        return "RNAlertView";
    }

    public RNAlertViewModule(ReactApplicationContext reactContext) {
        super(reactContext);
        context = reactContext;
    }

    @ReactMethod
    public void show(ReadableMap options, Callback callback) {
        String title = options.getString("title");
        String message = options.getString("message");

        ReadableArray buttons = options.getArray("buttons");

        ReadableMap positiveButton = buttons.getMap(0);
        String positiveButtonTitle = positiveButton.getString("title");
        int positiveButtonBackgroundColor = positiveButton.getInt("backgroundColor");
        int positiveButtonTextColor = positiveButton.getInt("textColor");

        ReadableMap negativeButton = buttons.getMap(1);
        String negativeButtonTitle = negativeButton.getString("title");
        int negativeButtonBackgroundColor = negativeButton.getInt("backgroundColor");
        int negativeButtonTextColor = negativeButton.getInt("textColor");

        CFAlertDialogButton.Builder positiveButtonBuilder = new CFAlertDialogButton.Builder(positiveButtonTitle, CFAlertDialogButton.POSITIVE_BUTTON_ID);
        positiveButtonBuilder.backgroundColor(positiveButtonBackgroundColor);
        positiveButtonBuilder.textColor(positiveButtonTextColor);

        CFAlertDialogButton.Builder negativeButtonBuilder = new CFAlertDialogButton.Builder(negativeButtonTitle, CFAlertDialogButton.NEGATIVE_BUTTON_ID);
        negativeButtonBuilder.backgroundColor(negativeButtonBackgroundColor);
        negativeButtonBuilder.textColor(negativeButtonTextColor);

        CFAlertDialog.Builder builder = new CFAlertDialog.Builder(context.getCurrentActivity(), R.style.reactNativePopup);
        builder.title(title);
        builder.message(message);

        builder.addButton(positiveButtonBuilder.build());
        builder.addButton(negativeButtonBuilder.build());
        builder.onButtonClickListener((cfAlertDialog, buttonId) -> {
            switch (buttonId) {
                case CFAlertDialogButton.POSITIVE_BUTTON_ID:
                    callback.invoke(0);
                    alertDialog.dismiss();
                    break;
                case CFAlertDialogButton.NEGATIVE_BUTTON_ID:
                    alertDialog.dismiss();
                    callback.invoke(1);
                    break;
            }
        });

        builder.onDismissListener(dialogInterface -> alertDialog.dismiss());

        alertDialog = builder.create();
        alertDialog.show();
    }

}