package com.ankamagames.dofus.externalnotification
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import flash.display.NativeWindow;
   import flash.display.NativeWindowInitOptions;
   import com.ankamagames.jerakine.types.DataStoreType;
   import flash.net.LocalConnection;
   import flash.utils.Timer;
   import com.ankamagames.dofus.datacenter.externalnotifications.ExternalNotification;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationTypeEnum;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationPositionEnum;
   import by.blooddy.crypto.MD5;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.events.TimerEvent;
   import flash.display.NativeWindowSystemChrome;
   import flash.display.NativeWindowType;
   import flash.utils.describeType;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.Event;
   import flash.events.NativeWindowDisplayStateEvent;
   import flash.system.Capabilities;
   import flash.events.KeyboardEvent;
   import flash.utils.setTimeout;
   import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationModeEnum;
   import flash.utils.clearTimeout;
   import flash.events.MouseEvent;
   import flash.display.NativeWindowDisplayState;
   import flash.desktop.NativeApplication;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import flash.events.AsyncErrorEvent;
   import flash.events.StatusEvent;
   import flash.events.SecurityErrorEvent;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.jerakine.json.JSON;
   import com.ankamagames.berilia.types.data.Hook;
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import flash.geom.Rectangle;
   
   public class ExternalNotificationManager extends Object
   {
      
      public function ExternalNotificationManager(pc:PrivateClass) {
         super();
      }
      
      private static const DEBUG:Boolean = false;
      
      private static const _log:Logger;
      
      private static var _instance:ExternalNotificationManager;
      
      public static function getInstance() : ExternalNotificationManager {
         if(!_instance)
         {
            _instance = new ExternalNotificationManager(new PrivateClass());
         }
         return _instance;
      }
      
      private var _initialized:Boolean;
      
      private var _notificationsList:Vector.<ExternalNotificationWindow>;
      
      private var _notificationsOptions:Dictionary;
      
      private var _notificationsEnabled:Boolean;
      
      private var _clientWindow:NativeWindow;
      
      private var _showMode:int;
      
      private var _notificationsPosition:int = -1;
      
      private var _maxNotifications:int;
      
      private var _timeoutDuration:Number;
      
      private var _startCoordinatesY:Number;
      
      private var _startCoordinatesX:Number;
      
      private var _nativeWinOpts:NativeWindowInitOptions;
      
      private var _dataStoreType:DataStoreType;
      
      private var _optionChangedFromOtherClient:Boolean;
      
      private const NOTIFICATION_SPACING:Number = 10;
      
      private var _nbGeneralEvents:int;
      
      private const MODULE_NAME:String = "Ankama_GameUiCore";
      
      private const UI_NAME:String = "externalnotification";
      
      private const CONNECTION_ID:String = "_externalNotifications";
      
      private var _clientId:String;
      
      private var _isMaster:Boolean;
      
      private var _masterConnection:LocalConnection;
      
      private var _slaveConnection:LocalConnection;
      
      private var _slavesIds:Array;
      
      private var dofusHasFocus:Boolean;
      
      private const WINDOWS_KEY:int = 91;
      
      private var _windowsStartMenuOpened:Boolean;
      
      private var _clientWasClicked:Boolean;
      
      private var _checkBeforeActivateTimeoutId:uint;
      
      private var _timeOut:Timer;
      
      private var _buffer:Vector.<ExternalNotificationRequest>;
      
      private var _playSound:Boolean;
      
      private var _broadCasting:Boolean = false;
      
      private function log(pMsg:Object) : void {
         var from:String = null;
         if(DEBUG)
         {
            from = this._isMaster?"[master]":"";
            _log.debug(from + " " + pMsg);
         }
      }
      
      public function canAddExternalNotification(pExternalNotificationType:int) : Boolean {
         return (this.notificationsEnabled) && (!this.isExternalNotificationTypeIgnored(pExternalNotificationType));
      }
      
      public function getNotificationOptions(pNotificationType:int) : Object {
         var extNotifs:Array = null;
         var extNotif:ExternalNotification = null;
         var notifData:Object = StoreDataManager.getInstance().getData(this._dataStoreType,"notificationsEvent" + pNotificationType);
         var hasOptions:Boolean = this.hasNotificationData(pNotificationType);
         var invalidData:Boolean = (notifData && hasOptions && !notifData.hasOwnProperty("active") && !notifData.hasOwnProperty("sound")) && (!notifData.hasOwnProperty("multi")) && (!notifData.hasOwnProperty("notify"));
         if((!notifData) || (invalidData))
         {
            extNotifs = ExternalNotification.getExternalNotifications();
            notifData = new Object();
            if(hasOptions)
            {
               for each(extNotif in extNotifs)
               {
                  if(ExternalNotificationTypeEnum[extNotif.name] == pNotificationType)
                  {
                     notifData.active = extNotif.defaultEnable;
                     notifData.sound = extNotif.defaultSound;
                     notifData.notify = extNotif.defaultNotify;
                     notifData.multi = extNotif.defaultMultiAccount;
                     break;
                  }
               }
            }
            else
            {
               notifData.active = true;
            }
            this.setNotificationOptions(pNotificationType,notifData);
         }
         return notifData;
      }
      
      public function setNotificationOptions(pNotificationType:int, pOptions:Object) : void {
         var multiaccountChanged:Boolean = false;
         StoreDataManager.getInstance().setData(this._dataStoreType,"notificationsEvent" + pNotificationType,pOptions);
         if(this._initialized)
         {
            multiaccountChanged = !this._notificationsOptions[pNotificationType].hasOwnProperty("multi")?false:!(this._notificationsOptions[pNotificationType].multi == pOptions.multi);
            this.updateNotificationOptions(pNotificationType,pOptions);
            if(multiaccountChanged)
            {
               if(!this._isMaster)
               {
                  try
                  {
                     this.becomeMaster(this._slavesIds);
                  }
                  catch(ae:ArgumentError)
                  {
                     log("there\'s already a master");
                  }
               }
               this.synchronizeMultiAccountOptions();
            }
         }
      }
      
      private function getOptionValue(pOptionName:String) : * {
         return OptionManager.getOptionManager("dofus")[pOptionName];
      }
      
      private function setOptionValue(pOptionName:String, pOptionValue:*) : void {
         OptionManager.getOptionManager("dofus")[pOptionName] = pOptionValue;
      }
      
      private function isTopPosition(pPosition:int) : Boolean {
         return (pPosition == ExternalNotificationPositionEnum.TOP_LEFT) || (pPosition == ExternalNotificationPositionEnum.TOP_RIGHT);
      }
      
      private function isNotificationDuplicated(pClientId:String, pNotificationType:int) : Boolean {
         var typeVisible:* = false;
         var enWin:ExternalNotificationWindow = null;
         for each(enWin in this._notificationsList)
         {
            if((!(enWin.clientId == pClientId)) && (enWin.notificationType == pNotificationType))
            {
               typeVisible = true;
               break;
            }
         }
         return typeVisible;
      }
      
      private function initDataStoreType() : void {
         var storeKey:String = "externalNotifications_" + MD5.hash(PlayerManager.getInstance().nickname);
         if((!this._dataStoreType) || (!(this._dataStoreType.category == storeKey)))
         {
            this._dataStoreType = new DataStoreType(storeKey,true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_CHARACTER);
         }
      }
      
      public function init() : void {
         var notificationEvent:XML = null;
         var notificationType:int = 0;
         this._timeOut = new Timer(50);
         this._timeOut.addEventListener(TimerEvent.TIMER,this.processRequests);
         this._buffer = new Vector.<ExternalNotificationRequest>();
         this._startCoordinatesX = 25;
         this._startCoordinatesY = 50;
         this._nativeWinOpts = new NativeWindowInitOptions();
         this._nativeWinOpts.systemChrome = NativeWindowSystemChrome.NONE;
         this._nativeWinOpts.type = NativeWindowType.LIGHTWEIGHT;
         this._nativeWinOpts.resizable = false;
         this._nativeWinOpts.transparent = true;
         this.initDataStoreType();
         this._notificationsList = new Vector.<ExternalNotificationWindow>(0);
         this._notificationsOptions = new Dictionary();
         this._slavesIds = new Array();
         this.setNotificationsMode(this.getOptionValue("notificationsMode"));
         this.setDisplayDuration(this.getOptionValue("notificationsDisplayDuration"));
         this.setMaxNotifications(this.getOptionValue("notificationsMaxNumber"));
         this._nbGeneralEvents = ExternalNotification.getExternalNotifications().length;
         var x:XML = describeType(ExternalNotificationTypeEnum);
         var events:XMLList = x..constant;
         for each(notificationEvent in events)
         {
            notificationType = ExternalNotificationTypeEnum[notificationEvent.@name];
            this.updateNotificationOptions(notificationType,this.getNotificationOptions(notificationType));
         }
         this.setNotificationsPosition(this.getOptionValue("notificationsPosition"));
         OptionManager.getOptionManager("dofus").addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         this._clientWindow = StageShareManager.stage.nativeWindow;
         if(this._masterConnection)
         {
            this.destroyLocalConnection(this._masterConnection);
         }
         this._masterConnection = new LocalConnection();
         this.initLocalConnection(this._masterConnection);
         this._slaveConnection = new LocalConnection();
         this.initLocalConnection(this._slaveConnection);
         try
         {
            this.becomeMaster();
         }
         catch(ae:ArgumentError)
         {
            becomeSlave();
         }
         this._clientWindow.addEventListener(Event.ACTIVATE,this.onWindowActivate);
         this._clientWindow.addEventListener(Event.DEACTIVATE,this.onWindowDeactivate);
         this._clientWindow.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE,this.onDisplayStateChange);
         this._clientWindow.addEventListener(Event.CLOSING,this.onClientClosing);
         this._clientWindow.addEventListener(Event.CLOSE,this.onClientClose);
         if(Capabilities.os.toLowerCase().indexOf("windows") != -1)
         {
            StageShareManager.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         }
         this._notificationsEnabled = this._clientWindow.active?false:true;
         this._initialized = true;
      }
      
      public function reset() : void {
         this.removeAllListeners();
         this._clientWindow.removeEventListener(Event.CLOSE,this.onClientClose);
         this.closeAllNotifications();
         if(this._isMaster)
         {
            this.closeMasterConnection();
            this.destroyLocalConnection(this._masterConnection);
            this.destroyLocalConnection(this._slaveConnection);
         }
         else
         {
            this.closeSlaveConnection();
            this.destroyLocalConnection(this._slaveConnection);
            this.sendToMaster("unregisterSlave",this._clientId);
         }
         this._initialized = false;
      }
      
      private function removeAllListeners() : void {
         this._timeOut.removeEventListener(TimerEvent.TIMER,this.processRequests);
         OptionManager.getOptionManager("dofus").removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         this._clientWindow.removeEventListener(Event.ACTIVATE,this.onWindowActivate);
         this._clientWindow.removeEventListener(Event.DEACTIVATE,this.onWindowDeactivate);
         this._clientWindow.removeEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE,this.onDisplayStateChange);
         this._clientWindow.removeEventListener(Event.CLOSING,this.onClientClosing);
         StageShareManager.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }
      
      private function closeAllNotifications() : void {
         var len:int = this._notificationsList.length;
         var i:int = 0;
         while(i < len)
         {
            this.destroyExternalNotification(this._notificationsList[i],false);
            i--;
            len--;
            i++;
         }
      }
      
      private function onWindowActivate(pEvent:Event) : void {
         if(this._windowsStartMenuOpened)
         {
            this._windowsStartMenuOpened = false;
            this._checkBeforeActivateTimeoutId = setTimeout(this.checkBeforeActivate,500);
            return;
         }
         this._notificationsEnabled = false;
         if(!this._isMaster)
         {
            this.sendToMaster("updateDofusFocus",this._clientId,this._clientWindow.active);
         }
      }
      
      private function onWindowDeactivate(pEvent:Event) : void {
         if((this._showMode == ExternalNotificationModeEnum.FOCUS_LOST_DOFUS) || (this._showMode == ExternalNotificationModeEnum.FOCUS_LOST_OTHER))
         {
            this._notificationsEnabled = true;
         }
         if(!this._isMaster)
         {
            this.sendToMaster("updateDofusFocus",this._clientId,this._clientWindow.active);
         }
      }
      
      private function checkBeforeActivate() : void {
         clearTimeout(this._checkBeforeActivateTimeoutId);
         StageShareManager.stage.removeEventListener(MouseEvent.CLICK,this.onClick);
         if(this._clientWasClicked)
         {
            this.onWindowActivate(null);
            this._clientWasClicked = false;
         }
         else
         {
            StageShareManager.stage.dispatchEvent(new Event(Event.DEACTIVATE));
            this.onWindowDeactivate(null);
            StageShareManager.stage.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         }
      }
      
      private function onDisplayStateChange(pEvent:NativeWindowDisplayStateEvent) : void {
         if(pEvent.afterDisplayState == NativeWindowDisplayState.MINIMIZED)
         {
            if(this._showMode == ExternalNotificationModeEnum.FOCUS_LOST_MINIMIZE)
            {
               this._notificationsEnabled = true;
            }
         }
         else
         {
            this._notificationsEnabled = false;
         }
      }
      
      private function onClientClosing(pEvent:Event) : void {
         this.removeAllListeners();
         this._showMode = ExternalNotificationModeEnum.DISABLED;
         if(this._isMaster)
         {
            this.closeMasterConnection();
            this.destroyLocalConnection(this._masterConnection);
            this.destroyLocalConnection(this._slaveConnection);
         }
         else
         {
            this.closeSlaveConnection();
            this.destroyLocalConnection(this._slaveConnection);
            this.sendToMaster("unregisterSlave",this._clientId);
         }
      }
      
      private function onClientClose(pEvent:Event) : void {
         this._clientWindow.removeEventListener(Event.CLOSE,this.onClientClose);
         if(this._isMaster)
         {
            this.closeAllNotifications();
         }
      }
      
      private function onKeyDown(pEvent:KeyboardEvent) : void {
         if(pEvent.keyCode == this.WINDOWS_KEY)
         {
            this._windowsStartMenuOpened = true;
            this._clientWasClicked = false;
            StageShareManager.stage.addEventListener(MouseEvent.CLICK,this.onClick);
         }
      }
      
      private function onClick(pEvent:MouseEvent) : void {
         this._clientWasClicked = true;
      }
      
      private function onMouseOver(pEvent:MouseEvent) : void {
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         StageShareManager.stage.dispatchEvent(new Event(Event.ACTIVATE));
         this.onWindowActivate(null);
      }
      
      public function updateDofusFocus(pClientId:String, pHasFocus:Boolean) : void {
         if((this._clientWindow.active) && (pHasFocus))
         {
            this._clientWindow.dispatchEvent(new Event(Event.DEACTIVATE));
         }
         this.dofusHasFocus = pHasFocus;
         if(this._slavesIds.indexOf(pClientId) == -1)
         {
            this._slavesIds.push(pClientId);
            this.sendToSlaves("updateClientsIds",this._slavesIds);
         }
      }
      
      private function takeFocus() : void {
         NativeApplication.nativeApplication.activate();
         this._clientWindow.activate();
      }
      
      private function toFront() : void {
         this._clientWindow.alwaysInFront = true;
         this._clientWindow.orderToFront();
         this._clientWindow.alwaysInFront = false;
      }
      
      public function notifyUser(pAlways:Boolean = true) : void {
         SystemManager.getSingleton().notifyUser(pAlways);
      }
      
      public function get initialized() : Boolean {
         return this._initialized;
      }
      
      public function get clientId() : String {
         return this._clientId;
      }
      
      public function get otherClientsIds() : Array {
         return this._slavesIds;
      }
      
      public function get showMode() : int {
         return this._showMode;
      }
      
      public function get notificationsEnabled() : Boolean {
         return this._showMode == ExternalNotificationModeEnum.DISABLED?false:this._notificationsEnabled;
      }
      
      private function getExternalNotification(pClientId:String, pExternalNotificationId:String) : ExternalNotificationWindow {
         var enWin:ExternalNotificationWindow = null;
         var foundNotification:ExternalNotificationWindow = null;
         if(this._notificationsList.length > 0)
         {
            for each(enWin in this._notificationsList)
            {
               if((enWin.clientId == pClientId) && (enWin.id == pExternalNotificationId))
               {
                  foundNotification = enWin;
                  break;
               }
            }
         }
         return foundNotification;
      }
      
      private function getExternalNotifications(pClientId:String) : Vector.<ExternalNotificationWindow> {
         var foundNotifications:Vector.<ExternalNotificationWindow> = null;
         var enWin:ExternalNotificationWindow = null;
         if(this._notificationsList.length > 0)
         {
            foundNotifications = new Vector.<ExternalNotificationWindow>(0);
            for each(enWin in this._notificationsList)
            {
               if(enWin.clientId == pClientId)
               {
                  foundNotifications.push(enWin);
               }
            }
            foundNotifications = foundNotifications.length == 0?null:foundNotifications;
         }
         return foundNotifications;
      }
      
      private function hasNotificationData(pNotificationType:int) : Boolean {
         var extNotif:ExternalNotification = null;
         var extNotifs:Array = ExternalNotification.getExternalNotifications();
         for each(extNotif in extNotifs)
         {
            if(ExternalNotificationTypeEnum[extNotif.name] == pNotificationType)
            {
               return true;
            }
         }
         return false;
      }
      
      public function updateProperty(pPropertyName:String, pPropertyNewValue:*) : void {
         this._optionChangedFromOtherClient = true;
         this.setOptionValue(pPropertyName,pPropertyNewValue);
         this._optionChangedFromOtherClient = false;
      }
      
      private function onPropertyChanged(pEvent:PropertyChangeEvent) : void {
         if(pEvent.propertyValue == pEvent.propertyOldValue)
         {
            return;
         }
         switch(pEvent.propertyName)
         {
            case "notificationsMode":
               this.setNotificationsMode(pEvent.propertyValue as int);
               break;
            case "notificationsDisplayDuration":
               this.setDisplayDuration(pEvent.propertyValue as Number);
               break;
            case "notificationsMaxNumber":
               this.setMaxNotifications(pEvent.propertyValue as int);
               break;
            case "notificationsPosition":
               this.setNotificationsPosition(pEvent.propertyValue as int);
               break;
            default:
               return;
         }
         if(!this._isMaster)
         {
            try
            {
               this.becomeMaster(this._slavesIds);
            }
            catch(ae:ArgumentError)
            {
            }
         }
         if(!this._isMaster)
         {
            if(!this._optionChangedFromOtherClient)
            {
               this.sendToMaster("updateProperty",pEvent.propertyName,pEvent.propertyValue);
            }
         }
         else
         {
            this.sendToSlaves("updateProperty",pEvent.propertyName,pEvent.propertyValue);
         }
      }
      
      private function synchronizeMultiAccountOptions() : void {
         var values:Array = new Array();
         var i:int = 1;
         while(i <= this._nbGeneralEvents)
         {
            values.push(this._notificationsOptions[i].multi);
            i++;
         }
         if(!this._isMaster)
         {
            this.sendToMaster("updateAllMultiAccountOptions",values);
         }
         else
         {
            this.sendToSlaves("updateAllMultiAccountOptions",values);
         }
      }
      
      public function updateAllMultiAccountOptions(pValues:Array) : void {
         var i:int = 1;
         while(i <= this._nbGeneralEvents)
         {
            this.updateMultiAccountOption(i,pValues[i - 1]);
            i++;
         }
         if(this._isMaster)
         {
            this.sendToSlaves("updateAllMultiAccountOptions",pValues);
         }
      }
      
      private function updateMultiAccountOption(pNotificationType:int, pEnabled:Boolean) : void {
         this._notificationsOptions[pNotificationType].multi = pEnabled;
         StoreDataManager.getInstance().setData(this._dataStoreType,"notificationsEvent" + pNotificationType,this._notificationsOptions[pNotificationType]);
      }
      
      public function updateNotificationOptions(pNotificationType:int, pOptions:Object) : void {
         if(!this._notificationsOptions[pNotificationType])
         {
            this._notificationsOptions[pNotificationType] = new Object();
         }
         this._notificationsOptions[pNotificationType].active = pOptions.active;
         if(pOptions.hasOwnProperty("sound"))
         {
            this._notificationsOptions[pNotificationType].sound = pOptions.sound;
         }
         if(pOptions.hasOwnProperty("multi"))
         {
            this._notificationsOptions[pNotificationType].multi = pOptions.multi;
         }
         if(pOptions.hasOwnProperty("notify"))
         {
            this._notificationsOptions[pNotificationType].notify = pOptions.notify;
         }
      }
      
      public function setNotificationsPosition(pValue:int) : void {
         if((!(this._notificationsPosition == -1)) && (this._notificationsList.length > 0) && (!(this._notificationsPosition == pValue)))
         {
            this.changeNotificationsPosition(pValue);
         }
         this._notificationsPosition = pValue;
      }
      
      public function setMaxNotifications(pValue:int) : void {
         this._maxNotifications = pValue;
      }
      
      public function setNotificationsMode(pValue:int) : void {
         this._showMode = pValue;
      }
      
      public function setDisplayDuration(pSeconds:Number) : void {
         this._timeoutDuration = pSeconds * 1000;
      }
      
      public function isExternalNotificationTypeIgnored(pNotificationType:int) : Boolean {
         var opts:Object = this._notificationsOptions[pNotificationType];
         return !opts.active;
      }
      
      private function ignoreExternalNotificationType(pNotificationType:int) : void {
         var opts:Object = this._notificationsOptions[pNotificationType];
         opts.active = false;
      }
      
      public function notificationPlaySound(pNotificationType:int) : Boolean {
         return this.hasNotificationData(pNotificationType)?this._notificationsOptions[pNotificationType].sound:true;
      }
      
      public function notificationNotify(pNotificationType:int) : Boolean {
         return this.hasNotificationData(pNotificationType)?this._notificationsOptions[pNotificationType].notify:false;
      }
      
      private function initLocalConnection(pLc:LocalConnection) : void {
         pLc.allowDomain("*");
         pLc.allowInsecureDomain("*");
         pLc.addEventListener(AsyncErrorEvent.ASYNC_ERROR,this.onConnectionError);
         pLc.addEventListener(StatusEvent.STATUS,this.onConnectionStatus);
         pLc.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onConnectionSecurityError);
      }
      
      private function destroyLocalConnection(pLc:LocalConnection) : void {
         pLc.removeEventListener(AsyncErrorEvent.ASYNC_ERROR,this.onConnectionError);
         pLc.removeEventListener(StatusEvent.STATUS,this.onConnectionStatus);
         pLc.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onConnectionSecurityError);
      }
      
      private function onConnectionError(pEvent:AsyncErrorEvent) : void {
      }
      
      private function onConnectionStatus(pEvent:StatusEvent) : void {
      }
      
      private function onConnectionSecurityError(pEvent:SecurityErrorEvent) : void {
      }
      
      private function closeMasterConnection() : void {
         try
         {
            this._masterConnection.close();
         }
         catch(ae:ArgumentError)
         {
         }
      }
      
      private function closeSlaveConnection() : void {
         try
         {
            this._slaveConnection.close();
         }
         catch(ae:ArgumentError)
         {
         }
      }
      
      private function sendToMaster(pMethodName:String, ... pArgs) : void {
         var argArray:Array = null;
         try
         {
            argArray = [this.CONNECTION_ID,pMethodName].concat(pArgs);
            this._masterConnection.send.apply(this,argArray);
         }
         catch(e:Error)
         {
         }
      }
      
      private function sendToSlave(pSlaveId:String, pMethodName:String, ... pArgs) : void {
         var argArray:Array = null;
         var params:Array = null;
         var param:* = undefined;
         try
         {
            argArray = [this.CONNECTION_ID + "." + pSlaveId,pMethodName];
            if(!this._broadCasting)
            {
               argArray = argArray.concat(pArgs);
            }
            else
            {
               params = pArgs[0];
               for each(param in params)
               {
                  argArray.push(param);
               }
            }
            this._slaveConnection.send.apply(this,argArray);
         }
         catch(e:Error)
         {
         }
      }
      
      private function sendToSlaves(pMethodName:String, ... pArgs) : void {
         var slaveId:String = null;
         this._broadCasting = true;
         for each(slaveId in this._slavesIds)
         {
            this.sendToSlave(slaveId,pMethodName,pArgs);
         }
         this._broadCasting = false;
      }
      
      private function becomeMaster(pSlavesIds:Array = null) : void {
         var id:String = null;
         this._masterConnection.client = getInstance();
         this._masterConnection.connect(this.CONNECTION_ID);
         if(pSlavesIds)
         {
            pSlavesIds.splice(pSlavesIds.indexOf(this._clientId),1);
            if(pSlavesIds != this._slavesIds)
            {
               this._slavesIds = new Array();
               for each(id in pSlavesIds)
               {
                  this._slavesIds.push(id);
               }
            }
         }
         this.closeSlaveConnection();
         this._clientId = "master";
         this._isMaster = true;
      }
      
      private function becomeSlave() : void {
         this._clientId = "slave" + Math.floor(Math.random() * 100000000);
         this._slaveConnection.client = getInstance();
         this._slaveConnection.connect(this.CONNECTION_ID + "." + this._clientId);
         this._isMaster = false;
         this.sendToMaster("updateDofusFocus",this._clientId,this._clientWindow.active);
      }
      
      public function unregisterSlave(pSlaveId:String) : void {
         var extNotif:ExternalNotificationWindow = null;
         this.updateDofusFocus(pSlaveId,false);
         this._slavesIds.splice(this._slavesIds.indexOf(pSlaveId),1);
         this.sendToSlaves("updateClientsIds",this._slavesIds);
         var extNotifs:Vector.<ExternalNotificationWindow> = this.getExternalNotifications(pSlaveId);
         if(extNotifs)
         {
            for each(extNotif in extNotifs)
            {
               this.destroyExternalNotification(extNotif);
            }
         }
      }
      
      public function updateClientsIds(pClientsIds:Array) : void {
         var id:String = null;
         this._slavesIds = new Array();
         for each(id in pClientsIds)
         {
            if(this._slavesIds.indexOf(id) == -1)
            {
               this._slavesIds.push(id);
            }
         }
      }
      
      public function handleNotificationRequest(pExtNotifRequest:Object) : void {
         var req:ExternalNotificationRequest = null;
         var focus:* = false;
         if(pExtNotifRequest is String)
         {
            req = ExternalNotificationRequest.createFromJSONString(pExtNotifRequest as String);
         }
         else
         {
            req = pExtNotifRequest as ExternalNotificationRequest;
         }
         if((this._clientId == req.clientId) && (!(req.showMode == ExternalNotificationModeEnum.ALWAYS)))
         {
            focus = this.dofusHasFocus;
            if((!focus) && (this._clientWindow.active))
            {
               focus = true;
            }
            if((req.showMode == ExternalNotificationModeEnum.FOCUS_LOST_OTHER) && (focus))
            {
               return;
            }
         }
         if((this._isMaster) && (this.hasNotificationData(req.notificationType)))
         {
            if((this._notificationsOptions[req.notificationType].multi == false) && (this.isNotificationDuplicated(req.clientId,req.notificationType)))
            {
               return;
            }
         }
         this._buffer.push(req);
         this._timeOut.reset();
         this._timeOut.start();
      }
      
      public function processRequest(pExtNotifRequest:ExternalNotificationRequest) : void {
         var mod:UiModule = UiModuleManager.getInstance().getModule(this.MODULE_NAME);
         var ctr:UiRootContainer = Berilia.getInstance().loadUi(mod,mod.uis[pExtNotifRequest.uiName],pExtNotifRequest.instanceId,pExtNotifRequest.displayData);
         var enWin:ExternalNotificationWindow = new ExternalNotificationWindow(pExtNotifRequest.notificationType,pExtNotifRequest.clientId,pExtNotifRequest.id,ctr,this._nativeWinOpts,pExtNotifRequest.hookName,pExtNotifRequest.hookParams);
         this._notificationsList.push(enWin);
         this.setNotificationCoordinates(enWin);
         this.showExternalNotification(enWin);
         if(this._playSound)
         {
            if((!this.hasNotificationData(pExtNotifRequest.notificationType)) || (pExtNotifRequest.playSound))
            {
               SoundManager.getInstance().manager.playUISound(pExtNotifRequest.soundId);
            }
            this._playSound = false;
         }
         if(pExtNotifRequest.notify)
         {
            if(pExtNotifRequest.clientId != this._clientId)
            {
               this.sendToSlave(pExtNotifRequest.clientId,"notifyUser");
            }
            else
            {
               this.notifyUser();
            }
         }
      }
      
      private function processRequests(pEvent:TimerEvent) : void {
         var bufferLen:int = 0;
         var i:int = 0;
         bufferLen = this._buffer.length;
         var maxLen:int = bufferLen > this._maxNotifications?this._maxNotifications:bufferLen;
         if(this._isMaster)
         {
            this._playSound = true;
            i = 0;
            while(i < maxLen)
            {
               this.processRequest(this._buffer[bufferLen - maxLen + i]);
               i++;
            }
            this._timeOut.stop();
            this._buffer.length = 0;
         }
         else
         {
            try
            {
               this.becomeMaster(this.otherClientsIds);
               this.processRequests(null);
            }
            catch(ae:ArgumentError)
            {
               if(bufferLen > _maxNotifications)
               {
                  _buffer = _buffer.slice(bufferLen - 1 - _maxNotifications,bufferLen - 1);
               }
               sendToMaster("handleNotificationRequest",com.ankamagames.jerakine.json.JSON.encode(_buffer.pop()));
               if(_buffer.length == 0)
               {
                  _timeOut.stop();
               }
            }
         }
      }
      
      public function handleFocusRequest(pClientId:String, pHookName:String = null, pHookParams:Array = null) : void {
         var hook:Hook = null;
         if(pClientId != this._clientId)
         {
            this.sendToSlave(pClientId,"handleFocusRequest",pClientId,pHookName,pHookParams);
         }
         else
         {
            if(this._clientWindow.displayState != NativeWindowDisplayState.MINIMIZED)
            {
               this.takeFocus();
               this.toFront();
            }
            else
            {
               this._clientWindow.restore();
            }
            if((pHookName) && (pHookParams))
            {
               hook = Hook.getHookByName(pHookName);
               if(hook)
               {
                  CallWithParameters.call(KernelEventsManager.getInstance().processCallback,new Array(hook).concat(pHookParams));
               }
            }
         }
      }
      
      private function showExternalNotification(pExtNotifWin:ExternalNotificationWindow) : void {
         pExtNotifWin.show();
         pExtNotifWin.timeoutId = setTimeout(this.destroyExternalNotification,this._timeoutDuration,pExtNotifWin);
         var offScreen:Boolean = this.isTopPosition(this._notificationsPosition)?pExtNotifWin.y > Capabilities.screenResolutionY - pExtNotifWin.contentHeight:pExtNotifWin.y < 0;
         if((this._notificationsList.length > this._maxNotifications) || (offScreen))
         {
            this.destroyExternalNotification(this._notificationsList[0]);
         }
      }
      
      public function closeExternalNotification(pClientId:String, pExternalNotificationId:String, pSendFocusRequestOnClose:Boolean = false) : void {
         var enWin:ExternalNotificationWindow = this.getExternalNotification(pClientId,pExternalNotificationId);
         if(pSendFocusRequestOnClose)
         {
            this._clientWindow.visible = false;
            enWin.addEventListener(Event.CLOSE,this.onExternalNotificationWindowClose);
         }
         this.destroyExternalNotification(enWin);
      }
      
      private function onExternalNotificationWindowClose(pEvent:Event) : void {
         var enWin:ExternalNotificationWindow = pEvent.currentTarget as ExternalNotificationWindow;
         enWin.removeEventListener(Event.CLOSE,this.onExternalNotificationWindowClose);
         this.handleFocusRequest(enWin.clientId,enWin.hookName,enWin.hookParams);
         this._clientWindow.visible = true;
      }
      
      public function resetNotificationDisplayTimeout(pClientId:String, pExternalNotificationId:String) : void {
         var enWin:ExternalNotificationWindow = this.getExternalNotification(pClientId,pExternalNotificationId);
         clearTimeout(enWin.timeoutId);
         enWin.timeoutId = setTimeout(this.destroyExternalNotification,this._timeoutDuration,enWin);
      }
      
      private function setNotificationCoordinates(pExtNotifWin:ExternalNotificationWindow) : void {
         var notificationX:* = NaN;
         var notificationY:* = NaN;
         var index:int = this._notificationsList.indexOf(pExtNotifWin);
         switch(this._notificationsPosition)
         {
            case ExternalNotificationPositionEnum.BOTTOM_RIGHT:
               notificationX = Capabilities.screenResolutionX - pExtNotifWin.contentWidth - this._startCoordinatesX;
               if(index == 0)
               {
                  notificationY = Capabilities.screenResolutionY - pExtNotifWin.contentHeight - this._startCoordinatesY;
               }
               break;
            case ExternalNotificationPositionEnum.BOTTOM_LEFT:
               notificationX = this._startCoordinatesX;
               if(index == 0)
               {
                  notificationY = Capabilities.screenResolutionY - pExtNotifWin.contentHeight - this._startCoordinatesY;
               }
               break;
            case ExternalNotificationPositionEnum.TOP_RIGHT:
               notificationX = Capabilities.screenResolutionX - pExtNotifWin.contentWidth - this._startCoordinatesX;
               if(index == 0)
               {
                  notificationY = this._startCoordinatesY;
               }
               break;
            case ExternalNotificationPositionEnum.TOP_LEFT:
               notificationX = this._startCoordinatesX;
               if(index == 0)
               {
                  notificationY = this._startCoordinatesY;
               }
               break;
         }
         if(index > 0)
         {
            if(this.isTopPosition(this._notificationsPosition))
            {
               notificationY = this._notificationsList[index - 1].y + (this._notificationsList[index - 1].height + this.NOTIFICATION_SPACING);
            }
            else
            {
               notificationY = this._notificationsList[index - 1].y - (pExtNotifWin.contentHeight + this.NOTIFICATION_SPACING);
            }
         }
         pExtNotifWin.bounds = new Rectangle(notificationX,notificationY,pExtNotifWin.contentWidth,pExtNotifWin.contentHeight);
      }
      
      private function changeNotificationsPosition(pNewPosition:int) : void {
         var len:uint = this._notificationsList.length;
         this._notificationsPosition = pNewPosition;
         var i:int = 0;
         while(i < len)
         {
            this.setNotificationCoordinates(this._notificationsList[i]);
            i++;
         }
      }
      
      private function destroyExternalNotification(pExtNotifWin:ExternalNotificationWindow, pReplaceOthers:Boolean = true) : void {
         var i:* = 0;
         var diff:* = NaN;
         clearTimeout(pExtNotifWin.timeoutId);
         pExtNotifWin.destroy();
         var len:int = this._notificationsList.length;
         var destroyedNotificationIndex:int = this._notificationsList.indexOf(pExtNotifWin);
         if(pReplaceOthers)
         {
            if((this._notificationsList.length > 0) && (!(destroyedNotificationIndex == len - 1)))
            {
               diff = pExtNotifWin.height + this.NOTIFICATION_SPACING;
               if(this.isTopPosition(this._notificationsPosition))
               {
                  diff = -diff;
               }
               i = len - 1;
               while(i > destroyedNotificationIndex)
               {
                  this._notificationsList[i].y = this._notificationsList[i].y + diff;
                  i--;
               }
            }
         }
         this._notificationsList.splice(destroyedNotificationIndex,1);
      }
   }
}
class PrivateClass extends Object
{
   
   function PrivateClass() {
      super();
   }
}
