<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="messaging-sources">
<folder name="com">
  <folder name="mbaas">
    <folder name="rt">
      <folder name="messaging">
        <folder name="chat" >
            <file path="templates/rt/messaging/files/main/java/com/mbaas/rt/messaging/chat/ChatRoomActivity.java"/>
            <file path="templates/rt/messaging/files/main/java/com/mbaas/rt/messaging/chat/ColorPickerUtility.java"/>
            <file path="templates/rt/messaging/files/main/java/com/mbaas/rt/messaging/chat/StartChatActivity.java"/>
                                            <file name="Defaults.java">
package <xsl:value-of select="$package"/>;

public class Defaults
{
  <xsl:call-template name="common-defaults"/>

  public static final String DEFAULT_CHANNEL = "chat";
}
                                            </file>
                                            </folder>
                                        </folder>
                                    </folder>
                                </folder>
                            </folder>

    </xsl:template>

</xsl:stylesheet>