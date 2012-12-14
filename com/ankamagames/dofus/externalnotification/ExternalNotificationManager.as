package com.ankamagames.dofus.externalnotification
{
    import __AS3__.vec.*;
    import by.blooddy.crypto.*;
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.dofus.datacenter.externalnotifications.*;
    import com.ankamagames.dofus.externalnotification.enums.*;
    import com.ankamagames.dofus.kernel.sound.*;
    import com.ankamagames.dofus.kernel.sound.enum.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.jerakine.json.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;

    public class ExternalNotificationManager extends Object
    {
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
        private const NB_EVENTS_TYPES:int = 35;
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
        private static const DEBUG:Boolean = false;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(ExternalNotificationManager));
        private static var _instance:ExternalNotificationManager;

        public function ExternalNotificationManager(param1:PrivateClass)
        {
            return;
        }// end function

        private function log(param1:Object) : void
        {
            var _loc_2:* = null;
            if (DEBUG)
            {
                _loc_2 = this._isMaster ? ("[master]") : ("");
                _log.debug(_loc_2 + " " + param1);
            }
            return;
        }// end function

        public function canAddExternalNotification(param1:int) : Boolean
        {
            return this.notificationsEnabled && !this.isExternalNotificationTypeIgnored(param1);
        }// end function

        public function getNotificationOptions(param1:int) : Object
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = StoreDataManager.getInstance().getData(this._dataStoreType, "notificationsEvent" + param1);
            var _loc_3:* = _loc_2 && !_loc_2.hasOwnProperty("active") && !_loc_2.hasOwnProperty("sound") && !_loc_2.hasOwnProperty("multi") && !_loc_2.hasOwnProperty("notify");
            if (!_loc_2 || _loc_3)
            {
                _loc_4 = ExternalNotification.getExternalNotifications();
                _loc_2 = new Object();
                for each (_loc_5 in _loc_4)
                {
                    
                    if (ExternalNotificationTypeEnum[_loc_5.name] == param1)
                    {
                        _loc_2.active = _loc_5.defaultEnable;
                        _loc_2.sound = _loc_5.defaultSound;
                        _loc_2.notify = _loc_5.defaultNotify;
                        _loc_2.multi = _loc_5.defaultMultiAccount;
                        break;
                    }
                }
                this.setNotificationOptions(param1, _loc_2);
            }
            return _loc_2;
        }// end function

        public function setNotificationOptions(param1:int, param2:Object) : void
        {
            var multiaccountChanged:Boolean;
            var pNotificationType:* = param1;
            var pOptions:* = param2;
            StoreDataManager.getInstance().setData(this._dataStoreType, "notificationsEvent" + pNotificationType, pOptions);
            if (this._initialized)
            {
                multiaccountChanged = this._notificationsOptions[pNotificationType].multi != pOptions.multi;
                this.updateNotificationOptions(pNotificationType, pOptions);
                if (multiaccountChanged)
                {
                    if (!this._isMaster)
                    {
                        try
                        {
                            this.becomeMaster(this._slavesIds);
                        }
                        catch (ae:ArgumentError)
                        {
                            log("there\'s already a master");
                        }
                    }
                    this.synchronizeMultiAccountOptions();
                }
            }
            return;
        }// end function

        private function getOptionValue(param1:String)
        {
            return OptionManager.getOptionManager("dofus")[param1];
        }// end function

        private function setOptionValue(param1:String, param2) : void
        {
            OptionManager.getOptionManager("dofus")[param1] = param2;
            return;
        }// end function

        private function isTopPosition(param1:int) : Boolean
        {
            return param1 == ExternalNotificationPositionEnum.TOP_LEFT || param1 == ExternalNotificationPositionEnum.TOP_RIGHT;
        }// end function

        private function isNotificationDuplicated(param1:String, param2:int) : Boolean
        {
            var _loc_3:* = false;
            var _loc_4:* = null;
            for each (_loc_4 in this._notificationsList)
            {
                
                if (!_loc_3 && _loc_4.clientId != param1 && _loc_4.notificationType == param2)
                {
                    _loc_3 = true;
                    break;
                }
            }
            return _loc_3;
        }// end function

        private function initDataStoreType() : void
        {
            var _loc_1:* = "externalNotifications_" + MD5.hash(PlayerManager.getInstance().nickname);
            if (!this._dataStoreType || this._dataStoreType.category != _loc_1)
            {
                this._dataStoreType = new DataStoreType(_loc_1, true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_CHARACTER);
            }
            return;
        }// end function

        public function init() : void
        {
            this._timeOut = new Timer(50);
            this._timeOut.addEventListener(TimerEvent.TIMER, this.processRequests);
            this._buffer = new Vector.<ExternalNotificationRequest>;
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
            var i:int;
            while (i <= this.NB_EVENTS_TYPES)
            {
                
                this.updateNotificationOptions(i, this.getNotificationOptions(i));
                i = (i + 1);
            }
            this.setNotificationsPosition(this.getOptionValue("notificationsPosition"));
            OptionManager.getOptionManager("dofus").addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            this._clientWindow = StageShareManager.stage.nativeWindow;
            if (this._masterConnection)
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
            catch (ae:ArgumentError)
            {
                becomeSlave();
            }
            this._clientWindow.addEventListener(Event.ACTIVATE, this.onWindowActivate);
            this._clientWindow.addEventListener(Event.DEACTIVATE, this.onWindowDeactivate);
            this._clientWindow.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE, this.onDisplayStateChange);
            this._clientWindow.addEventListener(Event.CLOSING, this.onClientClosing);
            this._clientWindow.addEventListener(Event.CLOSE, this.onClientClose);
            if (Capabilities.os.toLowerCase().indexOf("windows") != -1)
            {
                StageShareManager.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            }
            this._notificationsEnabled = this._clientWindow.active ? (false) : (true);
            this._initialized = true;
            return;
        }// end function

        public function reset() : void
        {
            this.removeAllListeners();
            this._clientWindow.removeEventListener(Event.CLOSE, this.onClientClose);
            this.closeAllNotifications();
            if (this._isMaster)
            {
                this.closeMasterConnection();
                this.destroyLocalConnection(this._masterConnection);
                this.destroyLocalConnection(this._slaveConnection);
            }
            else
            {
                this.closeSlaveConnection();
                this.destroyLocalConnection(this._slaveConnection);
                this.sendToMaster("unregisterSlave", this._clientId);
            }
            this._initialized = false;
            return;
        }// end function

        private function removeAllListeners() : void
        {
            this._timeOut.removeEventListener(TimerEvent.TIMER, this.processRequests);
            OptionManager.getOptionManager("dofus").removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            this._clientWindow.removeEventListener(Event.ACTIVATE, this.onWindowActivate);
            this._clientWindow.removeEventListener(Event.DEACTIVATE, this.onWindowDeactivate);
            this._clientWindow.removeEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE, this.onDisplayStateChange);
            this._clientWindow.removeEventListener(Event.CLOSING, this.onClientClosing);
            StageShareManager.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            return;
        }// end function

        private function closeAllNotifications() : void
        {
            var _loc_1:* = this._notificationsList.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this.destroyExternalNotification(this._notificationsList[_loc_2], false);
                _loc_2 = _loc_2 - 1;
                _loc_1 = _loc_1 - 1;
                _loc_2++;
            }
            return;
        }// end function

        private function onWindowActivate(event:Event) : void
        {
            if (this._windowsStartMenuOpened)
            {
                this._windowsStartMenuOpened = false;
                this._checkBeforeActivateTimeoutId = setTimeout(this.checkBeforeActivate, 500);
                return;
            }
            this._notificationsEnabled = false;
            if (!this._isMaster)
            {
                this.sendToMaster("updateDofusFocus", this._clientId, this._clientWindow.active);
            }
            return;
        }// end function

        private function onWindowDeactivate(event:Event) : void
        {
            if (this._showMode == ExternalNotificationModeEnum.FOCUS_LOST_DOFUS || this._showMode == ExternalNotificationModeEnum.FOCUS_LOST_OTHER)
            {
                this._notificationsEnabled = true;
            }
            if (!this._isMaster)
            {
                this.sendToMaster("updateDofusFocus", this._clientId, this._clientWindow.active);
            }
            return;
        }// end function

        private function checkBeforeActivate() : void
        {
            clearTimeout(this._checkBeforeActivateTimeoutId);
            StageShareManager.stage.removeEventListener(MouseEvent.CLICK, this.onClick);
            if (this._clientWasClicked)
            {
                this.onWindowActivate(null);
                this._clientWasClicked = false;
            }
            else
            {
                StageShareManager.stage.dispatchEvent(new Event(Event.DEACTIVATE));
                StageShareManager.stage.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            }
            return;
        }// end function

        private function onDisplayStateChange(event:NativeWindowDisplayStateEvent) : void
        {
            if (event.afterDisplayState == NativeWindowDisplayState.MINIMIZED)
            {
                if (this._showMode == ExternalNotificationModeEnum.FOCUS_LOST_MINIMIZE)
                {
                    this._notificationsEnabled = true;
                }
            }
            else
            {
                this._notificationsEnabled = false;
            }
            return;
        }// end function

        private function onClientClosing(event:Event) : void
        {
            this.removeAllListeners();
            this._showMode = ExternalNotificationModeEnum.DISABLED;
            if (this._isMaster)
            {
                this.closeMasterConnection();
                this.destroyLocalConnection(this._masterConnection);
                this.destroyLocalConnection(this._slaveConnection);
            }
            else
            {
                this.closeSlaveConnection();
                this.destroyLocalConnection(this._slaveConnection);
                this.sendToMaster("unregisterSlave", this._clientId);
            }
            return;
        }// end function

        private function onClientClose(event:Event) : void
        {
            this._clientWindow.removeEventListener(Event.CLOSE, this.onClientClose);
            if (this._isMaster)
            {
                this.closeAllNotifications();
            }
            return;
        }// end function

        private function onKeyDown(event:KeyboardEvent) : void
        {
            if (event.keyCode == this.WINDOWS_KEY)
            {
                this._windowsStartMenuOpened = true;
                this._clientWasClicked = false;
                StageShareManager.stage.addEventListener(MouseEvent.CLICK, this.onClick);
            }
            return;
        }// end function

        private function onClick(event:MouseEvent) : void
        {
            this._clientWasClicked = true;
            return;
        }// end function

        private function onMouseOver(event:MouseEvent) : void
        {
            StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            StageShareManager.stage.dispatchEvent(new Event(Event.ACTIVATE));
            return;
        }// end function

        public function updateDofusFocus(param1:String, param2:Boolean) : void
        {
            if (this._clientWindow.active && param2)
            {
                this._clientWindow.dispatchEvent(new Event(Event.DEACTIVATE));
            }
            this.dofusHasFocus = param2;
            if (this._slavesIds.indexOf(param1) == -1)
            {
                this._slavesIds.push(param1);
                this.sendToSlaves("updateClientsIds", this._slavesIds);
            }
            return;
        }// end function

        private function takeFocus() : void
        {
            NativeApplication.nativeApplication.activate();
            this._clientWindow.activate();
            return;
        }// end function

        private function toFront() : void
        {
            this._clientWindow.alwaysInFront = true;
            this._clientWindow.orderToFront();
            this._clientWindow.alwaysInFront = false;
            return;
        }// end function

        public function notifyUser(param1:Boolean = true) : void
        {
            SystemManager.getSingleton().notifyUser(param1);
            return;
        }// end function

        public function get initialized() : Boolean
        {
            return this._initialized;
        }// end function

        public function get clientId() : String
        {
            return this._clientId;
        }// end function

        public function get otherClientsIds() : Array
        {
            return this._slavesIds;
        }// end function

        public function get showMode() : int
        {
            return this._showMode;
        }// end function

        public function get notificationsEnabled() : Boolean
        {
            return this._showMode == ExternalNotificationModeEnum.DISABLED ? (false) : (this._notificationsEnabled);
        }// end function

        private function getExternalNotification(param1:String, param2:String) : ExternalNotificationWindow
        {
            var _loc_4:* = null;
            var _loc_3:* = null;
            if (this._notificationsList.length > 0)
            {
                for each (_loc_4 in this._notificationsList)
                {
                    
                    if (_loc_4.clientId == param1 && _loc_4.id == param2)
                    {
                        _loc_3 = _loc_4;
                        break;
                    }
                }
            }
            return _loc_3;
        }// end function

        private function getExternalNotifications(param1:String) : Vector.<ExternalNotificationWindow>
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._notificationsList.length > 0)
            {
                _loc_2 = new Vector.<ExternalNotificationWindow>(0);
                for each (_loc_3 in this._notificationsList)
                {
                    
                    if (_loc_3.clientId == param1)
                    {
                        _loc_2.push(_loc_3);
                    }
                }
                _loc_2 = _loc_2.length == 0 ? (null) : (_loc_2);
            }
            return _loc_2;
        }// end function

        public function updateProperty(param1:String, param2) : void
        {
            this._optionChangedFromOtherClient = true;
            this.setOptionValue(param1, param2);
            this._optionChangedFromOtherClient = false;
            return;
        }// end function

        private function onPropertyChanged(event:PropertyChangeEvent) : void
        {
            if (event.propertyValue == event.propertyOldValue)
            {
                return;
            }
            switch(event.propertyName)
            {
                case "notificationsMode":
                {
                    this.setNotificationsMode(event.propertyValue as int);
                    break;
                }
                case "notificationsDisplayDuration":
                {
                    this.setDisplayDuration(event.propertyValue as Number);
                    break;
                }
                case "notificationsMaxNumber":
                {
                    this.setMaxNotifications(event.propertyValue as int);
                    break;
                }
                case "notificationsPosition":
                {
                    this.setNotificationsPosition(event.propertyValue as int);
                    break;
                }
                default:
                {
                    return;
                    break;
                }
            }
            if (!this._isMaster)
            {
                try
                {
                    this.becomeMaster(this._slavesIds);
                }
                catch (ae:ArgumentError)
                {
                }
            }
            if (!this._isMaster)
            {
                if (!this._optionChangedFromOtherClient)
                {
                    this.sendToMaster("updateProperty", event.propertyName, event.propertyValue);
                }
            }
            else
            {
                this.sendToSlaves("updateProperty", event.propertyName, event.propertyValue);
            }
            return;
        }// end function

        private function synchronizeMultiAccountOptions() : void
        {
            var _loc_1:* = new Array();
            var _loc_2:* = 1;
            while (_loc_2 <= this.NB_EVENTS_TYPES)
            {
                
                _loc_1.push(this._notificationsOptions[_loc_2].multi);
                _loc_2++;
            }
            if (!this._isMaster)
            {
                this.sendToMaster("updateAllMultiAccountOptions", _loc_1);
            }
            else
            {
                this.sendToSlaves("updateAllMultiAccountOptions", _loc_1);
            }
            return;
        }// end function

        public function updateAllMultiAccountOptions(param1:Array) : void
        {
            var _loc_2:* = 1;
            while (_loc_2 <= this.NB_EVENTS_TYPES)
            {
                
                this.updateMultiAccountOption(_loc_2, param1[(_loc_2 - 1)]);
                _loc_2++;
            }
            if (this._isMaster)
            {
                this.sendToSlaves("updateAllMultiAccountOptions", param1);
            }
            return;
        }// end function

        private function updateMultiAccountOption(param1:int, param2:Boolean) : void
        {
            this._notificationsOptions[param1].multi = param2;
            StoreDataManager.getInstance().setData(this._dataStoreType, "notificationsEvent" + param1, this._notificationsOptions[param1]);
            return;
        }// end function

        public function updateNotificationOptions(param1:int, param2:Object) : void
        {
            if (!this._notificationsOptions[param1])
            {
                this._notificationsOptions[param1] = new Object();
            }
            this._notificationsOptions[param1].active = param2.active;
            this._notificationsOptions[param1].sound = param2.sound;
            this._notificationsOptions[param1].multi = param2.multi;
            this._notificationsOptions[param1].notify = param2.notify;
            return;
        }// end function

        public function setNotificationsPosition(param1:int) : void
        {
            if (this._notificationsPosition != -1 && this._notificationsList.length > 0 && this._notificationsPosition != param1)
            {
                this.changeNotificationsPosition(param1);
            }
            this._notificationsPosition = param1;
            return;
        }// end function

        public function setMaxNotifications(param1:int) : void
        {
            this._maxNotifications = param1;
            return;
        }// end function

        public function setNotificationsMode(param1:int) : void
        {
            this._showMode = param1;
            return;
        }// end function

        public function setDisplayDuration(param1:Number) : void
        {
            this._timeoutDuration = param1 * 1000;
            return;
        }// end function

        public function isExternalNotificationTypeIgnored(param1:int) : Boolean
        {
            var _loc_2:* = this._notificationsOptions[param1];
            return !_loc_2.active;
        }// end function

        private function ignoreExternalNotificationType(param1:int) : void
        {
            var _loc_2:* = this._notificationsOptions[param1];
            _loc_2.active = false;
            return;
        }// end function

        public function notificationPlaySound(param1:int) : Boolean
        {
            return param1 != ExternalNotificationTypeEnum.NONE ? (this._notificationsOptions[param1].sound) : (true);
        }// end function

        public function notificationNotify(param1:int) : Boolean
        {
            return param1 != ExternalNotificationTypeEnum.NONE ? (this._notificationsOptions[param1].notify) : (false);
        }// end function

        private function initLocalConnection(param1:LocalConnection) : void
        {
            param1.allowDomain("*");
            param1.allowInsecureDomain("*");
            param1.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onConnectionError);
            param1.addEventListener(StatusEvent.STATUS, this.onConnectionStatus);
            param1.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onConnectionSecurityError);
            return;
        }// end function

        private function destroyLocalConnection(param1:LocalConnection) : void
        {
            param1.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onConnectionError);
            param1.removeEventListener(StatusEvent.STATUS, this.onConnectionStatus);
            param1.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onConnectionSecurityError);
            return;
        }// end function

        private function onConnectionError(event:AsyncErrorEvent) : void
        {
            return;
        }// end function

        private function onConnectionStatus(event:StatusEvent) : void
        {
            return;
        }// end function

        private function onConnectionSecurityError(event:SecurityErrorEvent) : void
        {
            return;
        }// end function

        private function closeMasterConnection() : void
        {
            try
            {
                this._masterConnection.close();
            }
            catch (ae:ArgumentError)
            {
            }
            return;
        }// end function

        private function closeSlaveConnection() : void
        {
            try
            {
                this._slaveConnection.close();
            }
            catch (ae:ArgumentError)
            {
            }
            return;
        }// end function

        private function sendToMaster(param1:String, ... args) : void
        {
            args = null;
            try
            {
                args = [this.CONNECTION_ID, param1].concat(args);
                this._masterConnection.send.apply(this, args);
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        private function sendToSlave(param1:String, param2:String, ... args) : void
        {
            args = null;
            try
            {
                args = [this.CONNECTION_ID + "." + param1, param2].concat(args);
                this._slaveConnection.send.apply(this, args);
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        private function sendToSlaves(param1:String, ... args) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = undefined;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            args = args.length;
            var _loc_4:* = 0;
            while (_loc_4 < args)
            {
                
                _loc_6 = args[_loc_4];
                if (_loc_6 is Array)
                {
                    args.splice(_loc_4, 1);
                    _loc_7 = _loc_6.length;
                    _loc_8 = 0;
                    while (_loc_8 < _loc_7)
                    {
                        
                        args.splice(_loc_4 + _loc_8, 0, _loc_6[_loc_8]);
                        _loc_8++;
                    }
                }
                _loc_4++;
            }
            for each (_loc_5 in this._slavesIds)
            {
                
                this.sendToSlave(_loc_5, param1, args);
            }
            return;
        }// end function

        private function becomeMaster(param1:Array = null) : void
        {
            var _loc_2:* = null;
            this._masterConnection.client = getInstance();
            this._masterConnection.connect(this.CONNECTION_ID);
            if (param1)
            {
                param1.splice(param1.indexOf(this._clientId), 1);
                if (param1 != this._slavesIds)
                {
                    this._slavesIds = new Array();
                    for each (_loc_2 in param1)
                    {
                        
                        this._slavesIds.push(_loc_2);
                    }
                }
            }
            this.closeSlaveConnection();
            this._clientId = "master";
            this._isMaster = true;
            return;
        }// end function

        private function becomeSlave() : void
        {
            this._clientId = "slave" + Math.floor(Math.random() * 100000000);
            this._slaveConnection.client = getInstance();
            this._slaveConnection.connect(this.CONNECTION_ID + "." + this._clientId);
            this._isMaster = false;
            this.sendToMaster("updateDofusFocus", this._clientId, this._clientWindow.active);
            return;
        }// end function

        public function unregisterSlave(param1:String) : void
        {
            var _loc_3:* = null;
            this.updateDofusFocus(param1, false);
            this._slavesIds.splice(this._slavesIds.indexOf(param1), 1);
            this.sendToSlaves("updateClientsIds", this._slavesIds);
            var _loc_2:* = this.getExternalNotifications(param1);
            if (_loc_2)
            {
                for each (_loc_3 in _loc_2)
                {
                    
                    this.destroyExternalNotification(_loc_3);
                }
            }
            return;
        }// end function

        public function updateClientsIds(param1:Array) : void
        {
            var _loc_2:* = null;
            this._slavesIds = new Array();
            for each (_loc_2 in param1)
            {
                
                if (this._slavesIds.indexOf(_loc_2) == -1)
                {
                    this._slavesIds.push(_loc_2);
                }
            }
            return;
        }// end function

        public function handleNotificationRequest(param1:Object, param2:Boolean = false) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = false;
            if (param1 is String)
            {
                _loc_3 = ExternalNotificationRequest.createFromJSONString(param1 as String);
            }
            else
            {
                _loc_3 = param1 as ExternalNotificationRequest;
            }
            if (this._clientId == _loc_3.clientId && _loc_3.showMode != ExternalNotificationModeEnum.ALWAYS)
            {
                _loc_4 = this.dofusHasFocus;
                if (!_loc_4 && this._clientWindow.active)
                {
                    _loc_4 = true;
                }
                if (_loc_3.showMode == ExternalNotificationModeEnum.FOCUS_LOST_OTHER && _loc_4)
                {
                    return;
                }
            }
            if (this._isMaster && _loc_3.notificationType != ExternalNotificationTypeEnum.NONE)
            {
                if (this._notificationsOptions[_loc_3.notificationType].multi == false && this.isNotificationDuplicated(_loc_3.clientId, _loc_3.notificationType))
                {
                    return;
                }
            }
            this._buffer.push(_loc_3);
            this._timeOut.reset();
            this._timeOut.start();
            return;
        }// end function

        public function processRequest(param1:ExternalNotificationRequest) : void
        {
            var _loc_2:* = UiModuleManager.getInstance().getModule(this.MODULE_NAME);
            var _loc_3:* = Berilia.getInstance().loadUi(_loc_2, _loc_2.uis[param1.uiName], param1.instanceId, param1.displayData);
            var _loc_4:* = new ExternalNotificationWindow(param1.notificationType, param1.clientId, param1.id, _loc_3, this._nativeWinOpts, param1.hookName, param1.hookParams);
            this._notificationsList.push(_loc_4);
            this.setNotificationCoordinates(_loc_4);
            this.showExternalNotification(_loc_4);
            if (this._playSound)
            {
                switch(param1.uiName)
                {
                    case "achievementNotification":
                    {
                        SoundManager.getInstance().manager.playUISound(UISoundEnum.ACHIEVEMENT_UNLOCKED);
                        break;
                    }
                    default:
                    {
                        if (param1.playSound)
                        {
                            SoundManager.getInstance().manager.playUISound(UISoundEnum.POPUP_INFO);
                        }
                        break;
                        break;
                    }
                }
                this._playSound = false;
            }
            if (param1.notify)
            {
                if (param1.clientId != this._clientId)
                {
                    this.sendToSlave(param1.clientId, "notifyUser");
                }
                else
                {
                    this.notifyUser();
                }
            }
            return;
        }// end function

        private function processRequests(event:TimerEvent) : void
        {
            var bufferLen:int;
            var i:int;
            var pEvent:* = event;
            bufferLen = this._buffer.length;
            var maxLen:* = bufferLen > this._maxNotifications ? (this._maxNotifications) : (bufferLen);
            if (this._isMaster)
            {
                this._playSound = true;
                i;
                while (i < maxLen)
                {
                    
                    this.processRequest(this._buffer[bufferLen - maxLen + i]);
                    i = (i + 1);
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
                catch (ae:ArgumentError)
                {
                    if (bufferLen > _maxNotifications)
                    {
                        _buffer = _buffer.slice((bufferLen - 1) - _maxNotifications, (bufferLen - 1));
                    }
                    sendToMaster("handleNotificationRequest", JSON.encode(_buffer.pop()));
                    if (_buffer.length == 0)
                    {
                        _timeOut.stop();
                    }
                }
            }
            return;
        }// end function

        public function handleFocusRequest(param1:String, param2:String = null, param3:Array = null) : void
        {
            var _loc_4:* = null;
            if (param1 != this._clientId)
            {
                this.sendToSlave(param1, "handleFocusRequest", param1, param2, param3);
            }
            else
            {
                if (this._clientWindow.displayState != NativeWindowDisplayState.MINIMIZED)
                {
                    this.takeFocus();
                    this.toFront();
                }
                else
                {
                    this._clientWindow.restore();
                }
                if (param2 && param3)
                {
                    _loc_4 = Hook.getHookByName(param2);
                    if (_loc_4)
                    {
                        CallWithParameters.call(KernelEventsManager.getInstance().processCallback, new Array(_loc_4).concat(param3));
                    }
                }
            }
            return;
        }// end function

        private function showExternalNotification(param1:ExternalNotificationWindow) : void
        {
            param1.show();
            param1.timeoutId = setTimeout(this.destroyExternalNotification, this._timeoutDuration, param1);
            var _loc_2:* = this.isTopPosition(this._notificationsPosition) ? (param1.y > Capabilities.screenResolutionY - param1.contentHeight) : (param1.y < 0);
            if (this._notificationsList.length > this._maxNotifications || _loc_2)
            {
                this.destroyExternalNotification(this._notificationsList[0]);
            }
            return;
        }// end function

        public function closeExternalNotification(param1:String, param2:String, param3:Boolean = false) : void
        {
            var _loc_4:* = this.getExternalNotification(param1, param2);
            if (param3)
            {
                this._clientWindow.visible = false;
                _loc_4.addEventListener(Event.CLOSE, this.onExternalNotificationWindowClose);
            }
            this.destroyExternalNotification(_loc_4);
            return;
        }// end function

        private function onExternalNotificationWindowClose(event:Event) : void
        {
            var _loc_2:* = event.currentTarget as ExternalNotificationWindow;
            _loc_2.removeEventListener(Event.CLOSE, this.onExternalNotificationWindowClose);
            this.handleFocusRequest(_loc_2.clientId, _loc_2.hookName, _loc_2.hookParams);
            this._clientWindow.visible = true;
            return;
        }// end function

        public function resetNotificationDisplayTimeout(param1:String, param2:String) : void
        {
            var _loc_3:* = this.getExternalNotification(param1, param2);
            clearTimeout(_loc_3.timeoutId);
            _loc_3.timeoutId = setTimeout(this.destroyExternalNotification, this._timeoutDuration, _loc_3);
            return;
        }// end function

        private function setNotificationCoordinates(param1:ExternalNotificationWindow) : void
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_2:* = this._notificationsList.indexOf(param1);
            switch(this._notificationsPosition)
            {
                case ExternalNotificationPositionEnum.BOTTOM_RIGHT:
                {
                    _loc_3 = Capabilities.screenResolutionX - param1.contentWidth - this._startCoordinatesX;
                    if (_loc_2 == 0)
                    {
                        _loc_4 = Capabilities.screenResolutionY - param1.contentHeight - this._startCoordinatesY;
                    }
                    break;
                }
                case ExternalNotificationPositionEnum.BOTTOM_LEFT:
                {
                    _loc_3 = this._startCoordinatesX;
                    if (_loc_2 == 0)
                    {
                        _loc_4 = Capabilities.screenResolutionY - param1.contentHeight - this._startCoordinatesY;
                    }
                    break;
                }
                case ExternalNotificationPositionEnum.TOP_RIGHT:
                {
                    _loc_3 = Capabilities.screenResolutionX - param1.contentWidth - this._startCoordinatesX;
                    if (_loc_2 == 0)
                    {
                        _loc_4 = this._startCoordinatesY;
                    }
                    break;
                }
                case ExternalNotificationPositionEnum.TOP_LEFT:
                {
                    _loc_3 = this._startCoordinatesX;
                    if (_loc_2 == 0)
                    {
                        _loc_4 = this._startCoordinatesY;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_2 > 0)
            {
                if (this.isTopPosition(this._notificationsPosition))
                {
                    _loc_4 = this._notificationsList[(_loc_2 - 1)].y + (this._notificationsList[(_loc_2 - 1)].height + this.NOTIFICATION_SPACING);
                }
                else
                {
                    _loc_4 = this._notificationsList[(_loc_2 - 1)].y - (param1.contentHeight + this.NOTIFICATION_SPACING);
                }
            }
            param1.bounds = new Rectangle(_loc_3, _loc_4, param1.contentWidth, param1.contentHeight);
            return;
        }// end function

        private function changeNotificationsPosition(param1:int) : void
        {
            var _loc_2:* = this._notificationsList.length;
            this._notificationsPosition = param1;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                this.setNotificationCoordinates(this._notificationsList[_loc_3]);
                _loc_3++;
            }
            return;
        }// end function

        private function destroyExternalNotification(param1:ExternalNotificationWindow, param2:Boolean = true) : void
        {
            var _loc_4:* = 0;
            var _loc_6:* = NaN;
            clearTimeout(param1.timeoutId);
            param1.destroy();
            var _loc_3:* = this._notificationsList.length;
            var _loc_5:* = this._notificationsList.indexOf(param1);
            if (param2)
            {
                if (this._notificationsList.length > 0 && _loc_5 != (_loc_3 - 1))
                {
                    _loc_6 = param1.height + this.NOTIFICATION_SPACING;
                    if (this.isTopPosition(this._notificationsPosition))
                    {
                        _loc_6 = -_loc_6;
                    }
                    _loc_4 = _loc_3 - 1;
                    while (_loc_4 > _loc_5)
                    {
                        
                        this._notificationsList[_loc_4].y = this._notificationsList[_loc_4].y + _loc_6;
                        _loc_4 = _loc_4 - 1;
                    }
                }
            }
            this._notificationsList.splice(_loc_5, 1);
            return;
        }// end function

        public static function getInstance() : ExternalNotificationManager
        {
            if (!_instance)
            {
                _instance = new ExternalNotificationManager(new PrivateClass());
            }
            return _instance;
        }// end function

    }
}

import __AS3__.vec.*;

import by.blooddy.crypto.*;

import com.ankamagames.berilia.*;

import com.ankamagames.berilia.managers.*;

import com.ankamagames.berilia.types.data.*;

import com.ankamagames.berilia.types.graphic.*;

import com.ankamagames.dofus.datacenter.externalnotifications.*;

import com.ankamagames.dofus.externalnotification.enums.*;

import com.ankamagames.dofus.kernel.sound.*;

import com.ankamagames.dofus.kernel.sound.enum.*;

import com.ankamagames.dofus.logic.common.managers.*;

import com.ankamagames.jerakine.json.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.managers.*;

import com.ankamagames.jerakine.types.*;

import com.ankamagames.jerakine.types.enums.*;

import com.ankamagames.jerakine.types.events.*;

import com.ankamagames.jerakine.utils.display.*;

import com.ankamagames.jerakine.utils.misc.*;

import com.ankamagames.jerakine.utils.system.*;

import flash.desktop.*;

import flash.display.*;

import flash.events.*;

import flash.geom.*;

import flash.net.*;

import flash.system.*;

import flash.utils.*;

class PrivateClass extends Object
{

    function PrivateClass()
    {
        return;
    }// end function

}

