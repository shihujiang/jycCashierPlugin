package com.pingan.jyc.cashier;

import android.util.Log;

import com.pingan.pay.sdk.CallBack;
import com.pingan.pay.sdk.PayAPI;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * This class echoes a string called from JavaScript.
 */
public class jycCashierPlugin extends CordovaPlugin {
    
    private  String tag = "jycCashierPlugin";
    
    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("coolMethod")) {
            String message = args.getString(0);
            this.coolMethod(message, callbackContext);
            return true;
        }
        return false;
    }
    
    private void coolMethod(String message, final CallbackContext callbackContext) {
        
        PayAPI api = PayAPI.getInstance();
        api.startPaySDKForResult(this.cordova.getActivity(), message, 1, new CallBack() {
            @Override
            public void success(String s) {
                Log.d(tag,s);
                callbackContext.success(s);
            }
            
            @Override
            public void fail(String s) {
                Log.d(tag,s);
                callbackContext.error("Expected one non-empty string argument.");
            }
        });
        //        if (message != null && message.length() > 0) {
        //            callbackContext.success(message);
        //        } else {
        //            callbackContext.error("Expected one non-empty string argument.");
        //        }
    }
}
