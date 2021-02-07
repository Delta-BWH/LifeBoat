<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- @formatter:off -->
    <xsl:import href="js-util.xsl"/>
    <xsl:include href="../util.xsl"/>

    <xsl:variable name="applicationName" select="backendless-codegen/application/name"/>
    <xsl:variable name="projectName"><xsl:value-of select="$applicationName"/>-File</xsl:variable>
    <xsl:variable name="applicationId" select="backendless-codegen/application/id"/>
    <xsl:variable name="apiKey" select="backendless-codegen/application/apiKeys/JS"/>
    <xsl:variable name="serverURL" select="backendless-codegen/application/serverURL"/>
    <xsl:variable name="jsSdkLink" select="backendless-codegen/application/jsSDKLink"/>

    <xsl:template match="/">
        <folder name="{$projectName}">
            <folder path="backendless-codegen/file-service/css"/>
            <folder name="js">
                <file path="backendless-codegen/file-service/js/jquery.js"/>

                <file name="{$projectName}.js">
$.holdReady(true);

$.getScript(((window.location.protocol == 'file:') ? "http:" : window.location.protocol) +
  "//<xsl:value-of select="$jsSdkLink"/>", function() {
  $.holdReady(false);
    <xsl:call-template name="initApp"/>
    var DEVICE_ID = "fileServiceTest";
    var TEST_FOLDER = "testFolder";
    var files;

    $().ready( function() {
      init();
    });

    function init() {
        $('.carousel').carousel({interval: false});

        $('.uploadd').click(function(){
            uploadFileFunc();
        });

        $('.delsel').click(function(){
            deleteSelectedFiles();
        });

        document.getElementById('files').addEventListener('change', handleFileSelect, false);
    }

    function protectXSS(val) {
        return val.replace(/(&lt;|&gt;|\/)/g, function (match) {
            return match == '&lt;' ? '&lt;' : match == '&gt;' ? '&gt;' : '/';
        });
    }

    function handleFileSelect(evt) {
    files = evt.target.files; // FileList object
    var output = [];
    for (var i = 0, f; f = files[i]; i++) {
        output.push('&lt;li&gt;&lt;strong&gt;', protectXSS(f.name), '&lt;/strong&gt; (', f.type || 'n/a', ') - ',
            f.size, ' bytes, last modified: ',
            f.lastModifiedDate ? f.lastModifiedDate.toLocaleDateString() : 'n/a',
        '&lt;/li&gt;');
        }
        document.getElementById('list').innerHTML = '&lt;ul&gt;' + output.join('') + '&lt;/ul&gt;';
    }

    function FileItem() {
        this.url = "";
        this.deviceId = DEVICE_ID;
    }

    function createNewItem(fileUrl) {
        var record = new FileItem();
        record.url = fileUrl;
        Backendless.Persistence.of(FileItem).save(record);
    }

    function deleteItem(id) {
        Backendless.Persistence.of(FileItem).remove(id);
    }

    function onClickFunc(element) {
        var el = $(element);

        if (el.hasClass("selectedThumbnail")) {
            $(element).removeClass("selectedThumbnail");
        } else {
            $(element).addClass("selectedThumbnail");
        }
    }

    function refreshItemsList() {
        var items = getItemsFromPersistance();
        $(".thumbnails").empty();

        $.each(items, function(index, value) {
        var name = getRelativeFileName(value.url);
        $(".thumbnails").append("&lt;li class='span4'&gt; &lt;div class='thumbnail' onclick='onClickFunc(this)'&gt; &lt;img class='dataPicture' id='" + value.objectId + "' src='"
        + value.url + "'  alt=''&gt;&lt;div align='center'&gt;&lt;a href='" + value.url +  "' &gt;" + decodeURIComponent(protectXSS(name)) + "&lt;/a&gt;&lt;/div&gt;&lt;/div&gt;&lt;/li&gt;");
        });
    }

    function getRelativeFileName(str) {
        var rest = str.substring(0, str.lastIndexOf(TEST_FOLDER + "/") + 1);
        return str.substring(str.lastIndexOf("/") + 1, str.length);
    }

    function getItemsFromPersistance() {
        var db = Backendless.Persistence.of(FileItem);
        var query = Backendless.DataQueryBuilder.create().setWhereClause("deviceId == " + DEVICE_ID);
        db.find(query)
            .then(result => {
            return result;
        })
        .catch(e => {
            if (e.code == 1009)
            alert("Please upload a file first");
        else
            alert(e.message);
        return [];
        });
    }

    function uploadFileFunc() {
        if (!files) {
            alert('No files chosen!');
            return;
        }

        var requests = [];

        for (var i = 0, file; file = files[i]; i++) {
            var request = Backendless.Files.upload(file, TEST_FOLDER, true).then(function (result) {
               return createNewItem(result.fileURL);
            });

            requests.push(request)
        }

        Promise
           .all(requests)
           .then(function () {
               showInfo('Files successfully uploaded.');
               files = [];
               $('#list').empty();
           },
           function (e) {
               showInfo(e.message);
           });
    }

    function deleteSelectedFiles() {
      try {
        var num = 0;
        $(".selectedThumbnail img").each( function(index, value) {
        Backendless.Files.remove( value.src);
        deleteItem(value.id);
        num++;
      });

      if(num == 0)
        alert("Select files to delete");
      else
        showInfo( "Objects successfully removed. Objects affected: " + num );
      }
      catch(e) {
        showInfo(e.message );
      }
    }

    function showInfo(text) {
        $('#message').text(text);
        var carousel = $('.carousel');
        carousel.carousel(2);
        carousel.carousel('pause');
    }
});</file>

            </folder>

            <file name="index.html">&lt;!DOCTYPE html&gt;
&lt;html lang="en"&gt;
&lt;head&gt;
    &lt;meta charset="utf-8"&gt;
    &lt;title&gt;File Service Sample&lt;/title&gt;
    &lt;meta name="viewport" content="width=device-width, initial-scale=1.0"&gt;
    &lt;meta name="description" content=""&gt;
    &lt;meta name="author" content=""&gt;

    &lt;!-- Le styles --&gt;
    &lt;link href="css/bootstrap.css" rel="stylesheet"&gt;
    &lt;link href="css/fileService.css" rel="stylesheet"&gt;
    &lt;script src="js/jquery.js"&gt;&lt;/script&gt;
    &lt;script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"&gt;&lt;/script&gt;
                            &lt;script type="text/javascript"&gt;
                            var script=document.createElement('script'),
                            url = ((window.location.protocol == 'file:') ? "http:" : window.location.protocol) + "//<xsl:value-of select="$jsSdkLink"/>";
                            script.setAttribute('src',url);
                            document.head.appendChild(script);
                            &lt;/script&gt;
&lt;script src="js/<xsl:value-of select="$projectName"/>.js"&gt;&lt;/script&gt;
&lt;/head&gt;

&lt;body&gt;
&lt;div class="navbar navbar-inverse navbar-static-top"&gt;
    &lt;div class="navbar-inner"&gt;
        &lt;div class="container"&gt;
            &lt;h4&gt;Upload file&lt;/h4&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/div&gt;
&lt;div id="myCarousel" class="carousel slide" interval="false"&gt;
&lt;div class="carousel-inner"&gt;
&lt;div class="item active" style="background-color: #FAFAFA"&gt;
&lt;div class="container"&gt;
&lt;div class="carousel-caption"&gt;
&lt;div class="container"&gt;
&lt;input type="file" id="files" name="files[]" multiple /&gt;
&lt;output id="list"&gt;&lt;/output&gt;
&lt;div&gt;&lt;input class="btn btn-large btn-primary uploadd" type="button" value="Upload File"/&gt;&lt;/div&gt;
&lt;/div&gt;
&lt;/div&gt;
&lt;/div&gt;
&lt;/div&gt;

&lt;div class="item" style="background-color: #EFEDEF;"&gt;
&lt;div class="container"&gt;
&lt;div class="carousel-caption"&gt;

&lt;div class="container"&gt;
&lt;div&gt;&lt;input class="btn btn-large btn-primary delsel" type="button" value="Delete Files"/&gt;&lt;/div&gt;
&lt;div&gt;
&lt;ul class="thumbnails"&gt;
&lt;/ul&gt;
&lt;/div&gt;
&lt;/div&gt;
&lt;/div&gt;
&lt;/div&gt;
&lt;/div&gt;

&lt;div class="item" style="background-color: #EEEDF7;"&gt;
&lt;div class="container"&gt;
&lt;div class="carousel-caption"&gt;
&lt;div class="container"&gt;
&lt;h2 class="lead" id="message"&gt;Test Message&lt;/h2&gt;
                            &lt;a onclick="location.reload()" style="padding:10px;background:#5a5a5a;font-size:16px;border-radius:5px;color:#fff;position: relative;
top: 30px;"&gt;Back&lt;/a&gt;
&lt;/div&gt;
&lt;/div&gt;
&lt;/div&gt;

&lt;/div&gt;

&lt;/div&gt;
&lt;/div&gt;
&lt;/div&gt;&lt;!-- /.carousel --&gt;
&lt;/body&gt;
&lt;/html&gt;
</file>

        </folder>
    </xsl:template>
</xsl:stylesheet>