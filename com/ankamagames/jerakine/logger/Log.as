package com.ankamagames.jerakine.logger
{
   import flash.utils.Dictionary;
   import flash.events.EventDispatcher;
   import flash.net.URLLoader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import com.ankamagames.jerakine.logger.targets.*;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public final class Log extends Object
   {
      
      public function Log() {
         super();
      }
      
      protected static const _preparator:TargetsPreparator = null;
      
      private static var _tempTarget:TemporaryBufferTarget;
      
      private static var _initializing:Boolean;
      
      private static var _manualInit:Boolean;
      
      private static var _targets:Array = new Array();
      
      private static var _loggers:Dictionary = new Dictionary();
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Log));
      
      public static var exitIfNoConfigFile:Boolean = true;
      
      public static function initFromString(param1:String) : void {
         _manualInit = true;
         _initializing = true;
         parseConfiguration(new XML(param1));
         LogLogger.activeLog(true);
      }
      
      public static function getLogger(param1:String) : Logger {
         var _loc2_:URLLoader = null;
         var _loc3_:LogLogger = null;
         if(!_initializing)
         {
            _initializing = true;
            _tempTarget = new TemporaryBufferTarget();
            addTarget(_tempTarget);
            _loc2_ = new URLLoader();
            _loc2_.addEventListener(Event.COMPLETE,completeHandler);
            _loc2_.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
            _loc2_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
            try
            {
               _loc2_.load(new URLRequest("log4as.xml"));
            }
            catch(e:Error)
            {
            }
         }
         if(_loggers[param1] != null)
         {
            return _loggers[param1];
         }
         _loc3_ = new LogLogger(param1);
         _loggers[param1] = _loc3_;
         return _loc3_;
      }
      
      public static function addTarget(param1:LoggingTarget) : void {
         if(containsTarget(param1))
         {
            return;
         }
         _dispatcher.addEventListener(LogEvent.LOG_EVENT,param1.onLog);
         _targets.push(param1);
      }
      
      private static function removeTarget(param1:LoggingTarget) : void {
         var _loc2_:int = _targets.indexOf(param1);
         if(_loc2_ > -1)
         {
            _dispatcher.removeEventListener(LogEvent.LOG_EVENT,param1.onLog);
            _targets.splice(_loc2_,1);
         }
      }
      
      private static function containsTarget(param1:LoggingTarget) : Boolean {
         return _targets.indexOf(param1) > -1;
      }
      
      private static function parseConfiguration(param1:XML) : void {
         var filter:XML = null;
         var target:XML = null;
         var allow:Boolean = false;
         var ltf:LogTargetFilter = null;
         var x:XMLList = null;
         var moduleClass:Object = null;
         var targetInstance:LoggingTarget = null;
         var config:XML = param1;
         var filters:Array = new Array();
         for each (filter in config..filter)
         {
            allow = true;
            try
            {
               x = filter.attribute("allow");
               if(x.length() > 0)
               {
                  allow = filter.@allow == "true";
               }
            }
            catch(e:Error)
            {
               trace("error");
            }
            ltf = new LogTargetFilter(filter.@value,allow);
            filters.push(ltf);
         }
         for each (target in config..target)
         {
            try
            {
               moduleClass = getDefinitionByName(target.@module);
               targetInstance = new moduleClass as Class();
               targetInstance.filters = filters;
               if((target.hasComplexContent()) && targetInstance is ConfigurableLoggingTarget)
               {
                  ConfigurableLoggingTarget(targetInstance).configure(target);
               }
               addTarget(targetInstance);
            }
            catch(ife:InvalidFilterError)
            {
               _tempTarget.getBuffer().unshift(new LogEvent("com.ankamagames.jerakine.logger.Log",ife.getStackTrace(),LogLevel.WARN));
               _tempTarget.getBuffer().unshift(new LogEvent("com.ankamagames.jerakine.logger.Log","Filtre invalide.",LogLevel.WARN));
               continue;
            }
            catch(re:ReferenceError)
            {
               _tempTarget.getBuffer().unshift(new LogEvent("com.ankamagames.jerakine.logger.Log",re.getStackTrace(),LogLevel.WARN));
               _tempTarget.getBuffer().unshift(new LogEvent("com.ankamagames.jerakine.logger.Log","Module " + target.@module + " introuvable.",LogLevel.WARN));
               continue;
            }
            continue;
            if((target.hasComplexContent()) && targetInstance is ConfigurableLoggingTarget)
            {
               ConfigurableLoggingTarget(targetInstance).configure(target);
            }
            addTarget(targetInstance);
         }
      }
      
      private static function configurationFileMissing() : void {
         if(exitIfNoConfigFile)
         {
            LogLogger.activeLog(false);
         }
         flushBuffer();
      }
      
      private static function flushBuffer() : void {
         var _loc2_:LogEvent = null;
         var _loc1_:Array = _tempTarget.getBuffer();
         removeTarget(_tempTarget);
         for each (_loc2_ in _loc1_)
         {
            _dispatcher.dispatchEvent(_loc2_.clone());
         }
         _tempTarget.clearBuffer();
         _tempTarget = null;
      }
      
      static function broadcastToTargets(param1:LogEvent) : void {
         _dispatcher.dispatchEvent(param1);
      }
      
      private static function completeHandler(param1:Event) : void {
         var e:Event = param1;
         try
         {
            parseConfiguration(new XML(URLLoader(e.target).data));
         }
         catch(e:Error)
         {
            trace("Erreur de formatage du fichier log4as.xml");
         }
         flushBuffer();
      }
      
      private static function ioErrorHandler(param1:IOErrorEvent) : void {
         if(_manualInit)
         {
            return;
         }
         _log.warn("Missing log4as.xml file.");
         configurationFileMissing();
      }
      
      private static function securityErrorHandler(param1:SecurityErrorEvent) : void {
         if(_manualInit)
         {
            return;
         }
         _log.warn("Can\'t load log4as.xml file : forbidden by sandbox.");
         configurationFileMissing();
      }
   }
}
