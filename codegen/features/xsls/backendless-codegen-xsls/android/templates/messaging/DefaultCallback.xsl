<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="DefaultCallbackTemplate">
                                            <file name="DefaultCallback.java">
package <xsl:value-of select="$package"/>;

import android.app.ProgressDialog;
import android.content.Context;
import android.widget.Toast;
import com.backendless.async.callback.BackendlessCallback;
import com.backendless.exceptions.BackendlessFault;

public class DefaultCallback&lt;T&gt; extends BackendlessCallback&lt;T&gt;
{
  Context context;
  ProgressDialog progressDialog;

  public DefaultCallback( Context context )
  {
    this.context = context;
    progressDialog = ProgressDialog.show( context, "", "Loading...", true );
  }

  public DefaultCallback( Context context, String loadingMessage )
  {
    this.context = context;
    progressDialog = ProgressDialog.show( context, "", loadingMessage, true );
  }

  @Override
  public void handleResponse( T response )
  {
    progressDialog.cancel();
  }

  @Override
  public void handleFault( BackendlessFault fault )
  {
    progressDialog.cancel();
    Toast.makeText( context, fault.getMessage(), Toast.LENGTH_LONG ).show();
  }
}
                                            </file>
    </xsl:template>

</xsl:stylesheet>