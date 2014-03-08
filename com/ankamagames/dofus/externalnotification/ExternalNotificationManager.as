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
   import __AS3__.vec.*;
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
      
      public function ExternalNotificationManager(param1:PrivateClass) {
         super();
      }
      
      private static const DEBUG:Boolean = false;
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(ExternalNotificationManager));
      
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
      
      private function log(param1:Object) : void {
         var _loc2_:String = null;
         if(DEBUG)
         {
            _loc2_ = this._isMaster?"[master]":"";
            _log.debug(_loc2_ + " " + param1);
         }
      }
      
      public function canAddExternalNotification(param1:int) : Boolean {
         return (this.notificationsEnabled) && !this.isExternalNotificationTypeIgnored(param1);
      }
      
      public function getNotificationOptions(param1:int) : Object {
         var _loc5_:Array = null;
         var _loc6_:ExternalNotification = null;
         var _loc2_:Object = StoreDataManager.getInstance().getData(this._dataStoreType,"notificationsEvent" + param1);
         var _loc3_:Boolean = this.hasNotificationData(param1);
         var _loc4_:Boolean = ((((_loc2_) && (_loc3_)) && (!_loc2_.hasOwnProperty("active"))) && (!_loc2_.hasOwnProperty("sound"))) && !_loc2_.hasOwnProperty("multi") && !_loc2_.hasOwnProperty("notify");
         if(!_loc2_ || (_loc4_))
         {
            _loc5_ = ExternalNotification.getExternalNotifications();
            _loc2_ = new Object();
            if(_loc3_)
            {
               for each (_loc6_ in _loc5_)
               {
                  if(ExternalNotificationTypeEnum[_loc6_.name] == param1)
                  {
                     _loc2_.active = _loc6_.defaultEnable;
                     _loc2_.sound = _loc6_.defaultSound;
                     _loc2_.notify = _loc6_.defaultNotify;
                     _loc2_.multi = _loc6_.defaultMultiAccount;
                     break;
                  }
               }
            }
            else
            {
               _loc2_.active = true;
            }
            this.setNotificationOptions(param1,_loc2_);
         }
         return _loc2_;
      }
      
      public function setNotificationOptions(param1:int, param2:Object) : void {
         var multiaccountChanged:Boolean = false;
         var pNotificationType:int = param1;
         var pOptions:Object = param2;
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
      
      private function getOptionValue(param1:String) : * {
         return OptionManager.getOptionManager("dofus")[param1];
      }
      
      private function setOptionValue(param1:String, param2:*) : void {
         OptionManager.getOptionManager("dofus")[param1] = param2;
      }
      
      private function isTopPosition(param1:int) : Boolean {
         return param1 == ExternalNotificationPositionEnum.TOP_LEFT || param1 == ExternalNotificationPositionEnum.TOP_RIGHT;
      }
      
      private function isNotificationDuplicated(param1:String, param2:int) : Boolean {
         var _loc3_:* = false;
         var _loc4_:ExternalNotificationWindow = null;
         for each (_loc4_ in this._notificationsList)
         {
            if(!_loc3_ && !(_loc4_.clientId == param1) && _loc4_.notificationType == param2)
            {
               _loc3_ = true;
               break;
            }
         }
         return _loc3_;
      }
      
      private function initDataStoreType() : void {
         var _loc1_:String = "externalNotifications_" + MD5.hash(PlayerManager.getInstance().nickname);
         if(!this._dataStoreType || !(this._dataStoreType.category == _loc1_))
         {
            this._dataStoreType = new DataStoreType(_loc1_,true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_CHARACTER);
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
         for each (notificationEvent in events)
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
         var _loc1_:int = this._notificationsList.length;
         var _loc2_:* = 0;
         while(_loc2_ < _loc1_)
         {
            this.destroyExternalNotification(this._notificationsList[_loc2_],false);
            _loc2_--;
            _loc1_--;
            _loc2_++;
         }
      }
      
      private function onWindowActivate(param1:Event) : void {
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
      
      private function onWindowDeactivate(param1:Event) : void {
         if(this._showMode == ExternalNotificationModeEnum.FOCUS_LOST_DOFUS || this._showMode == ExternalNotificationModeEnum.FOCUS_LOST_OTHER)
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
      
      private function onDisplayStateChange(param1:NativeWindowDisplayStateEvent) : void {
         if(param1.afterDisplayState == NativeWindowDisplayState.MINIMIZED)
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
      
      private function onClientClosing(param1:Event) : void {
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
      
      private function onClientClose(param1:Event) : void {
         this._clientWindow.removeEventListener(Event.CLOSE,this.onClientClose);
         if(this._isMaster)
         {
            this.closeAllNotifications();
         }
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void {
         if(param1.keyCode == this.WINDOWS_KEY)
         {
            this._windowsStartMenuOpened = true;
            this._clientWasClicked = false;
            StageShareManager.stage.addEventListener(MouseEvent.CLICK,this.onClick);
         }
      }
      
      private function onClick(param1:MouseEvent) : void {
         this._clientWasClicked = true;
      }
      
      private function onMouseOver(param1:MouseEvent) : void {
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         StageShareManager.stage.dispatchEvent(new Event(Event.ACTIVATE));
         this.onWindowActivate(null);
      }
      
      public function updateDofusFocus(param1:String, param2:Boolean) : void {
         if((this._clientWindow.active) && (param2))
         {
            this._clientWindow.dispatchEvent(new Event(Event.DEACTIVATE));
         }
         this.dofusHasFocus = param2;
         if(this._slavesIds.indexOf(param1) == -1)
         {
            this._slavesIds.push(param1);
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
      
      public function notifyUser(param1:Boolean=true) : void {
         SystemManager.getSingleton().notifyUser(param1);
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
      
      private function getExternalNotification(param1:String, param2:String) : ExternalNotificationWindow {
         var _loc4_:ExternalNotificationWindow = null;
         var _loc3_:ExternalNotificationWindow = null;
         if(this._notificationsList.length > 0)
         {
            for each (_loc4_ in this._notificationsList)
            {
               if(_loc4_.clientId == param1 && _loc4_.id == param2)
               {
                  _loc3_ = _loc4_;
                  break;
               }
            }
         }
         return _loc3_;
      }
      
      private function getExternalNotifications(param1:String) : Vector.<ExternalNotificationWindow> {
         var _loc2_:Vector.<ExternalNotificationWindow> = null;
         var _loc3_:ExternalNotificationWindow = null;
         if(this._notificationsList.length > 0)
         {
            _loc2_ = new Vector.<ExternalNotificationWindow>(0);
            for each (_loc3_ in this._notificationsList)
            {
               if(_loc3_.clientId == param1)
               {
                  _loc2_.push(_loc3_);
               }
            }
            _loc2_ = _loc2_.length == 0?null:_loc2_;
         }
         return _loc2_;
      }
      
      private function hasNotificationData(param1:int) : Boolean {
         var _loc3_:ExternalNotification = null;
         var _loc2_:Array = ExternalNotification.getExternalNotifications();
         for each (_loc3_ in _loc2_)
         {
            if(ExternalNotificationTypeEnum[_loc3_.name] == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function updateProperty(param1:String, param2:*) : void {
         this._optionChangedFromOtherClient = true;
         this.setOptionValue(param1,param2);
         this._optionChangedFromOtherClient = false;
      }
      
      private function onPropertyChanged(param1:PropertyChangeEvent) : void {
         if(param1.propertyValue == param1.propertyOldValue)
         {
            return;
         }
         switch(param1.propertyName)
         {
            case "notificationsMode":
               this.setNotificationsMode(param1.propertyValue as int);
               break;
            case "notificationsDisplayDuration":
               this.setDisplayDuration(param1.propertyValue as Number);
               break;
            case "notificationsMaxNumber":
               this.setMaxNotifications(param1.propertyValue as int);
               break;
            case "notificationsPosition":
               this.setNotificationsPosition(param1.propertyValue as int);
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
               this.sendToMaster("updateProperty",param1.propertyName,param1.propertyValue);
            }
         }
         else
         {
            this.sendToSlaves("updateProperty",param1.propertyName,param1.propertyValue);
         }
      }
      
      private function synchronizeMultiAccountOptions() : void {
         var _loc1_:Array = new Array();
         var _loc2_:* = 1;
         while(_loc2_ <= this._nbGeneralEvents)
         {
            _loc1_.push(this._notificationsOptions[_loc2_].multi);
            _loc2_++;
         }
         if(!this._isMaster)
         {
            this.sendToMaster("updateAllMultiAccountOptions",_loc1_);
         }
         else
         {
            this.sendToSlaves("updateAllMultiAccountOptions",_loc1_);
         }
      }
      
      public function updateAllMultiAccountOptions(param1:Array) : void {
         var _loc2_:* = 1;
         while(_loc2_ <= this._nbGeneralEvents)
         {
            this.updateMultiAccountOption(_loc2_,param1[_loc2_-1]);
            _loc2_++;
         }
         if(this._isMaster)
         {
            this.sendToSlaves("updateAllMultiAccountOptions",param1);
         }
      }
      
      private function updateMultiAccountOption(param1:int, param2:Boolean) : void {
         this._notificationsOptions[param1].multi = param2;
         StoreDataManager.getInstance().setData(this._dataStoreType,"notificationsEvent" + param1,this._notificationsOptions[param1]);
      }
      
      public function updateNotificationOptions(param1:int, param2:Object) : void {
         if(!this._notificationsOptions[param1])
         {
            this._notificationsOptions[param1] = new Object();
         }
         this._notificationsOptions[param1].active = param2.active;
         if(param2.hasOwnProperty("sound"))
         {
            this._notificationsOptions[param1].sound = param2.sound;
         }
         if(param2.hasOwnProperty("multi"))
         {
            this._notificationsOptions[param1].multi = param2.multi;
         }
         if(param2.hasOwnProperty("notify"))
         {
            this._notificationsOptions[param1].notify = param2.notify;
         }
      }
      
      public function setNotificationsPosition(param1:int) : void {
         if(!(this._notificationsPosition == -1) && this._notificationsList.length > 0 && !(this._notificationsPosition == param1))
         {
            this.changeNotificationsPosition(param1);
         }
         this._notificationsPosition = param1;
      }
      
      public function setMaxNotifications(param1:int) : void {
         this._maxNotifications = param1;
      }
      
      public function setNotificationsMode(param1:int) : void {
         this._showMode = param1;
      }
      
      public function setDisplayDuration(param1:Number) : void {
         this._timeoutDuration = param1 * 1000;
      }
      
      public function isExternalNotificationTypeIgnored(param1:int) : Boolean {
         var _loc2_:Object = this._notificationsOptions[param1];
         return !_loc2_.active;
      }
      
      private function ignoreExternalNotificationType(param1:int) : void {
         var _loc2_:Object = this._notificationsOptions[param1];
         _loc2_.active = false;
      }
      
      public function notificationPlaySound(param1:int) : Boolean {
         return this.hasNotificationData(param1)?this._notificationsOptions[param1].sound:true;
      }
      
      public function notificationNotify(param1:int) : Boolean {
         return this.hasNotificationData(param1)?this._notificationsOptions[param1].notify:false;
      }
      
      private function initLocalConnection(param1:LocalConnection) : void {
         param1.allowDomain("*");
         param1.allowInsecureDomain("*");
         param1.addEventListener(AsyncErrorEvent.ASYNC_ERROR,this.onConnectionError);
         param1.addEventListener(StatusEvent.STATUS,this.onConnectionStatus);
         param1.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onConnectionSecurityError);
      }
      
      private function destroyLocalConnection(param1:LocalConnection) : void {
         param1.removeEventListener(AsyncErrorEvent.ASYNC_ERROR,this.onConnectionError);
         param1.removeEventListener(StatusEvent.STATUS,this.onConnectionStatus);
         param1.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onConnectionSecurityError);
      }
      
      private function onConnectionError(param1:AsyncErrorEvent) : void {
      }
      
      private function onConnectionStatus(param1:StatusEvent) : void {
      }
      
      private function onConnectionSecurityError(param1:SecurityErrorEvent) : void {
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
      
      private function sendToMaster(param1:String, ... rest) : void {
         var _loc3_:Array = null;
         try
         {
            _loc3_ = [this.CONNECTION_ID,param1].concat(rest);
            this._masterConnection.send.apply(this,_loc3_);
         }
         catch(e:Error)
         {
         }
      }
      
      private function sendToSlave(param1:String, param2:String, ... rest) : void {
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:* = undefined;
         try
         {
            _loc4_ = [this.CONNECTION_ID + "." + param1,param2];
            if(!this._broadCasting)
            {
               _loc4_ = _loc4_.concat(rest);
            }
            else
            {
               _loc5_ = rest[0];
               for each (_loc6_ in _loc5_)
               {
                  _loc4_.push(_loc6_);
               }
            }
            this._slaveConnection.send.apply(this,_loc4_);
         }
         catch(e:Error)
         {
         }
      }
      
      private function sendToSlaves(param1:String, ... rest) : void {
         var _loc3_:String = null;
         this._broadCasting = true;
         for each (_loc3_ in this._slavesIds)
         {
            this.sendToSlave(_loc3_,param1,rest);
         }
         this._broadCasting = false;
      }
      
      private function becomeMaster(param1:Array=null) : void {
         var _loc2_:String = null;
         this._masterConnection.client = getInstance();
         this._masterConnection.connect(this.CONNECTION_ID);
         if(param1)
         {
            param1.splice(param1.indexOf(this._clientId),1);
            if(param1 != this._slavesIds)
            {
               this._slavesIds = new Array();
               for each (_loc2_ in param1)
               {
                  this._slavesIds.push(_loc2_);
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
      
      public function unregisterSlave(param1:String) : void {
         var _loc3_:ExternalNotificationWindow = null;
         this.updateDofusFocus(param1,false);
         this._slavesIds.splice(this._slavesIds.indexOf(param1),1);
         this.sendToSlaves("updateClientsIds",this._slavesIds);
         var _loc2_:Vector.<ExternalNotificationWindow> = this.getExternalNotifications(param1);
         if(_loc2_)
         {
            for each (_loc3_ in _loc2_)
            {
               this.destroyExternalNotification(_loc3_);
            }
         }
      }
      
      public function updateClientsIds(param1:Array) : void {
         var _loc2_:String = null;
         this._slavesIds = new Array();
         for each (_loc2_ in param1)
         {
            if(this._slavesIds.indexOf(_loc2_) == -1)
            {
               this._slavesIds.push(_loc2_);
            }
         }
      }
      
      public function handleNotificationRequest(param1:Object) : void {
         var _loc2_:ExternalNotificationRequest = null;
         var _loc3_:* = false;
         if(param1 is String)
         {
            _loc2_ = ExternalNotificationRequest.createFromJSONString(param1 as String);
         }
         else
         {
            _loc2_ = param1 as ExternalNotificationRequest;
         }
         if(this._clientId == _loc2_.clientId && !(_loc2_.showMode == ExternalNotificationModeEnum.ALWAYS))
         {
            _loc3_ = this.dofusHasFocus;
            if(!_loc3_ && (this._clientWindow.active))
            {
               _loc3_ = true;
            }
            if(_loc2_.showMode == ExternalNotificationModeEnum.FOCUS_LOST_OTHER && (_loc3_))
            {
               return;
            }
         }
         if((this._isMaster) && (this.hasNotificationData(_loc2_.notificationType)))
         {
            if(this._notificationsOptions[_loc2_.notificationType].multi == false && (this.isNotificationDuplicated(_loc2_.clientId,_loc2_.notificationType)))
            {
               return;
            }
         }
         this._buffer.push(_loc2_);
         this._timeOut.reset();
         this._timeOut.start();
      }
      
      public function processRequest(param1:ExternalNotificationRequest) : void {
         var _loc2_:UiModule = UiModuleManager.getInstance().getModule(this.MODULE_NAME);
         var _loc3_:UiRootContainer = Berilia.getInstance().loadUi(_loc2_,_loc2_.uis[param1.uiName],param1.instanceId,param1.displayData);
         var _loc4_:ExternalNotificationWindow = new ExternalNotificationWindow(param1.notificationType,param1.clientId,param1.id,_loc3_,this._nativeWinOpts,param1.hookName,param1.hookParams);
         this._notificationsList.push(_loc4_);
         this.setNotificationCoordinates(_loc4_);
         this.showExternalNotification(_loc4_);
         if(this._playSound)
         {
            if(!this.hasNotificationData(param1.notificationType) || (param1.playSound))
            {
               SoundManager.getInstance().manager.playUISound(param1.soundId);
            }
            this._playSound = false;
         }
         if(param1.notify)
         {
            if(param1.clientId != this._clientId)
            {
               this.sendToSlave(param1.clientId,"notifyUser");
            }
            else
            {
               this.notifyUser();
            }
         }
      }
      
      private function processRequests(param1:TimerEvent) : void {
         var bufferLen:int = 0;
         var i:int = 0;
         var pEvent:TimerEvent = param1;
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
                  _buffer = _buffer.slice(bufferLen-1 - _maxNotifications,bufferLen-1);
               }
               sendToMaster("handleNotificationRequest",com.ankamagames.jerakine.json.JSON.encode(_buffer.pop()));
               if(_buffer.length == 0)
               {
                  _timeOut.stop();
               }
            }
         }
      }
      
      public function handleFocusRequest(param1:String, param2:String=null, param3:Array=null) : void {
         var _loc4_:Hook = null;
         if(param1 != this._clientId)
         {
            this.sendToSlave(param1,"handleFocusRequest",param1,param2,param3);
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
            if((param2) && (param3))
            {
               _loc4_ = Hook.getHookByName(param2);
               if(_loc4_)
               {
                  CallWithParameters.call(KernelEventsManager.getInstance().processCallback,new Array(_loc4_).concat(param3));
               }
            }
         }
      }
      
      private function showExternalNotification(param1:ExternalNotificationWindow) : void {
         param1.show();
         param1.timeoutId = setTimeout(this.destroyExternalNotification,this._timeoutDuration,param1);
         var _loc2_:Boolean = this.isTopPosition(this._notificationsPosition)?param1.y > Capabilities.screenResolutionY - param1.contentHeight:param1.y < 0;
         if(this._notificationsList.length > this._maxNotifications || (_loc2_))
         {
            this.destroyExternalNotification(this._notificationsList[0]);
         }
      }
      
      public function closeExternalNotification(param1:String, param2:String, param3:Boolean=false) : void {
         var _loc4_:ExternalNotificationWindow = this.getExternalNotification(param1,param2);
         if(param3)
         {
            this._clientWindow.visible = false;
            _loc4_.addEventListener(Event.CLOSE,this.onExternalNotificationWindowClose);
         }
         this.destroyExternalNotification(_loc4_);
      }
      
      private function onExternalNotificationWindowClose(param1:Event) : void {
         var _loc2_:ExternalNotificationWindow = param1.currentTarget as ExternalNotificationWindow;
         _loc2_.removeEventListener(Event.CLOSE,this.onExternalNotificationWindowClose);
         this.handleFocusRequest(_loc2_.clientId,_loc2_.hookName,_loc2_.hookParams);
         this._clientWindow.visible = true;
      }
      
      public function resetNotificationDisplayTimeout(param1:String, param2:String) : void {
         var _loc3_:ExternalNotificationWindow = this.getExternalNotification(param1,param2);
         clearTimeout(_loc3_.timeoutId);
         _loc3_.timeoutId = setTimeout(this.destroyExternalNotification,this._timeoutDuration,_loc3_);
      }
      
      private function setNotificationCoordinates(param1:ExternalNotificationWindow) : void {
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc2_:int = this._notificationsList.indexOf(param1);
         switch(this._notificationsPosition)
         {
            case ExternalNotificationPositionEnum.BOTTOM_RIGHT:
               _loc3_ = Capabilities.screenResolutionX - param1.contentWidth - this._startCoordinatesX;
               if(_loc2_ == 0)
               {
                  _loc4_ = Capabilities.screenResolutionY - param1.contentHeight - this._startCoordinatesY;
               }
               break;
            case ExternalNotificationPositionEnum.BOTTOM_LEFT:
               _loc3_ = this._startCoordinatesX;
               if(_loc2_ == 0)
               {
                  _loc4_ = Capabilities.screenResolutionY - param1.contentHeight - this._startCoordinatesY;
               }
               break;
            case ExternalNotificationPositionEnum.TOP_RIGHT:
               _loc3_ = Capabilities.screenResolutionX - param1.contentWidth - this._startCoordinatesX;
               if(_loc2_ == 0)
               {
                  _loc4_ = this._startCoordinatesY;
               }
               break;
            case ExternalNotificationPositionEnum.TOP_LEFT:
               _loc3_ = this._startCoordinatesX;
               if(_loc2_ == 0)
               {
                  _loc4_ = this._startCoordinatesY;
               }
               break;
         }
         if(_loc2_ > 0)
         {
            if(this.isTopPosition(this._notificationsPosition))
            {
               _loc4_ = this._notificationsList[_loc2_-1].y + (this._notificationsList[_loc2_-1].height + this.NOTIFICATION_SPACING);
            }
            else
            {
               _loc4_ = this._notificationsList[_loc2_-1].y - (param1.contentHeight + this.NOTIFICATION_SPACING);
            }
         }
         param1.bounds = new Rectangle(_loc3_,_loc4_,param1.contentWidth,param1.contentHeight);
      }
      
      private function changeNotificationsPosition(param1:int) : void {
         var _loc2_:uint = this._notificationsList.length;
         this._notificationsPosition = param1;
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_)
         {
            this.setNotificationCoordinates(this._notificationsList[_loc3_]);
            _loc3_++;
         }
      }
      
      private function destroyExternalNotification(param1:ExternalNotificationWindow, param2:Boolean=true) : void {
         var _loc4_:* = 0;
         var _loc6_:* = NaN;
         clearTimeout(param1.timeoutId);
         param1.destroy();
         var _loc3_:int = this._notificationsList.length;
         var _loc5_:int = this._notificationsList.indexOf(param1);
         if(param2)
         {
            if(this._notificationsList.length > 0 && !(_loc5_ == _loc3_-1))
            {
               _loc6_ = param1.height + this.NOTIFICATION_SPACING;
               if(this.isTopPosition(this._notificationsPosition))
               {
                  _loc6_ = -_loc6_;
               }
               _loc4_ = _loc3_-1;
               while(_loc4_ > _loc5_)
               {
                  this._notificationsList[_loc4_].y = this._notificationsList[_loc4_].y + _loc6_;
                  _loc4_--;
               }
            }
         }
         this._notificationsList.splice(_loc5_,1);
      }
   }
}
class PrivateClass extends Object
{
   
   function PrivateClass() {
      super();
   }
}
