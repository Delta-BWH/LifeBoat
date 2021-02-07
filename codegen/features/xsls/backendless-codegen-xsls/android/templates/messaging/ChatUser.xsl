<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="ChatUserTemplate">
                                <file name="ChatUser.java">
package <xsl:value-of select="$package"/>;

public class ChatUser
{
  private static ChatUser currentUser = new ChatUser();

  public static ChatUser currentUser()
  {
    return currentUser;
  }

  private String objectId;
  private String nickname;
  private String deviceId;

  public String getObjectId()
  {
    return objectId;
  }

  public void setObjectId( String objectId )
  {
    this.objectId = objectId;
  }

  public String getNickname()
  {
    return nickname;
  }

  public void setNickname( String nickname )
  {
    this.nickname = nickname;
  }

  public String getDeviceId()
  {
    return deviceId;
  }

  public void setDeviceId( String deviceId )
  {
    this.deviceId = deviceId;
  }
}

                                            </file>
    </xsl:template>

</xsl:stylesheet>