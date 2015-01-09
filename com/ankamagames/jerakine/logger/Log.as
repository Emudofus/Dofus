package com.ankamagames.jerakine.logger
{
    import com.ankamagames.jerakine.logger.targets.TargetsPreparator;
    import com.ankamagames.jerakine.logger.targets.TemporaryBufferTarget;
    import flash.utils.Dictionary;
    import flash.events.EventDispatcher;
    import flash.utils.getQualifiedClassName;
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequest;
    import com.ankamagames.jerakine.logger.targets.LoggingTarget;
    import flash.utils.getDefinitionByName;
    import com.ankamagames.jerakine.logger.targets.ConfigurableLoggingTarget;
    import com.ankamagames.jerakine.logger.targets.AbstractTarget;
    import com.ankamagames.jerakine.logger.targets.*;

    public final class Log 
    {

        protected static const _preparator:TargetsPreparator = null;
        private static var _tempTarget:TemporaryBufferTarget;
        private static var _initializing:Boolean;
        private static var _manualInit:Boolean;
        private static var _targets:Array = new Array();
        private static var _loggers:Dictionary = new Dictionary();
        private static var _dispatcher:EventDispatcher = new EventDispatcher();
        protected static const _log:Logger = Log.getLogger(flash.utils.getQualifiedClassName(Log));
        public static var exitIfNoConfigFile:Boolean = true;


        public static function initFromString(xml:String):void
        {
            _manualInit = true;
            _initializing = true;
            parseConfiguration(new XML(xml));
            LogLogger.activeLog(true);
        }

        public static function getLogger(category:String):Logger
        {
            var xmlLoader:URLLoader;
            var _local_3:LogLogger;
            if (!(_initializing))
            {
                _initializing = true;
                _tempTarget = new TemporaryBufferTarget();
                addTarget(_tempTarget);
                xmlLoader = new URLLoader();
                xmlLoader.addEventListener(Event.COMPLETE, completeHandler);
                xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
                xmlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
                try
                {
                    xmlLoader.load(new URLRequest("log4as.xml"));
                }
                catch(e:Error)
                {
                };
            };
            if (_loggers[category] != null)
            {
                return (_loggers[category]);
            };
            _local_3 = new LogLogger(category);
            _loggers[category] = _local_3;
            return (_local_3);
        }

        public static function addTarget(target:LoggingTarget):void
        {
            if (containsTarget(target))
            {
                return;
            };
            _dispatcher.addEventListener(LogEvent.LOG_EVENT, target.onLog);
            _targets.push(target);
        }

        private static function removeTarget(target:LoggingTarget):void
        {
            var index:int = _targets.indexOf(target);
            if (index > -1)
            {
                _dispatcher.removeEventListener(LogEvent.LOG_EVENT, target.onLog);
                _targets.splice(index, 1);
            };
        }

        private static function containsTarget(target:LoggingTarget):Boolean
        {
            return ((_targets.indexOf(target) > -1));
        }

        private static function parseConfiguration(config:XML):void
        {
            var filter:XML;
            var target:XML;
            var allow:Boolean;
            var ltf:LogTargetFilter;
            var x:XMLList;
            var moduleClass:Object;
            var targetInstance:LoggingTarget;
            var filters:Array = new Array();
            for each (filter in config..filter)
            {
                allow = true;
                try
                {
                    x = filter.attribute("allow");
                    if (x.length() > 0)
                    {
                        allow = (filter.@allow == "true");
                    };
                }
                catch(e:Error)
                {
                    trace("error");
                };
                ltf = new LogTargetFilter(filter.@value, allow);
                filters.push(ltf);
            };
            for each (target in config..target)
            {
                try
                {
                    moduleClass = getDefinitionByName(target.@module);
                    targetInstance = new ((moduleClass as Class))();
                    targetInstance.filters = filters;
                    if (((target.hasComplexContent()) && ((targetInstance is ConfigurableLoggingTarget))))
                    {
                        ConfigurableLoggingTarget(targetInstance).configure(target);
                    };
                    addTarget(targetInstance);
                }
                catch(ife:InvalidFilterError)
                {
                    _tempTarget.getBuffer().unshift(new LogEvent("com.ankamagames.jerakine.logger.Log", ife.getStackTrace(), LogLevel.WARN));
                    _tempTarget.getBuffer().unshift(new LogEvent("com.ankamagames.jerakine.logger.Log", "Filtre invalide.", LogLevel.WARN));
                }
                catch(re:ReferenceError)
                {
                    _tempTarget.getBuffer().unshift(new LogEvent("com.ankamagames.jerakine.logger.Log", re.getStackTrace(), LogLevel.WARN));
                    _tempTarget.getBuffer().unshift(new LogEvent("com.ankamagames.jerakine.logger.Log", (("Module " + target.@module) + " introuvable."), LogLevel.WARN));
                };
            };
        }

        private static function configurationFileMissing():void
        {
            if (exitIfNoConfigFile)
            {
                LogLogger.activeLog(false);
            };
            flushBuffer();
        }

        private static function flushBuffer():void
        {
            var target:AbstractTarget;
            var bufferedEvent:LogEvent;
            var bufferedEvents:Array = _tempTarget.getBuffer();
            removeTarget(_tempTarget);
            for each (target in _targets)
            {
                if ((target is TemporaryBufferTarget))
                {
                    TemporaryBufferTarget(target).clearBuffer();
                    break;
                };
            };
            for each (bufferedEvent in bufferedEvents)
            {
                _dispatcher.dispatchEvent(bufferedEvent.clone());
            };
            _tempTarget.clearBuffer();
            _tempTarget = null;
        }

        static function broadcastToTargets(event:LogEvent):void
        {
            _dispatcher.dispatchEvent(event);
        }

        private static function completeHandler(e:Event):void
        {
            try
            {
                parseConfiguration(new XML(URLLoader(e.target).data));
            }
            catch(e:Error)
            {
                trace("Erreur de formatage du fichier log4as.xml");
            };
            flushBuffer();
        }

        private static function ioErrorHandler(ioe:IOErrorEvent):void
        {
            if (_manualInit)
            {
                return;
            };
            _log.warn("Missing log4as.xml file.");
            configurationFileMissing();
        }

        private static function securityErrorHandler(se:SecurityErrorEvent):void
        {
            if (_manualInit)
            {
                return;
            };
            _log.warn("Can't load log4as.xml file : forbidden by sandbox.");
            configurationFileMissing();
        }


    }
}//package com.ankamagames.jerakine.logger

