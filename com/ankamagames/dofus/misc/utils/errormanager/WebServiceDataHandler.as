package com.ankamagames.dofus.misc.utils.errormanager
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.targets.LimitedBufferTarget;
   import com.ankamagames.jerakine.logger.Logger;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.misc.utils.RpcServiceManager;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.messages.Frame;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import by.blooddy.crypto.MD5;
   import com.ankamagames.dofus.misc.utils.DateFormat;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.logger.TextLogEvent;
   import by.blooddy.crypto.Base64;
   import by.blooddy.crypto.image.JPEGEncoder;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import flash.utils.getQualifiedClassName;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import flash.utils.setInterval;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   
   public class WebServiceDataHandler extends EventDispatcher
   {
      
      public function WebServiceDataHandler(param1:PrivateClass) {
         this._log = Log.getLogger(getQualifiedClassName(WebServiceDataHandler));
         this._exceptionsList = new Vector.<DataExceptionModel>();
         this._exceptionsInProgress = new Dictionary(true);
         this._timersList = new Dictionary(true);
         super();
         if(param1 == null)
         {
            throw new SingletonError();
         }
         else
         {
            if(BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE || BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA || BuildInfos.BUILD_TYPE == BuildTypeEnum.ALPHA)
            {
               BASE_URL = BASE_URL + "com";
            }
            else
            {
               BASE_URL = BASE_URL + "lan";
            }
            return;
         }
      }
      
      public static var ENABLE_SCREENSHOT:Boolean = true;
      
      public static var buffer:LimitedBufferTarget;
      
      private static var _self:WebServiceDataHandler;
      
      private static var LIMIT_REBOOT:int = 20;
      
      public static const ALL_DATA_SENT:String = "everythings has been sent";
      
      private static const MIN_DELAY:int = 30;
      
      private static const MAX_DELAY:int = 5 * 60 - MIN_DELAY;
      
      private static var BASE_URL:String = "http://api.ankama.";
      
      public static function getInstance() : WebServiceDataHandler {
         if(_self == null)
         {
            _self = new WebServiceDataHandler(new PrivateClass());
         }
         return _self;
      }
      
      private var _log:Logger;
      
      private var _exceptionsList:Vector.<DataExceptionModel>;
      
      private var _webService:RpcServiceManager;
      
      private var _exceptionsInProgress:Dictionary;
      
      private var _timersList:Dictionary;
      
      private var _previousErrorType:String = "";
      
      public function createNewException(param1:Object, param2:String) : DataExceptionModel {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function cleanStacktrace(param1:String) : String {
         var _loc4_:String = null;
         var _loc5_:* = 0;
         var _loc6_:RegExp = null;
         var _loc2_:* = "";
         var _loc3_:Array = param1.split("\n");
         for each (_loc4_ in _loc3_)
         {
            _loc5_ = _loc3_.indexOf(_loc4_);
            if(_loc5_ > 0)
            {
               _loc4_ = _loc4_.replace(new RegExp("\\\\","g"),"/");
            }
            _loc6_ = new RegExp("^(.*?\\[)(.*?)((\\/modules\\/Ankama_|\\/com\\/ankama).*?)(:?[0-9]*?)(\\].*?)","g");
            _loc2_ = _loc2_ + _loc4_.replace(_loc6_,"$1$3$6");
            if(_loc5_ < _loc3_.length-1)
            {
               _loc2_ = _loc2_ + "\n";
            }
         }
         return _loc2_;
      }
      
      private function sendDataToWebservice(param1:DataExceptionModel) : void {
         if(param1 == null)
         {
            return;
         }
         if(this._webService == null)
         {
            this.initWebService();
         }
         this._webService.callMethod("Exception",
            {
               "sHash":param1.hash,
               "sStacktrace":param1.stacktrace,
               "iVersion":param1.buildType,
               "iBuildVersion":param1.buildVersion,
               "iDate":param1.date,
               "sOs":param1.osType,
               "sOsVersion":param1.osVersion,
               "iServerId":param1.serverId,
               "iCharacterId":param1.characterId,
               "iMapId":param1.mapId,
               "bMultipleAccout":param1.isMultiAccount,
               "bIsFighting":param1.isInFight,
               "sFrameList":param1.framesList,
               "sCustom":param1.logsSos,
               "sErrorType":param1.errorType
            });
      }
      
      private function onDataSavedComplete(param1:Event) : void {
         var _loc2_:RpcServiceManager = param1.currentTarget as RpcServiceManager;
         var _loc3_:String = _loc2_.requestData.params.sHash;
         if(this._exceptionsInProgress[_loc3_])
         {
            (this._exceptionsInProgress[_loc3_] as DataExceptionModel).sent = true;
            delete this._exceptionsInProgress[[_loc3_]];
         }
         if(this.getWaitingExceptionsNumber() == 0)
         {
            dispatchEvent(new Event(ALL_DATA_SENT));
         }
      }
      
      private function getWaitingExceptionsNumber() : int {
         var _loc2_:* = undefined;
         var _loc1_:* = 0;
         for (_loc2_ in this._exceptionsInProgress)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      private function onDataSavedError(param1:Event) : void {
         this._log.trace(param1.toString());
         var _loc2_:RpcServiceManager = param1.currentTarget as RpcServiceManager;
      }
      
      private function initWebService() : void {
         var _loc1_:* = BASE_URL + "/dofus/logger.json";
         this._webService = new RpcServiceManager(_loc1_,"json");
         this._webService.addEventListener(Event.COMPLETE,this.onDataSavedComplete);
         this._webService.addEventListener(IOErrorEvent.IO_ERROR,this.onDataSavedError);
         this._webService.addEventListener(RpcServiceManager.SERVER_ERROR,this.onDataSavedError);
      }
      
      public function clearService(param1:RpcServiceManager=null) : void {
         if(param1 == null)
         {
            param1 = this._webService;
         }
         param1.removeEventListener(Event.COMPLETE,this.onDataSavedComplete);
         param1.removeEventListener(IOErrorEvent.IO_ERROR,this.onDataSavedError);
         param1.removeEventListener(RpcServiceManager.SERVER_ERROR,this.onDataSavedError);
         param1.destroy();
         var param1:RpcServiceManager = null;
      }
      
      public function saveException(param1:DataExceptionModel, param2:Boolean=false) : void {
         var v:int = 0;
         var t:Timer = null;
         var exception:DataExceptionModel = param1;
         var forceSend:Boolean = param2;
         if(forceSend)
         {
            this.sendDataToWebservice(exception);
            this._exceptionsInProgress[exception.hash] = exception;
         }
         else
         {
            v = Math.round(Math.random() * MAX_DELAY * 1000 + MIN_DELAY * 1000);
            t = new Timer(v,1);
            this._exceptionsInProgress[exception.hash] = exception;
            this._timersList[t] = null;
            t.addEventListener(TimerEvent.TIMER_COMPLETE,function e(param1:TimerEvent):void
            {
               sendDataToWebservice(exception);
               (param1.currentTarget as Timer).stop();
            });
            t.start();
         }
      }
      
      public function sendWaitingException() : void {
         var _loc1_:* = undefined;
         var _loc2_:DataExceptionModel = null;
         for (_loc1_ in this._timersList)
         {
            (_loc1_ as Timer).stop();
            _loc1_ = null;
         }
         for each (_loc2_ in this._exceptionsList)
         {
            if(!_loc2_.sent)
            {
               this.saveException(_loc2_,true);
            }
         }
      }
      
      public function quit() : Boolean {
         if(this._exceptionsList.length == 0)
         {
            return false;
         }
         var exception:DataExceptionModel = this._exceptionsList[this._exceptionsList.length-1];
         var d:Date = new Date();
         if(Math.round(d.time / 1000) - exception.date <= LIMIT_REBOOT)
         {
            exception.isBlockerAndReboot = true;
         }
         if(this._exceptionsList.length > 0)
         {
            setInterval(function e():void
            {
               dispatchEvent(new Event(ALL_DATA_SENT));
            },3000);
            return true;
         }
         return false;
      }
      
      public function changeCharacter() : void {
         var _loc2_:DataExceptionModel = null;
         if(this._exceptionsList == null || this._exceptionsList.length == 0)
         {
            return;
         }
         var _loc1_:Date = new Date();
         for each (_loc2_ in this._exceptionsList)
         {
            if(!(_loc2_ == null) && Math.round(_loc1_.time / 1000) - _loc2_.date <= LIMIT_REBOOT)
            {
               _loc2_.isBlockerAndChangeCharacter = true;
            }
         }
      }
      
      public function getSendingType(param1:String) : String {
         switch(param1.toLowerCase())
         {
            case "error":
               break;
         }
         return "ONE";
      }
      
      public function reset() : void {
         this._previousErrorType = "";
         this._exceptionsList = new Vector.<DataExceptionModel>();
      }
   }
}
class PrivateClass extends Object
{
   
   function PrivateClass() {
      super();
   }
}
