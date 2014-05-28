package com.ankamagames.dofus.misc.utils.errormanager
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.targets.LimitedBufferTarget;
   import com.ankamagames.jerakine.logger.Logger;
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
      
      public function WebServiceDataHandler(pPrivate:PrivateClass) {
         this._log = Log.getLogger(getQualifiedClassName(WebServiceDataHandler));
         this._exceptionsList = new Vector.<DataExceptionModel>();
         this._exceptionsInProgress = new Dictionary(true);
         this._timersList = new Dictionary(true);
         super();
         if(pPrivate == null)
         {
            throw new SingletonError();
         }
         else
         {
            if((BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.ALPHA))
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
      
      private static const MAX_DELAY:int = 270.0;
      
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
      
      public function createNewException(reportInfo:Object, errorType:String) : DataExceptionModel {
         var fr:Frame = null;
         var f:Array = null;
         var date:Date = null;
         var tmp:Array = null;
         var screenScale:* = NaN;
         var bd:BitmapData = null;
         var m:Matrix = null;
         if((this._previousErrorType == "ONE") && (this._exceptionsList.length >= 1))
         {
            return null;
         }
         this._previousErrorType = this.getSendingType(errorType);
         var exception:DataExceptionModel = new DataExceptionModel();
         if(reportInfo.stacktrace == null)
         {
            return null;
         }
         exception.hash = MD5.hash(this.cleanStacktrace(reportInfo.stacktrace));
         exception.stacktrace = reportInfo.stacktrace;
         if((!(reportInfo.errorMsg == null)) && (!(reportInfo.errorMsg == "")))
         {
            exception.stacktrace = reportInfo.errorMsg + "\n" + exception.stacktrace;
         }
         exception.buildType = reportInfo.buildType;
         exception.buildVersion = reportInfo.buildVersion;
         if((exception.buildType == "INTERNAL") || (exception.buildType == "DEBUG"))
         {
            date = new Date();
            tmp = exception.buildVersion.split(".");
            tmp[tmp.length - 2] = DateFormat.dayOfYear(date.fullYear,date.month,date.date);
            tmp.pop();
            exception.buildVersion = tmp.join(".");
         }
         var os:Array = reportInfo.os.split(" ");
         exception.osType = os[0];
         exception.osVersion = os[1]?os[1]:"";
         if(ENABLE_SCREENSHOT)
         {
            screenScale = 1 / 3;
            bd = new BitmapData(StageShareManager.startWidth * screenScale,StageShareManager.startHeight * screenScale);
            m = new Matrix();
            m.scale(screenScale,screenScale);
            bd.draw(StageShareManager.stage,m);
            buffer.logEvent(new TextLogEvent("[BUG_REPORT]","[SCREEN]" + Base64.encode(JPEGEncoder.encode(bd,60))));
         }
         exception.logsSos = buffer.getFormatedBuffer();
         exception.serverId = reportInfo.serverId;
         exception.mapId = reportInfo.idMap;
         exception.characterId = reportInfo.characterId;
         exception.isInFight = reportInfo.wasFighting;
         exception.isMultiAccount = reportInfo.multicompte;
         exception.date = TimeManager.getInstance().getTimestamp() / 1000;
         var frString:String = "";
         for each(fr in Kernel.getWorker().framesList)
         {
            f = getQualifiedClassName(fr).split("::");
            frString = frString + (String(f[1]?f[1]:f[0]).replace("Frame","") + ",");
         }
         exception.framesList = frString;
         this._exceptionsList.push(exception);
         return exception;
      }
      
      public function cleanStacktrace(inStack:String) : String {
         var line:String = null;
         var lineIndex:* = 0;
         var reg:RegExp = null;
         var outStack:String = "";
         var tmp:Array = inStack.split("\n");
         for each(line in tmp)
         {
            lineIndex = tmp.indexOf(line);
            if(lineIndex > 0)
            {
               line = line.replace(new RegExp("\\\\","g"),"/");
            }
            reg = new RegExp("^(.*?\\[)(.*?)((\\/modules\\/Ankama_|\\/com\\/ankama).*?)(:?[0-9]*?)(\\].*?)","g");
            outStack = outStack + line.replace(reg,"$1$3$6");
            if(lineIndex < tmp.length - 1)
            {
               outStack = outStack + "\n";
            }
         }
         return outStack;
      }
      
      private function sendDataToWebservice(exception:DataExceptionModel) : void {
         if(exception == null)
         {
            return;
         }
         if(this._webService == null)
         {
            this.initWebService();
         }
         this._webService.callMethod("Exception",
            {
               "sHash":exception.hash,
               "sStacktrace":exception.stacktrace,
               "iVersion":exception.buildType,
               "iBuildVersion":exception.buildVersion,
               "iDate":exception.date,
               "sOs":exception.osType,
               "sOsVersion":exception.osVersion,
               "iServerId":exception.serverId,
               "iCharacterId":exception.characterId,
               "iMapId":exception.mapId,
               "bMultipleAccout":exception.isMultiAccount,
               "bIsFighting":exception.isInFight,
               "sFrameList":exception.framesList,
               "sCustom":exception.logsSos,
               "sErrorType":exception.errorType
            });
      }
      
      private function onDataSavedComplete(pEvt:Event) : void {
         var rpcService:RpcServiceManager = pEvt.currentTarget as RpcServiceManager;
         var hash:String = rpcService.requestData.params.sHash;
         if(this._exceptionsInProgress[hash])
         {
            (this._exceptionsInProgress[hash] as DataExceptionModel).sent = true;
            delete this._exceptionsInProgress[hash];
         }
         if(this.getWaitingExceptionsNumber() == 0)
         {
            dispatchEvent(new Event(ALL_DATA_SENT));
         }
      }
      
      private function getWaitingExceptionsNumber() : int {
         var val:* = undefined;
         var cpt:int = 0;
         for(val in this._exceptionsInProgress)
         {
            cpt++;
         }
         return cpt;
      }
      
      private function onDataSavedError(pEvt:Event) : void {
         this._log.trace(pEvt.toString());
         var rpcService:RpcServiceManager = pEvt.currentTarget as RpcServiceManager;
      }
      
      private function initWebService() : void {
         var url:String = BASE_URL + "/dofus/logger.json";
         this._webService = new RpcServiceManager(url,"json");
         this._webService.addEventListener(Event.COMPLETE,this.onDataSavedComplete);
         this._webService.addEventListener(IOErrorEvent.IO_ERROR,this.onDataSavedError);
         this._webService.addEventListener(RpcServiceManager.SERVER_ERROR,this.onDataSavedError);
      }
      
      public function clearService(rpcService:RpcServiceManager = null) : void {
         if(rpcService == null)
         {
            rpcService = this._webService;
         }
         rpcService.removeEventListener(Event.COMPLETE,this.onDataSavedComplete);
         rpcService.removeEventListener(IOErrorEvent.IO_ERROR,this.onDataSavedError);
         rpcService.removeEventListener(RpcServiceManager.SERVER_ERROR,this.onDataSavedError);
         rpcService.destroy();
         var rpcService:RpcServiceManager = null;
      }
      
      public function saveException(exception:DataExceptionModel, forceSend:Boolean = false) : void {
         var v:int = 0;
         var t:Timer = null;
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
            t.addEventListener(TimerEvent.TIMER_COMPLETE,function e(pEvt:TimerEvent):void
            {
               sendDataToWebservice(exception);
               (pEvt.currentTarget as Timer).stop();
            });
            t.start();
         }
      }
      
      public function sendWaitingException() : void {
         var t:* = undefined;
         var exception:DataExceptionModel = null;
         for(t in this._timersList)
         {
            (t as Timer).stop();
            t = null;
         }
         for each(exception in this._exceptionsList)
         {
            if(!exception.sent)
            {
               this.saveException(exception,true);
            }
         }
      }
      
      public function quit() : Boolean {
         if(this._exceptionsList.length == 0)
         {
            return false;
         }
         var exception:DataExceptionModel = this._exceptionsList[this._exceptionsList.length - 1];
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
         var exception:DataExceptionModel = null;
         if((this._exceptionsList == null) || (this._exceptionsList.length == 0))
         {
            return;
         }
         var d:Date = new Date();
         for each(exception in this._exceptionsList)
         {
            if((!(exception == null)) && (Math.round(d.time / 1000) - exception.date <= LIMIT_REBOOT))
            {
               exception.isBlockerAndChangeCharacter = true;
            }
         }
      }
      
      public function getSendingType(pType:String) : String {
         switch(pType.toLowerCase())
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
