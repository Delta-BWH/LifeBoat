<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->
    <xsl:import href="js-util.xsl"/>
    <xsl:include href="../util.xsl"/>

    <xsl:variable name="applicationName" select="backendless-codegen/application/name"/>
    <xsl:variable name="projectName"><xsl:value-of select="$applicationName"/>-Messaging</xsl:variable>
    <xsl:variable name="applicationId" select="backendless-codegen/application/id"/>
    <xsl:variable name="apiKey" select="backendless-codegen/application/apiKeys/JS"/>
    <xsl:variable name="serverURL" select="backendless-codegen/application/serverURL"/>
    <xsl:variable name="jsSdkLink" select="backendless-codegen/application/jsSDKLink"/>

    <xsl:template match="/">
        <folder name="{$applicationName}-Messaging">
            <folder path="backendless-codegen/messaging-service/css"/>
            <folder name="js">
                <file name="main.js">
(function startApp() {

<xsl:call-template name="initApp"/>

  var MESSAGES_CHANNEL = 'default';
  var LOCAL_STORAGE_USERNAME_KEY = 'BackendlessChatSample.username';
  var LOCAL_STORAGE_MESSAGES_KEY = 'BackendlessChatSample.messages';
  var HIDDEN_CLASS_NAME = 'd-none';

  var $currentUsername = document.getElementById('current-username');
  var $loginBtn = document.getElementById('login-btn');
  var $logoutBtn = document.getElementById('logout-btn');
  var $usernameInput = document.getElementById('username-input');
  var $rememberMeToggler = document.getElementById('remember-me-toggler');
  var $loginPanel = document.getElementById('login-panel');
  var $chatPanel = document.getElementById('chat-panel');
  var $chatMessages = document.getElementById('chat-messages');
  var $messageInput = document.getElementById('message-input');
  var $sendBtn = document.getElementById('send-btn');
  var $alertsContainer = document.getElementById('alerts-container');

  var channel = Backendless.Messaging.subscribe(MESSAGES_CHANNEL);

  var currentUsername = localStorage.getItem(LOCAL_STORAGE_USERNAME_KEY);
  var messages = getOldMessages();

  $loginBtn.addEventListener('click', login);
  $usernameInput.addEventListener('keypress', onEnter(login));

  $logoutBtn.addEventListener('click', logout);

  $sendBtn.addEventListener('click', sendMessage);
  $messageInput.addEventListener('keypress', onEnter(sendMessage));

  renderApp();

  function login() {
    var username = $usernameInput.value.trim();

    if (username) {
      currentUsername = username;

      if ($rememberMeToggler.checked) {
        localStorage.setItem(LOCAL_STORAGE_USERNAME_KEY, username);
      }

      renderApp();
    }
  }

  function logout() {
    currentUsername = null;
    localStorage.removeItem(LOCAL_STORAGE_USERNAME_KEY);

    renderApp();
  }

  function renderApp() {
    $currentUsername.parentNode.classList.toggle(HIDDEN_CLASS_NAME, !currentUsername);
    $currentUsername.innerText = currentUsername || '';

    $logoutBtn.classList.toggle(HIDDEN_CLASS_NAME, !currentUsername);

    $chatPanel.classList.toggle(HIDDEN_CLASS_NAME, !currentUsername);
    $loginPanel.classList.toggle(HIDDEN_CLASS_NAME, !!currentUsername);

    if (currentUsername) {
      channel.addMessageListener(onMessage);

      renderMessages();

    } else {
      channel.removeMessageListener(onMessage);
    }
  }

  function getOldMessages() {
    const messagesStr = localStorage.getItem(LOCAL_STORAGE_MESSAGES_KEY);

    if (messagesStr) {
      try {
        var messages = JSON.parse(messagesStr);

        if (Array.isArray(messages)) {
          return messages;
        }

      } catch (e) {
        console.log('can not parse messages from LocalStorage');
      }
    }

    return []
  }

  function keepMessages() {
    localStorage.setItem(LOCAL_STORAGE_MESSAGES_KEY, JSON.stringify(messages));
  }

  function sendMessage() {
    var message = $messageInput.value.trim();

    if (message) {
      channel
        .publish('&lt;font color=#cc0029&gt;[' + currentUsername + ']&lt;/font&gt;: ' + message)
        .catch(addErrorAlert);

      $messageInput.value = '';
    }
  }

  function onMessage(message) {
    messages.push(message.message);

    keepMessages();
    renderMessages();
  }

  function renderMessages() {
    var messagesText = '';

    messages.forEach(function (message) {
      messagesText = messagesText + '&lt;div class="chat-message"&gt;' + message + '&lt;/div&gt;'
    });

    $chatMessages.innerHTML = messagesText;
    $chatMessages.scrollTop = $chatMessages.scrollHeight;
  }

  function onEnter(callback) {
    return function onKeyPress(e) {
      if (e.keyCode === 13) {//Enter key
        callback()
      }
    }
  }
  
  function addErrorAlert(message) {
    message = message.message || message;

    console.log('addErrorAlert', message);

    var $item = document.createElement('div');
    $item.innerHTML = '&lt;div class="error-item"&gt;' + message + '&lt;/div&gt;';

    $alertsContainer.appendChild($item);

    setTimeout(function () {
      $alertsContainer.removeChild($item);
    }, 3000)
  }
})();
                </file>
            </folder>

            <file path="backendless-codegen/messaging-service/index.html"/>
        </folder>
    </xsl:template>
</xsl:stylesheet>
