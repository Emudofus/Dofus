package com.ankamagames.jerakine.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.types.events.ErrorReportedEvent;
   import flash.display.LoaderInfo;
   import flash.system.ApplicationDomain;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class ErrorManager extends Object
   {
      
      public function ErrorManager() {
         super();
      }
      
      public static var catchError:Boolean = false;
      
      public static var showPopup:Boolean = false;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ErrorManager));
      
      public static var eventDispatcher:EventDispatcher = new EventDispatcher();
      
      public static var lastTryFunctionHasException:Boolean;
      
      public static var lastTryFunctionParams:Array;
      
      public static function tryFunction(param1:Function, param2:Array=null, param3:String=null, param4:Object=null) : * {
         var result:* = undefined;
         var result2:* = undefined;
         var fct:Function = param1;
         var params:Array = param2;
         var complementaryInformations:String = param3;
         var context:Object = param4;
         if(!catchError)
         {
            lastTryFunctionHasException = true;
            result = fct.apply(context,params);
            lastTryFunctionHasException = false;
            return result;
         }
         try
         {
            lastTryFunctionParams = params;
            lastTryFunctionHasException = false;
            result2 = fct.apply(context,params);
            lastTryFunctionParams = null;
            return result2;
         }
         catch(e:Error)
         {
            lastTryFunctionHasException = true;
            addError(complementaryInformations,e,showPopup);
            lastTryFunctionParams = null;
            return null;
         }
      }
      
      public static function addError(param1:String=null, param2:*=null, param3:Boolean=true) : void {
         if(!param2)
         {
            param2 = new Error();
         }
         if(!param1)
         {
            param1 = "";
         }
         eventDispatcher.dispatchEvent(new ErrorReportedEvent(param2,param1,param3));
      }
      
      public static function registerLoaderInfo(param1:LoaderInfo) : void {
         if(!ApplicationDomain.currentDomain.hasDefinition("flash.events::UncaughtErrorEvent"))
         {
            return;
         }
         var _loc2_:Object = ApplicationDomain.currentDomain.getDefinition("flash.events::UncaughtErrorEvent");
         if(catchError)
         {
            param1["uncaughtErrorEvents"].addEventListener(_loc2_.UNCAUGHT_ERROR,onUncaughtError,false,0,true);
         }
      }
      
      private static function onUncaughtError(param1:Object) : void {
         param1.preventDefault();
         if(param1.error is Error)
         {
            addError(null,param1.error,showPopup);
         }
         else
         {
            addError(param1.error,new EmptyError(),showPopup);
         }
      }
   }
}
class EmptyError extends Error
{
   
   function EmptyError() {
      super();
   }
}
