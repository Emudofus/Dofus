package com.ankamagames.jerakine.managers
{
    import com.ankamagames.jerakine.types.events.*;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;

    public class ErrorManager extends Object
    {
        public static var catchError:Boolean = false;
        public static var eventDispatcher:EventDispatcher = new EventDispatcher();
        public static var lastTryFunctionHasException:Boolean;

        public function ErrorManager()
        {
            return;
        }// end function

        public static function tryFunction(param1:Function, param2:Array = null, param3:String = null)
        {
            var result:*;
            var fct:* = param1;
            var params:* = param2;
            var complementaryInformations:* = param3;
            if (!catchError)
            {
                lastTryFunctionHasException = true;
                result = fct.apply(null, params);
                lastTryFunctionHasException = false;
                return result;
            }
            try
            {
                lastTryFunctionHasException = false;
                return fct.apply(null, params);
            }
            catch (e:Error)
            {
                lastTryFunctionHasException = true;
                addError(complementaryInformations, e);
                return null;
            }
            return;
        }// end function

        public static function addError(param1:String = null, param2 = null) : void
        {
            if (!param2)
            {
                param2 = new Error();
            }
            if (!param1)
            {
                param1 = "";
            }
            eventDispatcher.dispatchEvent(new ErrorReportedEvent(param2, param1));
            return;
        }// end function

        public static function registerLoaderInfo(param1:LoaderInfo) : void
        {
            if (!ApplicationDomain.currentDomain.hasDefinition("flash.events::UncaughtErrorEvent"))
            {
                return;
            }
            var _loc_2:* = ApplicationDomain.currentDomain.getDefinition("flash.events::UncaughtErrorEvent");
            if (catchError)
            {
                param1["uncaughtErrorEvents"].addEventListener(_loc_2.UNCAUGHT_ERROR, onUncaughtError, false, 0, true);
            }
            return;
        }// end function

        private static function onUncaughtError(param1:Object) : void
        {
            param1.preventDefault();
            if (param1.error is Error)
            {
                addError(null, param1.error);
            }
            else
            {
                addError(param1.error, new EmptyError());
            }
            return;
        }// end function

    }
}
