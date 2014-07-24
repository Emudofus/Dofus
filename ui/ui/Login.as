package ui
{
   import d2api.SystemApi;
   import d2api.ConfigApi;
   import d2api.UiApi;
   import d2api.SoundApi;
   import d2api.ConnectionApi;
   import d2components.Input;
   import d2components.Label;
   import d2components.ButtonContainer;
   import d2components.Texture;
   import d2components.StateContainer;
   import d2components.GraphicContainer;
   import d2components.InputComboBox;
   import d2components.ComboBox;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import d2enums.ComponentHookList;
   import d2hooks.*;
   import d2actions.*;
   import flash.utils.*;
   import flash.ui.Keyboard;
   import flash.events.TimerEvent;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   import d2enums.BuildTypeEnum;
   
   public class Login extends Object
   {
      
      public function Login() {
         this._componentsList = new Dictionary(true);
         this._delayTimer = new Timer(this._timerDelay,0);
         super();
      }
      
      public var output:Object;
      
      public var sysApi:SystemApi;
      
      public var configApi:ConfigApi;
      
      public var uiApi:UiApi;
      
      public var modCommon:Object;
      
      public var soundApi:SoundApi;
      
      public var connectionApi:ConnectionApi;
      
      private var _giftsList:Array;
      
      private var _currentGift:uint;
      
      private var _aPorts:Array;
      
      private var _aPortsName:Array;
      
      private var _componentsList:Dictionary;
      
      private var _previousFocus:Input;
      
      private var timeoutPopupName:String;
      
      public var lbl_capsLock:Label;
      
      public var btn_play:ButtonContainer;
      
      public var btn_rememberLogin:ButtonContainer;
      
      public var btn_passForgotten:ButtonContainer;
      
      public var btn_createAccount:ButtonContainer;
      
      public var btn_options:ButtonContainer;
      
      public var btn_manualConnection:ButtonContainer;
      
      public var btn_serverConnection:ButtonContainer;
      
      public var btn_characterConnection:ButtonContainer;
      
      public var btn_leftArrow:ButtonContainer;
      
      public var btn_rightArrow:ButtonContainer;
      
      public var btn_gift0:ButtonContainer;
      
      public var btn_gift1:ButtonContainer;
      
      public var btn_gift2:ButtonContainer;
      
      public var btn_gift3:ButtonContainer;
      
      public var btn_members:ButtonContainer;
      
      public var btn_lowa:ButtonContainer;
      
      public var bgTexturebtn_gift0:Texture;
      
      public var bgTexturebtn_gift1:Texture;
      
      public var bgTexturebtn_gift2:Texture;
      
      public var bgTexturebtn_gift3:Texture;
      
      public var ctr_inputs:StateContainer;
      
      public var ctr_socket:GraphicContainer;
      
      public var ctr_gifts:GraphicContainer;
      
      public var cbx_login:InputComboBox;
      
      public var input_pass:Input;
      
      public var tx_logo:Texture;
      
      public var tx_background:Texture;
      
      public var tx_capsLockMsg:Texture;
      
      public var tx_socketBg:Texture;
      
      public var cb_socket:ComboBox;
      
      public var verMaj:Object;
      
      private var _delayTimer:Timer;
      
      private var _timerDelay:int = 1000;
      
      private var _animedGift:Array;
      
      private var _giftIndex:int = 0;
      
      public function main(popup:String = null) : void {
         var porc:String = null;
         var serverport:uint = 0;
         var lastLogins:Array = null;
         var deprecatedLogin:String = null;
         var logins:Array = null;
         this.cbx_login.input.tabEnabled = true;
         this.input_pass.tabEnabled = true;
         this.btn_play.soundId = "-1";
         this.btn_leftArrow.soundId = SoundEnum.SCROLL_DOWN;
         this.btn_rightArrow.soundId = SoundEnum.SCROLL_UP;
         this.soundApi.playIntroMusic();
         this.sysApi.addHook(NicknameRegistration,this.onNicknameRegistration);
         this.sysApi.addHook(SubscribersList,this.onSubscribersList);
         this.sysApi.addHook(UiUnloaded,this.onUiUnloaded);
         this.sysApi.addHook(SelectedServerFailed,this.onSelectedServerFailed);
         this.sysApi.addHook(ConfigPropertyChange,this.onQualityChange);
         this.sysApi.addHook(KeyUp,this.onKeyUp);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addComponentHook(this.btn_rememberLogin,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_rememberLogin,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_rememberLogin,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_manualConnection,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_manualConnection,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_serverConnection,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_serverConnection,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_characterConnection,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_characterConnection,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.cbx_login,ComponentHookList.ON_SELECT_ITEM);
         this._giftsList = new Array();
         this.sysApi.sendAction(new SubscribersGiftListRequest());
         this.ctr_gifts.visible = false;
         this.bgTexturebtn_gift0.useCache = false;
         this.bgTexturebtn_gift1.useCache = false;
         this.bgTexturebtn_gift2.useCache = false;
         this.bgTexturebtn_gift3.useCache = false;
         this.stopGiftAnimation();
         if(this.sysApi.getOption("dofusQuality","dofus") >= 1)
         {
            this.startGiftAnimation();
         }
         this.ctr_socket.visible = false;
         var cachePortIsStillOk:Boolean = false;
         var cachePort:int = this.sysApi.getPort();
         this._aPorts = new Array();
         this._aPortsName = new Array();
         var ports:String = this.sysApi.getConfigKey("connection.port");
         for each(porc in ports.split(","))
         {
            this._aPorts.push(int(porc));
            this._aPortsName.push(this.uiApi.getText("ui.connection.serverPort",porc));
            if(cachePort == int(porc))
            {
               cachePortIsStillOk = true;
            }
         }
         this.cb_socket.dataProvider = this._aPortsName;
         if((cachePort) && (cachePortIsStillOk))
         {
            serverport = cachePort;
         }
         else
         {
            serverport = this._aPorts[0];
            this.sysApi.setPort(this._aPorts[0]);
         }
         this.cb_socket.value = this._aPortsName[this._aPorts.indexOf(serverport)];
         var logoUrl:String = this.sysApi.getConfigEntry("config.content.path") + "/gfx/illusUi/logo_dofus.swf|";
         switch(this.sysApi.getCurrentLanguage())
         {
            case "ja":
               logoUrl = logoUrl + "tx_logo_JP";
               break;
            case "ru":
               logoUrl = logoUrl + "tx_logo_RU";
               this.tx_background.uri = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "login_tx_background_russe");
               break;
            case "fr":
            default:
               logoUrl = logoUrl + "tx_logo_FR";
         }
         this.tx_logo.uri = this.uiApi.createUri(logoUrl);
         this.cbx_login.input.restrict = "A-Za-z0-9\\-\\|.@_";
         var autoConnectType:uint = this.configApi.getConfigProperty("dofus","autoConnectType");
         if(autoConnectType == 0)
         {
            this.uiApi.setRadioGroupSelectedItem("btnConnectionGroup",this.btn_manualConnection,this.uiApi.me());
         }
         else if(autoConnectType == 1)
         {
            this.uiApi.setRadioGroupSelectedItem("btnConnectionGroup",this.btn_serverConnection,this.uiApi.me());
         }
         else if(autoConnectType == 2)
         {
            this.uiApi.setRadioGroupSelectedItem("btnConnectionGroup",this.btn_characterConnection,this.uiApi.me());
         }
         
         
         if(this.sysApi.isEventMode())
         {
            this.uiApi.setFullScreen(true,true);
            this.cbx_login.input.text = this.uiApi.getText("ui.connection.eventModeLogin");
            this.input_pass.text = "**********";
            this.cbx_login.disabled = true;
            this.input_pass.disabled = true;
            this.ctr_inputs.state = "DISABLED";
            this.btn_rememberLogin.disabled = true;
            this.btn_rememberLogin.mouseEnabled = false;
            this.btn_manualConnection.disabled = true;
            this.btn_serverConnection.disabled = true;
            this.btn_characterConnection.disabled = true;
         }
         else
         {
            if((this.sysApi.getConfigKey("boo") == "1") && (this.sysApi.getBuildType() > 1))
            {
               this.input_pass.text = this.sysApi.getData("LastPassword")?this.sysApi.getData("LastPassword"):"";
            }
            Connection.loginMustBeSaved = this.sysApi.getData("saveLogin");
            this.btn_rememberLogin.selected = Connection.loginMustBeSaved;
            lastLogins = this.sysApi.getData("LastLogins");
            if((lastLogins) && (lastLogins.length > 0))
            {
               this.cbx_login.input.text = lastLogins[0];
               this.cbx_login.dataProvider = lastLogins;
               this.input_pass.focus();
            }
            else
            {
               deprecatedLogin = this.sysApi.getData("LastLogin");
               if((deprecatedLogin) && (deprecatedLogin.length > 0))
               {
                  this.sysApi.setData("LastLogin","");
                  logins = new Array();
                  logins.push(deprecatedLogin);
                  this.sysApi.setData("LastLogins",logins);
                  this.sysApi.setData("saveLogin",true);
                  Connection.loginMustBeSaved = true;
                  this.btn_rememberLogin.selected = true;
                  this.cbx_login.input.text = deprecatedLogin;
                  this.cbx_login.dataProvider = logins;
                  this.input_pass.focus();
               }
               else
               {
                  this.cbx_login.input.focus();
               }
            }
         }
         if(popup == "unexpectedSocketClosure")
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.unexpectedSocketClosure"),this.uiApi.getText("ui.popup.unexpectedSocketClosure.text"),[this.uiApi.getText("ui.common.ok")]);
         }
         this.lbl_capsLock.multiline = false;
         this.lbl_capsLock.wordWrap = false;
         this.lbl_capsLock.fullWidth();
         this.tx_capsLockMsg.width = this.lbl_capsLock.textfield.width + 12;
         if((!Keyboard.capsLock) || (this.sysApi.getOs() == "Mac OS"))
         {
            this.lbl_capsLock.visible = false;
            this.tx_capsLockMsg.visible = false;
         }
         this.sysApi.dispatchHook(QualitySelectionRequired);
      }
      
      public function unload() : void {
         if(this.sysApi.getOption("dofusQuality","dofus") == 1)
         {
            this._delayTimer.removeEventListener(TimerEvent.TIMER,this.timerCallback);
         }
         this.uiApi.hideTooltip();
         this.uiApi.unloadUi(this.timeoutPopupName);
      }
      
      public function disableUi(disable:Boolean) : void {
         this.cbx_login.input.mouseEnabled = !disable;
         this.cbx_login.input.mouseChildren = !disable;
         this.input_pass.mouseEnabled = !disable;
         this.input_pass.mouseChildren = !disable;
         if(disable)
         {
            this.ctr_inputs.state = "DISABLED";
            if(this.cbx_login.input.haveFocus)
            {
               this._previousFocus = this.cbx_login.input;
            }
            else if(this.input_pass.haveFocus)
            {
               this._previousFocus = this.input_pass;
            }
            
            this.btn_play.focus();
         }
         else
         {
            this.ctr_inputs.state = "NORMAL";
            if(this._previousFocus)
            {
               this._previousFocus.focus();
               this._previousFocus = null;
            }
         }
         this.btn_play.disabled = disable;
         this.btn_rememberLogin.disabled = disable;
         this.btn_rememberLogin.mouseEnabled = !disable;
         this.cbx_login.disabled = disable;
         this.btn_manualConnection.disabled = disable;
         this.btn_serverConnection.disabled = disable;
         this.btn_characterConnection.disabled = disable;
      }
      
      public function updateLoginLine(data:*, componentsRef:*, selected:Boolean) : void {
         if(!this._componentsList[componentsRef.btn_removeLogin.name])
         {
            this.uiApi.addComponentHook(componentsRef.btn_removeLogin,"onRelease");
            this.uiApi.addComponentHook(componentsRef.btn_removeLogin,"onRollOut");
            this.uiApi.addComponentHook(componentsRef.btn_removeLogin,"onRollOver");
         }
         this._componentsList[componentsRef.btn_removeLogin.name] = data;
         if(data)
         {
            componentsRef.lbl_loginName.text = data;
            componentsRef.btn_removeLogin.visible = true;
            if(selected)
            {
               componentsRef.btn_login.selected = true;
            }
            else
            {
               componentsRef.btn_login.selected = false;
            }
         }
         else
         {
            componentsRef.lbl_loginName.text = "";
            componentsRef.btn_removeLogin.visible = false;
            componentsRef.btn_login.selected = false;
         }
      }
      
      private function login() : void {
         var username:String = null;
         var usernameLength:uint = 0;
         var i:uint = 0;
         this.soundApi.playSound(SoundTypeEnum.OK_BUTTON);
         var sLogin:String = this.cbx_login.input.text;
         var sPass:String = this.input_pass.text;
         if((sLogin.length == 0) || (sPass.length == 0))
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"),this.uiApi.getText("ui.popup.accessDenied.wrongCredentials"),[this.uiApi.getText("ui.common.ok")],[]);
            this.disableUi(false);
         }
         else
         {
            if((this.sysApi.getConfigKey("boo") == "1") && (this.sysApi.getBuildType() > BuildTypeEnum.BETA))
            {
               this.sysApi.setData("LastPassword",sPass);
            }
            else
            {
               this.sysApi.setData("LastPassword",null);
            }
            if(this.sysApi.isEventMode())
            {
               username = this.sysApi.getData("EventModeLogins");
               if((!username) || (username.length == 0))
               {
                  username = "$";
                  usernameLength = 10 + Math.random() * 10;
                  i = 0;
                  while(i < usernameLength)
                  {
                     username = username + String.fromCharCode(Math.floor(97 + Math.random() * 26));
                     i++;
                  }
                  this.sysApi.setData("EventModeLogins",username);
               }
               this.sysApi.sendAction(new LoginValidation(username,"pass",true));
            }
            else
            {
               if(this.btn_characterConnection.selected)
               {
                  this.connectionApi.allowAutoConnectCharacter(true);
               }
               this.sysApi.sendAction(new LoginValidation(sLogin,sPass,(this.btn_serverConnection.selected) || (this.btn_characterConnection.selected)));
            }
         }
      }
      
      private function displayGifts() : void {
         if(this._giftsList[this._currentGift])
         {
            this.bgTexturebtn_gift0.uri = this.uiApi.createUri(this.uiApi.me().getConstant("gifts_uri") + this._giftsList[this._currentGift].uri);
         }
         else
         {
            this.bgTexturebtn_gift0.uri = null;
         }
         if(this._giftsList[this._currentGift + 1])
         {
            this.bgTexturebtn_gift1.uri = this.uiApi.createUri(this.uiApi.me().getConstant("gifts_uri") + this._giftsList[this._currentGift + 1].uri);
         }
         else
         {
            this.bgTexturebtn_gift1.uri = null;
         }
         if(this._giftsList[this._currentGift + 2])
         {
            this.bgTexturebtn_gift2.uri = this.uiApi.createUri(this.uiApi.me().getConstant("gifts_uri") + this._giftsList[this._currentGift + 2].uri);
         }
         else
         {
            this.bgTexturebtn_gift2.uri = null;
         }
         if(this._giftsList[this._currentGift + 3])
         {
            this.bgTexturebtn_gift3.uri = this.uiApi.createUri(this.uiApi.me().getConstant("gifts_uri") + this._giftsList[this._currentGift + 3].uri);
         }
         else
         {
            this.bgTexturebtn_gift3.uri = null;
         }
         if(!this._giftsList[this._currentGift + 4])
         {
            this.btn_rightArrow.disabled = true;
         }
         else
         {
            this.btn_rightArrow.disabled = false;
         }
         if(!this._giftsList[this._currentGift - 1])
         {
            this.btn_leftArrow.disabled = true;
         }
         else
         {
            this.btn_leftArrow.disabled = false;
         }
         this.stopGiftAnimation();
         this.startGiftAnimation();
      }
      
      private function randomSort(a:*, b:*) : Number {
         if(Math.random() < 0.5)
         {
            return -1;
         }
         return 1;
      }
      
      private function stopGiftAnimation() : void {
         this._delayTimer.stop();
         this.bgTexturebtn_gift0.disableAnimation = true;
         this.bgTexturebtn_gift1.disableAnimation = true;
         this.bgTexturebtn_gift2.disableAnimation = true;
         this.bgTexturebtn_gift3.disableAnimation = true;
      }
      
      private function startGiftAnimation() : void {
         this._animedGift = new Array(0,1,2,3);
         this._animedGift.sort(this.randomSort);
         this._delayTimer.reset();
         this._delayTimer.addEventListener(TimerEvent.TIMER,this.timerCallback);
         this.timerCallback(new TimerEvent("",false));
         this._delayTimer.start();
      }
      
      public function onRelease(target:Object) : void {
         var loginToDelete:String = null;
         var oldLogins:Array = null;
         var logins:Array = null;
         var oldLog:String = null;
         switch(target)
         {
            case this.btn_play:
               if(!this.btn_play.disabled)
               {
                  this._delayTimer.stop();
                  this.disableUi(true);
                  this.login();
               }
               break;
            case this.btn_rememberLogin:
               Connection.loginMustBeSaved = this.btn_rememberLogin.selected;
               this.sysApi.setData("saveLogin",this.btn_rememberLogin.selected);
               break;
            case this.btn_passForgotten:
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.findPassword"));
               break;
            case this.btn_createAccount:
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.createAccount"));
               break;
            case this.btn_manualConnection:
               if(this.btn_manualConnection.selected)
               {
                  this.configApi.setConfigProperty("dofus","autoConnectType",0);
               }
               break;
            case this.btn_serverConnection:
               if(this.btn_serverConnection.selected)
               {
                  this.configApi.setConfigProperty("dofus","autoConnectType",1);
               }
               break;
            case this.btn_characterConnection:
               if(this.btn_characterConnection.selected)
               {
                  this.configApi.setConfigProperty("dofus","autoConnectType",2);
               }
               break;
            case this.btn_options:
               if(this.ctr_socket.visible)
               {
                  this.ctr_socket.visible = false;
               }
               else
               {
                  this.ctr_socket.visible = true;
               }
               break;
            case this.btn_leftArrow:
               if(this._giftsList[this._currentGift - 4])
               {
                  this._currentGift = this._currentGift - 4;
                  this.displayGifts();
               }
               break;
            case this.btn_rightArrow:
               if(this._giftsList[this._currentGift + 4])
               {
                  this._currentGift = this._currentGift + 4;
                  this.displayGifts();
               }
               break;
            case this.btn_gift0:
               this.sysApi.goToUrl(this._giftsList[this._currentGift].link);
               break;
            case this.btn_gift1:
               if(this._giftsList[this._currentGift + 1])
               {
                  this.sysApi.goToUrl(this._giftsList[this._currentGift + 1].link);
               }
               break;
            case this.btn_gift2:
               if(this._giftsList[this._currentGift + 2])
               {
                  this.sysApi.goToUrl(this._giftsList[this._currentGift + 2].link);
               }
               break;
            case this.btn_gift3:
               if(this._giftsList[this._currentGift + 3])
               {
                  this.sysApi.goToUrl(this._giftsList[this._currentGift + 3].link);
               }
               break;
            case this.btn_members:
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.members"));
               break;
            case this.btn_lowa:
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.lowa"));
               break;
            default:
               if(target.name.indexOf("btn_removeLogin") != -1)
               {
                  loginToDelete = this._componentsList[target.name];
                  oldLogins = this.sysApi.getData("LastLogins");
                  logins = new Array();
                  for each(oldLog in oldLogins)
                  {
                     if(oldLog != loginToDelete)
                     {
                        logins.push(oldLog);
                     }
                  }
                  this.sysApi.setData("LastLogins",logins);
                  this.cbx_login.dataProvider = logins;
                  this.cbx_login.selectedIndex = 0;
               }
         }
      }
      
      public function onRollOver(target:Object) : void {
         var tooltipText:String = null;
         switch(target)
         {
            case this.btn_manualConnection:
               tooltipText = this.uiApi.getText("ui.connection.connectionTypeManual");
               break;
            case this.btn_serverConnection:
               tooltipText = this.uiApi.getText("ui.connection.connectionTypeServer");
               break;
            case this.btn_characterConnection:
               tooltipText = this.uiApi.getText("ui.connection.connectionTypeCharacter");
               break;
            case this.btn_rememberLogin:
               tooltipText = this.uiApi.getText("ui.connection.rememberLogin.info");
               break;
            case this.btn_gift0:
               tooltipText = this._giftsList[this._currentGift].description;
               break;
            case this.btn_gift1:
               if(this._giftsList[this._currentGift + 1])
               {
                  tooltipText = this._giftsList[this._currentGift + 1].description;
               }
               break;
            case this.btn_gift2:
               if(this._giftsList[this._currentGift + 2])
               {
                  tooltipText = this._giftsList[this._currentGift + 2].description;
               }
               break;
            case this.btn_gift3:
               if(this._giftsList[this._currentGift + 3])
               {
                  tooltipText = this._giftsList[this._currentGift + 3].description;
               }
               break;
            default:
               if(target.name.indexOf("btn_removeLogin") != -1)
               {
                  tooltipText = this.uiApi.getText("ui.login.deleteLogin");
                  this.cbx_login.closeOnClick = false;
               }
         }
         if((tooltipText) && (tooltipText.length > 1))
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",6,1,0,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
         if(target.name.indexOf("btn_removeLogin") != -1)
         {
            this.cbx_login.closeOnClick = true;
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         switch(target)
         {
            case this.cb_socket:
               this.sysApi.setPort(this._aPorts[this.cb_socket.selectedIndex]);
               break;
         }
      }
      
      public function onShortcut(s:String) : Boolean {
         switch(s)
         {
            case "validUi":
               if(!this.btn_play.disabled)
               {
                  this._delayTimer.stop();
                  this.disableUi(true);
                  this.login();
                  return true;
               }
               break;
         }
         return false;
      }
      
      private function onNicknameRegistration() : void {
         this.disableUi(true);
         this.uiApi.loadUi("pseudoChoice");
      }
      
      private function onUiUnloaded(name:String) : void {
         if((name.indexOf("popup") == 0) && (this._previousFocus))
         {
            this._previousFocus.focus();
            this._previousFocus = null;
         }
      }
      
      private function onSubscribersList(giftsList:Object) : void {
         var gift:* = undefined;
         this.ctr_gifts.visible = true;
         this._giftsList = [];
         for each(gift in giftsList)
         {
            this._giftsList.push(gift);
         }
         this._currentGift = 0;
         this.btn_leftArrow.disabled = true;
         this.displayGifts();
      }
      
      public function onSelectedServerFailed() : void {
         this.disableUi(false);
      }
      
      public function onQualityChange(target:String, name:String, value:*, oldValue:*) : void {
         if((target == "dofus") && (name == "dofusQuality"))
         {
            if(value as uint == 0)
            {
               this.stopGiftAnimation();
            }
            else if(oldValue as uint == 0)
            {
               this.startGiftAnimation();
            }
            
         }
      }
      
      public function onKeyUp(target:Object, keyCode:uint) : void {
         if(keyCode == 9)
         {
            if(this.cbx_login.input.haveFocus)
            {
               this.input_pass.focus();
               this.input_pass.setSelection(0,this.input_pass.text.length);
            }
            else if(this.input_pass.haveFocus)
            {
               this.cbx_login.input.focus();
               this.cbx_login.input.setSelection(0,this.cbx_login.input.text.length);
            }
            
         }
         else if(keyCode == 20)
         {
            if(Keyboard.capsLock)
            {
               this.tx_capsLockMsg.visible = true;
               this.lbl_capsLock.visible = true;
            }
            else
            {
               this.tx_capsLockMsg.visible = false;
               this.lbl_capsLock.visible = false;
            }
         }
         
      }
      
      public function timerCallback(e:TimerEvent) : void {
         var toStop:* = 0;
         if(this._giftIndex == 0)
         {
            toStop = 3;
         }
         else
         {
            toStop = this._giftIndex - 1;
         }
         if(!this["bgTexturebtn_gift" + this._animedGift[toStop]])
         {
            return;
         }
         this["bgTexturebtn_gift" + this._animedGift[toStop]].gotoAndStop = 1;
         this["bgTexturebtn_gift" + this._animedGift[toStop]].disableAnimation = true;
         var duration:uint = 0;
         duration = this["bgTexturebtn_gift" + this._animedGift[this._giftIndex]].getChildDuration();
         if(duration > 0)
         {
            this["bgTexturebtn_gift" + this._animedGift[this._giftIndex]].disableAnimation = false;
            this["bgTexturebtn_gift" + this._animedGift[this._giftIndex]].gotoAndPayChild(1);
            this._delayTimer.reset();
            this._delayTimer.delay = duration / 50 * 1000;
            this._delayTimer.start();
         }
         if(this._giftIndex == 3)
         {
            this._giftIndex = 0;
         }
         else
         {
            this._giftIndex++;
         }
      }
   }
}
