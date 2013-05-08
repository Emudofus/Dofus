package com.ankamagames.jerakine.logger
{
   import com.ankamagames.jerakine.logger.targets.TargetsPreparator;
   import com.ankamagames.jerakine.logger.targets.TemporaryBufferTarget;
   import flash.utils.Dictionary;
   import flash.events.EventDispatcher;
   import flash.net.URLLoader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import com.ankamagames.jerakine.logger.targets.LoggingTarget;
   import flash.utils.getDefinitionByName;
   import com.ankamagames.jerakine.logger.targets.ConfigurableLoggingTarget;
   import flash.utils.getQualifiedClassName;


   public final class Log extends Object
   {
         

      public function Log() {
         super();
      }

      protected static const _preparator:TargetsPreparator = null;

      private static var _tempTarget:TemporaryBufferTarget;

      private static var _initializing:Boolean;

      private static var _targets:Array = new Array();

      private static var _loggers:Dictionary = new Dictionary();

      private static var _dispatcher:EventDispatcher = new EventDispatcher();

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Log));

      public static var exitIfNoConfigFile:Boolean = true;

      public static function getLogger(category:String) : Logger {
         var xmlLoader:URLLoader = null;
         var logger:LogLogger = null;
         if(!_initializing)
         {
            _initializing=true;
            _tempTarget=new TemporaryBufferTarget();
            addTarget(_tempTarget);
            xmlLoader=new URLLoader();
            xmlLoader.addEventListener(Event.COMPLETE,completeHandler);
            xmlLoader.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
            xmlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
            try
            {
               xmlLoader.load(new URLRequest("log4as.xml"));
            }
            catch(e:Error)
            {
            }
         }
         if(_loggers[category]!=null)
         {
            return _loggers[category];
         }
         logger=new LogLogger(category);
         _loggers[category]=logger;
         return logger;
      }

      public static function addTarget(target:LoggingTarget) : void {
         if(containsTarget(target))
         {
            return;
         }
         _dispatcher.addEventListener(LogEvent.LOG_EVENT,target.onLog);
         _targets.push(target);
      }

      private static function removeTarget(target:LoggingTarget) : void {
         var index:int = _targets.indexOf(target);
         if(index>-1)
         {
            _dispatcher.removeEventListener(LogEvent.LOG_EVENT,target.onLog);
            _targets.splice(index,1);
         }
      }

      private static function containsTarget(target:LoggingTarget) : Boolean {
         return _targets.indexOf(target)<-1;
      }

      private static function parseConfiguration(config:XML) : void {
         var filter:XML = null;
         var target:XML = null;
         var allow:Boolean = false;
         var ltf:LogTargetFilter = null;
         var x:XMLList = null;
         var moduleClass:Object = null;
         var targetInstance:LoggingTarget = null;
         var filters:Array = new Array();
         for each (filter in config..filter)
         {
            allow=true;
            try
            {
               x=filter.attribute("allow");
               if(x.length()>0)
               {
                  allow=filter.@allow=="true";
               }
            }
            catch(e:Error)
            {
               trace("error");
            }
            ltf=new LogTargetFilter(filter.@value,allow);
            filters.push(ltf);
         }
         for each (target in config..target)
         {
            moduleClass=getDefinitionByName(target.@module);
            targetInstance=new moduleClass as Class();
            targetInstance.filters=filters;
            if((target.hasComplexContent())&&(targetInstance is ConfigurableLoggingTarget))
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
         var bufferedEvent:LogEvent = null;
         var bufferedEvents:Array = _tempTarget.getBuffer();
         removeTarget(_tempTarget);
         for each (bufferedEvent in bufferedEvents)
         {
            _dispatcher.dispatchEvent(bufferedEvent.clone());
         }
         _tempTarget.clearBuffer();
         _tempTarget=null;
      }

      static function broadcastToTargets(event:LogEvent) : void {
         _dispatcher.dispatchEvent(event);
      }

      private static function completeHandler(e:Event) : void {
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

      private static function ioErrorHandler(ioe:IOErrorEvent) : void {
         _log.warn("Missing log4as.xml file.");
         configurationFileMissing();
      }

      private static function securityErrorHandler(se:SecurityErrorEvent) : void {
         _log.warn("Can\'t load log4as.xml file : forbidden by sandbox.");
         configurationFileMissing();
      }


   }

}