package com.ankamagames.jerakine.logger
{
    import com.ankamagames.jerakine.logger.targets.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    final public class Log extends Object
    {
        static const _preparator:TargetsPreparator = null;
        private static var _tempTarget:TemporaryBufferTarget;
        private static var _initializing:Boolean;
        private static var _targets:Array = new Array();
        private static var _loggers:Dictionary = new Dictionary();
        private static var _dispatcher:EventDispatcher = new EventDispatcher();
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Log));
        public static var exitIfNoConfigFile:Boolean = true;

        public function Log()
        {
            return;
        }// end function

        public static function getLogger(param1:String) : Logger
        {
            var xmlLoader:URLLoader;
            var logger:LogLogger;
            var category:* = param1;
            if (!_initializing)
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
                catch (e:Error)
                {
                }
            }
            if (_loggers[category] != null)
            {
                return _loggers[category];
            }
            logger = new LogLogger(category);
            _loggers[category] = logger;
            return logger;
        }// end function

        public static function addTarget(param1:LoggingTarget) : void
        {
            if (containsTarget(param1))
            {
                return;
            }
            _dispatcher.addEventListener(LogEvent.LOG_EVENT, param1.onLog);
            _targets.push(param1);
            return;
        }// end function

        private static function removeTarget(param1:LoggingTarget) : void
        {
            var _loc_2:* = _targets.indexOf(param1);
            if (_loc_2 > -1)
            {
                _dispatcher.removeEventListener(LogEvent.LOG_EVENT, param1.onLog);
                _targets.splice(_loc_2, 1);
            }
            return;
        }// end function

        private static function containsTarget(param1:LoggingTarget) : Boolean
        {
            return _targets.indexOf(param1) > -1;
        }// end function

        private static function parseConfiguration(param1:XML) : void
        {
            var filter:XML;
            var target:XML;
            var allow:Boolean;
            var ltf:LogTargetFilter;
            var x:XMLList;
            var moduleClass:Object;
            var targetInstance:LoggingTarget;
            var config:* = param1;
            var filters:* = new Array();
            var _loc_3:int = 0;
            var _loc_4:* = config..filter;
            while (_loc_4 in _loc_3)
            {
                
                filter = _loc_4[_loc_3];
                allow;
                try
                {
                    x = filter.attribute("allow");
                    if (x.length() > 0)
                    {
                        allow = filter.@allow == "true";
                    }
                }
                catch (e:Error)
                {
                    trace("error");
                }
                ltf = new LogTargetFilter(filter.@value, allow);
                filters.push(ltf);
            }
            var _loc_3:int = 0;
            var _loc_4:* = config..target;
            do
            {
                
                target = _loc_4[_loc_3];
                try
                {
                    moduleClass = getDefinitionByName(target.@module);
                    targetInstance = new moduleClass;
                    targetInstance.filters = filters;
                    if (target.hasComplexContent() && targetInstance is ConfigurableLoggingTarget)
                    {
                        ConfigurableLoggingTarget(targetInstance).configure(target);
                    }
                    addTarget(targetInstance);
                }
                catch (ife:InvalidFilterError)
                {
                    _tempTarget.getBuffer().unshift(new LogEvent("com.ankamagames.jerakine.logger.Log", ife.getStackTrace(), LogLevel.WARN));
                    _tempTarget.getBuffer().unshift(new LogEvent("com.ankamagames.jerakine.logger.Log", "Filtre invalide.", LogLevel.WARN));
                    ;
                }
                catch (re:ReferenceError)
                {
                    _tempTarget.getBuffer().unshift(new LogEvent("com.ankamagames.jerakine.logger.Log", re.getStackTrace(), LogLevel.WARN));
                    _tempTarget.getBuffer().unshift(new LogEvent("com.ankamagames.jerakine.logger.Log", "Module " + target.@module + " introuvable.", LogLevel.WARN));
                }
            }while (_loc_4 in _loc_3)
            return;
        }// end function

        private static function configurationFileMissing() : void
        {
            if (exitIfNoConfigFile)
            {
                LogLogger.activeLog(false);
            }
            flushBuffer();
            return;
        }// end function

        private static function flushBuffer() : void
        {
            var _loc_2:LogEvent = null;
            var _loc_1:* = _tempTarget.getBuffer();
            removeTarget(_tempTarget);
            for each (_loc_2 in _loc_1)
            {
                
                _dispatcher.dispatchEvent(_loc_2.clone());
            }
            _tempTarget.clearBuffer();
            _tempTarget = null;
            return;
        }// end function

        static function broadcastToTargets(event:LogEvent) : void
        {
            _dispatcher.dispatchEvent(event);
            return;
        }// end function

        private static function completeHandler(event:Event) : void
        {
            var e:* = event;
            try
            {
                parseConfiguration(new XML(URLLoader(e.target).data));
            }
            catch (e:Error)
            {
                trace("Erreure de formatage du fichier log4as.xml");
            }
            flushBuffer();
            return;
        }// end function

        private static function ioErrorHandler(event:IOErrorEvent) : void
        {
            _log.warn("Missing log4as.xml file.");
            configurationFileMissing();
            return;
        }// end function

        private static function securityErrorHandler(event:SecurityErrorEvent) : void
        {
            _log.warn("Can\'t load log4as.xml file : forbidden by sandbox.");
            configurationFileMissing();
            return;
        }// end function

    }
}
