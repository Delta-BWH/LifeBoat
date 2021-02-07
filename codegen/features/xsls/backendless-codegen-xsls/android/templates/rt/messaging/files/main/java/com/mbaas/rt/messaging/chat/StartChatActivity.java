package com.mbaas.rt.messaging.chat;

import android.content.Intent;
import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;

import com.backendless.Backendless;

import chat.messaging.rt.backendless.com.realtimechat.R;

public class StartChatActivity extends AppCompatActivity {

  private EditText userNameEditText;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    Backendless.setUrl(Defaults.SERVER_URL);
    Backendless.initApp(this, Defaults.APPLICATION_ID, Defaults.API_KEY);

    setContentView(R.layout.activity_start_char);

    userNameEditText = findViewById(R.id.userName);

    Button startChatButton = findViewById(R.id.start_chat_button);
    startChatButton.setOnClickListener(new OnClickListener() {
      @Override
      public void onClick(View view) {
        startChat();
      }
    });
  }

  private void startChat() {
    Intent intent = new Intent(StartChatActivity.this, ChatRoomActivity.class);
    String name = userNameEditText.getText().toString();
    intent.putExtra("name", name);
    startActivity(intent);

  }

}