package com.mbaas.examples;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Toast;

import com.backendless.Backendless;
import com.backendless.async.callback.AsyncCallback;
import com.backendless.exceptions.BackendlessFault;
import com.backendless.push.DeviceRegistrationResult;
import com.mbaas.examples.Defaults;
import android.app.Activity;


public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Backendless.setUrl( Defaults.SERVER_URL );
        Backendless.initApp(this, Defaults.APPLICATION_ID, Defaults.API_KEY);

        Backendless.Messaging.registerDevice(new AsyncCallback<DeviceRegistrationResult>() {
            @Override
            public void handleResponse(DeviceRegistrationResult response) {
                Toast.makeText( MainActivity.this, "Device registered!",
                    Toast.LENGTH_LONG).show();
            }

            @Override
            public void handleFault(BackendlessFault fault) {
                Toast.makeText( MainActivity.this, "Error registering " + fault.getMessage(),
                    Toast.LENGTH_LONG).show();
            }
        });

    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        Toast.makeText(this, "Push notification demo. You tapped a notification", Toast.LENGTH_LONG).show();
    }
}
