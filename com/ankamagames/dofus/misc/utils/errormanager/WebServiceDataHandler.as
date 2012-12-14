package com.ankamagames.dofus.misc.utils.errormanager
{
    import __AS3__.vec.*;
    import by.blooddy.crypto.*;
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.logger.targets.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.events.*;
    import flash.utils.*;

    public class WebServiceDataHandler extends EventDispatcher
    {
        private var _log:Logger;
        private var _exceptionsList:Vector.<DataExceptionModel>;
        private var _webService:RpcServiceManager;
        private var _exceptionsInProgress:Dictionary;
        private var _timersList:Dictionary;
        private var _previousErrorType:String = "";
        public static var buffer:LimitedBufferTarget;
        private static var _self:WebServiceDataHandler;
        private static var LIMIT_REBOOT:int = 20;
        public static const ALL_DATA_SENT:String = "everythings has been sent";
        private static const MIN_DELAY:int = 30;
        private static const MAX_DELAY:int = 270;
        private static var BASE_URL:String = "http://api.ankama.";

        public function WebServiceDataHandler(param1:PrivateClass)
        {
            this._log = Log.getLogger(getQualifiedClassName(WebServiceDataHandler));
            this._exceptionsList = new Vector.<DataExceptionModel>;
            this._exceptionsInProgress = new Dictionary(true);
            this._timersList = new Dictionary(true);
            if (param1 == null)
            {
                throw new SingletonError();
            }
            if (BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE || BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA || BuildInfos.BUILD_TYPE == BuildTypeEnum.ALPHA)
            {
                BASE_URL = BASE_URL + "com";
            }
            else
            {
                BASE_URL = BASE_URL + "lan";
            }
            return;
        }// end function

        public function createNewException(param1:Object, param2:String) : DataExceptionModel
        {
            var _loc_5:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            if (this._previousErrorType == "ONE" && this._exceptionsList.length >= 1)
            {
                return null;
            }
            this._previousErrorType = this.getSendingType(param2);
            var _loc_3:* = new DataExceptionModel();
            if (param1.stacktrace == null)
            {
                return null;
            }
            _loc_3.hash = MD5.hash(this.cleanStacktrace(param1.stacktrace));
            _loc_3.stacktrace = param1.stacktrace;
            if (param1.errorMsg != null && param1.errorMsg != "")
            {
                _loc_3.stacktrace = param1.errorMsg + "\n" + _loc_3.stacktrace;
            }
            _loc_3.buildType = param1.buildType;
            _loc_3.buildVersion = param1.buildVersion;
            if (_loc_3.buildType == "INTERNAL" || _loc_3.buildType == "DEBUG")
            {
                _loc_8 = new Date();
                _loc_9 = _loc_3.buildVersion.split(".");
                _loc_3.buildVersion.split(".")[_loc_9.length - 2] = DateFormat.dayOfYear(_loc_8.fullYear, _loc_8.month, _loc_8.date);
                _loc_9.pop();
                _loc_3.buildVersion = _loc_9.join(".");
            }
            var _loc_4:* = param1.os.split(" ");
            _loc_3.osType = _loc_4[0];
            _loc_3.osVersion = _loc_4[1] ? (_loc_4[1]) : ("");
            _loc_3.logsSos = buffer.getFormatedBuffer();
            _loc_3.serverId = param1.serverId;
            _loc_3.mapId = param1.idMap;
            _loc_3.characterId = param1.characterId;
            _loc_3.isInFight = param1.wasFighting;
            _loc_3.isMultiAccount = param1.multicompte;
            _loc_3.date = TimeManager.getInstance().getTimestamp() / 1000;
            var _loc_6:* = "";
            for each (_loc_5 in Kernel.getWorker().framesList)
            {
                
                _loc_7 = getQualifiedClassName(_loc_5).split("::");
                _loc_6 = _loc_6 + (String(_loc_7[1] ? (_loc_7[1]) : (_loc_7[0])).replace("Frame", "") + ",");
            }
            _loc_3.framesList = _loc_6;
            this._exceptionsList.push(_loc_3);
            return _loc_3;
        }// end function

        public function cleanStacktrace(param1:String) : String
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_2:* = "";
            var _loc_3:* = param1.split("\n");
            for each (_loc_4 in _loc_3)
            {
                
                _loc_5 = _loc_3.indexOf(_loc_4);
                if (_loc_5 > 0)
                {
                    _loc_4 = _loc_4.replace(/\\\"""\\/g, "/");
                }
                _loc_6 = /^(.*?\[)(.*?)((\/modules\/Ankama_|\/com\/ankama).*?)(:?[0-9]*?)(\].*?)""^(.*?\[)(.*?)((\/modules\/Ankama_|\/com\/ankama).*?)(:?[0-9]*?)(\].*?)/g;
                _loc_2 = _loc_2 + _loc_4.replace(_loc_6, "$1$3$6");
                if (_loc_5 < (_loc_3.length - 1))
                {
                    _loc_2 = _loc_2 + "\n";
                }
            }
            return _loc_2;
        }// end function

        private function sendDataToWebservice(param1:DataExceptionModel) : void
        {
            if (param1 == null)
            {
                return;
            }
            if (this._webService == null)
            {
                this.initWebService();
            }
            this._webService.callMethod("Exception", {sHash:param1.hash, sStacktrace:param1.stacktrace, iVersion:param1.buildType, iBuildVersion:param1.buildVersion, iDate:param1.date, sOs:param1.osType, sOsVersion:param1.osVersion, iServerId:param1.serverId, iCharacterId:param1.characterId, iMapId:param1.mapId, bMultipleAccout:param1.isMultiAccount, bIsFighting:param1.isInFight, sFrameList:param1.framesList, sCustom:param1.logsSos, sErrorType:param1.errorType});
            return;
        }// end function

        private function onDataSavedComplete(event:Event) : void
        {
            var _loc_2:* = event.currentTarget as RpcServiceManager;
            var _loc_3:* = _loc_2.requestData.params.sHash;
            if (this._exceptionsInProgress[_loc_3])
            {
                (this._exceptionsInProgress[_loc_3] as DataExceptionModel).sent = true;
                delete this._exceptionsInProgress[_loc_3];
            }
            if (this.getWaitingExceptionsNumber() == 0)
            {
                dispatchEvent(new Event(ALL_DATA_SENT));
            }
            return;
        }// end function

        private function getWaitingExceptionsNumber() : int
        {
            var _loc_2:* = undefined;
            var _loc_1:* = 0;
            for (_loc_2 in this._exceptionsInProgress)
            {
                
                _loc_1++;
            }
            return _loc_1;
        }// end function

        private function onDataSavedError(event:Event) : void
        {
            this._log.trace(event.toString());
            var _loc_2:* = event.currentTarget as RpcServiceManager;
            return;
        }// end function

        private function initWebService() : void
        {
            var _loc_1:* = BASE_URL + "/dofus/logger.json";
            this._webService = new RpcServiceManager(_loc_1, "json");
            this._webService.addEventListener(Event.COMPLETE, this.onDataSavedComplete);
            this._webService.addEventListener(IOErrorEvent.IO_ERROR, this.onDataSavedError);
            this._webService.addEventListener(RpcServiceManager.SERVER_ERROR, this.onDataSavedError);
            return;
        }// end function

        public function clearService(param1:RpcServiceManager = null) : void
        {
            if (param1 == null)
            {
                param1 = this._webService;
            }
            param1.removeEventListener(Event.COMPLETE, this.onDataSavedComplete);
            param1.removeEventListener(IOErrorEvent.IO_ERROR, this.onDataSavedError);
            param1.removeEventListener(RpcServiceManager.SERVER_ERROR, this.onDataSavedError);
            param1.destroy();
            param1 = null;
            return;
        }// end function

        public function saveException(param1:DataExceptionModel, param2:Boolean = false) : void
        {
            var v:int;
            var t:Timer;
            var exception:* = param1;
            var forceSend:* = param2;
            if (forceSend)
            {
                this.sendDataToWebservice(exception);
                this._exceptionsInProgress[exception.hash] = exception;
            }
            else
            {
                v = Math.round(Math.random() * MAX_DELAY * 1000 + MIN_DELAY * 1000);
                t = new Timer(v, 1);
                this._exceptionsInProgress[exception.hash] = exception;
                this._timersList[t] = null;
                with ({})
                {
                    {}.e = function (event:TimerEvent) : void
            {
                sendDataToWebservice(exception);
                (event.currentTarget as Timer).stop();
                return;
            }// end function
            ;
                }
                t.addEventListener(TimerEvent.TIMER_COMPLETE, function (event:TimerEvent) : void
            {
                sendDataToWebservice(exception);
                (event.currentTarget as Timer).stop();
                return;
            }// end function
            );
                t.start();
            }
            return;
        }// end function

        public function sendWaitingException() : void
        {
            var _loc_1:* = undefined;
            var _loc_2:* = null;
            for (_loc_1 in this._timersList)
            {
                
                (_loc_1 as Timer).stop();
                _loc_1 = null;
            }
            for each (_loc_2 in this._exceptionsList)
            {
                
                if (!_loc_2.sent)
                {
                    this.saveException(_loc_2, true);
                }
            }
            return;
        }// end function

        public function quit() : Boolean
        {
            if (this._exceptionsList.length == 0)
            {
                return false;
            }
            var exception:* = this._exceptionsList[(this._exceptionsList.length - 1)];
            var d:* = new Date();
            if (Math.round(d.time / 1000) - exception.date <= LIMIT_REBOOT)
            {
                exception.isBlockerAndReboot = true;
            }
            if (this._exceptionsList.length > 0)
            {
                with ({})
                {
                    {}.e = function () : void
            {
                dispatchEvent(new Event(ALL_DATA_SENT));
                return;
            }// end function
            ;
                }
                setInterval(function () : void
            {
                dispatchEvent(new Event(ALL_DATA_SENT));
                return;
            }// end function
            , 3000);
                return true;
            }
            return false;
        }// end function

        public function changeCharacter() : void
        {
            var _loc_2:* = null;
            if (this._exceptionsList == null || this._exceptionsList.length == 0)
            {
                return;
            }
            var _loc_1:* = new Date();
            for each (_loc_2 in this._exceptionsList)
            {
                
                if (_loc_2 != null && Math.round(_loc_1.time / 1000) - _loc_2.date <= LIMIT_REBOOT)
                {
                    _loc_2.isBlockerAndChangeCharacter = true;
                }
            }
            return;
        }// end function

        public function getSendingType(param1:String) : String
        {
            switch(param1.toLowerCase())
            {
                case "error":
                {
                }
                default:
                {
                    return "ONE";
                    break;
                }
            }
        }// end function

        public function reset() : void
        {
            this._previousErrorType = "";
            this._exceptionsList = new Vector.<DataExceptionModel>;
            return;
        }// end function

        public static function getInstance() : WebServiceDataHandler
        {
            if (_self == null)
            {
                _self = new WebServiceDataHandler(new PrivateClass());
            }
            return _self;
        }// end function

    }
}

import __AS3__.vec.*;

import by.blooddy.crypto.*;

import com.ankamagames.dofus.*;

import com.ankamagames.dofus.kernel.*;

import com.ankamagames.dofus.logic.game.common.managers.*;

import com.ankamagames.dofus.misc.utils.*;

import com.ankamagames.dofus.network.enums.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.logger.targets.*;

import com.ankamagames.jerakine.messages.*;

import com.ankamagames.jerakine.utils.errors.*;

import flash.events.*;

import flash.utils.*;

class PrivateClass extends Object
{

    function PrivateClass()
    {
        return;
    }// end function

}

