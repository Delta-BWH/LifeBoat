<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="messaging-res">

<folder name="res">
                            <folder path="messagingservicechatdemo/res/drawable"/>
                            <folder path="messagingservicechatdemo/res/layout"/>
                            <folder name="values">
                                <file path="messagingservicechatdemo/res/values/dimens.xml"/>
                                <file name="strings.xml">&lt;?xml version="1.0" encoding="utf-8"?&gt;
&lt;resources&gt;
    &lt;string name="app_name"&gt;<xsl:value-of select="$applicationName"/>-Messaging&lt;/string&gt;

    &lt;string name="loading_text"&gt;Loading...&lt;/string&gt;
    &lt;string name="text_chat_title"&gt;Text Chat&lt;/string&gt;
    &lt;string name="select_user_prompt"&gt;Select a user to chat with:&lt;/string&gt;
    &lt;string name="previous_symbol"&gt;&lt;![CDATA[&lt;&lt;]]&gt;&lt;/string&gt;
    &lt;string name="next_symbol"&gt;&lt;![CDATA[&gt;&gt;]]&gt;&lt;/string&gt;
    &lt;string name="nickname_prompt"&gt;What is your name?&lt;/string&gt;
    &lt;string name="start_chat_button_text"&gt;Start chat&lt;/string&gt;
    &lt;string name="chat_invitation_message"&gt;Do you want to chat with %s?&lt;/string&gt;
    &lt;string name="decline_button_text"&gt;Decline&lt;/string&gt;
    &lt;string name="accept_button_text"&gt;Accept&lt;/string&gt;
    &lt;string name="text_chat_with_smb_title"&gt;Text Chat with %s&lt;/string&gt;
    &lt;string name="chat_invitation_default"&gt;Do you want to chat?&lt;/string&gt;
    &lt;string name="list_row_arrow_description"&gt;list_row_arrow&lt;/string&gt;
    &lt;string name="waiting_for_template"&gt;Waiting for %s to accept invitation...&lt;/string&gt;
&lt;/resources&gt;
                                </file>
                            </folder>
                        </folder>

    </xsl:template>

</xsl:stylesheet>