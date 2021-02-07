<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->

    <xsl:template match="/">
        <folder name="{backendless-codegen/application/name}">
            <file name="{backendless-codegen/application/name}.iml">&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;module type="WEB_MODULE" version="4"&gt;
    &lt;component name="NewModuleRootManager" inherit-compiler-output="false"&gt;
        &lt;content url="file://$MODULE_DIR$" /&gt;
        &lt;orderEntry type="sourceFolder" forTests="false" /&gt;
    &lt;/component&gt;
&lt;/module&gt;
            </file>
            <folder name="src">
                <folder path="project-files/js"/>
                <folder path="project-files/css"/>
                <file path="project-files/index.html"/>
                <file name="js/app.js">
(function () {
  const APP_ID = '<xsl:value-of select="backendless-codegen/application/id"/>';
  const API_KEY = '<xsl:value-of select="backendless-codegen/application/apiKeys/JS"/>';

  Backendless.serverURL = '<xsl:value-of select="backendless-codegen/application/serverURL"/>';
  Backendless.initApp(APP_ID, API_KEY);

  const testTableStore = Backendless.Data.of('TestTable');

  const $createObjStatusMsg = document.getElementById('create-obj-status');
  const $modifierPanel = document.getElementById('modifier-panel');
  const $currentValue = document.getElementById('current-value');
  const $input = document.getElementById('input');
  const $updateBtn = document.getElementById('update-btn');

  function createObject() {
    return testTableStore.save({ foo: 'Hello World' })
      .then(function (object) {
        $createObjStatusMsg.classList.add('text-success');
        $createObjStatusMsg.innerText = 'Object has been saved in real-time database';

        return object;
      })
      .catch(function (error) {
        $createObjStatusMsg.classList.add('text-danger');
        $createObjStatusMsg.innerText = error.message;

        throw error;
      });
  }

  function updateObjectValue(object) {
    $currentValue.innerText = object.foo
  }

  function subscribeOnObjectChanges(object) {
    testTableStore.rt().addUpdateListener("objectId = '" + object.objectId + "'", updateObjectValue);
  }

  function onEnter(callback) {
    return function onKeyPress(e) {
      if (e.keyCode === 13) {//Enter key
        callback()
      }
    }
  }

  function onObjectCreate(object) {
    $modifierPanel.classList.remove('d-none');

    $updateBtn.addEventListener('click', saveObject);
    $input.addEventListener('keypress', onEnter(saveObject));

    updateObjectValue(object);
    subscribeOnObjectChanges(object);

    function saveObject() {
      object.foo = $input.value;

      $input.value = '';

      testTableStore.save(object);
    }
  }

  createObject().then(onObjectCreate)
})();
                </file>
            </folder>
        </folder>
    </xsl:template>
</xsl:stylesheet>