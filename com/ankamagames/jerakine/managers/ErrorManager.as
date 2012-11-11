package com.ankamagames.jerakine.managers
{
    import com.ankamagames.jerakine.json.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.events.*;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;

    public class ErrorManager extends Object
    {
        public static var catchError:Boolean = false;
        public static var showPopup:Boolean = false;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ErrorManager));
        public static var eventDispatcher:EventDispatcher = new EventDispatcher();
        public static var lastTryFunctionHasException:Boolean;
        public static var lastTryFunctionParams:Array;

        public function ErrorManager()
        {
            return;
        }// end function

        public static function tryFunction(param1:Function, param2:Array = null, param3:String = null)
        {
            var result:*;
            var result2:*;
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
                lastTryFunctionParams = params;
                lastTryFunctionHasException = false;
                result2 = fct.apply(null, params);
                lastTryFunctionParams = null;
                return result2;
            }
            catch (e:Error)
            {
                lastTryFunctionHasException = true;
                addError(complementaryInformations, e, showPopup);
                lastTryFunctionParams = null;
                return null;
            }
            return;
        }// end function

        public static function addError(param1:String = null, param2 = null, param3:Boolean = true) : void
        {
            if (!param2)
            {
                param2 = new Error();
            }
            if (!param1)
            {
                param1 = "";
            }
            if (lastTryFunctionParams != null)
            {
                _log.error("[JSON]" + JSON.encode(lastTryFunctionParams, 4, true));
            }
            eventDispatcher.dispatchEvent(new ErrorReportedEvent(param2, param1, param3));
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
                addError(null, param1.error, showPopup);
            }
            else
            {
                addError(param1.error, new EmptyError(), showPopup);
            }
            return;
        }// end function

    }
}

import com.ankamagames.jerakine.json.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.types.events.*;

import flash.display.*;

import flash.events.*;

import flash.system.*;

import flash.utils.*;

class EmptyError extends Error
{

    function EmptyError()
    {
        return;
    }// end function

}

