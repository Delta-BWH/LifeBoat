<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
    <!-- @formatter:off -->
    
    <xsl:param name="language"/>
    <xsl:param name="backendlessLogin"/>
    <xsl:param name="facebookLogin"/>
    <xsl:param name="twitterLogin"/>
    <xsl:param name="googleLogin"/>
    
    <!-- @formatter:off -->

    <xsl:variable name="applicationName" select="backendless-codegen/application/name"/>
    <xsl:variable name="applicationId" select="backendless-codegen/application/id"/>
    <xsl:variable name="apiKey" select="backendless-codegen/application/apiKeys/IOS"/>
    <xsl:variable name="serverURL" select="backendless-codegen/application/serverURL"/>

    <xsl:template name="loginSwift">
      <folder  hideContent="true" name="{$applicationName}-Login">
        
        <file name="Podfile">
target '<xsl:value-of select="$applicationName"/>-Login' do

use_frameworks!

pod 'BackendlessSwift'
<xsl:if test="$facebookLogin = 'true'">
pod 'FBSDKLoginKit'
</xsl:if>
<xsl:if test="$googleLogin = 'true'">
pod 'GoogleSignIn'
</xsl:if>
<xsl:if test="$twitterLogin = 'true'">
pod 'TwitterKit'
</xsl:if>

end
        </file>
        
        <file name="README.txt">1. Open a Terminal window, and change the current directory to be the project's directory.
2. Run $pod install.
3. Run $pod update.
Once all of the pod data is downloaded / updated, Xcode project workspace file will be created. This should be the file you use everyday to create your app.
4.Open .xcworkspace file to launch your project, and build it.

          <xsl:if test="$facebookLogin = 'true'">
FACEBOOK LOGIN
Assuming you are already have the Facebook application:
1. Follow the steps 1 and 4 from https://developers.facebook.com/docs/ios/getting-started (only Configure Facebook App Settings for iOS and Configure Xcode Project, everything else is already done).
          </xsl:if>
          <xsl:if test="$googleLogin = 'true'">
GOOGLE LOGIN             
Assuming you are already have the Google application:
1. Follow the step of adding a URL scheme: https://developers.google.com/identity/sign-in/ios/start-integrating (everything else is already done).
2. Setup your Client ID for the clientID property in the AppDelegate.m file.
3. Make sure your Bundle Identifier corresponds to Bundle ID in your Google application.
          </xsl:if>
          <xsl:if test="$twitterLogin = 'true'">
TWITTER LOGIN
Assuming you are already have the Twitter application:
1. In the Twitter application's Settings tab, set the Website and Callback URL to https://api.backendless.com.
2. From the Keys and Access Tokens tab, copy the Consumer Key and the Consumer Secret values.
3. Click the Permissions tab and select the Request email addresses from users checkbox. Click Update Settings.
4. Log in to your account in the Backendless Console, select your app and click Manage.
5. Scroll down to the Social Settings section and insert the values copied on step 4 into the Twitter Consumer key and Twitter Consumer secret fields.
6. Follow the steps: "Initialize Twitter Kit" and "Configure Info.Plist" from https://dev.twitter.com/twitterkit/ios/installation.
          </xsl:if>
        </file>
        
        <folder  hideContent="true" name="{$applicationName}-Login">
          <folder  hideContent="true" path="backendless-codegen/Swift/Login/Login/Assets.xcassets"/>
          
          <folder  hideContent="true" name="Base.lproj">
            <file  hideContent="true" path="backendless-codegen/Swift/Login/Login/Base.lproj/LaunchScreen.storyboard"/>
            
            
            <file  hideContent="true" name="Main.storyboard">&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;document type="com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB" version="3.0" toolsVersion="12120" systemVersion="16F73" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" colorMatched="YES" initialViewController="M7p-zs-ada"&gt;
    &lt;device id="retina4_7" orientation="portrait"&gt;
        &lt;adaptation id="fullscreen"/&gt;
    &lt;/device&gt;
    &lt;dependencies&gt;
        &lt;deployment identifier="iOS"/&gt;
        &lt;plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="12088"/&gt;
        &lt;capability name="Constraints to layout margins" minToolsVersion="6.0"/&gt;
        &lt;capability name="documents saved in the Xcode 8 format" minToolsVersion="8.0"/&gt;
    &lt;/dependencies&gt;
    &lt;scenes&gt;
    
      <!--Navigation Controller-->
      &lt;scene sceneID="Pah-fE-Oew"&gt;
            &lt;objects&gt;
                &lt;navigationController id="M7p-zs-ada" sceneMemberID="viewController"&gt;
                    &lt;navigationBar key="navigationBar" contentMode="scaleToFill" misplaced="YES" id="XcK-lR-W5q"&gt;
                        &lt;rect key="frame" x="0.0" y="0.0" width="375" height="44"/&gt;
                        &lt;autoresizingMask key="autoresizingMask"/&gt;
                    &lt;/navigationBar&gt;
                    &lt;connections&gt;
                        &lt;segue destination="KZO-xW-DJZ" kind="relationship" relationship="rootViewController" id="mgV-P5-ynr"/&gt;
                    &lt;/connections&gt;
                &lt;/navigationController&gt;
                &lt;placeholder placeholderIdentifier="IBFirstResponder" id="zPo-IT-R2c" userLabel="First Responder" sceneMemberID="firstResponder"/&gt;
            &lt;/objects&gt;
            &lt;point key="canvasLocation" x="-153" y="167"/&gt;
        &lt;/scene&gt;
        
        <!--Registration and Login-->
        &lt;scene sceneID="eLp-Oq-YNR"&gt;
            &lt;objects&gt;
                &lt;tableViewController id="KZO-xW-DJZ" customClass="MainTableViewController" customModule="LoginSwift" customModuleProvider="target" sceneMemberID="viewController"&gt;
                    &lt;tableView key="view" clipsSubviews="YES" contentMode="scaleToFill" alwaysBounceVertical="YES" dataMode="prototypes" style="plain" separatorStyle="default" rowHeight="44" sectionHeaderHeight="28" sectionFooterHeight="28" id="R2l-de-Hew"&gt;
                        &lt;rect key="frame" x="0.0" y="0.0" width="375" height="667"/&gt;
                        &lt;autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/&gt;
                        &lt;color key="backgroundColor" white="1" alpha="1" colorSpace="calibratedWhite"/&gt;
                        &lt;prototypes&gt;
                            &lt;tableViewCell clipsSubviews="YES" contentMode="scaleToFill" selectionStyle="blue" hidesAccessoryWhenEditing="NO" indentationLevel="1" indentationWidth="0.0" reuseIdentifier="Cell" textLabel="kgG-eM-y5G" style="IBUITableViewCellStyleDefault" id="llp-Tx-Lb4"&gt;
                                &lt;rect key="frame" x="0.0" y="28" width="375" height="44"/&gt;
                                &lt;autoresizingMask key="autoresizingMask"/&gt;
                                &lt;tableViewCellContentView key="contentView" opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="center" tableViewCell="llp-Tx-Lb4" id="Gzn-Lb-qNy"&gt;
                                    &lt;rect key="frame" x="0.0" y="0.0" width="375" height="43.5"/&gt;
                                    &lt;autoresizingMask key="autoresizingMask"/&gt;
                                    &lt;subviews&gt;
                                        &lt;label opaque="NO" multipleTouchEnabled="YES" contentMode="left" text="Title" textAlignment="natural" lineBreakMode="tailTruncation" baselineAdjustment="alignBaselines" adjustsFontSizeToFit="NO" id="kgG-eM-y5G"&gt;
                                            &lt;rect key="frame" x="15" y="0.0" width="345" height="43.5"/&gt;
                                            &lt;autoresizingMask key="autoresizingMask"/&gt;
                                            &lt;fontDescription key="fontDescription" type="system" pointSize="17"/&gt;
                                            &lt;nil key="textColor"/&gt;
                                            &lt;nil key="highlightedColor"/&gt;
                                        &lt;/label&gt;
                                    &lt;/subviews&gt;
                                &lt;/tableViewCellContentView&gt;
                            &lt;/tableViewCell&gt;
                        &lt;/prototypes&gt;
                        &lt;connections&gt;
                            &lt;outlet property="dataSource" destination="KZO-xW-DJZ" id="GQK-Nc-ecX"/&gt;
                            &lt;outlet property="delegate" destination="KZO-xW-DJZ" id="CYI-E8-7eO"/&gt;
                        &lt;/connections&gt;
                    &lt;/tableView&gt;
                    &lt;navigationItem key="navigationItem" title="Registration and Login" id="gce-Rv-LnE"&gt;
                        &lt;barButtonItem key="backBarButtonItem" title=" " id="6Az-OJ-JYW"/&gt;
                    &lt;/navigationItem&gt;
                    &lt;connections&gt;
                        <xsl:if test="$facebookLogin = 'true'">
                        &lt;segue destination="Cv9-hR-K5u" kind="show" identifier="FacebookLoginSegue" id="tYH-Zi-tHa"/&gt;
                        </xsl:if>
                        <xsl:if test="$googleLogin = 'true'">
                        &lt;segue destination="al5-g7-unC" kind="show" identifier="GoogleLoginSegue" id="XUa-G6-8Zl"/&gt;
                        </xsl:if>
                        <xsl:if test="$twitterLogin = 'true'">
                        &lt;segue destination="36n-DL-D8C" kind="show" identifier="TwitterLoginSegue" id="0OO-43-Ac3"/&gt;
                        </xsl:if>
                        <xsl:if test="$backendlessLogin = 'true'">
                        &lt;segue destination="tRb-tc-q3t" kind="show" identifier="BackendlessLoginSegue" id="1Uh-24-WCR"/&gt;
                        </xsl:if>
                    &lt;/connections&gt;
                &lt;/tableViewController&gt;
                &lt;placeholder placeholderIdentifier="IBFirstResponder" id="XeJ-xl-VXy" userLabel="First Responder" sceneMemberID="firstResponder"/&gt;
            &lt;/objects&gt;
            &lt;point key="canvasLocation" x="580" y="167"/&gt;
        &lt;/scene&gt;
        
        
        <xsl:if test="$backendlessLogin = 'true'">
        <!--Backendless Registration and Login-->
        &lt;scene sceneID="nMH-tn-6ur"&gt;
            &lt;objects&gt;
                &lt;viewController storyboardIdentifier="BackendlessLoginViewController" id="tRb-tc-q3t" customClass="BackendlessViewController" customModule="LoginSwift" customModuleProvider="target" sceneMemberID="viewController"&gt;
                    &lt;layoutGuides&gt;
                        &lt;viewControllerLayoutGuide type="top" id="ffe-G9-xWr"/&gt;
                        &lt;viewControllerLayoutGuide type="bottom" id="vov-a9-BHU"/&gt;
                    &lt;/layoutGuides&gt;
                    &lt;view key="view" contentMode="scaleToFill" id="rch-TD-7uJ"&gt;
                        &lt;rect key="frame" x="0.0" y="64" width="375" height="603"/&gt;
                        &lt;autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/&gt;
                        &lt;subviews&gt;
                            &lt;textField opaque="NO" clipsSubviews="YES" contentMode="scaleToFill" contentHorizontalAlignment="left" contentVerticalAlignment="center" borderStyle="roundedRect" placeholder="Password" textAlignment="natural" minimumFontSize="17" translatesAutoresizingMaskIntoConstraints="NO" id="Z4j-i8-EVI"&gt;
                                &lt;rect key="frame" x="26" y="286.5" width="323" height="30"/&gt;
                                &lt;nil key="textColor"/&gt;
                                &lt;fontDescription key="fontDescription" type="system" pointSize="14"/&gt;
                                &lt;textInputTraits key="textInputTraits" secureTextEntry="YES"/&gt;
                            &lt;/textField&gt;
                            &lt;textField opaque="NO" clipsSubviews="YES" contentMode="scaleToFill" contentHorizontalAlignment="left" contentVerticalAlignment="center" borderStyle="roundedRect" placeholder="Login" textAlignment="natural" minimumFontSize="17" translatesAutoresizingMaskIntoConstraints="NO" id="oHe-Gj-wFC"&gt;
                                &lt;rect key="frame" x="26" y="248.5" width="323" height="30"/&gt;
                                &lt;nil key="textColor"/&gt;
                                &lt;fontDescription key="fontDescription" type="system" pointSize="14"/&gt;
                                &lt;textInputTraits key="textInputTraits"/&gt;
                            &lt;/textField&gt;
                            &lt;switch opaque="NO" contentMode="scaleToFill" horizontalHuggingPriority="750" verticalHuggingPriority="750" contentHorizontalAlignment="center" contentVerticalAlignment="center" on="YES" translatesAutoresizingMaskIntoConstraints="NO" id="PS1-cF-Sa5"&gt;
                                &lt;rect key="frame" x="300" y="324.5" width="51" height="31"/&gt;
                            &lt;/switch&gt;
                            &lt;label opaque="NO" userInteractionEnabled="NO" contentMode="left" horizontalHuggingPriority="251" verticalHuggingPriority="251" text="Remember me" textAlignment="natural" lineBreakMode="tailTruncation" baselineAdjustment="alignBaselines" adjustsFontSizeToFit="NO" translatesAutoresizingMaskIntoConstraints="NO" id="I4W-gv-C8u"&gt;
                                &lt;rect key="frame" x="192" y="328.5" width="100" height="18"/&gt;
                                &lt;fontDescription key="fontDescription" type="system" pointSize="15"/&gt;
                                &lt;nil key="textColor"/&gt;
                                &lt;nil key="highlightedColor"/&gt;
                            &lt;/label&gt;
                            &lt;button opaque="NO" contentMode="scaleToFill" contentHorizontalAlignment="center" contentVerticalAlignment="center" buttonType="roundedRect" lineBreakMode="middleTruncation" translatesAutoresizingMaskIntoConstraints="NO" id="p1h-Gj-0z6"&gt;
                                &lt;rect key="frame" x="126" y="565" width="123" height="30"/&gt;
                                &lt;state key="normal" title="Restore password"/&gt;
                                &lt;connections&gt;
                                    &lt;action selector="pressedRestorePassword:" destination="tRb-tc-q3t" eventType="touchUpInside" id="tYO-Sg-Xga"/&gt;
                                &lt;/connections&gt;
                            &lt;/button&gt;
                            &lt;button opaque="NO" contentMode="scaleToFill" contentHorizontalAlignment="center" contentVerticalAlignment="center" buttonType="roundedRect" lineBreakMode="middleTruncation" translatesAutoresizingMaskIntoConstraints="NO" id="BKx-wl-p7Y"&gt;
                                &lt;rect key="frame" x="168.5" y="361.5" width="38" height="30"/&gt;
                                &lt;state key="normal" title="Login"/&gt;
                                &lt;connections&gt;
                                    &lt;action selector="pressedLogin:" destination="tRb-tc-q3t" eventType="touchUpInside" id="ixm-mT-aLH"/&gt;
                                &lt;/connections&gt;
                            &lt;/button&gt;
                            &lt;button opaque="NO" contentMode="scaleToFill" contentHorizontalAlignment="center" contentVerticalAlignment="center" buttonType="roundedRect" lineBreakMode="middleTruncation" translatesAutoresizingMaskIntoConstraints="NO" id="aV5-iU-HMz"&gt;
                                &lt;rect key="frame" x="159" y="520" width="57" height="30"/&gt;
                                &lt;state key="normal" title="Register"/&gt;
                                &lt;connections&gt;
                                    &lt;action selector="pressedRegister:" destination="tRb-tc-q3t" eventType="touchUpInside" id="kWD-hy-Tt1"/&gt;
                                &lt;/connections&gt;
                            &lt;/button&gt;
                        &lt;/subviews&gt;
                        &lt;color key="backgroundColor" white="1" alpha="1" colorSpace="calibratedWhite"/&gt;
                        &lt;constraints&gt;
                            &lt;constraint firstItem="oHe-Gj-wFC" firstAttribute="leading" secondItem="rch-TD-7uJ" secondAttribute="leadingMargin" constant="10" id="2mi-gg-RpI"/&gt;
                            &lt;constraint firstItem="Z4j-i8-EVI" firstAttribute="centerY" secondItem="rch-TD-7uJ" secondAttribute="centerY" id="8bz-1W-DQs"/&gt;
                            &lt;constraint firstItem="p1h-Gj-0z6" firstAttribute="centerX" secondItem="rch-TD-7uJ" secondAttribute="centerX" id="9zu-0S-elf"/&gt;
                            &lt;constraint firstItem="Z4j-i8-EVI" firstAttribute="top" secondItem="oHe-Gj-wFC" secondAttribute="bottom" constant="8" id="IHy-vx-yeF"/&gt;
                            &lt;constraint firstAttribute="trailingMargin" secondItem="Z4j-i8-EVI" secondAttribute="trailing" constant="10" id="Ine-Ri-Elv"/&gt;
                            &lt;constraint firstItem="BKx-wl-p7Y" firstAttribute="centerX" secondItem="rch-TD-7uJ" secondAttribute="centerX" id="RZc-Z9-e8u"/&gt;
                            &lt;constraint firstItem="PS1-cF-Sa5" firstAttribute="leading" secondItem="I4W-gv-C8u" secondAttribute="trailing" constant="8" id="SFJ-8d-VTy"/&gt;
                            &lt;constraint firstItem="BKx-wl-p7Y" firstAttribute="top" secondItem="I4W-gv-C8u" secondAttribute="bottom" constant="15" id="ThT-uD-YGN"/&gt;
                            &lt;constraint firstItem="Z4j-i8-EVI" firstAttribute="leading" secondItem="rch-TD-7uJ" secondAttribute="leadingMargin" constant="10" id="VSM-tD-cr0"/&gt;
                            &lt;constraint firstAttribute="trailingMargin" secondItem="oHe-Gj-wFC" secondAttribute="trailing" constant="10" id="ZOc-RT-J5T"/&gt;
                            &lt;constraint firstItem="p1h-Gj-0z6" firstAttribute="top" secondItem="aV5-iU-HMz" secondAttribute="bottom" constant="15" id="dhF-uX-DE3"/&gt;
                            &lt;constraint firstItem="vov-a9-BHU" firstAttribute="top" secondItem="p1h-Gj-0z6" secondAttribute="bottom" constant="8" id="eGI-WR-v9X"/&gt;
                            &lt;constraint firstItem="I4W-gv-C8u" firstAttribute="top" secondItem="Z4j-i8-EVI" secondAttribute="bottom" constant="12" id="i2H-ey-BLh"/&gt;
                            &lt;constraint firstItem="aV5-iU-HMz" firstAttribute="centerX" secondItem="rch-TD-7uJ" secondAttribute="centerX" id="mWN-xC-inX"/&gt;
                            &lt;constraint firstAttribute="trailingMargin" secondItem="PS1-cF-Sa5" secondAttribute="trailing" constant="10" id="pa3-1E-c9p"/&gt;
                            &lt;constraint firstItem="PS1-cF-Sa5" firstAttribute="top" secondItem="Z4j-i8-EVI" secondAttribute="bottom" constant="8" id="yXp-ky-NBN"/&gt;
                        &lt;/constraints&gt;
                    &lt;/view&gt;
                    &lt;navigationItem key="navigationItem" title="Backendless Registration and Login" id="7x8-5l-MyD"&gt;
                        &lt;barButtonItem key="backBarButtonItem" title=" " id="eX1-QW-Kal"/&gt;
                    &lt;/navigationItem&gt;
                    &lt;simulatedNavigationBarMetrics key="simulatedTopBarMetrics" translucent="NO" prompted="NO"/&gt;
                    &lt;connections&gt;
                        &lt;outlet property="loginField" destination="oHe-Gj-wFC" id="rYz-EL-l0x"/&gt;
                        &lt;outlet property="passwordField" destination="Z4j-i8-EVI" id="Cm6-Bl-8v2"/&gt;
                        &lt;outlet property="stayLoggedInSwitch" destination="PS1-cF-Sa5" id="c2B-SD-vEU"/&gt;
                        &lt;segue destination="bY5-9W-L7P" kind="show" identifier="BackendlessLoginSegue" id="2Fc-fH-bdu"/&gt;
                        &lt;segue destination="ScS-6G-dbd" kind="show" identifier="BackendlessRegistrationSegue" id="0eS-nL-7bt"/&gt;
                        &lt;segue destination="j4a-ms-vfz" kind="show" identifier="RestorePasswordSegue" id="ReL-3f-mTh"/&gt;
                    &lt;/connections&gt;
                &lt;/viewController&gt;
                &lt;placeholder placeholderIdentifier="IBFirstResponder" id="zFA-Kf-uEu" userLabel="First Responder" sceneMemberID="firstResponder"/&gt;
            &lt;/objects&gt;
            &lt;point key="canvasLocation" x="2055" y="-16"/&gt;
        &lt;/scene&gt;
        
        <!--Backendless User View Controller-->
        &lt;scene sceneID="gXf-qA-NvE"&gt;
            &lt;objects&gt;
                &lt;viewController storyboardIdentifier="BackendlessUserViewController" title="Backendless User" id="bY5-9W-L7P" customClass="BackendlessUserViewController" customModule="LoginSwift" customModuleProvider="target" sceneMemberID="viewController"&gt;
                    &lt;layoutGuides&gt;
                        &lt;viewControllerLayoutGuide type="top" id="sC6-yp-jBy"/&gt;
                        &lt;viewControllerLayoutGuide type="bottom" id="uug-Lv-llN"/&gt;
                    &lt;/layoutGuides&gt;
                    &lt;view key="view" contentMode="scaleToFill" id="4vf-Xp-zhk"&gt;
                        &lt;rect key="frame" x="0.0" y="64" width="375" height="603"/&gt;
                        &lt;autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/&gt;
                        &lt;subviews&gt;
                            &lt;label opaque="NO" userInteractionEnabled="NO" contentMode="left" horizontalHuggingPriority="251" verticalHuggingPriority="251" text="You are now logged in." textAlignment="natural" lineBreakMode="tailTruncation" baselineAdjustment="alignBaselines" adjustsFontSizeToFit="NO" translatesAutoresizingMaskIntoConstraints="NO" id="uPT-8q-4gD"&gt;
                                &lt;rect key="frame" x="101" y="291" width="173" height="21"/&gt;
                                &lt;fontDescription key="fontDescription" type="system" pointSize="17"/&gt;
                                &lt;nil key="textColor"/&gt;
                                &lt;nil key="highlightedColor"/&gt;
                            &lt;/label&gt;
                            &lt;button opaque="NO" contentMode="scaleToFill" contentHorizontalAlignment="center" contentVerticalAlignment="center" buttonType="roundedRect" lineBreakMode="middleTruncation" translatesAutoresizingMaskIntoConstraints="NO" id="82C-ns-huA"&gt;
                                &lt;rect key="frame" x="161.5" y="327" width="52" height="30"/&gt;
                                &lt;state key="normal" title="Log out"/&gt;
                                &lt;connections&gt;
                                    &lt;action selector="pressedLogout:" destination="bY5-9W-L7P" eventType="touchUpInside" id="45j-x7-5sA"/&gt;
                                &lt;/connections&gt;
                            &lt;/button&gt;
                        &lt;/subviews&gt;
                        &lt;color key="backgroundColor" white="1" alpha="1" colorSpace="calibratedWhite"/&gt;
                        &lt;constraints&gt;
                            &lt;constraint firstItem="82C-ns-huA" firstAttribute="top" secondItem="uPT-8q-4gD" secondAttribute="bottom" constant="15" id="3V6-WB-hFM"/&gt;
                            &lt;constraint firstItem="uPT-8q-4gD" firstAttribute="centerX" secondItem="4vf-Xp-zhk" secondAttribute="centerX" id="LeY-x7-2Kg"/&gt;
                            &lt;constraint firstItem="82C-ns-huA" firstAttribute="centerX" secondItem="4vf-Xp-zhk" secondAttribute="centerX" id="OWo-CS-t1h"/&gt;
                            &lt;constraint firstItem="uPT-8q-4gD" firstAttribute="centerY" secondItem="4vf-Xp-zhk" secondAttribute="centerY" id="z2e-ik-8QR"/&gt;
                        &lt;/constraints&gt;
                    &lt;/view&gt;
                    &lt;navigationItem key="navigationItem" title="Logged In" id="frj-48-Xis"&gt;
                        &lt;barButtonItem key="backBarButtonItem" title=" " id="lCP-bH-oiV"/&gt;
                    &lt;/navigationItem&gt;
                    &lt;connections&gt;
                        &lt;outlet property="label" destination="uPT-8q-4gD" id="OBp-tV-UWb"/&gt;
                        &lt;outlet property="logoutButton" destination="82C-ns-huA" id="Fcj-Dz-m45"/&gt;
                    &lt;/connections&gt;
                &lt;/viewController&gt;
                &lt;placeholder placeholderIdentifier="IBFirstResponder" id="LOk-EP-DJg" userLabel="First Responder" sceneMemberID="firstResponder"/&gt;
            &lt;/objects&gt;
            &lt;point key="canvasLocation" x="2774" y="-17"/&gt;
        &lt;/scene&gt;
        
        <!--Registration View Controller-->
        &lt;scene sceneID="I9q-8i-6id"&gt;
            &lt;objects&gt;
                &lt;viewController storyboardIdentifier="RegistrationViewController" id="ScS-6G-dbd" customClass="RegistrationViewController" customModule="LoginSwift" customModuleProvider="target" sceneMemberID="viewController"&gt;
                    &lt;layoutGuides&gt;
                        &lt;viewControllerLayoutGuide type="top" id="iXR-tX-KK3"/&gt;
                        &lt;viewControllerLayoutGuide type="bottom" id="7Pu-CD-jhR"/&gt;
                    &lt;/layoutGuides&gt;
                    &lt;view key="view" contentMode="scaleToFill" id="ea5-Nq-OYD"&gt;
                        &lt;rect key="frame" x="0.0" y="64" width="375" height="603"/&gt;
                        &lt;autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/&gt;
                        &lt;subviews&gt;
                            &lt;textField opaque="NO" clipsSubviews="YES" contentMode="scaleToFill" contentHorizontalAlignment="left" contentVerticalAlignment="center" borderStyle="roundedRect" placeholder="Email" textAlignment="natural" minimumFontSize="17" translatesAutoresizingMaskIntoConstraints="NO" id="dfw-KK-7oU"&gt;
                                &lt;rect key="frame" x="26" y="248.5" width="323" height="30"/&gt;
                                &lt;nil key="textColor"/&gt;
                                &lt;fontDescription key="fontDescription" type="system" pointSize="14"/&gt;
                                &lt;textInputTraits key="textInputTraits"/&gt;
                            &lt;/textField&gt;
                            &lt;textField opaque="NO" clipsSubviews="YES" contentMode="scaleToFill" contentHorizontalAlignment="left" contentVerticalAlignment="center" borderStyle="roundedRect" placeholder="Password" textAlignment="natural" minimumFontSize="17" translatesAutoresizingMaskIntoConstraints="NO" id="KKi-Vk-Iah"&gt;
                                &lt;rect key="frame" x="26" y="286.5" width="323" height="30"/&gt;
                                &lt;nil key="textColor"/&gt;
                                &lt;fontDescription key="fontDescription" type="system" pointSize="14"/&gt;
                                &lt;textInputTraits key="textInputTraits" secureTextEntry="YES"/&gt;
                            &lt;/textField&gt;
                            &lt;textField opaque="NO" clipsSubviews="YES" contentMode="scaleToFill" contentHorizontalAlignment="left" contentVerticalAlignment="center" borderStyle="roundedRect" placeholder="Name" textAlignment="natural" minimumFontSize="17" translatesAutoresizingMaskIntoConstraints="NO" id="5Vf-zJ-UTa"&gt;
                                &lt;rect key="frame" x="26" y="324.5" width="323" height="30"/&gt;
                                &lt;nil key="textColor"/&gt;
                                &lt;fontDescription key="fontDescription" type="system" pointSize="14"/&gt;
                                &lt;textInputTraits key="textInputTraits"/&gt;
                            &lt;/textField&gt;
                            &lt;button opaque="NO" contentMode="scaleToFill" contentHorizontalAlignment="center" contentVerticalAlignment="center" buttonType="roundedRect" lineBreakMode="middleTruncation" translatesAutoresizingMaskIntoConstraints="NO" id="CDA-mG-a8o"&gt;
                                &lt;rect key="frame" x="159" y="369.5" width="57" height="30"/&gt;
                                &lt;state key="normal" title="Register"/&gt;
                                &lt;connections&gt;
                                    &lt;action selector="pressedRegister:" destination="ScS-6G-dbd" eventType="touchUpInside" id="DXo-cO-e3Q"/&gt;
                                &lt;/connections&gt;
                            &lt;/button&gt;
                        &lt;/subviews&gt;
                        &lt;color key="backgroundColor" white="1" alpha="1" colorSpace="calibratedWhite"/&gt;
                        &lt;constraints&gt;
                            &lt;constraint firstItem="KKi-Vk-Iah" firstAttribute="centerY" secondItem="ea5-Nq-OYD" secondAttribute="centerY" id="6yZ-T8-fia"/&gt;
                            &lt;constraint firstItem="KKi-Vk-Iah" firstAttribute="top" secondItem="dfw-KK-7oU" secondAttribute="bottom" constant="8" id="7Ne-cR-2Hg"/&gt;
                            &lt;constraint firstAttribute="trailingMargin" secondItem="5Vf-zJ-UTa" secondAttribute="trailing" constant="10" id="BJL-aN-Fgy"/&gt;
                            &lt;constraint firstItem="5Vf-zJ-UTa" firstAttribute="leading" secondItem="ea5-Nq-OYD" secondAttribute="leadingMargin" constant="10" id="BOO-vO-dTu"/&gt;
                            &lt;constraint firstAttribute="trailingMargin" secondItem="dfw-KK-7oU" secondAttribute="trailing" constant="10" id="CKD-LY-eyZ"/&gt;
                            &lt;constraint firstItem="dfw-KK-7oU" firstAttribute="leading" secondItem="ea5-Nq-OYD" secondAttribute="leadingMargin" constant="10" id="GjD-oL-6qr"/&gt;
                            &lt;constraint firstItem="CDA-mG-a8o" firstAttribute="centerX" secondItem="ea5-Nq-OYD" secondAttribute="centerX" id="KDd-RX-q1j"/&gt;
                            &lt;constraint firstItem="KKi-Vk-Iah" firstAttribute="leading" secondItem="ea5-Nq-OYD" secondAttribute="leadingMargin" constant="10" id="KfQ-Ru-8Sm"/&gt;
                            &lt;constraint firstAttribute="trailingMargin" secondItem="KKi-Vk-Iah" secondAttribute="trailing" constant="10" id="eSn-4J-NAh"/&gt;
                            &lt;constraint firstItem="CDA-mG-a8o" firstAttribute="top" secondItem="5Vf-zJ-UTa" secondAttribute="bottom" constant="15" id="oir-Ja-wWb"/&gt;
                            &lt;constraint firstItem="5Vf-zJ-UTa" firstAttribute="top" secondItem="KKi-Vk-Iah" secondAttribute="bottom" constant="8" id="tdU-Lw-48B"/&gt;
                        &lt;/constraints&gt;
                    &lt;/view&gt;
                    &lt;navigationItem key="navigationItem" title="Registration" id="z9h-Hd-CL7"&gt;
                        &lt;barButtonItem key="backBarButtonItem" title=" " id="93G-i1-yL5"/&gt;
                    &lt;/navigationItem&gt;
                    &lt;connections&gt;
                        &lt;outlet property="emailField" destination="dfw-KK-7oU" id="Bke-x5-8Tn"/&gt;
                        &lt;outlet property="nameField" destination="5Vf-zJ-UTa" id="oth-gO-gSd"/&gt;
                        &lt;outlet property="passwordField" destination="KKi-Vk-Iah" id="Aeh-Ri-J4K"/&gt;
                    &lt;/connections&gt;
                &lt;/viewController&gt;
                &lt;placeholder placeholderIdentifier="IBFirstResponder" id="7Z1-uP-ktI" userLabel="First Responder" sceneMemberID="firstResponder"/&gt;
            &lt;/objects&gt;
            &lt;point key="canvasLocation" x="3478.125" y="-17.95774647887324"/&gt;
        &lt;/scene&gt;
        
        <!--Restore Password View Controller-->
        &lt;scene sceneID="njW-CS-fdM"&gt;
            &lt;objects&gt;
                &lt;viewController storyboardIdentifier="RestorePasswordViewController" id="j4a-ms-vfz" customClass="RestorePasswordViewController" customModule="LoginSwift" customModuleProvider="target" sceneMemberID="viewController"&gt;
                    &lt;layoutGuides&gt;
                        &lt;viewControllerLayoutGuide type="top" id="Wnn-5m-YQs"/&gt;
                        &lt;viewControllerLayoutGuide type="bottom" id="DGg-Lp-Gi2"/&gt;
                    &lt;/layoutGuides&gt;
                    &lt;view key="view" contentMode="scaleToFill" id="BDA-z0-v5a"&gt;
                        &lt;rect key="frame" x="0.0" y="64" width="375" height="603"/&gt;
                        &lt;autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/&gt;
                        &lt;subviews&gt;
                            &lt;textField opaque="NO" clipsSubviews="YES" contentMode="scaleToFill" contentHorizontalAlignment="left" contentVerticalAlignment="center" borderStyle="roundedRect" placeholder="Email" textAlignment="natural" minimumFontSize="17" translatesAutoresizingMaskIntoConstraints="NO" id="KKE-f1-fAk"&gt;
                                &lt;rect key="frame" x="26" y="286.5" width="323" height="30"/&gt;
                                &lt;nil key="textColor"/&gt;
                                &lt;fontDescription key="fontDescription" type="system" pointSize="14"/&gt;
                                &lt;textInputTraits key="textInputTraits"/&gt;
                            &lt;/textField&gt;
                            &lt;button opaque="NO" contentMode="scaleToFill" contentHorizontalAlignment="center" contentVerticalAlignment="center" buttonType="roundedRect" lineBreakMode="middleTruncation" translatesAutoresizingMaskIntoConstraints="NO" id="8fa-2X-oow"&gt;
                                &lt;rect key="frame" x="161" y="331.5" width="53" height="30"/&gt;
                                &lt;state key="normal" title="Restore"/&gt;
                                &lt;connections&gt;
                                    &lt;action selector="pressedRestore:" destination="j4a-ms-vfz" eventType="touchUpInside" id="zEj-ZE-rBu"/&gt;
                                &lt;/connections&gt;
                            &lt;/button&gt;
                        &lt;/subviews&gt;
                        &lt;color key="backgroundColor" white="1" alpha="1" colorSpace="calibratedWhite"/&gt;
                        &lt;constraints&gt;
                            &lt;constraint firstAttribute="trailingMargin" secondItem="KKE-f1-fAk" secondAttribute="trailing" constant="10" id="GN7-eT-KEq"/&gt;
                            &lt;constraint firstItem="8fa-2X-oow" firstAttribute="top" secondItem="KKE-f1-fAk" secondAttribute="bottom" constant="15" id="NCU-f5-SUP"/&gt;
                            &lt;constraint firstItem="KKE-f1-fAk" firstAttribute="centerY" secondItem="BDA-z0-v5a" secondAttribute="centerY" id="i9i-O2-w2D"/&gt;
                            &lt;constraint firstItem="8fa-2X-oow" firstAttribute="centerX" secondItem="BDA-z0-v5a" secondAttribute="centerX" id="luV-XD-feN"/&gt;
                            &lt;constraint firstItem="KKE-f1-fAk" firstAttribute="leading" secondItem="BDA-z0-v5a" secondAttribute="leadingMargin" constant="10" id="mqC-3c-uwI"/&gt;
                        &lt;/constraints&gt;
                    &lt;/view&gt;
                    &lt;navigationItem key="navigationItem" title="Restore password" id="49U-Rs-9yh"&gt;
                        &lt;barButtonItem key="backBarButtonItem" title=" " id="7eG-6n-QL7"/&gt;
                    &lt;/navigationItem&gt;
                    &lt;connections&gt;
                        &lt;outlet property="emailField" destination="KKE-f1-fAk" id="AS2-Vx-RgP"/&gt;
                    &lt;/connections&gt;
                &lt;/viewController&gt;
                &lt;placeholder placeholderIdentifier="IBFirstResponder" id="bKI-4b-H0A" userLabel="First Responder" sceneMemberID="firstResponder"/&gt;
            &lt;/objects&gt;
            &lt;point key="canvasLocation" x="4234" y="-17"/&gt;
        &lt;/scene&gt;
        </xsl:if>
        
        
        <xsl:if test="$facebookLogin = 'true'">
        <!--Facebook View Controller-->
          &lt;scene sceneID="3mN-HX-5Ph"&gt;
            &lt;objects&gt;
                &lt;viewController storyboardIdentifier="FacebookViewController" id="Cv9-hR-K5u" customClass="FacebookViewController" customModule="LoginSwift" customModuleProvider="target" sceneMemberID="viewController"&gt;
                    &lt;layoutGuides&gt;
                        &lt;viewControllerLayoutGuide type="top" id="law-YU-1Pf"/&gt;
                        &lt;viewControllerLayoutGuide type="bottom" id="Jei-nA-TWO"/&gt;
                    &lt;/layoutGuides&gt;
                    &lt;view key="view" contentMode="scaleToFill" id="VMp-dT-nDi"&gt;
                        &lt;rect key="frame" x="0.0" y="0.0" width="375" height="667"/&gt;
                        &lt;autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/&gt;
                        &lt;color key="backgroundColor" white="1" alpha="1" colorSpace="calibratedWhite"/&gt;
                    &lt;/view&gt;
                    &lt;navigationItem key="navigationItem" title="Facebook Login" id="enK-TP-rS0"&gt;
                        &lt;barButtonItem key="backBarButtonItem" title=" " id="RH8-Gz-dJY"/&gt;
                    &lt;/navigationItem&gt;
                &lt;/viewController&gt;
                &lt;placeholder placeholderIdentifier="IBFirstResponder" id="25Q-Jf-zwf" userLabel="First Responder" sceneMemberID="firstResponder"/&gt;
            &lt;/objects&gt;
            &lt;point key="canvasLocation" x="2055" y="717"/&gt;
        &lt;/scene&gt;
        </xsl:if>
        
        
        <xsl:if test="$googleLogin = 'true'">
        <!--Google View Controller-->
        &lt;scene sceneID="kwB-WI-RoP"&gt;
            &lt;objects&gt;
                &lt;viewController storyboardIdentifier="GoogleViewController" id="al5-g7-unC" customClass="GoogleViewController" customModule="LoginSwift" customModuleProvider="target" sceneMemberID="viewController"&gt;
                    &lt;layoutGuides&gt;
                        &lt;viewControllerLayoutGuide type="top" id="Auo-l6-dka"/&gt;
                        &lt;viewControllerLayoutGuide type="bottom" id="NnW-Cu-cve"/&gt;
                    &lt;/layoutGuides&gt;
                    &lt;view key="view" contentMode="scaleToFill" id="Iv5-mO-qXg"&gt;
                        &lt;rect key="frame" x="0.0" y="0.0" width="375" height="667"/&gt;
                        &lt;autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/&gt;
                        &lt;color key="backgroundColor" white="1" alpha="1" colorSpace="calibratedWhite"/&gt;
                    &lt;/view&gt;
                    &lt;navigationItem key="navigationItem" title="Google Login" id="wdf-KU-mAj"&gt;
                        &lt;barButtonItem key="backBarButtonItem" title=" " id="uUP-KR-iEG"/&gt;
                    &lt;/navigationItem&gt;
                &lt;/viewController&gt;
                &lt;placeholder placeholderIdentifier="IBFirstResponder" id="3De-jk-rcj" userLabel="First Responder" sceneMemberID="firstResponder"/&gt;
            &lt;/objects&gt;
            &lt;point key="canvasLocation" x="2775" y="657"/&gt;
        &lt;/scene&gt;
        </xsl:if>
        
        <xsl:if test="$twitterLogin = 'true'">
        <!--Twitter View Controller-->
        &lt;scene sceneID="Wns-A0-4ha"&gt;
            &lt;objects&gt;
                &lt;viewController storyboardIdentifier="TwitterViewController" id="36n-DL-D8C" customClass="TwitterViewController" customModule="LoginSwift" customModuleProvider="target" sceneMemberID="viewController"&gt;
                    &lt;layoutGuides&gt;
                        &lt;viewControllerLayoutGuide type="top" id="crr-s7-Foe"/&gt;
                        &lt;viewControllerLayoutGuide type="bottom" id="Rap-08-i5V"/&gt;
                    &lt;/layoutGuides&gt;
                    &lt;view key="view" contentMode="scaleToFill" id="U39-7N-2QY"&gt;
                        &lt;rect key="frame" x="0.0" y="0.0" width="375" height="667"/&gt;
                        &lt;autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/&gt;
                        &lt;color key="backgroundColor" white="1" alpha="1" colorSpace="calibratedWhite"/&gt;
                    &lt;/view&gt;
                    &lt;navigationItem key="navigationItem" title="Twitter Login" id="X7o-D3-Jhb"&gt;
                        &lt;barButtonItem key="backBarButtonItem" title=" " id="T5b-gM-c5x"/&gt;
                    &lt;/navigationItem&gt;
                &lt;/viewController&gt;
                &lt;placeholder placeholderIdentifier="IBFirstResponder" id="YW7-Ms-2BO" userLabel="First Responder" sceneMemberID="firstResponder"/&gt;
            &lt;/objects&gt;
            &lt;point key="canvasLocation" x="3478" y="657"/&gt;
        &lt;/scene&gt;
        </xsl:if>
    &lt;/scenes&gt;
&lt;/document&gt;
            </file>
          </folder>
          
          <file  hideContent="true" path="backendless-codegen/Swift/Login/Login/Info.plist"/>
          
          <file  hideContent="true" name="AppDelegate.swift">
import UIKit
import Backendless
<xsl:if test="$googleLogin = 'true'">
import GoogleSignIn
</xsl:if>
<xsl:if test="$facebookLogin = 'true'">
import FBSDKCoreKit
</xsl:if>
<xsl:if test="$twitterLogin = 'true'">
import TwitterKit
</xsl:if>
            
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate<xsl:if test="$googleLogin = 'true'">, GIDSignInDelegate</xsl:if> {

    private let APPLICATION_ID = "<xsl:value-of select="$applicationId"/>"
    private let API_KEY = "<xsl:value-of select="$apiKey"/>"
    private let SERVER_URL = "<xsl:value-of select="$serverURL"/>"

    var window: UIWindow?
    
    private func initBackendless() {
        Backendless.shared.hostUrl = SERVER_URL
        Backendless.shared.initApp(applicationId: APPLICATION_ID, apiKey: API_KEY) 
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -&gt; Bool {
        initBackendless()
        <xsl:if test="$facebookLogin = 'true'">
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        </xsl:if>
        <xsl:if test="$googleLogin = 'true'">
        GIDSignIn.sharedInstance().clientID = "YOUR-CLIENT-ID"
        GIDSignIn.sharedInstance().delegate = self
        </xsl:if>
        <xsl:if test="$twitterLogin = 'true'">
        Twitter.sharedInstance().start(withConsumerKey:"CONSUMER-KEY", consumerSecret:"CONSUMER-SECRET")
        </xsl:if>
        return true
    }
    
    <xsl:if test="$twitterLogin = 'true'">
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -&gt; Bool {
        return Twitter.sharedInstance().application(app, open: url, options: options)
    }
    </xsl:if>
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -&gt; Bool {
        <xsl:if test="$facebookLogin = 'true'">
        if ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation) {
            return true
        }
        </xsl:if>
        <xsl:if test="$googleLogin = 'true'">
        if GIDSignIn.sharedInstance()?.handle(url) ?? false {
            return true
        }
        </xsl:if>
        return false
    }
    <xsl:if test="$googleLogin = 'true'">
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil {
            Backendless.shared.userService.loginWithGoogle(accessToken: user.authentication.accessToken, fieldsMapping: ["email": "email"], responseHandler: { loggedUser in
                UIAlertView.init(title: "Google login", message: "You are now logged in", delegate: nil, cancelButtonTitle: "OK").show()
            }, errorHandler: { fault in
                UIAlertView.init(title: "Google login failed", message: fault.message, delegate: nil, cancelButtonTitle: "OK").show()
            })
        }
        else {
            UIAlertView.init(title: "Google login failed", message: error.localizedDescription, delegate: nil, cancelButtonTitle: "OK").show()
        }
    }
    </xsl:if>
  }
          </file>
          
          <file  hideContent="true" name="MainTableViewController.swift">
import UIKit
import Backendless

class MainTableViewController: UITableViewController {
    <xsl:if test="$backendlessLogin = 'true'">
    let BACKENDLESS_LOGIN_STRING = "Backendless registration/login"
    </xsl:if>
    <xsl:if test="$facebookLogin = 'true'">
    let FACEBOOK_LOGIN_STRING = "Facebook login"
    </xsl:if>
    <xsl:if test="$googleLogin = 'true'">
    let GOOGLE_LOGIN_STRING = "Google login"
    </xsl:if>
    <xsl:if test="$twitterLogin = 'true'">
    let TWITTER_LOGIN_STRING = "Twitter login"
    </xsl:if>
    private var loginTypes = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        <xsl:if test="$backendlessLogin = 'true'">
        loginTypes.append(BACKENDLESS_LOGIN_STRING)
        </xsl:if>
        <xsl:if test="$facebookLogin = 'true'">
        loginTypes.append(FACEBOOK_LOGIN_STRING)
        </xsl:if>
        <xsl:if test="$googleLogin = 'true'">
        loginTypes.append(GOOGLE_LOGIN_STRING)
        </xsl:if>
        <xsl:if test="$twitterLogin = 'true'">
        loginTypes.append(TWITTER_LOGIN_STRING)
        </xsl:if>
    }
    
    override func numberOfSections(in tableView: UITableView) -&gt; Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -&gt; Int {
        return loginTypes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -&gt; UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = loginTypes[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -&gt; Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = self.tableView.cellForRow(at: indexPath)
        <xsl:if test="$backendlessLogin = 'true'">
        if selectedCell?.textLabel?.text == BACKENDLESS_LOGIN_STRING {
            self.performSegue(withIdentifier: "BackendlessLoginSegue", sender: self)
        }
        </xsl:if>
        <xsl:if test="$facebookLogin = 'true'">
        if selectedCell?.textLabel?.text == FACEBOOK_LOGIN_STRING {
            self.performSegue(withIdentifier: "FacebookLoginSegue", sender: self)
        }
        </xsl:if>
        <xsl:if test="$googleLogin = 'true'">
        if selectedCell?.textLabel?.text == GOOGLE_LOGIN_STRING {
            self.performSegue(withIdentifier: "GoogleLoginSegue", sender: self)
        }
        </xsl:if>
        <xsl:if test="$twitterLogin = 'true'">
        if selectedCell?.textLabel?.text == TWITTER_LOGIN_STRING {
            self.performSegue(withIdentifier: "TwitterLoginSegue", sender: self)
        }
        </xsl:if>
    }
}
          </file>
          
          
          <!--Backendless files-->
          <xsl:if test="$backendlessLogin = 'true'">
            <file  hideContent="true" name="BackendlessViewController.swift">
import UIKit
import Backendless

class BackendlessViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var stayLoggedInSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginField.delegate = self
        self.passwordField.delegate = self
    }
    
    @IBAction func pressedLogin(_ sender: Any) {
        if (loginField.text == "" || passwordField.text == "") {
            UIAlertView.init(title: "Login failed", message: "Please enter email and password to continue", delegate: nil, cancelButtonTitle: "OK").show()
        }
        else {
            if let login = loginField.text,
                let password = passwordField.text {
                Backendless.shared.userService.login(identity: login, password: password, responseHandler: { loggedUser in
                    if self.stayLoggedInSwitch.isOn {
                        Backendless.shared.userService.stayLoggedIn = true
                    }
                    else {
                        Backendless.shared.userService.stayLoggedIn = false
                    }
                    self.performSegue(withIdentifier: "BackendlessLoginSegue", sender: loggedUser)
                }, errorHandler: { fault in
                    UIAlertView.init(title: "Login failed", message: fault.message, delegate: nil, cancelButtonTitle: "OK").show()
                })
            }
        }
    }
    
    @IBAction func pressedRegister(_ sender: Any) {
        self.performSegue(withIdentifier: "BackendlessRegistrationSegue", sender: sender)
    }
    
    @IBAction func pressedRestorePassword(_ sender: Any) {
        self.performSegue(withIdentifier: "RestorePasswordSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BackendlessLoginSegue" {
            let userVC = segue.destination as! BackendlessUserViewController
            userVC.user = sender as? BackendlessUser
        }
    }
    
    // keyboard actions
    
    func textFieldShouldReturn(_ textField: UITextField) -&gt; Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.animateTextField(textField: textField, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.animateTextField(textField: textField, up: false)
    }
    
    func animateTextField(textField: UITextField, up: Bool) {
        let movementDistance = 80
        let movementDuration = 0.3
        let movement = up ? -movementDistance : movementDistance
        UIView.beginAnimations("anim", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: CGFloat(movement))
        UIView.commitAnimations()
    }
    
    override func touchesBegan(_ touches: Set&lt;UITouch&gt;, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
            </file>
          
            <file  hideContent="true" name="BackendlessUserViewController.swift">
import UIKit
import Backendless

class BackendlessUserViewController: UIViewController {

    var user: BackendlessUser!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = user.email as String
    }
    
    @IBAction func pressedLogout(_ sender: Any) {
        if user != nil {
            Backendless.shared.userService.logout(responseHandler: {
                UIAlertView.init(title: "Logout", message: "\(self.user.email) has been logged out", delegate: nil, cancelButtonTitle: "OK").show()
            }, errorHandler: { fault in
                UIAlertView.init(title: "Logout failed", message: fault.message, delegate: nil, cancelButtonTitle: "OK").show()
            })
        }
    }
}
            </file>
          
            <file  hideContent="true" name="RegistrationViewController.swift">
import UIKit
import Backendless

class RegistrationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Registration"
        self.emailField.delegate = self
        self.passwordField.delegate = self
        self.nameField.delegate = self
    }
    
    @IBAction func pressedRegister(_ sender: Any) {
        if let email = self.emailField.text,
            let password = self.passwordField.text {
            let user = BackendlessUser()
            user.email = email
            user.password = password
            user.name = self.nameField.text
            
            Backendless.shared.userService.registerUser(user: user, responseHandler: { registeredUser in
                UIAlertView.init(title: "Registration completed", message: "User registered successfully", delegate: nil, cancelButtonTitle: "OK").show()
            }, errorHandler: { fault in
                UIAlertView.init(title: "Registration failed", message: fault.message ?? "", delegate: nil, cancelButtonTitle: "OK").show()
            })
        }
    }
    
    // keyboard actions
    
    func textFieldShouldReturn(_ textField: UITextField) -&gt; Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.animateTextField(textField: textField, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.animateTextField(textField: textField, up: false)
    }
    
    func animateTextField(textField: UITextField, up: Bool) {
        let movementDistance = 80
        let movementDuration = 0.3
        let movement = up ? -movementDistance : movementDistance
        UIView.beginAnimations("anim", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: CGFloat(movement))
        UIView.commitAnimations()
    }
    
    override func touchesBegan(_ touches: Set&lt;UITouch&gt;, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
            </file>
          
            <file  hideContent="true" name="RestorePasswordViewController.swift">
import UIKit
import Backendless

class RestorePasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailField.delegate = self
    }
    
    @IBAction func pressedRestore(_ sender: Any) {
        if let email = emailField.text {
            Backendless.shared.userService.restorePassword(identity: email, responseHandler: {
                UIAlertView.init(title: "Password restoration", message: "The email that you can use to reset your password has been sent to the specified address", delegate: nil, cancelButtonTitle: "OK").show()
            }, errorHandler: { fault in
                UIAlertView.init(title: "Password restoration failed", message: fault.message ?? "", delegate: nil, cancelButtonTitle: "OK").show()
            })
        }
    }
    
    // keyboard actions
    
    func textFieldShouldReturn(_ textField: UITextField) -&gt; Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.animateTextField(textField: textField, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.animateTextField(textField: textField, up: false)
    }
    
    func animateTextField(textField: UITextField, up: Bool) {
        let movementDistance = 80
        let movementDuration = 0.3
        let movement = up ? -movementDistance : movementDistance
        UIView.beginAnimations("anim", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: CGFloat(movement))
        UIView.commitAnimations()
    }
    
    override func touchesBegan(_ touches: Set&lt;UITouch&gt;, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
            </file>
          </xsl:if>
          
          
          <!--Facebook files-->
          <xsl:if test="$facebookLogin = 'true'">
            <file  hideContent="true" name="FacebookViewController.swift">
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Backendless

class FacebookViewController: UIViewController, LoginButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Facebook login"
        
        let loginButton = FBLoginButton()
        loginButton.delegate = self
        loginButton.permissions = ["public_profile", "email", "user_friends"]
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if error != nil {
            UIAlertView.init(title: "Facebook login failed", message: error?.localizedDescription, delegate: nil, cancelButtonTitle: "OK").show()
        }
        else {
            if let accessToken = AccessToken.current {
                Backendless.shared.userService.logingWithFacebook(accessToken: accessToken.tokenString, fieldsMapping: ["email": "email"], responseHandler: { loggedUser in
                    UIAlertView.init(title: "Login succeed", message: "You are now logged in", delegate: nil, cancelButtonTitle: "OK").show()
                }, errorHandler: { fault in
                    UIAlertView.init(title: "Facebook login failed", message: fault.message ?? "", delegate: nil, cancelButtonTitle: "OK").show()
                })
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        Backendless.shared.userService.logout(responseHandler: {
            UIAlertView.init(title: "Logout", message: "You have been logged out", delegate: nil, cancelButtonTitle: "OK").show()
        }, errorHandler: { fault in
            UIAlertView.init(title: "Logout failed", message: fault.message ?? "", delegate: nil, cancelButtonTitle: "OK").show()
        })
    }
}
            </file>
          </xsl:if>
          
          
          <!--Google files-->
          <xsl:if test="$googleLogin = 'true'">
            <file  hideContent="true" name="GoogleViewController.swift">
import UIKit
import GoogleSignIn
import Backendless

class GoogleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Google login"
        
        let signInButton = GIDSignInButton()
        signInButton.style = .wide
        signInButton.center = self.view.center
        self.view.addSubview(signInButton)
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        // Automatically sign in the user.
        // GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    // Use this method to logout
    /*Backendless.shared.userService.logout(responseHandler: {
     GIDSignIn.sharedInstance().signOut()
     print("LOGGED OUT")
     }, errorHandler: { fault in
     print("Server reported an error: \(fault.message ?? "")")
     })*/
}
            </file>
          </xsl:if>
          
          <!--Twitter files-->
          <xsl:if test="$twitterLogin = 'true'">
            <file  hideContent="true" name="TwitterViewController.swift">
import UIKit
import TwitterKit
import Backendless

class TwitterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if let session = session {
                Backendless.shared.userService.loginWithTwitter(authToken: session.authToken, authTokenSecret: session.authTokenSecret, fieldsMapping: ["email": "email"], responseHandler: { user in
                    UIAlertView.init(title: "Twitter login", message: "You are now logged in", delegate: nil, cancelButtonTitle: "OK").show()
                }, errorHandler: { fault in
                    UIAlertView.init(title: "Twitter login failed", message: fault.message ?? "", delegate: nil, cancelButtonTitle: "OK").show()
                })
            }
            else {
                print("Twitter login failed: \(error!.localizedDescription)");
            }
        })
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
    }
    
    // Use this method to logout
    /*Backendless.shared.userService.logout(responseHandler: {
     if let userId = Twitter.sharedInstance().sessionStore.session()?.userID {
     Twitter.sharedInstance().sessionStore.logOutUserID(userId)
     print("LOGGED OUT")
     }
     }, errorHandler: { fault in
     print("Server reported an error: \(fault.message ?? "")")
     })*/
}
            </file>
          </xsl:if>
        </folder>
      
      <folder  hideContent="true" name="{$applicationName}-Login.xcodeproj">
          <file  hideContent="true" name="project.pbxproj">// !$*UTF8*$!
{
	archiveVersion = 1;
	classes = {
	};
	objectVersion = 46;
	objects = {

/* Begin PBXBuildFile section */
		5A03B6201F1E0702003225B9 /* AppDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5A03B61F1F1E0702003225B9 /* AppDelegate.swift */; };
		5A03B6271F1E0702003225B9 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 5A03B6261F1E0702003225B9 /* Assets.xcassets */; };
		5A03B62A1F1E0702003225B9 /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 5A03B6281F1E0702003225B9 /* LaunchScreen.storyboard */; };
		5A03B6331F1E0804003225B9 /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 5A03B6311F1E0804003225B9 /* Main.storyboard */; };
		5AC095781F1E1A0100CFC899 /* MainTableViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5AC095771F1E1A0100CFC899 /* MainTableViewController.swift */; };
		<xsl:if test="$facebookLogin = 'true'">
		5A6358911F1E330D00CB5523 /* FacebookViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5A6358901F1E330D00CB5523 /* FacebookViewController.swift */; };
		</xsl:if>
		<xsl:if test="$googleLogin = 'true'">
		5A6358931F1E374E00CB5523 /* GoogleViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5A6358921F1E374E00CB5523 /* GoogleViewController.swift */; };
		</xsl:if>
		<xsl:if test="$twitterLogin = 'true'">
		5A6358951F1E38DC00CB5523 /* TwitterViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5A6358941F1E38DC00CB5523 /* TwitterViewController.swift */; };
		</xsl:if>
		<xsl:if test="$backendlessLogin = 'true'">
		5AC0957A1F1E1ED100CFC899 /* BackendlessViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5AC095791F1E1ED100CFC899 /* BackendlessViewController.swift */; };
		5AC0957C1F1E21A800CFC899 /* BackendlessUserViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5AC0957B1F1E21A800CFC899 /* BackendlessUserViewController.swift */; };
		5AC0957E1F1E2A6F00CFC899 /* RegistrationViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5AC0957D1F1E2A6F00CFC899 /* RegistrationViewController.swift */; };
		5AC095801F1E2EF500CFC899 /* RestorePasswordViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 5AC0957F1F1E2EF500CFC899 /* RestorePasswordViewController.swift */; };
		</xsl:if>
/* End PBXBuildFile section */

/* Begin PBXFileReference section */
		5A03B61C1F1E0702003225B9 /* <xsl:value-of select="$applicationName"/>-Login.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = "<xsl:value-of select="$applicationName"/>-Login.app"; sourceTree = BUILT_PRODUCTS_DIR; };
		5A03B61F1F1E0702003225B9 /* AppDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = "&lt;group&gt;"; };
		5A03B6261F1E0702003225B9 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "&lt;group&gt;"; };
		5A03B6291F1E0702003225B9 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = "&lt;group&gt;"; };
		5A03B62B1F1E0702003225B9 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "&lt;group&gt;"; };
		5A03B6321F1E0804003225B9 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = "&lt;group&gt;"; };
		5AC095771F1E1A0100CFC899 /* MainTableViewController.swift */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = MainTableViewController.swift; sourceTree = "&lt;group&gt;"; };
		<xsl:if test="$facebookLogin = 'true'">
		5A6358901F1E330D00CB5523 /* FacebookViewController.swift */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = FacebookViewController.swift; sourceTree = "&lt;group&gt;"; };
		</xsl:if>
		<xsl:if test="$googleLogin = 'true'">
		5A6358921F1E374E00CB5523 /* GoogleViewController.swift */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = GoogleViewController.swift; sourceTree = "&lt;group&gt;"; };
		</xsl:if>
		<xsl:if test="$twitterLogin = 'true'">
		5A6358941F1E38DC00CB5523 /* TwitterViewController.swift */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = TwitterViewController.swift; sourceTree = "&lt;group&gt;"; };
		</xsl:if>
		<xsl:if test="$backendlessLogin = 'true'">
		5AC095791F1E1ED100CFC899 /* BackendlessViewController.swift */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = BackendlessViewController.swift; sourceTree = "&lt;group&gt;"; };
		5AC0957B1F1E21A800CFC899 /* BackendlessUserViewController.swift */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = BackendlessUserViewController.swift; sourceTree = "&lt;group&gt;"; };
		5AC0957D1F1E2A6F00CFC899 /* RegistrationViewController.swift */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = RegistrationViewController.swift; sourceTree = "&lt;group&gt;"; };
		5AC0957F1F1E2EF500CFC899 /* RestorePasswordViewController.swift */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = RestorePasswordViewController.swift; sourceTree = "&lt;group&gt;"; };
		</xsl:if>
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
		5A03B6191F1E0702003225B9 /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
		5A03B6131F1E0702003225B9 = {
			isa = PBXGroup;
			children = (
				5A03B61E1F1E0702003225B9 /* <xsl:value-of select="$applicationName"/>-Login */,
				5A03B61D1F1E0702003225B9 /* Products */,
			);
			sourceTree = "&lt;group&gt;";
		};
		5A03B61D1F1E0702003225B9 /* Products */ = {
			isa = PBXGroup;
			children = (
				5A03B61C1F1E0702003225B9 /* <xsl:value-of select="$applicationName"/>-Login.app */,
			);
			name = Products;
			sourceTree = "&lt;group&gt;";
		};
		5A03B61E1F1E0702003225B9 /* <xsl:value-of select="$applicationName"/>-Login */ = {
			isa = PBXGroup;
			children = (
				5A03B6311F1E0804003225B9 /* Main.storyboard */,
				5A03B61F1F1E0702003225B9 /* AppDelegate.swift */,
				5AC095771F1E1A0100CFC899 /* MainTableViewController.swift */,
				5A03B6261F1E0702003225B9 /* Assets.xcassets */,
				5A03B6281F1E0702003225B9 /* LaunchScreen.storyboard */,
				5A03B62B1F1E0702003225B9 /* Info.plist */,
				<xsl:if test="$backendlessLogin = 'true'">
				5AC095791F1E1ED100CFC899 /* BackendlessViewController.swift */,
				5AC0957B1F1E21A800CFC899 /* BackendlessUserViewController.swift */,
				5AC0957D1F1E2A6F00CFC899 /* RegistrationViewController.swift */,
				5AC0957F1F1E2EF500CFC899 /* RestorePasswordViewController.swift */,
				</xsl:if>
				<xsl:if test="$facebookLogin = 'true'">
				5A6358901F1E330D00CB5523 /* FacebookViewController.swift */,
				</xsl:if>
				<xsl:if test="$googleLogin = 'true'">
				5A6358921F1E374E00CB5523 /* GoogleViewController.swift */,
				</xsl:if>
				<xsl:if test="$twitterLogin = 'true'">
				5A6358941F1E38DC00CB5523 /* TwitterViewController.swift */,
				</xsl:if>
			);
			path = "<xsl:value-of select="$applicationName"/>-Login";
			sourceTree = "&lt;group&gt;";
		};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		5A03B61B1F1E0702003225B9 /* <xsl:value-of select="$applicationName"/>-Login */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = 5A03B62E1F1E0702003225B9 /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$applicationName"/>-Login" */;
			buildPhases = (
				5A03B6181F1E0702003225B9 /* Sources */,
				5A03B6191F1E0702003225B9 /* Frameworks */,
				5A03B61A1F1E0702003225B9 /* Resources */,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = "<xsl:value-of select="$applicationName"/>-Login";
			productName = "<xsl:value-of select="$applicationName"/>-Login";
			productReference = 5A03B61C1F1E0702003225B9 /* <xsl:value-of select="$applicationName"/>-Login.app */;
			productType = "com.apple.product-type.application";
		};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		5A03B6141F1E0702003225B9 /* Project object */ = {
			isa = PBXProject;
			attributes = {
				LastSwiftUpdateCheck = 0830;
				LastUpgradeCheck = 1020;
				TargetAttributes = {
					5A03B61B1F1E0702003225B9 = {
						CreatedOnToolsVersion = 8.3.2;
						LastSwiftMigration = 1020;
						ProvisioningStyle = Automatic;
					};
				};
			};
			buildConfigurationList = 5A03B6171F1E0702003225B9 /* Build configuration list for PBXProject "<xsl:value-of select="$applicationName"/>-Login" */;
			compatibilityVersion = "Xcode 3.2";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				Base,
			);
			mainGroup = 5A03B6131F1E0702003225B9;
			productRefGroup = 5A03B61D1F1E0702003225B9 /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				5A03B61B1F1E0702003225B9 /* <xsl:value-of select="$applicationName"/>-Login */,
			);
		};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
		5A03B61A1F1E0702003225B9 /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				5A03B6331F1E0804003225B9 /* Main.storyboard in Resources */,
				5A03B62A1F1E0702003225B9 /* LaunchScreen.storyboard in Resources */,
				5A03B6271F1E0702003225B9 /* Assets.xcassets in Resources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
		5A03B6181F1E0702003225B9 /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				5A03B6201F1E0702003225B9 /* AppDelegate.swift in Sources */,
				5AC095781F1E1A0100CFC899 /* MainTableViewController.swift in Sources */,
				<xsl:if test="$backendlessLogin = 'true'">
				5AC0957C1F1E21A800CFC899 /* BackendlessUserViewController.swift in Sources */,
				5AC0957E1F1E2A6F00CFC899 /* RegistrationViewController.swift in Sources */,
				5AC0957A1F1E1ED100CFC899 /* BackendlessViewController.swift in Sources */,
				5AC095801F1E2EF500CFC899 /* RestorePasswordViewController.swift in Sources */,
				</xsl:if>
				<xsl:if test="$twitterLogin = 'true'">
				5A6358951F1E38DC00CB5523 /* TwitterViewController.swift in Sources */,
				</xsl:if>
				<xsl:if test="$googleLogin = 'true'">
				5A6358931F1E374E00CB5523 /* GoogleViewController.swift in Sources */,
				</xsl:if>
			  	<xsl:if test="$facebookLogin = 'true'">
				5A6358911F1E330D00CB5523 /* FacebookViewController.swift in Sources */,
				</xsl:if>
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXSourcesBuildPhase section */

/* Begin PBXVariantGroup section */
		5A03B6281F1E0702003225B9 /* LaunchScreen.storyboard */ = {
			isa = PBXVariantGroup;
			children = (
				5A03B6291F1E0702003225B9 /* Base */,
			);
			name = LaunchScreen.storyboard;
			sourceTree = "&lt;group&gt;";
		};
		5A03B6311F1E0804003225B9 /* Main.storyboard */ = {
			isa = PBXVariantGroup;
			children = (
				5A03B6321F1E0804003225B9 /* Base */,
			);
			name = Main.storyboard;
			sourceTree = "&lt;group&gt;";
		};
/* End PBXVariantGroup section */

/* Begin XCBuildConfiguration section */
		5A03B62C1F1E0702003225B9 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				CLANG_ANALYZER_LOCALIZABILITY_NONLOCALIZED = YES;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++0x";
				CLANG_CXX_LIBRARY = "libc++";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				"CODE_SIGN_IDENTITY[sdk=iphoneos*]" = "iPhone Developer";
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = dwarf;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_TESTABILITY = YES;
				GCC_C_LANGUAGE_STANDARD = gnu99;
				GCC_DYNAMIC_NO_PIC = NO;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_OPTIMIZATION_LEVEL = 0;
				GCC_PREPROCESSOR_DEFINITIONS = (
					"DEBUG=1",
					"$(inherited)",
				);
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 8.0;
				MTL_ENABLE_DEBUG_INFO = YES;
				ONLY_ACTIVE_ARCH = YES;
				SDKROOT = iphoneos;
				SWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;
				SWIFT_OPTIMIZATION_LEVEL = "-Onone";
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Debug;
		};
		5A03B62D1F1E0702003225B9 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				CLANG_ANALYZER_LOCALIZABILITY_NONLOCALIZED = YES;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++0x";
				CLANG_CXX_LIBRARY = "libc++";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				"CODE_SIGN_IDENTITY[sdk=iphoneos*]" = "iPhone Developer";
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
				ENABLE_NS_ASSERTIONS = NO;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				GCC_C_LANGUAGE_STANDARD = gnu99;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 8.0;
				MTL_ENABLE_DEBUG_INFO = NO;
				SDKROOT = iphoneos;
				SWIFT_OPTIMIZATION_LEVEL = "-Owholemodule";
				TARGETED_DEVICE_FAMILY = "1,2";
				VALIDATE_PRODUCT = YES;
			};
			name = Release;
		};
		5A03B62F1F1E0702003225B9 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				FRAMEWORK_SEARCH_PATHS = "$(inherited)";
				INFOPLIST_FILE = "<xsl:value-of select="$applicationName"/>-Login/Info.plist";
				IPHONEOS_DEPLOYMENT_TARGET = 8.0;
				LD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
				PRODUCT_BUNDLE_IDENTIFIER = "com.backendless.codegen.<xsl:value-of select="$applicationName"/>-Login";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_OBJC_BRIDGING_HEADER = "";
				SWIFT_VERSION = 5.0;
			};
			name = Debug;
		};
		5A03B6301F1E0702003225B9 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				FRAMEWORK_SEARCH_PATHS = "$(inherited)";
				INFOPLIST_FILE = "<xsl:value-of select="$applicationName"/>-Login/Info.plist";
				IPHONEOS_DEPLOYMENT_TARGET = 8.0;
				LD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
				PRODUCT_BUNDLE_IDENTIFIER = "com.backendless.codegenc<xsl:value-of select="$applicationName"/>-Login";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_OBJC_BRIDGING_HEADER = "";
				SWIFT_VERSION = 5.0;
			};
			name = Release;
		};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
		5A03B6171F1E0702003225B9 /* Build configuration list for PBXProject "<xsl:value-of select="$applicationName"/>-Login" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				5A03B62C1F1E0702003225B9 /* Debug */,
				5A03B62D1F1E0702003225B9 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		5A03B62E1F1E0702003225B9 /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$applicationName"/>-Login" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				5A03B62F1F1E0702003225B9 /* Debug */,
				5A03B6301F1E0702003225B9 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
/* End XCConfigurationList section */
	};
	rootObject = 5A03B6141F1E0702003225B9 /* Project object */;
}
          </file>
        </folder>
      </folder>
    </xsl:template>
</xsl:stylesheet>