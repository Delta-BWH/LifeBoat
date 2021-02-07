package com.mbass.examples

import android.app.Activity
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.EditText
import android.widget.TextView

import com.backendless.Backendless
import com.backendless.IDataStore
import com.backendless.async.callback.AsyncCallback
import com.backendless.exceptions.BackendlessFault

import java.util.HashMap

class MainActivity : Activity() {
    private var status: TextView? = null
    private var updateButton: Button? = null

    public override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.main_activity)

        Backendless.setUrl(Defaults.SERVER_URL)
        Backendless.initApp(applicationContext, Defaults.APPLICATION_ID, Defaults.API_KEY)

        status = findViewById(R.id.status)
        updateButton = findViewById(R.id.update_button)
        updateButton?.isEnabled = false

        val testObject = HashMap<Any?, Any?>()
        testObject["foo"] = "Hello World"
        val testTableDataStore = Backendless.Data.of("TestTable")
        testTableDataStore.save(testObject, object : AsyncCallback<MutableMap<Any?, Any?>> {
            override fun handleResponse(response: MutableMap<Any?, Any?>) {
                subscribeForObjectUpdate(response, testTableDataStore)

                updateButton?.setOnClickListener { updateValue(response, testTableDataStore) }

                status?.text = "Object has been saved in the real-time database"
                changeSavedValue(response)
                updateButton?.isEnabled = true
            }

            override fun handleFault(fault: BackendlessFault) {
                this@MainActivity.handleFault(fault)
            }
        })
    }

    private fun updateValue(response: MutableMap<Any?, Any?>, testTableDataStore: IDataStore<Map<Any?, Any?>>) {
        updateButton?.isEnabled = false
        val propertyValueText = findViewById<EditText>(R.id.property_value)
        response["foo"] = propertyValueText.text.toString()
        testTableDataStore.save(response, object : AsyncCallback<Map<Any?, Any?>> {
            override fun handleResponse(response: Map<Any?, Any?>) {
                Log.i("MYAPP", "saved $response")
                updateButton?.isEnabled = true
                propertyValueText.setText("")
            }

            override fun handleFault(fault: BackendlessFault) {
                this@MainActivity.handleFault(fault)
            }
        })
    }

    private fun subscribeForObjectUpdate(response: Map<Any?, Any?>, testTableDataStore: IDataStore<Map<Any?, Any?>>) {
        testTableDataStore.rt().addUpdateListener("objectId='${response["objectId"]}'",
            object : AsyncCallback<Map<Any?, Any?>> {
                override fun handleResponse(response: Map<Any?, Any?>) {
                    changeSavedValue(response)
                }

                override fun handleFault(fault: BackendlessFault) {
                    this@MainActivity.handleFault(fault)
                }
        })
    }

    private fun handleFault(fault: BackendlessFault) {
        val msg = "Server reported an error ${fault.message}"
        Log.e("MYAPP", msg)
        status?.text = msg
        updateButton?.isEnabled = true
    }

    private fun changeSavedValue(response: Map<Any?, Any?>) {
        val savedValueTextView = findViewById<TextView>(R.id.saved_value)
        savedValueTextView.text = response["foo"] as String
    }
}
                                    