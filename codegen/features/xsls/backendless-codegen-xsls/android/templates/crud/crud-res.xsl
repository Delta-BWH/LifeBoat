<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="crud-res">

<folder name="res">
                            <folder path="dataservicecruddemo/res/drawable"/>
                            <folder name="layout">
                                <file path="dataservicecruddemo/res/layout/entity_properties.xml"/>
                                <file path="dataservicecruddemo/res/layout/list_item_with_arrow.xml"/>
                                <file path="dataservicecruddemo/res/layout/property_row.xml"/>
                                <file path="dataservicecruddemo/res/layout/related_show_property_template.xml"/>
                                <file path="dataservicecruddemo/res/layout/sample_code_template.xml"/>
                                <file path="dataservicecruddemo/res/layout/sample_success.xml"/>
                                <file path="dataservicecruddemo/res/layout/select_retrieval_type.xml"/>
                                <file path="dataservicecruddemo/res/layout/select_table.xml"/>
                                <file path="dataservicecruddemo/res/layout/select_table_operation.xml"/>
                                <file path="dataservicecruddemo/res/layout/show_by_property.xml"/>
                                <file path="dataservicecruddemo/res/layout/show_property_template.xml"/>
                                <file name="send_email.xml">&lt;?xml version="1.0" encoding="utf-8"?&gt;

&lt;LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
              android:orientation="vertical"
              android:layout_width="match_parent"
              android:layout_height="match_parent"
              android:paddingLeft="@dimen/dp16"
              android:paddingRight="@dimen/dp16"&gt;

    &lt;TextView
            android:layout_width="match_parent"
            android:layout_height="@dimen/dp48"
            android:text="@string/send_email_title"
            android:layout_marginBottom="@dimen/dp4"
            android:gravity="center"
            android:textSize="@dimen/text_large"/&gt;

    &lt;TextView
            android:layout_width="match_parent"
            android:layout_height="@dimen/dp48"
            android:text="@string/email_address_propmt"
            android:layout_marginTop="@dimen/dp4"
            android:layout_marginBottom="@dimen/dp4"
            android:gravity="bottom"
            android:textSize="@dimen/text_medium"/&gt;

    &lt;EditText
            android:layout_width="match_parent"
            android:layout_height="@dimen/dp48"
            android:id="@+id/emailAddressEdit"
            android:layout_marginTop="@dimen/dp4"
            android:layout_marginBottom="@dimen/dp4"
            android:textSize="@dimen/text_medium"
            android:text="<xsl:value-of select="backendless-codegen/application/developerEmail"/>"/&gt;

    &lt;Button
            android:layout_width="@dimen/dp144"
            android:layout_height="wrap_content"
            android:id="@+id/sendButton"
            android:layout_marginTop="@dimen/dp4"
            android:text="@string/send_button_text"/&gt;

&lt;/LinearLayout&gt;
                                </file>
                            </folder>
                            <folder name="values">
                                <file path="dataservicecruddemo/res/values/dimens.xml"/>
                                <file path="dataservicecruddemo/res/values/string_arrays.xml"/>
                                <file name="strings.xml">&lt;?xml version="1.0" encoding="utf-8"?&gt;
&lt;resources&gt;
    &lt;string name="app_name"&gt;<xsl:value-of select="$applicationName"/>-CRUD&lt;/string&gt;
    &lt;string name="tables_list_title"&gt;Tables&lt;/string&gt;
    &lt;string name="previous_page_symbol"&gt;&lt;![CDATA[&lt;&lt;]]&gt;&lt;/string&gt;
    &lt;string name="next_page_symbol"&gt;&lt;![CDATA[&gt;&gt;]]&gt;&lt;/string&gt;
    &lt;string name="list_row_with_arrow_description"&gt;list row arrow&lt;/string&gt;
    &lt;string name="table_operations_title_template"&gt;%s table operations&lt;/string&gt;
    &lt;string name="create_record_title_template"&gt;Create new %s&lt;/string&gt;
    &lt;string name="run_code_button_text"&gt;Run Code&lt;/string&gt;
    &lt;string name="send_code_button_text"&gt;Send Code by Email&lt;/string&gt;
    &lt;string name="success_title"&gt;Success&lt;/string&gt;
    &lt;string name="send_email_title"&gt;Send Code by Email&lt;/string&gt;
    &lt;string name="email_address_propmt"&gt;Email address:&lt;/string&gt;
    &lt;string name="send_button_text"&gt;Send&lt;/string&gt;
    &lt;string name="retrieve_title_template"&gt;Retrieve %s objects&lt;/string&gt;
    &lt;string name="default_sample_code_title"&gt;Sample Code&lt;/string&gt;
    &lt;string name="delete_title_template"&gt;Delete %s&lt;/string&gt;
    &lt;string name="update_title_template"&gt;Update %s&lt;/string&gt;
    &lt;string name="success_info_template"&gt;The record has been %s.&lt;/string&gt;
    &lt;string name="property_to_show_prompt"&gt;Property to show:&lt;/string&gt;
    &lt;string name="find_with_relations_title"&gt;Find with Relations&lt;/string&gt;
    &lt;string name="related_property_to_show_prompt"&gt;Related property to show:&lt;/string&gt;
    &lt;string name="related_table_name_template"&gt;%s:&lt;/string&gt;
    &lt;string name="basic_find_title"&gt;Basic Find&lt;/string&gt;
    &lt;string name="property_title"&gt;Property&lt;/string&gt;
    &lt;string name="value_title"&gt;Value&lt;/string&gt;
&lt;/resources&gt;
                                </file>
                            </folder>
                        </folder>

    </xsl:template>

</xsl:stylesheet>