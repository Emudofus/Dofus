package com.ankamagames.dofus.externalnotification
{
    import __AS3__.vec.*;
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
    import com.ankamagames.jerakine.utils.crypto.*;
    import com.ankamagames.jerakine.utils.display.*;
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
        private var _notificationsWidth:Number;
        private var _notificationsHeight:Number;
        private var _timeoutDuration:Number;
        private var _replaceHeight:Number;
        private var _startCoordinates:Point;
        private var _dataStoreType:DataStoreType;
        private const NOTIFICATION_SPACING:Number = 10;
        private const NB_EVENTS_TYPES:int = 31;
        private const MODULE_NAME:String = "Ankama_GameUiCore";
        private const UI_NAME:String = "externalnotification";
        private const CONNECTION_ID:String = "_externalNotifications";
        private var _clientId:String;
        private var _isMaster:Boolean;
        private var _masterConnection:LocalConnection;
        private var _slaveConnection:LocalConnection;
        private var _slavesIds:Vector.<String>;
        private var dofusHasFocus:Boolean;
        private static const DEBUG:Boolean = false;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(ExternalNotificationManager));
        private static var _instance:ExternalNotificationManager;

        public function ExternalNotificationManager(param1:PrivateClass)
        {
            this._startCoordinates = new Point(25, 50);
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

        public function getNotificationValue(param1:int) : int
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            this.log("getNotificationValue " + param1);
            var _loc_2:* = StoreDataManager.getInstance().getSetData(this._dataStoreType, "notificationsEvent" + param1, -1);
            if (_loc_2 == -1)
            {
                _loc_3 = ExternalNotification.getExternalNotifications();
                _loc_2 = 0;
                for each (_loc_4 in _loc_3)
                {
                    
                    if (ExternalNotificationTypeEnum[_loc_4.name] == param1)
                    {
                        if (_loc_4.defaultEnable == true)
                        {
                            _loc_2 = _loc_2 + 1;
                        }
                        if (_loc_4.defaultSound == true)
                        {
                            _loc_2 = _loc_2 + 2;
                        }
                        if (_loc_4.defaultMultiAccount == true)
                        {
                            _loc_2 = _loc_2 + 4;
                        }
                        break;
                    }
                }
                this.setNotificationValue(param1, _loc_2);
            }
            return _loc_2;
        }// end function

        public function setNotificationValue(param1:int, param2:int) : void
        {
            var _loc_3:* = false;
            var _loc_4:* = false;
            this.log("setNotificationValue " + param1 + " " + param2);
            StoreDataManager.getInstance().setData(this._dataStoreType, "notificationsEvent" + param1, param2);
            if (this._initialized)
            {
                _loc_3 = (param2 & 4) > 0;
                _loc_4 = this._notificationsOptions[param1].multiaccount != _loc_3;
                this.setNotificationOptions(param1, param2);
                if (_loc_4)
                {
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
            this.log("setOptionValue " + param1 + " " + param2);
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
            this.log("init datastoretype");
            var _loc_1:* = "externalNotifications_" + MD5.hash(PlayerManager.getInstance().nickname);
            if (!this._dataStoreType || this._dataStoreType.category != _loc_1)
            {
                this._dataStoreType = new DataStoreType(_loc_1, true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_CHARACTER);
            }
            return;
        }// end function

        public function init() : void
        {
            this.log("ExternalNotificationManager init");
            this.initDataStoreType();
            this._notificationsList = new Vector.<ExternalNotificationWindow>(0);
            this._notificationsOptions = new Dictionary();
            this._notificationsWidth = 346;
            this._notificationsHeight = 90;
            this._replaceHeight = this._notificationsHeight + this.NOTIFICATION_SPACING;
            this.setNotificationsMode(this.getOptionValue("notificationsMode"));
            this.setDisplayDuration(this.getOptionValue("notificationsDisplayDuration"));
            this.setMaxNotifications(this.getOptionValue("notificationsMaxNumber"));
            var i:int;
            while (i <= this.NB_EVENTS_TYPES)
            {
                
                this.setNotificationOptions(i, this.getNotificationValue(i));
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
            this.log("is master:" + this._isMaster);
            this._clientWindow.addEventListener(Event.ACTIVATE, this.onWindowActivate);
            this._clientWindow.addEventListener(Event.DEACTIVATE, this.onWindowDeactivate);
            this._clientWindow.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE, this.onDisplayStateChange);
            this._clientWindow.addEventListener(Event.CLOSING, this.onClientClosing);
            this._clientWindow.addEventListener(Event.CLOSE, this.onClientClose);
            this._notificationsEnabled = this._clientWindow.active ? (false) : (true);
            this._initialized = true;
            return;
        }// end function

        public function reset() : void
        {
            this.log("reset");
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
            OptionManager.getOptionManager("dofus").removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            this._clientWindow.removeEventListener(Event.ACTIVATE, this.onWindowActivate);
            this._clientWindow.removeEventListener(Event.DEACTIVATE, this.onWindowDeactivate);
            this._clientWindow.removeEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE, this.onDisplayStateChange);
            this._clientWindow.removeEventListener(Event.CLOSING, this.onClientClosing);
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
            this.log("window activate " + this._clientId + " " + this._clientWindow.active);
            this._notificationsEnabled = false;
            if (!this._isMaster)
            {
                this.sendToMaster("updateDofusFocus", this._clientId, this._clientWindow.active);
            }
            return;
        }// end function

        private function onWindowDeactivate(event:Event) : void
        {
            this.log("window deactivate " + this._clientId + " " + this._clientWindow.active);
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

        private function onDisplayStateChange(event:NativeWindowDisplayStateEvent) : void
        {
            this.log("display state change " + event.afterDisplayState);
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
            this.log("on window closing");
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
            this.log("on window close " + this._notificationsList.length);
            this._clientWindow.removeEventListener(Event.CLOSE, this.onClientClose);
            if (this._isMaster)
            {
                this.closeAllNotifications();
            }
            return;
        }// end function

        public function updateDofusFocus(param1:String, param2:Boolean) : void
        {
            this.log("updateDofusFocus " + param1 + " " + param2);
            this.log("master active : " + this._clientWindow.active);
            this.dofusHasFocus = param2;
            if (this._slavesIds.indexOf(param1) == -1)
            {
                this._slavesIds.push(param1);
            }
            this.log("dofusHasFocus : " + this.dofusHasFocus);
            return;
        }// end function

        private function takeFocus() : void
        {
            this.log("takeFocus " + this._clientId + " active:" + this._clientWindow.active + " focus:" + this._clientWindow.stage.focus);
            this._clientWindow.alwaysInFront = true;
            this._clientWindow.orderToFront();
            this._clientWindow.alwaysInFront = false;
            if (this._clientWindow.displayState == NativeWindowDisplayState.MINIMIZED)
            {
                this._clientWindow.activate();
            }
            else
            {
                NativeApplication.nativeApplication.activate(NativeApplication.nativeApplication.openedWindows[0]);
            }
            return;
        }// end function

        private function removeFocus() : void
        {
            this.log("removeFocus " + this._clientId + " active:" + this._clientWindow.active + " focus:" + this._clientWindow.stage.focus);
            this._clientWindow.stage.focus = null;
            this._clientWindow.dispatchEvent(new Event(Event.DEACTIVATE, false, false));
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

        public function get showMode() : int
        {
            return this._showMode;
        }// end function

        public function get notificationsEnabled() : Boolean
        {
            this.log("notificationsEnabled ? " + this._clientId + " " + this._showMode + " " + this._clientWindow.active);
            return this._showMode == ExternalNotificationModeEnum.DISABLED ? (false) : (this._notificationsEnabled);
        }// end function

        public function get windowHeight() : Number
        {
            return this._notificationsHeight;
        }// end function

        public function get windowWidth() : Number
        {
            return this._notificationsWidth;
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
            this.log("getExternalNotification " + param1 + " " + param2 + " " + _loc_3);
            return _loc_3;
        }// end function

        private function getExternalNotifications(param1:String) : Vector.<ExternalNotificationWindow>
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this.log("getExternalNotifications " + param1);
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

        public function updateProperty(param1:String, param2, param3) : void
        {
            var _loc_4:* = new PropertyChangeEvent(OptionManager.getOptionManager("dofus"), param1, param2, param3);
            this.onPropertyChanged(_loc_4, true);
            return;
        }// end function

        private function onPropertyChanged(event:PropertyChangeEvent, param2:Boolean = false) : void
        {
            this.log("onPropertyChanged " + param2 + " " + event.propertyName + " " + event.propertyValue + " " + event.propertyOldValue);
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
                    break;
                }
            }
            this.setOptionValue(event.propertyName, event.propertyValue);
            if (!this._isMaster)
            {
                if (!param2)
                {
                    this.sendToMaster("updateProperty", event.propertyName, event.propertyValue, event.propertyOldValue);
                }
            }
            else
            {
                this.sendToSlaves("updateProperty", event.propertyName, event.propertyValue, event.propertyOldValue);
            }
            return;
        }// end function

        private function synchronizeMultiAccountOptions() : void
        {
            this.log("synchronizeMultiAccountOptions " + this._clientId);
            var _loc_1:* = new Array();
            var _loc_2:* = 1;
            while (_loc_2 <= this.NB_EVENTS_TYPES)
            {
                
                _loc_1.push(this._notificationsOptions[_loc_2].multiaccount);
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
            this.log("updateAllMultiAccountOptions " + param1);
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
            this.log("updateMultiAccountOption " + param1 + " " + param2);
            var _loc_3:* = 0;
            if (!this._notificationsOptions[param1].ignored)
            {
                _loc_3 = _loc_3 + 1;
            }
            if (this._notificationsOptions[param1].sound)
            {
                _loc_3 = _loc_3 + 2;
            }
            this._notificationsOptions[param1].multiaccount = param2;
            if (this._notificationsOptions[param1].multiaccount)
            {
                _loc_3 = _loc_3 + 4;
            }
            StoreDataManager.getInstance().setData(this._dataStoreType, "notificationsEvent" + param1, _loc_3);
            return;
        }// end function

        public function setNotificationOptions(param1:int, param2:int) : void
        {
            this.log("setNotificationOptions " + param1 + " " + param2);
            this._notificationsOptions[param1] = {ignored:(param2 & 1) == 0, sound:(param2 & 2) > 0, multiaccount:(param2 & 4) > 0};
            return;
        }// end function

        public function setNotificationsPosition(param1:int) : void
        {
            this.log("change notificationsPosition from " + this._notificationsPosition + " to " + param1);
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
            this.log("change maxNotifications to " + param1);
            return;
        }// end function

        public function setNotificationsMode(param1:int) : void
        {
            this._showMode = param1;
            this.log("change notificationsMode to " + param1);
            return;
        }// end function

        public function setDisplayDuration(param1:Number) : void
        {
            this._timeoutDuration = param1 * 1000;
            this.log("change notificationsDisplayDuration to " + this._timeoutDuration);
            return;
        }// end function

        public function isExternalNotificationTypeIgnored(param1:int) : Boolean
        {
            var _loc_2:* = this._notificationsOptions[param1];
            this.log("isExternalNotificationTypeIgnored " + param1 + " " + _loc_2.ignored);
            return _loc_2.ignored;
        }// end function

        private function ignoreExternalNotificationType(param1:int) : void
        {
            var _loc_2:* = this._notificationsOptions[param1];
            _loc_2.ignored = true;
            return;
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
            this.log("onConnectionError " + event.error.getStackTrace());
            return;
        }// end function

        private function onConnectionStatus(event:StatusEvent) : void
        {
            return;
        }// end function

        private function onConnectionSecurityError(event:SecurityErrorEvent) : void
        {
            this.log("onConnectionSecurityError " + event);
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
                log("master connection close fail");
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
                log("slave connection close fail");
            }
            return;
        }// end function

        private function sendToMaster(param1:String, ... args) : void
        {
            args = new activation;
            var argArray:Array;
            var pMethodName:* = param1;
            var pArgs:* = args;
            try
            {
                argArray = [this.CONNECTION_ID, ].concat();
                this.log("try " +  + " " + );
                this._masterConnection.send.apply(this, );
            }
            catch (e:Error)
            {
                log("send fail");
            }
            return;
        }// end function

        private function sendToSlave(param1:String, param2:String, ... args) : void
        {
            args = new activation;
            var argArray:Array;
            var len:int;
            var i:int;
            var params:*;
            var len2:int;
            var j:int;
            var pSlaveId:* = param1;
            var pMethodName:* = param2;
            var pArgs:* = args;
            try
            {
                argArray = [this.CONNECTION_ID + "." + , ].concat();
                len = length;
                i;
                while ( < )
                {
                    
                    params = [];
                    if ( is Array)
                    {
                        splice(, 1);
                        len2 = length;
                        j;
                        while ( < )
                        {
                            
                            splice( + , 0, []);
                            j = ( + 1);
                        }
                    }
                    i = ( + 1);
                }
                this.log("try " +  + " " +  + " " + );
                this._slaveConnection.send.apply(this, );
            }
            catch (e:Error)
            {
                log("send fail");
            }
            return;
        }// end function

        private function sendToSlaves(param1:String, ... args) : void
        {
            args = null;
            this.log("sendToSlaves " + param1 + " " + args);
            for each (args in this._slavesIds)
            {
                
                this.sendToSlave(args, param1, args);
            }
            return;
        }// end function

        private function becomeMaster() : void
        {
            this._masterConnection.client = getInstance();
            this._masterConnection.connect(this.CONNECTION_ID);
            this._clientId = "master";
            this._slavesIds = new Vector.<String>(0);
            this.log("becomeMaster");
            this._isMaster = true;
            return;
        }// end function

        private function becomeSlave() : void
        {
            this._clientId = "slave" + Math.floor(Math.random() * 100000000);
            this._slaveConnection.client = getInstance();
            this._slaveConnection.connect(this.CONNECTION_ID + "." + this._clientId);
            this.log("becomeSlave " + this._clientId);
            this._isMaster = false;
            this.sendToMaster("updateDofusFocus", this._clientId, this._clientWindow.active);
            return;
        }// end function

        public function unregisterSlave(param1:String) : void
        {
            var _loc_3:* = null;
            this.log("unregisterSlave " + param1);
            this.updateDofusFocus(param1, false);
            this._slavesIds.splice(this._slavesIds.indexOf(param1), 1);
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

        public function handleNotificationRequest(param1:Object) : void
        {
            var req:ExternalNotificationRequest;
            var pExtNotifRequest:* = param1;
            this.log("handleNotificationRequest " + pExtNotifRequest);
            if (!this._isMaster)
            {
                try
                {
                    this.log("slave try to become master");
                    this.becomeMaster();
                    this.closeSlaveConnection();
                }
                catch (ae:ArgumentError)
                {
                    log("there\'s already a master");
                    sendToMaster("handleNotificationRequest", JSON.encode(pExtNotifRequest));
                    log("send external notification request to master");
                    return;
                }
            }
            if (pExtNotifRequest is String)
            {
                req = ExternalNotificationRequest.createFromJSONString(pExtNotifRequest as String);
            }
            else
            {
                req = pExtNotifRequest as ExternalNotificationRequest;
            }
            if (this._notificationsOptions[req.notificationType].multiaccount == false && this.isNotificationDuplicated(req.clientId, req.notificationType))
            {
                this.log("notification request ignored because of multiaccount option");
                return;
            }
            this.log("client has focus:" + this._clientWindow.active + " dofus has focus:" + this.dofusHasFocus);
            var focus:* = this.dofusHasFocus;
            if (!focus && this._clientWindow.active)
            {
                focus;
            }
            this.log("focus:" + focus + " showMode:" + this._showMode + " req showMode:" + req.showMode);
            if (this._showMode == ExternalNotificationModeEnum.FOCUS_LOST_OTHER && focus)
            {
                this.log("notification request ignored because of focus mode");
                return;
            }
            var mod:* = UiModuleManager.getInstance().getModule(this.MODULE_NAME);
            var ctr:* = Berilia.getInstance().loadUi(mod, mod.uis[this.UI_NAME], req.instanceId, [req.title, req.iconId, req.iconBgColorId, req.message, req.css, req.cssClass], false, 1, false, null);
            this.createExternalNotification(req.notificationType, req.clientId, req.id, ctr);
            return;
        }// end function

        public function handleFocusRequest(param1:String) : void
        {
            this.log("handleFocusRequest " + param1 + " " + this._clientId);
            if (param1 != this._clientId)
            {
                this.removeFocus();
                this.sendToSlave(param1, "handleFocusRequest", param1);
            }
            else
            {
                this.takeFocus();
            }
            return;
        }// end function

        private function createExternalNotification(param1:int, param2:String, param3:String, param4:Object) : void
        {
            this.log("createExternalNotification " + param2 + " " + param3 + " " + param4 + " " + param4.name);
            var _loc_5:* = this.getNotificationCoordinates(this._notificationsPosition, this._notificationsList.length);
            var _loc_6:* = new ExternalNotificationWindow(param1, param2, param3, param4, this._notificationsWidth, this._notificationsHeight, _loc_5);
            this._notificationsList.push(_loc_6);
            _loc_6.order = this._notificationsList.length;
            this.showExternalNotification(_loc_6);
            return;
        }// end function

        private function showExternalNotification(param1:ExternalNotificationWindow) : void
        {
            this.log("showExternalNotification " + param1.clientId + " " + param1.id);
            param1.show();
            if (this._notificationsOptions[param1.notificationType].sound == true)
            {
                SoundManager.getInstance().manager.playUISound(UISoundEnum.POPUP_INFO);
            }
            param1.timeoutId = setTimeout(this.destroyExternalNotification, this._timeoutDuration, param1);
            var _loc_2:* = this.isTopPosition(this._notificationsPosition) ? (param1.y > Capabilities.screenResolutionY - this._notificationsHeight) : (param1.y < 0);
            if (this._notificationsList.length > this._maxNotifications || _loc_2)
            {
                this.destroyExternalNotification(this._notificationsList[0]);
            }
            return;
        }// end function

        public function closeExternalNotification(param1:String, param2:String, param3:Boolean = false) : void
        {
            this.log("closeExternalNotification " + param1 + " " + param2 + " " + param3);
            var _loc_4:* = this.getExternalNotification(param1, param2);
            if (param3)
            {
                _loc_4.addEventListener(Event.CLOSE, this.onExternalNotificationWindowClose);
            }
            this.destroyExternalNotification(_loc_4);
            return;
        }// end function

        private function onExternalNotificationWindowClose(event:Event) : void
        {
            var _loc_2:* = event.currentTarget as ExternalNotificationWindow;
            _loc_2.removeEventListener(Event.CLOSE, this.onExternalNotificationWindowClose);
            this.log("onExternalNotificationWindowClose " + _loc_2.closed);
            this.handleFocusRequest(_loc_2.clientId);
            return;
        }// end function

        private function getNotificationCoordinates(param1:int, param2:uint) : Point
        {
            var _loc_3:* = new Point();
            switch(param1)
            {
                case ExternalNotificationPositionEnum.BOTTOM_RIGHT:
                {
                    _loc_3.x = Capabilities.screenResolutionX - this._notificationsWidth - this._startCoordinates.x;
                    _loc_3.y = Capabilities.screenResolutionY - this._notificationsHeight - this._startCoordinates.y;
                    break;
                }
                case ExternalNotificationPositionEnum.BOTTOM_LEFT:
                {
                    _loc_3.x = this._startCoordinates.x;
                    _loc_3.y = Capabilities.screenResolutionY - this._notificationsHeight - this._startCoordinates.y;
                    break;
                }
                case ExternalNotificationPositionEnum.TOP_RIGHT:
                {
                    _loc_3.x = Capabilities.screenResolutionX - this._notificationsWidth - this._startCoordinates.x;
                    _loc_3.y = this._startCoordinates.y;
                    break;
                }
                case ExternalNotificationPositionEnum.TOP_LEFT:
                {
                    _loc_3.x = this._startCoordinates.x;
                    _loc_3.y = this._startCoordinates.y;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._notificationsList.length > 0)
            {
                if (this.isTopPosition(param1))
                {
                    _loc_3.y = _loc_3.y + (this._notificationsHeight + this.NOTIFICATION_SPACING) * param2;
                }
                else
                {
                    _loc_3.y = _loc_3.y - (this._notificationsHeight + this.NOTIFICATION_SPACING) * param2;
                }
            }
            return _loc_3;
        }// end function

        private function changeNotificationsPosition(param1:int) : void
        {
            var _loc_4:* = null;
            this.log("changeNotificationsPosition " + param1);
            var _loc_2:* = this._notificationsList.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this.getNotificationCoordinates(param1, _loc_3);
                this._notificationsList[_loc_3].x = _loc_4.x;
                this._notificationsList[_loc_3].y = _loc_4.y;
                _loc_3++;
            }
            return;
        }// end function

        private function destroyExternalNotification(param1:ExternalNotificationWindow, param2:Boolean = true) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            this.log("destroyExternalnotification " + param1.instanceId + " " + param1.order + " " + param2);
            clearTimeout(param1.timeoutId);
            param1.destroy();
            this._notificationsList.splice(this._notificationsList.indexOf(param1), 1);
            if (param2)
            {
                if (this._notificationsList.length > 0)
                {
                    if (this.isTopPosition(this._notificationsPosition))
                    {
                        for each (_loc_3 in this._notificationsList)
                        {
                            
                            if (_loc_3.order > param1.order)
                            {
                                _loc_3.y = _loc_3.y - this._replaceHeight;
                            }
                        }
                    }
                    else
                    {
                        for each (_loc_3 in this._notificationsList)
                        {
                            
                            if (_loc_3.order > param1.order)
                            {
                                _loc_3.y = _loc_3.y + this._replaceHeight;
                            }
                        }
                    }
                    _loc_4 = this._notificationsList.length;
                    _loc_5 = 0;
                    while (_loc_5 < _loc_4)
                    {
                        
                        this._notificationsList[_loc_5].order = _loc_5 + 1;
                        _loc_5++;
                    }
                }
            }
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

import com.ankamagames.jerakine.utils.crypto.*;

import com.ankamagames.jerakine.utils.display.*;

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

