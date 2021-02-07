<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->
    <xsl:import href="js-util.xsl"/>

    <xsl:param name="generateLoginAndRegistrationForm"/>
    <xsl:param name="facebookLogin"/>
    <xsl:param name="twitterLogin"/>
    <xsl:param name="googleLogin"/>

    <xsl:include href="../util.xsl"/>

    <xsl:variable name="applicationName" select="backendless-codegen/application/name"/>
    <xsl:variable name="projectName"><xsl:value-of select="$applicationName"/>-Login</xsl:variable>
    <xsl:variable name="applicationId" select="backendless-codegen/application/id"/>
    <xsl:variable name="apiKey" select="backendless-codegen/application/apiKeys/JS"/>
    <xsl:variable name="googleClientId" select="backendless-codegen/application/socialSettings/googleClientId"/>
    <xsl:variable name="facebookAppId" select="backendless-codegen/application/socialSettings/facebookAppId"/>
    <xsl:variable name="serverURL" select="backendless-codegen/application/serverURL"/>
    <xsl:variable name="emailConfirmationRequired" select="backendless-codegen/application/emailConfirmation"/>
    <xsl:variable name="socialLogin" select="$twitterLogin or $facebookLogin or $googleLogin"/>
    <xsl:variable name="jsSdkLink" select="backendless-codegen/application/jsSDKLink"/>

    <xsl:template match="/">
        <folder name="{$projectName}">
            <folder name="js">
                <file path="backendless-codegen/user-service/js/zepto.js"/>
                <file name="app.js">
$.holdReady(true);

const sdkUrl = ((window.location.protocol === 'file:')
  ? 'http:'
  : window.location.protocol) + '//<xsl:value-of select="$jsSdkLink"/>'

$.getScript(sdkUrl, () => {
  ;(async function () {
    $.holdReady(false);

    ;(function ($) {
      $.fn.wrongInput = function () {
        return this.each(function () {
          const $this = $(this)
          const $field = $this.is('input.txt') || $this.is('input[type=text]') ? $this : $this.find('input.txt')

          const rmWrng = function ($field) {
            $field.removeClass('wronginput');
          };

          if ($field.hasClass('wronginput')) {
            return
          }

          $field.addClass('wronginput');
          $field.one('input', function () {
            rmWrng($field);
          });
        });
      };
    })(Zepto);

    function createPopup(text, type) {
      const $popup = $("&lt;div class='popup'&gt;&lt;/div&gt;")
      const $body = $('body');

      if (type) {
        $popup.addClass(type);
      }
      $popup.text(text);
      if ($body.find('.popup').length) {
        $('.popup').remove();
      }
      $body.append($popup);
      $popup.animate({
        right  : '20px',
        opacity: 0.8
      }, 500);
      setTimeout(function () {
        $popup.animate({
          right  : '-' + $popup.width() + 'px',
          opacity: 0
        }, 500);
        setTimeout(function () {
          $popup.remove();
        }, 500);
      }, 3000);
    }

    function userLoggedInStatus(user) {
      console.log('user has logged in', user);
      $('.login').hide();
      $('.logined').show();
    }

    <xsl:call-template name="initApp"/>
    <xsl:if test="$facebookLogin">
        const FACEBOOK_APP_ID = <xsl:choose>
            <xsl:when test="$facebookAppId != ''">'<xsl:value-of select="$facebookAppId"/>'</xsl:when>
            <xsl:otherwise>null</xsl:otherwise>
        </xsl:choose>;
    </xsl:if>
    <xsl:if test="$googleLogin">
        const GOOGLE_CLIENT_ID = <xsl:choose>
            <xsl:when test="$googleClientId != ''">'<xsl:value-of select="$googleClientId"/>'</xsl:when>
            <xsl:otherwise>null</xsl:otherwise>
        </xsl:choose>;
    </xsl:if>

    let stayLoggedIn = Backendless.LocalCache.get(Backendless.LocalCache.Keys.STAY_LOGGED_IN)

    if (await Backendless.UserService.isValidLogin()) {
      $('.login').hide();
      $('.logined').show();
    } else {
      Backendless.setCurrentUserToken(null)
    }

    function gotError(err) { // see more on error handling
      $('input').addClass('redBorder');

      console.error(err);

      if (err.code) {
        createPopup(err.message || err, 'error');
        console.log('error message - ' + err.message);
        console.log('error code - ' + err.statusCode);
      }
    }

    function userLoggedOut() {
      location.reload();
    }

    $('#logout').on('click', function () {
      Backendless.UserService
        .logout()
        .then(userLoggedOut, gotError);
    });

                                <xsl:if test="$generateLoginAndRegistrationForm">
    function gotErrorRegister(err) { // see more on error handling
      $('input').each(function () {
        if (err.message.indexOf($(this).attr('id')) !== -1) {
          $(this).addClass('redBorder');
        }
      });

      createPopup(err.message, 'error');
      console.log('error message - ' + err.message);
      console.log('error code - ' + err.statusCode);
    }

    function gotErrorRestore(err) { // see more on error handling
      $('input').addClass('redBorder');
      createPopup(err.message, 'error');
      console.log('error message - ' + err.message);
      console.log('error code - ' + err.statusCode);
    }

    function userRegistered(user) {
      console.log('user has been registered');
      $('.thankTemp').show();
      $('.regForm').hide();
    }

    function success() {
      $('.restorePass').hide();
      $('.thankTemp').show();
    }

    $('#remember').prop('checked', stayLoggedIn);

    $('#remember').on('change', function () {
      stayLoggedIn = $('#remember').prop('checked');
    });

    $('#user_login').on('click', function () {
      const username = $('#login').val();
      const password = $('#password').val();

      $('input').on('keydown', function () {
        $('input').removeClass('redBorder');
      });

      if (!username) {
        createPopup('Identity cannot be empty!', 'error');
        $('#login').addClass('redBorder');

        return false;
      }

      if (!password) {
        createPopup('Password cannot be empty!', 'error');
        $('#password').addClass('redBorder');

        return false;
      }

      Backendless.UserService
        .login(username, password, stayLoggedIn)
        .then(userLoggedInStatus, gotError);
    });

    $('.double, .int').on('input', function (e) {
      const $el = $(this),
        value = $el.val().trim(),
        pattern = /^((-(([1-9]+\d*(\.\d+)?)|(0\.0*[1-9]+)))|((0|([1-9]+\d*))(\.\d+)?))([eE](\+|\-)?\d+)?$/;

      if (value.search(pattern) === -1) {
        $el.val("");
      }
    });

    $('.date').datepicker({
      beforeShow: function (input, inst) {
        setTimeout(function () {
          inst.dpDiv.css({ left: 50 + '%', top: 218, marginLeft: -30 });
        }, 0);
      }
    });

    $('#register').on('click', function () {
      const user = new Backendless.User();

      $('input').each(function () {
        const $el = $(this)
        const value = $el.val().trim();

        if (value) {
          user[$el.attr('id')] = value;
        }
      });

      Backendless.UserService
        .register(user)
        .then(userRegistered, gotErrorRegister);
    });

    $('#restore').on('click', function (e) {
      e.preventDefault();

      $('.restorePass input').removeClass('redBorder');
      $('.login').hide();
      $('.restorePass').show();
    });

    $('#restorePassword').on('click', function () {
      const login = $('#loginRestore').val();

      $('input').on('keydown', function () {
        $('input').removeClass('redBorder');
      });

      if (!login) {
        createPopup('Enter username!', 'error');
        $('input').addClass('redBorder');

        return false;
      }

      Backendless.UserService
        .restorePassword(login)
        .then(success, gotErrorRestore);
    });
                                </xsl:if>
                                <xsl:if test="$socialLogin">
    function callback(user) {
      $('.logined').show();
      $('.login').hide();

      console.log(user);
    }

    </xsl:if>
    <xsl:if test="$facebookLogin">
    $('#fb_login').on('click', function () {
      if (!FB) {
        return alert('Facebook SDK not found');
      }

      if (!FACEBOOK_APP_ID) {
        return alert(
          'Missing Facebook App Id. \n' +
          'Set your Facebook App Id in Social Settings of your app and then generate sample again'
        );
      }

      // description of options parameter: https://developers.facebook.com/docs/reference/javascript/FB.login/v2.9
      const fbLoginOptions = { scope: 'email' };

      FB.init({
        appId  : FACEBOOK_APP_ID,
        cookie : true,
        xfbml  : true,
        version: 'v2.8'
      });

      FB.getLoginStatus(function (response) {
        if (response.status === 'connected') {
          loginWithFacebookSDK(response);
        } else {
          FB.login(function (response) {
            loginWithFacebookSDK(response);
          }, fbLoginOptions);
        }
      });
    });

    function loginWithFacebookSDK(loginStatus) {
      const accessToken = loginStatus &amp;&amp; loginStatus.authResponse &amp;&amp; loginStatus.authResponse.accessToken;
      const fieldsMapping = { email: 'email' };

      Backendless.UserService
        .loginWithFacebookSdk(accessToken, fieldsMapping, stayLoggedIn)
        .then(callback, gotError);
    }
                                </xsl:if>
                                <xsl:if test="$twitterLogin">
    $('#tw_login').on('click', function () {
      const fieldsMapping = { email: 'email', displayName: 'name' };

      Backendless.UserService
        .loginWithTwitter(fieldsMapping, stayLoggedIn)
        .then(callback, gotError);
    });
                                </xsl:if>
                                <xsl:if test="$googleLogin">
    $('#gplus_login').on('click', function () {
      if (!gapi) {
        return alert('Google+ SDK not found');
      }

      if (!GOOGLE_CLIENT_ID) {
        return alert(
          'Missing Google client ID. \n' +
          'Set your Google client ID in Social Settings of your app and then generate sample again'
        );
      }

      gapi.auth.authorize({
        client_id: GOOGLE_CLIENT_ID,
        scope    : 'https://www.googleapis.com/auth/plus.login https://www.googleapis.com/auth/userinfo.email'
      }, function (response) {
        const accessToken = response &amp;&amp; response.access_token;
        const error = response &amp;&amp; response.error;
        const errorMessage = error &amp;&amp; response.details;

        if (errorMessage) {
          return createPopup(errorMessage, 'error');
        }

        loginWithGooglePlusSDK(accessToken);
      });
    });

    function loginWithGooglePlusSDK(accessToken) {
      const fieldsMapping = { email: 'email' };

      Backendless.UserService
        .loginWithGooglePlusSdk(accessToken, fieldsMapping, stayLoggedIn)
        .then(callback, gotError);
    }
                                </xsl:if>
  })()
});
</file>
                        </folder>
                        <folder name="assets">
                            <file path="backendless-codegen/user-service/assets/bg.png"/>
                            <file path="backendless-codegen/user-service/assets/bootstrap.css"/>
                            <file path="backendless-codegen/user-service/assets/bootstrap-responsive.css"/>
                            <file path="backendless-codegen/user-service/assets/ie.js"/>
                            <file path="backendless-codegen/user-service/assets/jquery.min.js"/>
                            <file path="backendless-codegen/user-service/assets/jquery-ui.min.js"/>
                            <file path="backendless-codegen/user-service/assets/jquery-ui.css" />
                            <xsl:if test="$facebookLogin">
                                <file path="backendless-codegen/user-service/assets/btn_facebook_bg.png"/>
                            </xsl:if>
                            <xsl:if test="$twitterLogin">
                                <file path="backendless-codegen/user-service/assets/btn_twitter_bg.png"/>
                            </xsl:if>
                            <xsl:if test="$googleLogin">
                                <file path="backendless-codegen/user-service/assets/btn_google_bg.png"/>
                            </xsl:if>
                        </folder>
                        <folder name="css">
                            <file name="app.css">body{
    background: rgb(50, 56, 63);
    font: 12px Arial, Helvetica, sans-serif;
}
.form{
	text-align:center;
	background:#fff;
	margin:150px 0 0 -200px;
	width:400px;
	position:relative;
	left:50%;
    -webkit-box-shadow: 0 0 12px #E7E7E7;
    -moz-box-shadow: 0 0 12px #E7E7E7;
    box-shadow: 0 0 12px #E7E7E7;
    -moz-border-radius: 10px;
    -webkit-border-radius: 10px;
    border-radius: 10px;
}

label{
	float: left;
	margin: 5px 0 0 30px;
    color:#666;
    font-size:12px;
}
label[for=login]{
	margin: 5px -13px 0 30px;
}
input{
    color: #666666!important;
    font-size: 12px!important;
    border: 1px solid #919191!important;
    -webkit-box-shadow: inset 1px 1px 3px rgba(128, 128, 128, 0.2);
    -moz-box-shadow: inset 1px 1px 3px rgba(128, 128, 128, 0.2);
    box-shadow: inset 1px 1px 3px rgba(128, 128, 128, 0.2);
    -moz-border-radius: 3px;
    -webkit-border-radius: 3px;
    border-radius: 3px;
}
.redBorder{
    border:1px solid red!important;
}
.btn-info, .btn-success{
    height: 34px;
    color: #fff;
    font-size:14px!important;
    padding: 0 20px;
    text-align: center;
    cursor: pointer;
    border:0px!important;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    border-radius: 5px;
    text-shadow: 0 1px 2px #333333;
}

.btn-success{
    background: #71b239;
    background-image: -webkit-linear-gradient(top, #7cbe3a, #5a9b39);
    background-image: -moz-linear-gradient(top, #7cbe3a, #5a9b39);
    background-image: -ms-linear-gradient(top, #7cbe3a, #5a9b39);
    background-image: -o-linear-gradient(top, #7cbe3a, #5a9b39);
    background-image: linear-gradient(top, #7cbe3a, #5a9b39);
    border-top: 1px solid #afafaf;
    border-right: 1px solid #919191;
    border-bottom: 1px solid #919191;
    border-left: 1px solid #afafaf;
    text-decoration:none;
}

.btn-success:hover{
    background: #71b239;
    background-image: -webkit-linear-gradient(top, #5a9b39, #71b239);
    background-image: -moz-linear-gradient(top, #5a9b39, #71b239);
    background-image: -ms-linear-gradient(top, #5a9b39, #71b239);
    background-image: -o-linear-gradient(top, #5a9b39, #71b239);
    background-image: linear-gradient(top, #5a9b39, #71b239);
    text-decoration:none;
}
h5{
    color:#666666;
    font-size:14px;
}

.info {
    font-size: 11px;
    width: inherit;
    color: rgb(155, 155, 155);
    margin:0px 0 10px 0;
}
.thankTemp .block{
	padding:15px;
}
#back{
    padding: 9px;
    position: relative;
    top: 2px;
    text-decoration:none;
}
.btn-info:hover{
    background: #3097B5;
    background-image: -webkit-linear-gradient(top, #3097B5, #53B8D6);
    background-image: -moz-linear-gradient(top, #3097B5, #53B8D6);
    background-image: -ms-linear-gradient(top, #3097B5, #53B8D6);
    background-image: -o-linear-gradient(top, #3097B5, #53B8D6);
    background-image: linear-gradient(top, #3097B5, #53B8D6);
}
.back{
    padding: 9px;
    margin: 9px 5px;
    font-size: 18px;
    position: relative;
    top: 0px;
    text-decoration: none!important;
}
.popup {
    max-width: 300px;
    padding: 10px 15px;
    color: rgb(220, 220, 220);
    opacity: 0;
    -moz-border-radius: 3px;
    -webkit-border-radius: 3px;
    border-radius: 3px;
    position: fixed;
    top: 30px;
    right: -120px;
}

.error {
    background-color: rgba(255, 27, 0, 0.5);
}

.success {
    background-color: rgba(50, 170, 0, 0.60);
}
.block #remember{
    float: left;
    margin: 5px 0 0 165px;
}
.block .remember{
    margin: 1px 0 0 5px;
}
                                <xsl:if test="$generateLoginAndRegistrationForm">
.register input{
    max-height:10px;
}
#restore{
	margin: 0 -9px 0 9px;
}
.btns{
	text-align: left;
	margin: 5px 0 0 90px;
}
.login .btns{
	margin: 5px 0 0 110px;
}
#registerLogin{
	margin: 5px 20px;
	padding: 8px;
	font-size: 16px;
	width: 100px;
	position: relative;
	top: 3px;
}
.register .btns{
	text-align:center;
	margin:5px;
}
.register #register{
	margin: 5px 5px;
	padding: 5px 10px;
	font-size: 16px;
	width: 80px;
	text-align:center;
}
.register label{
	width:125px;
	text-align:left;
	margin:5px 0 0 20px;
    color:#666;
    font-size:12px;
}
#user_login{
    margin: 5px 5px 4px -10px;
    padding: 5px;
    height: 32px;
    font-size: 16px;
    width: 80px;
}
.register input[type=text], .register input[type=password]{
    width:190px;
    color: #666666;
    padding: 8px 6px;
    font-size: 12px;
    border-top: 1px solid #919191;
    border-right: 1px solid #afafaf;
    border-bottom: 1px solid #afafaf;
    border-left: 1px solid #919191;
    -webkit-box-shadow: inset 1px 1px 3px rgba(128, 128, 128, 0.2);
    -moz-box-shadow: inset 1px 1px 3px rgba(128, 128, 128, 0.2);
    box-shadow: inset 1px 1px 3px rgba(128, 128, 128, 0.2);
    -moz-border-radius: 3px;
    -webkit-border-radius: 3px;
    border-radius: 3px;
}
.logined, .restorePass, .thankTemp{display:none;}
#restorePassword{
    margin: 10px 10px 10px 50px;
}

.logined.info{
    margin:20px 0;
}
                                </xsl:if>
                                <xsl:if test="$socialLogin">
.logined{display:none}
.login .soc_logins{
	padding-left:35px;
}
                                </xsl:if>
                                <xsl:if test="$twitterLogin">
#tw_login{
    background: url(../assets/btn_twitter_bg.png) no-repeat 0 0;
    width: 206px;
    border: 0px;
    color: #fff;
    margin:10px 0 20px 0;
    padding: 10px 10px 10px 40px;
}
                                </xsl:if>
                                <xsl:if test="$facebookLogin">
#fb_login{
    background: url(../assets/btn_facebook_bg.png) no-repeat 0 0;
    width: 206px;
    border: 0px;
    color: #fff;
    padding: 10px 10px 10px 40px;
    margin:10px 0 0 0;
}
                                </xsl:if>
                                <xsl:if test="$googleLogin">
#gplus_login{
    background: url(../assets/btn_google_bg.png) no-repeat 0 0;
    width: 206px;
    border: 0px;
    color: #fff;
    padding: 10px 10px 10px 40px;
    margin:10px 0 0 0;
}
                                </xsl:if>
                            </file>
                        </folder>
                        <file name="index.html">&lt;!doctype html&gt;
&lt;html lang="en"&gt;
&lt;head&gt;
    &lt;meta charset="utf-8"&gt;
    &lt;meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"&gt;
    &lt;title&gt;<xsl:value-of select="$projectName"/> Login&lt;/title&gt;
    &lt;link rel="stylesheet" href="assets/bootstrap.css"&gt;
    &lt;link rel="stylesheet" href="css/app.css"&gt;
    &lt;!--[if IE]&gt;
    &lt;script src="assets/ie.js"&gt;&lt;/script&gt;
    &lt;![endif]--&gt;
    &lt;script src="assets/jquery.min.js"&gt;&lt;/script&gt;
    &lt;script src="assets/jquery-ui.min.js"&gt;&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;div class="container"&gt;
    &lt;div class="form login span12"&gt;
        &lt;div class="appLogin"&gt;
            &lt;h5&gt;<xsl:value-of select="$applicationName"/> Login&lt;/h5&gt;
                            <xsl:if test="$generateLoginAndRegistrationForm">
            &lt;div class="block"&gt;
                &lt;label for="login"&gt;Login:&lt;/label&gt;&lt;input type="text" id="login" placeholder="login" /&gt;
            &lt;/div&gt;
            &lt;div class="block"&gt;
                &lt;label for="password"&gt;Password:&lt;/label&gt;&lt;input type="password" id="password" placeholder="password" /&gt;&lt;a href="#" id="restore"&gt;restore&lt;/a&gt;
            &lt;/div&gt;
            &lt;div class="btns"&gt;
                &lt;a href="register.html" id="registerLogin" class="btn-success"&gt;Register&lt;/a&gt;
                &lt;button id="user_login" class="btn-info"&gt;Login&lt;/button&gt;
            &lt;/div&gt;
            &lt;div class="block" style="height:20px"&gt;
                &lt;input type="checkbox" id="remember" /&gt;&lt;label class="remember" for="remember"&gt;Remember me&lt;/label&gt;
            &lt;/div&gt;
                            </xsl:if>
                            <xsl:if test="$socialLogin">
            &lt;div class="soc_logins"&gt;
                                <xsl:if test="$facebookLogin">
                &lt;button id="fb_login"&gt;Login With Facebook&lt;/button&gt;
                                </xsl:if>
                                <xsl:if test="$googleLogin">
                &lt;button id="gplus_login"&gt;Login With Google+&lt;/button&gt;
                                </xsl:if>
                                <xsl:if test="$twitterLogin">
                &lt;button id="tw_login"&gt;Login With Twitter&lt;/button&gt;
                                </xsl:if>
            &lt;/div&gt;
                            </xsl:if>
        &lt;/div&gt;
        &lt;div class="info"&gt;NOTE: You can change this page.&lt;/div&gt;
    &lt;/div&gt;
    &lt;div class="form logined span12"&gt;
        &lt;div class="appLogin"&gt;
            &lt;h5&gt;<xsl:value-of select="$applicationName"/> Login&lt;/h5&gt;
            &lt;div class="block" style="margin:5px 0"&gt;
                You are logged in now
            &lt;/div&gt;
            &lt;div class="block" style="margin:0px 0 5px 0"&gt;
                &lt;button id="logout" class="btn-info"&gt;Log Out&lt;/button&gt;
            &lt;/div&gt;
        &lt;/div&gt;
        &lt;div class="info"&gt;NOTE: You can change this page.&lt;/div&gt;
    &lt;/div&gt;
                            <xsl:if test="$generateLoginAndRegistrationForm">
    &lt;div class="form restorePass span12"&gt;
        &lt;div class="appLogin"&gt;
            &lt;h5&gt;<xsl:value-of select="$applicationName"/> Password Restoration&lt;/h5&gt;
            &lt;div class="block"&gt;
                &lt;label for="login"&gt;Login:&lt;/label&gt;&lt;input type="text" id="loginRestore" /&gt;
                &lt;button id="restorePassword" class="btn-info"&gt;Restore Password&lt;/button&gt;
                &lt;a href="index.html" id="back" class="btn-info"&gt;Back&lt;/a&gt;
            &lt;/div&gt;
        &lt;/div&gt;
        &lt;div class="info"&gt;NOTE: You can change this page.&lt;/div&gt;
    &lt;/div&gt;
                            </xsl:if>
                            <xsl:if test="$generateLoginAndRegistrationForm">
    &lt;div class="form thankTemp span12"&gt;
        &lt;div class="appLogin"&gt;
            &lt;h5&gt;<xsl:value-of select="$applicationName"/> Password Restoration&lt;/h5&gt;
            &lt;div class="block"&gt;
                We sent an email to your email adress with a link to password change page. Please check your email and follow link for further instructions.
            &lt;/div&gt;
            &lt;a href="index.html" class="btn-info back"&gt;Login&lt;/a&gt;
        &lt;/div&gt;
         &lt;div class="info" style="margin:15px 0"&gt;NOTE: You can change this page.&lt;/div&gt;
    &lt;/div&gt;
                            </xsl:if>
&lt;/div&gt;
<xsl:if test="$googleLogin">
    &lt;script src="//apis.google.com/js/platform.js">&lt;/script>
    &lt;script src="//apis.google.com/js/auth.js">&lt;/script>
</xsl:if>
<xsl:if test="$facebookLogin">
    &lt;script src="//connect.facebook.net/en_US/sdk.js">&lt;/script>
</xsl:if>
&lt;script src="js/zepto.js"&gt;&lt;/script&gt;
&lt;script src="js/app.js"&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;
                        </file>
                        <xsl:if test="$generateLoginAndRegistrationForm">
                            <file name="register.html">&lt;!doctype html&gt;
&lt;html lang="en"&gt;
&lt;head&gt;
	&lt;meta charset="utf-8"&gt;
	&lt;meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"&gt;
	&lt;title&gt;<xsl:value-of select="$projectName"/> Login&lt;/title&gt;
    &lt;link rel="stylesheet" href="assets/jquery-ui.css"&gt;
	&lt;link rel="stylesheet" href="assets/bootstrap.css"&gt;
	&lt;link rel="stylesheet" href="css/app.css"&gt;
	&lt;!--[if IE]&gt;
	&lt;script src="assets/ie.js"&gt;&lt;/script&gt;
	&lt;![endif]--&gt;
&lt;/head&gt;
&lt;body&gt;
	&lt;div class="container"&gt;
		&lt;div class="form regForm span12"&gt;
			&lt;div class="register"&gt;
					&lt;h5&gt;<xsl:value-of select="$applicationName"/> Registration&lt;/h5&gt;
                                <xsl:for-each select="backendless-codegen/application/user-properties/property">
                    &lt;div class="block"&gt;
                                    <xsl:choose>
                                        <xsl:when test="dataType = 'STRING'">
                                            <xsl:choose>
                                                <xsl:when test="name = 'email'">
                                                    &lt;label for="<xsl:value-of select="name"/>"&gt;<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>:&lt;/label&gt;&lt;input class="string" type="text" id="<xsl:value-of select="name"/>" /&gt;
                                                </xsl:when>
                                                <xsl:when test="name = 'password'">
                        &lt;label for="<xsl:value-of select="name"/>"&gt;<xsl:call-template name="firstCharToUpperCase"><xsl:with-param name="str" select="name"/></xsl:call-template>:&lt;/label&gt;&lt;input class="string" type="password" id="<xsl:value-of select="name"/>" /&gt;
                                                </xsl:when>
                                            </xsl:choose>
                                        </xsl:when>
                                    </xsl:choose>
					&lt;/div&gt;
                                </xsl:for-each>
					&lt;div class="btns"&gt;
                        &lt;a href="index.html" id="back" class="btn-info"&gt;Back&lt;/a&gt;
						&lt;button id="register" class="btn-success"&gt;Register&lt;/button&gt;
					&lt;/div&gt;
                &lt;div class="info"&gt;NOTE: You can change this page.&lt;/div&gt;
			&lt;/div&gt;
		&lt;/div&gt;
		&lt;div class="form thankTemp span12"&gt;
			&lt;div class="appLogin"&gt;
                                <xsl:choose>
                                    <xsl:when test="$emailConfirmationRequired = 'true'">
					&lt;h5&gt;<xsl:value-of select="$applicationName"/> Registration Confirmation&lt;/h5&gt;
                                    </xsl:when>
                                    <xsl:otherwise>
                    &lt;h5&gt;<xsl:value-of select="$applicationName"/> Thanks&lt;/h5&gt;
                                    </xsl:otherwise>
                                </xsl:choose>
					&lt;div class="block"&gt;
                                <xsl:choose>
                                    <xsl:when test="$emailConfirmationRequired = 'true'">
                        We sent an email to your email adress. The email contains link you must follow to complete registration. Once you visit this link you will be able to login to the application.
                                    </xsl:when>
                                    <xsl:otherwise>
						Thank you for registering with <xsl:value-of select="$applicationName"/>. Click the button below to proceed to the login.
                                    </xsl:otherwise>
                                </xsl:choose>
					&lt;/div&gt;
					&lt;a href="index.html" class="btn-info back"&gt;Login&lt;/a&gt;
			&lt;/div&gt;
            &lt;div class="info" style="margin:20px 0 10px 0"&gt;NOTE: You can change this page.&lt;/div&gt;
		&lt;/div&gt;
	&lt;/div&gt;
    &lt;script src="assets/jquery.min.js"&gt;&lt;/script&gt;
    &lt;script src="assets/jquery-ui.min.js"&gt;&lt;/script&gt;
    &lt;script type="text/javascript"&gt;
        var script=document.createElement('script'),
        url = ((window.location.protocol == 'file:') ? "http:" : window.location.protocol) + "//<xsl:value-of select="$jsSdkLink"/>";
        script.type='text/javascript';
        script.src=url;
        $("body").append(script);
    &lt;/script&gt;
    &lt;script src="js/zepto.js"&gt;&lt;/script&gt;
    &lt;script src="js/app.js"&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;
</file>
                        </xsl:if>

        </folder>
    </xsl:template>
</xsl:stylesheet>
