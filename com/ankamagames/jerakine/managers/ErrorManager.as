package com.ankamagames.jerakine.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.json.JSON;
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

      public static function tryFunction(fct:Function, params:Array=null, complementaryInformations:String=null) : * {
         var result:* = undefined;
         var result2:* = undefined;
         if(!catchError)
         {
            lastTryFunctionHasException=true;
            result=fct.apply(null,params);
            lastTryFunctionHasException=false;
            return result;
         }
         try
         {
            lastTryFunctionParams=params;
            lastTryFunctionHasException=false;
            result2=fct.apply(null,params);
            lastTryFunctionParams=null;
            return result2;
         }
         catch(e:Error)
         {
            lastTryFunctionHasException=true;
            addError(complementaryInformations,e,showPopup);
            lastTryFunctionParams=null;
            return null;
         }
      }

      public static function addError(txt:String=null, error:*=null, show:Boolean=true) : void {
         if(!error)
         {
            error=new Error();
         }
         if(!txt)
         {
            txt="";
         }
         if(lastTryFunctionParams!=null)
         {
            _log.error("[JSON]"+com.ankamagames.jerakine.json.JSON.encode(lastTryFunctionParams,4,true));
         }
         eventDispatcher.dispatchEvent(new ErrorReportedEvent(error,txt,show));
      }

      public static function registerLoaderInfo(loaderInfo:LoaderInfo) : void {
         if(!ApplicationDomain.currentDomain.hasDefinition("flash.events::UncaughtErrorEvent"))
         {
            return;
         }
         var UncaughtErrorEvent:Object = ApplicationDomain.currentDomain.getDefinition("flash.events::UncaughtErrorEvent");
         if(catchError)
         {
            loaderInfo["uncaughtErrorEvents"].addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,onUncaughtError,false,0,true);
         }
      }

      private static function onUncaughtError(event:Object) : void {
         event.preventDefault();
         if(event.error is Error)
         {
            addError(null,event.error,showPopup);
         }
         else
         {
            addError(event.error,new EmptyError(),showPopup);
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
