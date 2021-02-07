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

    <xsl:template name="loginObjC">
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
          <folder  hideContent="true" path="backendless-codegen/ObjC/Login/Login/Assets.xcassets"/>
          
          <folder  hideContent="true" name="Base.lproj">
            <file  hideContent="true" path="backendless-codegen/ObjC/Login/Login/Base.lproj/LaunchScreen.storyboard"/>
            
            
            <file  hideContent="true" name="Main.storyboard">&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;document type="com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB" version="3.0" toolsVersion="14490.70" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" colorMatched="YES" initialViewController="M7p-zs-ada"&gt;
    &lt;device id="retina4_0" orientation="portrait"&gt;
        &lt;adaptation id="fullscreen"/&gt;
    &lt;/device&gt;
    &lt;dependencies&gt;
        &lt;deployment identifier="iOS"/&gt;
        &lt;plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="14490.49"/&gt;
        &lt;capability name="documents saved in the Xcode 8 format" minToolsVersion="8.0"/&gt;
    &lt;/dependencies&gt;
    &lt;scenes&gt;

        <!--Navigation Controller-->
        &lt;scene sceneID="Pah-fE-Oew"&gt;
            &lt;objects&gt;
                &lt;navigationController id="M7p-zs-ada" sceneMemberID="viewController"&gt;
                    &lt;navigationBar key="navigationBar" contentMode="scaleToFill" id="XcK-lR-W5q"&gt;
                        &lt;rect key="frame" x="0.0" y="20" width="320" height="44"/&gt;
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
                &lt;tableViewController id="KZO-xW-DJZ" customClass="MainTableView" sceneMemberID="viewController"&gt;
                    &lt;tableView key="view" clipsSubviews="YES" contentMode="scaleToFill" alwaysBounceVertical="YES" dataMode="prototypes" style="plain" separatorStyle="default" rowHeight="44" sectionHeaderHeight="28" sectionFooterHeight="28" id="R2l-de-Hew"&gt;
                        &lt;rect key="frame" x="0.0" y="0.0" width="320" height="568"/&gt;
                        &lt;autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/&gt;
                        &lt;color key="backgroundColor" white="1" alpha="1" colorSpace="calibratedWhite"/&gt;
                        &lt;prototypes&gt;
                            &lt;tableViewCell clipsSubviews="YES" contentMode="scaleToFill" selectionStyle="blue" hidesAccessoryWhenEditing="NO" indentationLevel="1" indentationWidth="0.0" reuseIdentifier="Cell" textLabel="kgG-eM-y5G" style="IBUITableViewCellStyleDefault" id="llp-Tx-Lb4"&gt;
                                &lt;rect key="frame" x="0.0" y="28" width="320" height="44"/&gt;
                                &lt;autoresizingMask key="autoresizingMask"/&gt;
                                &lt;tableViewCellContentView key="contentView" opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="center" tableViewCell="llp-Tx-Lb4" id="Gzn-Lb-qNy"&gt;
                                    &lt;rect key="frame" x="0.0" y="0.0" width="320" height="43.5"/&gt;
                                    &lt;autoresizingMask key="autoresizingMask"/&gt;
                                    &lt;subviews&gt;
                                        &lt;label opaque="NO" multipleTouchEnabled="YES" contentMode="left" text="Title" textAlignment="natural" lineBreakMode="tailTruncation" baselineAdjustment="alignBaselines" adjustsFontSizeToFit="NO" id="kgG-eM-y5G"&gt;
                                            &lt;rect key="frame" x="16" y="0.0" width="288" height="43.5"/&gt;
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
                &lt;viewController storyboardIdentifier="BackendlessLoginViewController" id="tRb-tc-q3t" customClass="BackendlessViewController" sceneMemberID="viewController"&gt;
                    &lt;layoutGuides&gt;
                        &lt;viewControllerLayoutGuide type="top" id="ffe-G9-xWr"/&gt;
                        &lt;viewControllerLayoutGuide type="bottom" id="vov-a9-BHU"/&gt;
                    &lt;/layoutGuides&gt;
                    &lt;view key="view" contentMode="scaleToFill" id="rch-TD-7uJ"&gt;
                        &lt;rect key="frame" x="0.0" y="0.0" width="320" height="504"/&gt;
                        &lt;autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/&gt;
                        &lt;subviews&gt;
                            &lt;textField opaque="NO" clipsSubviews="YES" contentMode="scaleToFill" contentHorizontalAlignment="left" contentVerticalAlignment="center" borderStyle="roundedRect" placeholder="Password" textAlignment="natural" minimumFontSize="17" translatesAutoresizingMaskIntoConstraints="NO" id="Z4j-i8-EVI"&gt;
                                &lt;rect key="frame" x="26" y="237" width="268" height="30"/&gt;
                                &lt;nil key="textColor"/&gt;
                                &lt;fontDescription key="fontDescription" type="system" pointSize="14"/&gt;
                                &lt;textInputTraits key="textInputTraits" secureTextEntry="YES"/&gt;
                            &lt;/textField&gt;
                            &lt;textField opaque="NO" clipsSubviews="YES" contentMode="scaleToFill" contentHorizontalAlignment="left" contentVerticalAlignment="center" borderStyle="roundedRect" placeholder="Login" textAlignment="natural" minimumFontSize="17" translatesAutoresizingMaskIntoConstraints="NO" id="oHe-Gj-wFC"&gt;
                                &lt;rect key="frame" x="26" y="199" width="268" height="30"/&gt;
                                &lt;nil key="textColor"/&gt;
                                &lt;fontDescription key="fontDescription" type="system" pointSize="14"/&gt;
                                &lt;textInputTraits key="textInputTraits"/&gt;
                            &lt;/textField&gt;
                            &lt;switch opaque="NO" contentMode="scaleToFill" horizontalHuggingPriority="750" verticalHuggingPriority="750" contentHorizontalAlignment="center" contentVerticalAlignment="center" on="YES" translatesAutoresizingMaskIntoConstraints="NO" id="PS1-cF-Sa5"&gt;
                                &lt;rect key="frame" x="245" y="275" width="51" height="31"/&gt;
                            &lt;/switch&gt;
                            &lt;label opaque="NO" userInteractionEnabled="NO" contentMode="left" horizontalHuggingPriority="251" verticalHuggingPriority="251" text="Remember me" textAlignment="natural" lineBreakMode="tailTruncation" baselineAdjustment="alignBaselines" adjustsFontSizeToFit="NO" translatesAutoresizingMaskIntoConstraints="NO" id="I4W-gv-C8u"&gt;
                                &lt;rect key="frame" x="137" y="279" width="100" height="18"/&gt;
                                &lt;fontDescription key="fontDescription" type="system" pointSize="15"/&gt;
                                &lt;nil key="textColor"/&gt;
                                &lt;nil key="highlightedColor"/&gt;
                            &lt;/label&gt;
                            &lt;button opaque="NO" contentMode="scaleToFill" contentHorizontalAlignment="center" contentVerticalAlignment="center" buttonType="roundedRect" lineBreakMode="middleTruncation" translatesAutoresizingMaskIntoConstraints="NO" id="p1h-Gj-0z6"&gt;
                                &lt;rect key="frame" x="98.5" y="466" width="123" height="30"/&gt;
                                &lt;state key="normal" title="Restore password"/&gt;
                                &lt;connections&gt;
                                    &lt;action selector="pressedRestorePassword:" destination="tRb-tc-q3t" eventType="touchUpInside" id="uGV-gb-7q2"/&gt;
                                &lt;/connections&gt;
                            &lt;/button&gt;
                            &lt;button opaque="NO" contentMode="scaleToFill" contentHorizontalAlignment="center" contentVerticalAlignment="center" buttonType="roundedRect" lineBreakMode="middleTruncation" translatesAutoresizingMaskIntoConstraints="NO" id="BKx-wl-p7Y"&gt;
                                &lt;rect key="frame" x="141" y="312" width="38" height="30"/&gt;
                                &lt;state key="normal" title="Login"/&gt;
                                &lt;connections&gt;
                                    &lt;action selector="pressedLogin:" destination="tRb-tc-q3t" eventType="touchUpInside" id="fjs-dV-hVU"/&gt;
                                &lt;/connections&gt;
                            &lt;/button&gt;
                            &lt;button opaque="NO" contentMode="scaleToFill" contentHorizontalAlignment="center" contentVerticalAlignment="center" buttonType="roundedRect" lineBreakMode="middleTruncation" translatesAutoresizingMaskIntoConstraints="NO" id="aV5-iU-HMz"&gt;
                                &lt;rect key="frame" x="131.5" y="421" width="57" height="30"/&gt;
                                &lt;state key="normal" title="Register"/&gt;
                                &lt;connections&gt;
                                    &lt;action selector="pressedRegister:" destination="tRb-tc-q3t" eventType="touchUpInside" id="6AA-Bv-BdW"/&gt;
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
                            &lt;constraint firstItem="I4W-gv-C8u" firstAttribute="leading" relation="greaterThanOrEqual" secondItem="rch-TD-7uJ" secondAttribute="leading" constant="20" symbolic="YES" id="n5q-IY-hLJ"/&gt;
                            &lt;constraint firstAttribute="trailingMargin" secondItem="PS1-cF-Sa5" secondAttribute="trailing" constant="10" id="pa3-1E-c9p"/&gt;
                            &lt;constraint firstItem="PS1-cF-Sa5" firstAttribute="top" secondItem="Z4j-i8-EVI" secondAttribute="bottom" constant="8" id="yXp-ky-NBN"/&gt;
                        &lt;/constraints&gt;
                    &lt;/view&gt;
                    &lt;navigationItem key="navigationItem" title="Backendless Registration and Login" id="7x8-5l-MyD"&gt;
                        &lt;barButtonItem key="backBarButtonItem" title=" " id="eX1-QW-Kal"/&gt;
                    &lt;/navigationItem&gt;
                    &lt;simulatedNavigationBarMetrics key="simulatedTopBarMetrics" translucent="NO" prompted="NO"/&gt;
                    &lt;connections&gt;
                        &lt;outlet property="loginField" destination="oHe-Gj-wFC" id="3kD-Ow-wsU"/&gt;
                        &lt;outlet property="passwordField" destination="Z4j-i8-EVI" id="RCY-AA-ZkR"/&gt;
                        &lt;outlet property="stayLoggedInSwitch" destination="PS1-cF-Sa5" id="pqk-0S-NTe"/&gt;
                        &lt;segue destination="bY5-9W-L7P" kind="show" identifier="BackendlessLoginSegue" id="2Fc-fH-bdu"/&gt;
                        &lt;segue destination="ScS-6G-dbd" kind="show" identifier="BackendlessRegistrationSegue" id="0eS-nL-7bt"/&gt;
                        &lt;segue destination="j4a-ms-vfz" kind="show" identifier="RestorePasswordSegue" id="ReL-3f-mTh"/&gt;
                    &lt;/connections&gt;
                &lt;/viewController&gt;
                &lt;placeholder placeholderIdentifier="IBFirstResponder" id="zFA-Kf-uEu" userLabel="First Responder" sceneMemberID="firstResponder"/&gt;
            &lt;/objects&gt;
            &lt;point key="canvasLocation" x="2055" y="-16"/&gt;
        &lt;/scene&gt;

        <!--Backendless User-->
        &lt;scene sceneID="gXf-qA-NvE"&gt;
            &lt;objects&gt;
                &lt;viewController storyboardIdentifier="BackendlessUserViewController" title="Backendless User" id="bY5-9W-L7P" customClass="BackendlessUserViewController" sceneMemberID="viewController"&gt;
                    &lt;layoutGuides&gt;
                        &lt;viewControllerLayoutGuide type="top" id="sC6-yp-jBy"/&gt;
                        &lt;viewControllerLayoutGuide type="bottom" id="uug-Lv-llN"/&gt;
                    &lt;/layoutGuides&gt;
                    &lt;view key="view" contentMode="scaleToFill" id="4vf-Xp-zhk"&gt;
                        &lt;rect key="frame" x="0.0" y="0.0" width="320" height="504"/&gt;
                        &lt;autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/&gt;
                        &lt;subviews&gt;
                            &lt;label opaque="NO" userInteractionEnabled="NO" contentMode="left" horizontalHuggingPriority="251" verticalHuggingPriority="251" text="You are now logged in." textAlignment="natural" lineBreakMode="tailTruncation" baselineAdjustment="alignBaselines" adjustsFontSizeToFit="NO" translatesAutoresizingMaskIntoConstraints="NO" id="uPT-8q-4gD"&gt;
                                &lt;rect key="frame" x="73.5" y="241.5" width="173" height="21"/&gt;
                                &lt;fontDescription key="fontDescription" type="system" pointSize="17"/&gt;
                                &lt;nil key="textColor"/&gt;
                                &lt;nil key="highlightedColor"/&gt;
                            &lt;/label&gt;
                            &lt;button opaque="NO" contentMode="scaleToFill" contentHorizontalAlignment="center" contentVerticalAlignment="center" buttonType="roundedRect" lineBreakMode="middleTruncation" translatesAutoresizingMaskIntoConstraints="NO" id="82C-ns-huA"&gt;
                                &lt;rect key="frame" x="134" y="277.5" width="52" height="30"/&gt;
                                &lt;state key="normal" title="Log out"/&gt;
                                &lt;connections&gt;
                                    &lt;action selector="pressedLogout:" destination="bY5-9W-L7P" eventType="touchUpInside" id="lIX-YE-BuA"/&gt;
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
                        &lt;outlet property="label" destination="uPT-8q-4gD" id="HzE-sP-3qF"/&gt;
                        &lt;outlet property="logoutButton" destination="82C-ns-huA" id="YFz-d2-Z8c"/&gt;
                    &lt;/connections&gt;
                &lt;/viewController&gt;
                &lt;placeholder placeholderIdentifier="IBFirstResponder" id="LOk-EP-DJg" userLabel="First Responder" sceneMemberID="firstResponder"/&gt;
            &lt;/objects&gt;
            &lt;point key="canvasLocation" x="2774" y="-17"/&gt;
        &lt;/scene&gt;

        <!--Registration View Controller-->
        &lt;scene sceneID="I9q-8i-6id"&gt;
            &lt;objects&gt;
                &lt;viewController storyboardIdentifier="RegistrationViewController" id="ScS-6G-dbd" customClass="RegistrationViewController" sceneMemberID="viewController"&gt;
                    &lt;layoutGuides&gt;
                        &lt;viewControllerLayoutGuide type="top" id="iXR-tX-KK3"/&gt;
                        &lt;viewControllerLayoutGuide type="bottom" id="7Pu-CD-jhR"/&gt;
                    &lt;/layoutGuides&gt;
                    &lt;view key="view" contentMode="scaleToFill" id="ea5-Nq-OYD"&gt;
                        &lt;rect key="frame" x="0.0" y="0.0" width="320" height="504"/&gt;
                        &lt;autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/&gt;
                        &lt;subviews&gt;
                            &lt;textField opaque="NO" clipsSubviews="YES" contentMode="scaleToFill" contentHorizontalAlignment="left" contentVerticalAlignment="center" borderStyle="roundedRect" placeholder="Email" textAlignment="natural" minimumFontSize="17" translatesAutoresizingMaskIntoConstraints="NO" id="dfw-KK-7oU"&gt;
                                &lt;rect key="frame" x="26" y="199" width="268" height="30"/&gt;
                                &lt;nil key="textColor"/&gt;
                                &lt;fontDescription key="fontDescription" type="system" pointSize="14"/&gt;
                                &lt;textInputTraits key="textInputTraits"/&gt;
                            &lt;/textField&gt;
                            &lt;textField opaque="NO" clipsSubviews="YES" contentMode="scaleToFill" contentHorizontalAlignment="left" contentVerticalAlignment="center" borderStyle="roundedRect" placeholder="Password" textAlignment="natural" minimumFontSize="17" translatesAutoresizingMaskIntoConstraints="NO" id="KKi-Vk-Iah"&gt;
                                &lt;rect key="frame" x="26" y="237" width="268" height="30"/&gt;
                                &lt;nil key="textColor"/&gt;
                                &lt;fontDescription key="fontDescription" type="system" pointSize="14"/&gt;
                                &lt;textInputTraits key="textInputTraits" secureTextEntry="YES"/&gt;
                            &lt;/textField&gt;
                            &lt;textField opaque="NO" clipsSubviews="YES" contentMode="scaleToFill" contentHorizontalAlignment="left" contentVerticalAlignment="center" borderStyle="roundedRect" placeholder="Name" textAlignment="natural" minimumFontSize="17" translatesAutoresizingMaskIntoConstraints="NO" id="5Vf-zJ-UTa"&gt;
                                &lt;rect key="frame" x="26" y="275" width="268" height="30"/&gt;
                                &lt;nil key="textColor"/&gt;
                                &lt;fontDescription key="fontDescription" type="system" pointSize="14"/&gt;
                                &lt;textInputTraits key="textInputTraits"/&gt;
                            &lt;/textField&gt;
                            &lt;button opaque="NO" contentMode="scaleToFill" contentHorizontalAlignment="center" contentVerticalAlignment="center" buttonType="roundedRect" lineBreakMode="middleTruncation" translatesAutoresizingMaskIntoConstraints="NO" id="CDA-mG-a8o"&gt;
                                &lt;rect key="frame" x="131.5" y="320" width="57" height="30"/&gt;
                                &lt;state key="normal" title="Register"/&gt;
                                &lt;connections&gt;
                                    &lt;action selector="pressedRegister:" destination="ScS-6G-dbd" eventType="touchUpInside" id="VgN-dS-X8h"/&gt;
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
                        &lt;outlet property="emailField" destination="dfw-KK-7oU" id="UQp-hv-ZS6"/&gt;
                        &lt;outlet property="nameField" destination="5Vf-zJ-UTa" id="f92-v5-v2Q"/&gt;
                        &lt;outlet property="passwordField" destination="KKi-Vk-Iah" id="Kz2-dW-BQN"/&gt;
                    &lt;/connections&gt;
                &lt;/viewController&gt;
                &lt;placeholder placeholderIdentifier="IBFirstResponder" id="7Z1-uP-ktI" userLabel="First Responder" sceneMemberID="firstResponder"/&gt;
            &lt;/objects&gt;
            &lt;point key="canvasLocation" x="3478.125" y="-17.95774647887324"/&gt;
        &lt;/scene&gt;

        <!--Restore password-->
        &lt;scene sceneID="njW-CS-fdM"&gt;
            &lt;objects&gt;
                &lt;viewController storyboardIdentifier="RestorePasswordViewController" id="j4a-ms-vfz" customClass="RestorePasswordViewController" sceneMemberID="viewController"&gt;
                    &lt;layoutGuides&gt;
                        &lt;viewControllerLayoutGuide type="top" id="Wnn-5m-YQs"/&gt;
                        &lt;viewControllerLayoutGuide type="bottom" id="DGg-Lp-Gi2"/&gt;
                    &lt;/layoutGuides&gt;
                    &lt;view key="view" contentMode="scaleToFill" id="BDA-z0-v5a"&gt;
                        &lt;rect key="frame" x="0.0" y="0.0" width="320" height="504"/&gt;
                        &lt;autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/&gt;
                        &lt;subviews&gt;
                            &lt;textField opaque="NO" clipsSubviews="YES" contentMode="scaleToFill" contentHorizontalAlignment="left" contentVerticalAlignment="center" borderStyle="roundedRect" placeholder="Email" textAlignment="natural" minimumFontSize="17" translatesAutoresizingMaskIntoConstraints="NO" id="KKE-f1-fAk"&gt;
                                &lt;rect key="frame" x="26" y="237" width="268" height="30"/&gt;
                                &lt;nil key="textColor"/&gt;
                                &lt;fontDescription key="fontDescription" type="system" pointSize="14"/&gt;
                                &lt;textInputTraits key="textInputTraits"/&gt;
                            &lt;/textField&gt;
                            &lt;button opaque="NO" contentMode="scaleToFill" contentHorizontalAlignment="center" contentVerticalAlignment="center" buttonType="roundedRect" lineBreakMode="middleTruncation" translatesAutoresizingMaskIntoConstraints="NO" id="8fa-2X-oow"&gt;
                                &lt;rect key="frame" x="133.5" y="282" width="53" height="30"/&gt;
                                &lt;state key="normal" title="Restore"/&gt;
                                &lt;connections&gt;
                                    &lt;action selector="pressedRestore:" destination="j4a-ms-vfz" eventType="touchUpInside" id="93s-0t-BaI"/&gt;
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
                        &lt;outlet property="emailField" destination="KKE-f1-fAk" id="S0O-6u-UeE"/&gt;
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
                &lt;viewController storyboardIdentifier="FacebookViewController" id="Cv9-hR-K5u" customClass="FacebookViewController" sceneMemberID="viewController"&gt;
                    &lt;layoutGuides&gt;
                        &lt;viewControllerLayoutGuide type="top" id="law-YU-1Pf"/&gt;
                        &lt;viewControllerLayoutGuide type="bottom" id="Jei-nA-TWO"/&gt;
                    &lt;/layoutGuides&gt;
                    &lt;view key="view" contentMode="scaleToFill" id="VMp-dT-nDi"&gt;
                        &lt;rect key="frame" x="0.0" y="0.0" width="320" height="568"/&gt;
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
                &lt;viewController storyboardIdentifier="GoogleViewController" id="al5-g7-unC" customClass="GoogleViewController" sceneMemberID="viewController"&gt;
                    &lt;layoutGuides&gt;
                        &lt;viewControllerLayoutGuide type="top" id="Auo-l6-dka"/&gt;
                        &lt;viewControllerLayoutGuide type="bottom" id="NnW-Cu-cve"/&gt;
                    &lt;/layoutGuides&gt;
                    &lt;view key="view" contentMode="scaleToFill" id="Iv5-mO-qXg"&gt;
                        &lt;rect key="frame" x="0.0" y="0.0" width="320" height="568"/&gt;
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
                &lt;viewController storyboardIdentifier="TwitterViewController" id="36n-DL-D8C" customClass="TwitterViewController" sceneMemberID="viewController"&gt;
                    &lt;layoutGuides&gt;
                        &lt;viewControllerLayoutGuide type="top" id="crr-s7-Foe"/&gt;
                        &lt;viewControllerLayoutGuide type="bottom" id="Rap-08-i5V"/&gt;
                    &lt;/layoutGuides&gt;
                    &lt;view key="view" contentMode="scaleToFill" id="U39-7N-2QY"&gt;
                        &lt;rect key="frame" x="0.0" y="0.0" width="320" height="568"/&gt;
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
          
          <file  hideContent="true" path="backendless-codegen/ObjC/Login/Login/Info.plist"/>
          <file  hideContent="true" path="backendless-codegen/ObjC/Login/Login/main.m"/>
          <file  hideContent="true" path="backendless-codegen/ObjC/Login/Login/MainTableView.h"/>
          
          <file  hideContent="true" name="AppDelegate.h">
#import &lt;UIKit/UIKit.h&gt;
<xsl:if test="$googleLogin = 'true'">
#import &lt;GoogleSignIn/GoogleSignIn.h&gt;
</xsl:if>
@interface AppDelegate : UIResponder &lt;UIApplicationDelegate<xsl:if test="$googleLogin = 'true'">, GIDSignInDelegate</xsl:if>&gt;

@property (strong, nonatomic) UIWindow *window;

@end
          </file>
          
          <file  hideContent="true" name="AppDelegate.m">
#import "AppDelegate.h"
#import &lt;Backendless-Swift.h&gt;
<xsl:if test="$facebookLogin = 'true'">
#import &lt;FBSDKCoreKit/FBSDKCoreKit.h&gt;
</xsl:if>
<xsl:if test="$twitterLogin = 'true'">
@import TwitterKit;
</xsl:if>

#define APPLICATION_ID @"<xsl:value-of select="$applicationId"/>"
#define API_KEY @"<xsl:value-of select="$apiKey"/>"
#define SERVER_URL @"<xsl:value-of select="$serverURL"/>"

@implementation AppDelegate

- (void)initBackendless {
    Backendless.shared.hostUrl = SERVER_URL;
    [Backendless.shared initAppWithApplicationId:APPLICATION_ID apiKey:API_KEY];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initBackendless];
    <xsl:if test="$facebookLogin = 'true'">[[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    </xsl:if>
    <xsl:if test="$googleLogin = 'true'">[GIDSignIn sharedInstance].clientID = @"YOUR-CLIENT-ID";
    [GIDSignIn sharedInstance].delegate = self;
    </xsl:if>
    <xsl:if test="$twitterLogin = 'true'">[[Twitter sharedInstance] startWithConsumerKey:@"CONSUMER-KEY" consumerSecret:@"CONSUMER-SECRET"];
    </xsl:if>
    return YES;
}

 <xsl:if test="$twitterLogin = 'true'">
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary&lt;NSString *,id&gt; *)options {
    return [[Twitter sharedInstance] application:app openURL:url options:options];
}
</xsl:if>

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    <xsl:if test="$facebookLogin = 'true'">if ([[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation]) {
        return YES;
    }
    </xsl:if>
    <xsl:if test="$googleLogin = 'true'">if ([[GIDSignIn sharedInstance] handleURL:url]) {
        return YES;
    }
    </xsl:if>
    return NO;
}
<xsl:if test="$googleLogin = 'true'">
- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    if(!error) {
        [Backendless.shared.userService loginWithGoogleWithAccessToken:user.authentication.accessToken fieldsMapping:@{@"email": @"email"} responseHandler:^(BackendlessUser *loggedInUser) {
            [[[UIAlertView alloc] initWithTitle:@"Google login" message:@"You are now logged in" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        } errorHandler:^(Fault *fault) {
            [[[UIAlertView alloc] initWithTitle:@"Google login failed" message:fault.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }];
    }
    else {
        [[[UIAlertView alloc] initWithTitle:@"Google login failed" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error {
    if (!error) {
        [[[UIAlertView alloc] initWithTitle:@"Disconnection" message:@"User has been disconnected" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    else {
        [[[UIAlertView alloc] initWithTitle:@"Google login failed" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}
</xsl:if>
@end
          </file>
          
          <file  hideContent="true" name="MainTableView.m">
#import "MainTableView.h"
#import &lt;Backendless-Swift.h&gt;
<xsl:if test="$backendlessLogin = 'true'">
#import "BackendlessViewController.h"
</xsl:if>
<xsl:if test="$facebookLogin = 'true'">
#import "FacebookViewController.h"
</xsl:if>
<xsl:if test="$googleLogin = 'true'">
#import "GoogleViewController.h"
</xsl:if>
<xsl:if test="$twitterLogin = 'true'">
#import "TwitterViewController.h"
</xsl:if>

<xsl:if test="$backendlessLogin = 'true'">
#define BACKENDLESS_LOGIN_STRING @"Backendless registration/login"
</xsl:if>
<xsl:if test="$facebookLogin = 'true'">
#define FACEBOOK_LOGIN_STRING @"Facebook login"
</xsl:if>
<xsl:if test="$googleLogin = 'true'">
#define GOOGLE_LOGIN_STRING @"Google login"
</xsl:if>
<xsl:if test="$twitterLogin = 'true'">
#define TWITTER_LOGIN_STRING @"Twitter login"
</xsl:if>

@interface MainTableView() {
    NSMutableArray *loginTypes;
}
@end

@implementation MainTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    loginTypes = [NSMutableArray new];
    <xsl:if test="$backendlessLogin = 'true'">
    [loginTypes addObject:BACKENDLESS_LOGIN_STRING];
    </xsl:if>
    <xsl:if test="$facebookLogin = 'true'">
    [loginTypes addObject:FACEBOOK_LOGIN_STRING];
    </xsl:if>
    <xsl:if test="$googleLogin = 'true'">
    [loginTypes addObject:GOOGLE_LOGIN_STRING];
    </xsl:if>
    <xsl:if test="$twitterLogin = 'true'">
    [loginTypes addObject:TWITTER_LOGIN_STRING];
    </xsl:if>
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [loginTypes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [loginTypes objectAtIndex:indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [self.tableView cellForRowAtIndexPath:indexPath];
    <xsl:if test="$backendlessLogin = 'true'">
    if ([selectedCell.textLabel.text isEqualToString:BACKENDLESS_LOGIN_STRING])
        [self performSegueWithIdentifier:@"BackendlessLoginSegue" sender:self];
    </xsl:if>
    <xsl:if test="$facebookLogin = 'true'">
    if ([selectedCell.textLabel.text isEqualToString:FACEBOOK_LOGIN_STRING])
        [self performSegueWithIdentifier:@"FacebookLoginSegue" sender:self];
    </xsl:if>
    <xsl:if test="$googleLogin = 'true'">
    if ([selectedCell.textLabel.text isEqualToString:GOOGLE_LOGIN_STRING])
        [self performSegueWithIdentifier:@"GoogleLoginSegue" sender:self];
    </xsl:if>
    <xsl:if test="$twitterLogin = 'true'">
    if ([selectedCell.textLabel.text isEqualToString:TWITTER_LOGIN_STRING])
        [self performSegueWithIdentifier:@"TwitterLoginSegue" sender:self];
    </xsl:if>
}

@end
          </file>
          
          
          <!--Backendless files-->
          <xsl:if test="$backendlessLogin = 'true'">
            <file  hideContent="true" name="BackendlessViewController.h">
#import &lt;UIKit/UIKit.h&gt;

@interface BackendlessViewController : UIViewController&lt;UITextFieldDelegate&gt;

@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UISwitch *stayLoggedInSwitch;

- (IBAction)pressedLogin:(id)sender;
- (IBAction)pressedRegister:(id)sender;
- (IBAction)pressedRestorePassword:(id)sender;

@end
            </file>
          
            <file  hideContent="true" name="BackendlessViewController.m">
#import "BackendlessViewController.h"
#import "BackendlessUserViewController.h"
#import "RegistrationViewController.h"
#import "RestorePasswordViewController.h"
#import &lt;Backendless-Swift.h&gt;

@implementation BackendlessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.loginField setDelegate:self];
    [self.passwordField setDelegate:self];
}

- (IBAction)pressedLogin:(id)sender {
    if ([self.loginField.text isEqualToString:@""] || [self.passwordField.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"Login failed" message:@"Please enter email and password to continue" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    else {
        [Backendless.shared.userService loginWithIdentity:self.loginField.text password:self.passwordField.text responseHandler:^(BackendlessUser *user) {
            if (self.stayLoggedInSwitch.isOn) {
                [Backendless.shared.userService setStayLoggedIn:YES];
            }
            else {
                [Backendless.shared.userService setStayLoggedIn:NO];
            }
            if (user) {
                [self performSegueWithIdentifier:@"BackendlessLoginSegue" sender:user];
            }
        } errorHandler:^(Fault *fault) {
            [[[UIAlertView alloc] initWithTitle:@"Login failed" message:fault.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }];
    }
}

- (IBAction)pressedRegister:(id)sender {
    [self performSegueWithIdentifier:@"BackendlessRegistrationSegue" sender:sender];
}

- (IBAction)pressedRestorePassword:(id)sender {
    [self performSegueWithIdentifier:@"RestorePasswordSegue" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"BackendlessLoginSegue"]) {
        BackendlessUserViewController *userVC = [segue destinationViewController];
        [userVC setUser:sender];
    }
}

// keyboard actions

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self animateTextField: textField up: YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField *) textField up: (BOOL) up {
    const int movementDistance = 80;
    const float movementDuration = 0.3f;
    int movement = (up ? -movementDistance : movementDistance);
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:TRUE];
}

@end
            </file>
          
            <file  hideContent="true" name="BackendlessUserViewController.h">
#import &lt;UIKit/UIKit.h&gt;
#import &lt;Backendless-Swift.h&gt;

@interface BackendlessUserViewController : UIViewController

@property (nonatomic, strong) BackendlessUser *user;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

- (IBAction)pressedLogout:(id)sender;

@end
            </file>
          
            <file  hideContent="true" name="BackendlessUserViewController.m">
#import "BackendlessUserViewController.h"

@implementation BackendlessUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.user.email;
}

- (IBAction)pressedLogout:(id)sender {
    if (self.user) {
        [Backendless.shared.userService logoutWithResponseHandler:^{
            [[[UIAlertView alloc] initWithTitle:@"Logout" message:[NSString stringWithFormat:@"%@ has been logged out", self.user.email] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } errorHandler:^(Fault *fault) {
            [[[UIAlertView alloc] initWithTitle:@"Logout failed" message:fault.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }];
    }
}

@end
            </file>
          
            <file  hideContent="true" name="RegistrationViewController.h">
#import &lt;UIKit/UIKit.h&gt;

@interface RegistrationViewController : UIViewController&lt;UITextFieldDelegate&gt;

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;

- (IBAction)pressedRegister:(id)sender;

@end
            </file>
          
            <file  hideContent="true" name="RegistrationViewController.m">
#import "RegistrationViewController.h"
#import "BackendlessViewController.h"
#import &lt;Backendless-Swift.h&gt;

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Registration";
    [self.emailField setDelegate:self];
    [self.passwordField setDelegate:self];
    [self.nameField setDelegate:self];
}

- (IBAction)pressedRegister:(id)sender {
    BackendlessUser *user = [BackendlessUser new];
    user.email = self.emailField.text;
    user.password = self.passwordField.text;
    user.name = self.nameField.text;
    [Backendless.shared.userService registerUserWithUser:user responseHandler:^(BackendlessUser *registeredUser) {
        [[[UIAlertView alloc] initWithTitle:@"Registration completed" message:@"User registered successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } errorHandler:^(Fault *fault) {
        [[[UIAlertView alloc] initWithTitle:@"Registration failed" message:fault.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
}

// keyboard actions

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self animateTextField: textField up: YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField *) textField up: (BOOL) up {
    const int movementDistance = 80;
    const float movementDuration = 0.3f;
    int movement = (up ? -movementDistance : movementDistance);
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:TRUE];
}

@end
            </file>
          
            <file  hideContent="true" name="RestorePasswordViewController.h">
#import &lt;UIKit/UIKit.h&gt;

@interface RestorePasswordViewController : UIViewController&lt;UITextFieldDelegate&gt;

@property (weak, nonatomic) IBOutlet UITextField *emailField;

- (IBAction)pressedRestore:(id)sender;

@end
            </file>
          
            <file  hideContent="true" name="RestorePasswordViewController.m">
#import "RestorePasswordViewController.h"
#import "BackendlessViewController.h"
#import &lt;Backendless-Swift.h&gt;

@implementation RestorePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.emailField setDelegate:self];
}

- (IBAction)pressedRestore:(id)sender {
    [Backendless.shared.userService restorePasswordWithIdentity:self.emailField.text responseHandler:^{
        [[[UIAlertView alloc] initWithTitle:@"Password restoration" message:@"The email that you can use to reset your password has been sent to the specified address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } errorHandler:^(Fault *fault) {
        [[[UIAlertView alloc] initWithTitle:@"Password restoration failed" message:fault.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];    
}

// keyboard actions

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self animateTextField: textField up: YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField *) textField up: (BOOL) up {
    const int movementDistance = 80;
    const float movementDuration = 0.3f;
    int movement = (up ? -movementDistance : movementDistance);
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:TRUE];
}

@end
            </file>
          </xsl:if>
          
          
          <!--Facebook files-->
          <xsl:if test="$facebookLogin = 'true'">
            <file  hideContent="true" name="FacebookViewController.h">
#import &lt;UIKit/UIKit.h&gt;
#import &lt;FBSDKLoginKit/FBSDKLoginKit.h&gt;

@interface FacebookViewController : UIViewController &lt;FBSDKLoginButtonDelegate&gt;
@end
            </file>
            
            <file  hideContent="true" name="FacebookViewController.m">
#import "FacebookViewController.h"
#import &lt;FBSDKCoreKit/FBSDKCoreKit.h&gt;
#import &lt;Backendless-Swift.h&gt;

@implementation FacebookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Facebook login";
    
    FBSDKLoginButton *loginButton = [FBSDKLoginButton new];
    loginButton.delegate = self;
    loginButton.permissions = @[@"public_profile", @"email", @"user_friends"];
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
}

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    if (error) {
        [[[UIAlertView alloc] initWithTitle:@"Facebook login failed" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    else {
        FBSDKAccessToken *accessToken = [FBSDKAccessToken currentAccessToken];
        if (accessToken) {
            [Backendless.shared.userService logingWithFacebookWithAccessToken:accessToken.tokenString fieldsMapping:@{@"email": @"email"} responseHandler:^(BackendlessUser *loggedUser) {
                [[[UIAlertView alloc] initWithTitle:@"Login succeed" message:@"You are now logged in" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            } errorHandler:^(Fault *fault) {
                [[[UIAlertView alloc] initWithTitle:@"Facebook login failed" message:fault.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            }];
        }
    }
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    [Backendless.shared.userService logoutWithResponseHandler:^{
        [[[UIAlertView alloc] initWithTitle:@"Logout" message:@"You have been logged out" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    } errorHandler:^(Fault *fault) {
        [[[UIAlertView alloc] initWithTitle:@"Logout failed" message:fault.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
}

@end
            </file>
          </xsl:if>
          
          
          <!--Google files-->
          <xsl:if test="$googleLogin = 'true'">
            <file  hideContent="true" name="GoogleViewController.h">
#import &lt;UIKit/UIKit.h&gt;

@interface GoogleViewController : UIViewController
@end
            </file>
            
            <file  hideContent="true" name="GoogleViewController.m">
#import "GoogleViewController.h"
#import &lt;GoogleSignIn/GoogleSignIn.h&gt;

@implementation GoogleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Google login";
    
    GIDSignInButton *signInButton = [GIDSignInButton new];
    signInButton.style = kGIDSignInButtonStyleWide;
    signInButton.center = self.view.center;
    [self.view addSubview:signInButton];
    [GIDSignIn sharedInstance].presentingViewController = self;
    
    // Automatically sign in the user.
    // [[GIDSignIn sharedInstance] restorePreviousSignIn];
}

// Use this method to logout
/*[Backendless.shared.userService logoutWithResponseHandler:^{
 [[GIDSignIn sharedInstance] signOut];
 NSLog(@"LOGGED OUT");
 } errorHandler:^(Fault *fault) {
 NSLog(@"Server reported an error: %@", fault.message);
 }];*/

@end
            </file>
          </xsl:if>
          
          <!--Twitter files-->
          <xsl:if test="$twitterLogin = 'true'">
            <file  hideContent="true" name="TwitterViewController.h">
#import &lt;UIKit/UIKit.h&gt;

@interface TwitterViewController : UIViewController
@end
            </file>
            
            <file  hideContent="true" name="TwitterViewController.m">
#import "TwitterViewController.h"
#import &lt;Backendless-Swift.h&gt;
@import TwitterKit;

@implementation TwitterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Twitter login";
    TWTRLogInButton *logInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            [Backendless.shared.userService loginWithTwitterWithAuthToken:session.authToken authTokenSecret:session.authTokenSecret fieldsMapping:@{@"email": @"email"} responseHandler:^(BackendlessUser *loggedUser) {
                [[[UIAlertView alloc] initWithTitle:@"Login succeed" message:@"You are now logged in" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            } errorHandler: ^(Fault *fault) {
                [[[UIAlertView alloc] initWithTitle:@"Twitter login failed" message:fault.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            }];
        }
        else {
            NSLog(@"Twitter login failed: %@", [error localizedDescription]);
        }
    }];
    logInButton.center = self.view.center;
    [self.view addSubview:logInButton];
}

// Use this method to logout
/*[Backendless.shared.userService logoutWithResponseHandler:^{
 NSString *userId = Twitter.sharedInstance.sessionStore.session.userID;
 if (userId) {
 [Twitter.sharedInstance.sessionStore logOutUserID:userId];
 NSLog(@"LOGGED OUT");
 }
 } errorHandler:^(Fault *fault) {
 NSLog(@"Server reported an error: %@", fault.message);
 }];*/

@end
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
		0F7A633A1E769BB6007B6B07 /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 0F7A63381E769BB6007B6B07 /* Main.storyboard */; };
		0F7A633F1E769BB6007B6B07 /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 0F7A633D1E769BB6007B6B07 /* LaunchScreen.storyboard */; };
		0F7A633C1E769BB6007B6B07 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 0F7A633B1E769BB6007B6B07 /* Assets.xcassets */; };
		0F7A63311E769BB6007B6B07 /* main.m in Sources */ = {isa = PBXBuildFile; fileRef = 0F7A63301E769BB6007B6B07 /* main.m */; };
		5E3FF4FF22893AF3006A7710 /* AppDelegate.m in Sources */ = {isa = PBXBuildFile; fileRef = 0F7A63331E769BB6007B6B07 /* AppDelegate.m */; };
		5ACEA5161EF158A50003C82E /* MainTableView.m in Sources */ = {isa = PBXBuildFile; fileRef = 5ACEA5151EF158A50003C82E /* MainTableView.m */; };

		<xsl:if test="$backendlessLogin = 'true'">
		5A7380B91EF2789000F155E6 /* RegistrationViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = 5A7380B81EF2789000F155E6 /* RegistrationViewController.m */; };
		5A7380BF1EF281EE00F155E6 /* RestorePasswordViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = 5A7380BE1EF281EE00F155E6 /* RestorePasswordViewController.m */; };		
		5ACEA51C1EF160750003C82E /* BackendlessViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = 5ACEA51B1EF160750003C82E /* BackendlessViewController.m */; };
		5ACEA51F1EF170210003C82E /* BackendlessUserViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = 5ACEA51E1EF170210003C82E /* BackendlessUserViewController.m */; };		
		</xsl:if>

		<xsl:if test="$facebookLogin = 'true'">
		5E3FF50022893B00006A7710 /* FacebookViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = 5A4ADDCE1EF2C13B00B20502 /* FacebookViewController.m */; };
		</xsl:if>

		<xsl:if test="$twitterLogin = 'true'">
		5A5AB2341EF7F9FC00CF4DA1 /* TwitterViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = 5A5AB2331EF7F9FC00CF4DA1 /* TwitterViewController.m */; };
		</xsl:if>

		<xsl:if test="$googleLogin = 'true'">
		5A208EFC1EF4241100639CA8 /* GoogleViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = 5A208EFB1EF4241100639CA8 /* GoogleViewController.m */; };
		</xsl:if>

/* End PBXBuildFile section */

/* Begin PBXFileReference section */
		0F7A632C1E769BB6007B6B07 /* <xsl:value-of select="$applicationName"/>-Login.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = "<xsl:value-of select="$applicationName"/>-Login.app"; sourceTree = BUILT_PRODUCTS_DIR; };
		0F7A63391E769BB6007B6B07 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = "&lt;group&gt;"; };
		0F7A633E1E769BB6007B6B07 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = "&lt;group&gt;"; };
		0F7A63301E769BB6007B6B07 /* main.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = main.m; sourceTree = "&lt;group&gt;"; };
		0F7A633B1E769BB6007B6B07 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "&lt;group&gt;"; };
		0F7A63401E769BB6007B6B07 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "&lt;group&gt;"; };
		0F7A63321E769BB6007B6B07 /* AppDelegate.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = AppDelegate.h; sourceTree = "&lt;group&gt;"; };
		0F7A63331E769BB6007B6B07 /* AppDelegate.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = AppDelegate.m; sourceTree = "&lt;group&gt;"; };
		5ACEA5141EF158A50003C82E /* MainTableView.h */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.h; path = MainTableView.h; sourceTree = "&lt;group&gt;"; };
		5ACEA5151EF158A50003C82E /* MainTableView.m */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.objc; path = MainTableView.m; sourceTree = "&lt;group&gt;"; };

		<xsl:if test="$backendlessLogin = 'true'">
		5A7380B71EF2789000F155E6 /* RegistrationViewController.h */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.h; path = RegistrationViewController.h; sourceTree = "&lt;group&gt;"; };
		5A7380B81EF2789000F155E6 /* RegistrationViewController.m */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.objc; path = RegistrationViewController.m; sourceTree = "&lt;group&gt;"; };
		5A7380BD1EF281EE00F155E6 /* RestorePasswordViewController.h */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.h; path = RestorePasswordViewController.h; sourceTree = "&lt;group&gt;"; };
		5A7380BE1EF281EE00F155E6 /* RestorePasswordViewController.m */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.objc; path = RestorePasswordViewController.m; sourceTree = "&lt;group&gt;"; };		
		5ACEA51A1EF160750003C82E /* BackendlessViewController.h */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.h; path = BackendlessViewController.h; sourceTree = "&lt;group&gt;"; };
		5ACEA51B1EF160750003C82E /* BackendlessViewController.m */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.objc; path = BackendlessViewController.m; sourceTree = "&lt;group&gt;"; };
		5ACEA51D1EF170210003C82E /* BackendlessUserViewController.h */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.h; path = BackendlessUserViewController.h; sourceTree = "&lt;group&gt;"; };
		5ACEA51E1EF170210003C82E /* BackendlessUserViewController.m */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.objc; path = BackendlessUserViewController.m; sourceTree = "&lt;group&gt;"; };
		</xsl:if>

		<xsl:if test="$facebookLogin = 'true'">
		5A4ADDCD1EF2C13B00B20502 /* FacebookViewController.h */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.h; path = FacebookViewController.h; sourceTree = "&lt;group&gt;"; };
		5A4ADDCE1EF2C13B00B20502 /* FacebookViewController.m */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.objc; path = FacebookViewController.m; sourceTree = "&lt;group&gt;"; };
		</xsl:if>

		<xsl:if test="$twitterLogin = 'true'">
		5A5AB2321EF7F9FC00CF4DA1 /* TwitterViewController.h */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.h; path = TwitterViewController.h; sourceTree = "&lt;group&gt;"; };
		5A5AB2331EF7F9FC00CF4DA1 /* TwitterViewController.m */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.objc; path = TwitterViewController.m; sourceTree = "&lt;group&gt;"; };
		</xsl:if>

		<xsl:if test="$googleLogin = 'true'">
		5A208EFA1EF4241100639CA8 /* GoogleViewController.h */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.h; path = GoogleViewController.h; sourceTree = "&lt;group&gt;"; };
		5A208EFB1EF4241100639CA8 /* GoogleViewController.m */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.objc; path = GoogleViewController.m; sourceTree = "&lt;group&gt;"; };	
		</xsl:if>	

/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
		0F7A63291E769BB6007B6B07 /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
		0F7A63231E769BB6007B6B07 = {
			isa = PBXGroup;
			children = (
				0F7A632E1E769BB6007B6B07 /* <xsl:value-of select="$applicationName"/>-Login */,
				0F7A632D1E769BB6007B6B07 /* Products */,
				C2D23A30BB2CC4290CE118BF /* Frameworks */,
			);
			sourceTree = "&lt;group&gt;";
		};
		0F7A632D1E769BB6007B6B07 /* Products */ = {
			isa = PBXGroup;
			children = (
				0F7A632C1E769BB6007B6B07 /* <xsl:value-of select="$applicationName"/>-Login.app */,
			);
			name = Products;
			sourceTree = "&lt;group&gt;";
		};
		0F7A632E1E769BB6007B6B07 /* <xsl:value-of select="$applicationName"/>-Login */ = {
			isa = PBXGroup;
			children = (
				0F7A63381E769BB6007B6B07 /* Main.storyboard */,
				0F7A633D1E769BB6007B6B07 /* LaunchScreen.storyboard */,
				0F7A633B1E769BB6007B6B07 /* Assets.xcassets */,
				0F7A63401E769BB6007B6B07 /* Info.plist */,
				0F7A632F1E769BB6007B6B07 /* Supporting Files */,
				0F7A63301E769BB6007B6B07 /* main.m */,
				0F7A63321E769BB6007B6B07 /* AppDelegate.h */,
				0F7A63331E769BB6007B6B07 /* AppDelegate.m */,
				5ACEA5141EF158A50003C82E /* MainTableView.h */,
				5ACEA5151EF158A50003C82E /* MainTableView.m */,

				<xsl:if test="$backendlessLogin = 'true'">				
				5ACEA51A1EF160750003C82E /* BackendlessViewController.h */,
				5ACEA51B1EF160750003C82E /* BackendlessViewController.m */,
				5ACEA51D1EF170210003C82E /* BackendlessUserViewController.h */,
				5ACEA51E1EF170210003C82E /* BackendlessUserViewController.m */,
				5A7380B71EF2789000F155E6 /* RegistrationViewController.h */,
				5A7380B81EF2789000F155E6 /* RegistrationViewController.m */,
				5A7380BD1EF281EE00F155E6 /* RestorePasswordViewController.h */,
				5A7380BE1EF281EE00F155E6 /* RestorePasswordViewController.m */,
				</xsl:if>

				<xsl:if test="$facebookLogin = 'true'">
				5A4ADDCD1EF2C13B00B20502 /* FacebookViewController.h */,
				5A4ADDCE1EF2C13B00B20502 /* FacebookViewController.m */,
				</xsl:if>

				<xsl:if test="$twitterLogin = 'true'">
				5A5AB2321EF7F9FC00CF4DA1 /* TwitterViewController.h */,
				5A5AB2331EF7F9FC00CF4DA1 /* TwitterViewController.m */,
				</xsl:if>

				<xsl:if test="$googleLogin = 'true'">
				5A208EFA1EF4241100639CA8 /* GoogleViewController.h */,
				5A208EFB1EF4241100639CA8 /* GoogleViewController.m */,
				</xsl:if>
			);
			path = "<xsl:value-of select="$applicationName"/>-Login";
			sourceTree = "&lt;group&gt;";
		};
		0F7A632F1E769BB6007B6B07 /* Supporting Files */ = {
			isa = PBXGroup;
			children = (
			);
			name = "Supporting Files";
			sourceTree = "&lt;group&gt;";
		};
		C2D23A30BB2CC4290CE118BF /* Frameworks */ = {
			isa = PBXGroup;
			name = Frameworks;
			sourceTree = "&lt;group&gt;";
		};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		0F7A632B1E769BB6007B6B07 /* <xsl:value-of select="$applicationName"/>-Login */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = 0F7A63431E769BB6007B6B07 /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$applicationName"/>-Login" */;
			buildPhases = (
				0F7A63281E769BB6007B6B07 /* Sources */,
				0F7A63291E769BB6007B6B07 /* Frameworks */,
				0F7A632A1E769BB6007B6B07 /* Resources */,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = "<xsl:value-of select="$applicationName"/>-Login";
			productName = "<xsl:value-of select="$applicationName"/>-Login";
			productReference = 0F7A632C1E769BB6007B6B07 /* <xsl:value-of select="$applicationName"/>-Login.app */;
			productType = "com.apple.product-type.application";
		};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		0F7A63241E769BB6007B6B07 /* Project object */ = {
			isa = PBXProject;
			attributes = {
				LastUpgradeCheck = 1020;
				TargetAttributes = {
					0F7A632B1E769BB6007B6B07 = {
						CreatedOnToolsVersion = 8.2.1;
						ProvisioningStyle = Automatic;
					};
				};
			};
			buildConfigurationList = 0F7A63271E769BB6007B6B07 /* Build configuration list for PBXProject "<xsl:value-of select="$applicationName"/>-Login" */;
			compatibilityVersion = "Xcode 3.2";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				Base,
			);
			mainGroup = 0F7A63231E769BB6007B6B07;
			productRefGroup = 0F7A632D1E769BB6007B6B07 /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				0F7A632B1E769BB6007B6B07 /* <xsl:value-of select="$applicationName"/>-Login */,
			);
		};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
		0F7A632A1E769BB6007B6B07 /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				0F7A633A1E769BB6007B6B07 /* Main.storyboard in Resources */,
				0F7A633F1E769BB6007B6B07 /* LaunchScreen.storyboard in Resources */,
				0F7A633C1E769BB6007B6B07 /* Assets.xcassets in Resources */,				
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
		0F7A63281E769BB6007B6B07 /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (				
				0F7A63311E769BB6007B6B07 /* main.m in Sources */,
				5E3FF4FF22893AF3006A7710 /* AppDelegate.m in Sources */,				
				5ACEA5161EF158A50003C82E /* MainTableView.m in Sources */,

				<xsl:if test="$backendlessLogin = 'true'">
				5A7380BF1EF281EE00F155E6 /* RestorePasswordViewController.m in Sources */,
				5ACEA51C1EF160750003C82E /* BackendlessViewController.m in Sources */,
				5A7380B91EF2789000F155E6 /* RegistrationViewController.m in Sources */,
				5ACEA51F1EF170210003C82E /* BackendlessUserViewController.m in Sources */,
				</xsl:if>

				<xsl:if test="$facebookLogin = 'true'">
				5E3FF50022893B00006A7710 /* FacebookViewController.m in Sources */,
				</xsl:if>

				<xsl:if test="$twitterLogin = 'true'">
				5A5AB2341EF7F9FC00CF4DA1 /* TwitterViewController.m in Sources */,
				</xsl:if>
				
				<xsl:if test="$googleLogin = 'true'">
				5A208EFC1EF4241100639CA8 /* GoogleViewController.m in Sources */,
				</xsl:if>
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXSourcesBuildPhase section */

/* Begin PBXVariantGroup section */
		0F7A63381E769BB6007B6B07 /* Main.storyboard */ = {
			isa = PBXVariantGroup;
			children = (
				0F7A63391E769BB6007B6B07 /* Base */,
			);
			name = Main.storyboard;
			sourceTree = "&lt;group&gt;";
		};
		0F7A633D1E769BB6007B6B07 /* LaunchScreen.storyboard */ = {
			isa = PBXVariantGroup;
			children = (
				0F7A633E1E769BB6007B6B07 /* Base */,
			);
			name = LaunchScreen.storyboard;
			sourceTree = "&lt;group&gt;";
		};
/* End PBXVariantGroup section */

/* Begin XCBuildConfiguration section */
		0F7A63411E769BB6007B6B07 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				CLANG_ANALYZER_LOCALIZABILITY_NONLOCALIZED = YES;
				CLANG_ANALYZER_NONNULL = YES;
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
			};
			name = Debug;
		};
		0F7A63421E769BB6007B6B07 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				CLANG_ANALYZER_LOCALIZABILITY_NONLOCALIZED = YES;
				CLANG_ANALYZER_NONNULL = YES;
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
				VALIDATE_PRODUCT = YES;
			};
			name = Release;
		};
		0F7A63441E769BB6007B6B07 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				FRAMEWORK_SEARCH_PATHS = "$(inherited)";
				INFOPLIST_FILE = "<xsl:value-of select="$applicationName"/>-Login/Info.plist";
				LD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
				PRODUCT_BUNDLE_IDENTIFIER = "com.backendless.codegen.<xsl:value-of select="$applicationName"/>-Login";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_VERSION = 4.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Debug;
		};
		0F7A63451E769BB6007B6B07 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				FRAMEWORK_SEARCH_PATHS = "$(inherited)";
				INFOPLIST_FILE = "<xsl:value-of select="$applicationName"/>-Login/Info.plist";
				LD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
				PRODUCT_BUNDLE_IDENTIFIER = "com.backendless.codegen.<xsl:value-of select="$applicationName"/>-Login";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_VERSION = 4.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Release;
		};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
		0F7A63271E769BB6007B6B07 /* Build configuration list for PBXProject "<xsl:value-of select="$applicationName"/>-Login" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				0F7A63411E769BB6007B6B07 /* Debug */,
				0F7A63421E769BB6007B6B07 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		0F7A63431E769BB6007B6B07 /* Build configuration list for PBXNativeTarget "<xsl:value-of select="$applicationName"/>-Login" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				0F7A63441E769BB6007B6B07 /* Debug */,
				0F7A63451E769BB6007B6B07 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
/* End XCConfigurationList section */
	};
	rootObject = 0F7A63241E769BB6007B6B07 /* Project object */;
}
          </file>
        </folder>
      </folder>
    </xsl:template>
</xsl:stylesheet>