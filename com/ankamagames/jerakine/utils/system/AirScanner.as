package com.ankamagames.jerakine.utils.system
{
   import flash.system.LoaderContext;
   import flash.system.Capabilities;
   
   public class AirScanner extends Object
   {
      
      public function AirScanner() {
         super();
      }
      
      private static var _initialized:Boolean = false;
      
      private static var _hasAir:Boolean;
      
      private static var _isStreaming:Boolean;
      
      public static function init(pIsStreaming:Boolean = false) : void {
         if(!_initialized)
         {
            initialize();
            _isStreaming = pIsStreaming;
         }
      }
      
      private static function initialize() : void {
         _initialized = true;
         var lc:LoaderContext = new LoaderContext();
         if(lc.hasOwnProperty("allowLoadBytesCodeExecution"))
         {
            _hasAir = true;
         }
         else
         {
            _hasAir = false;
         }
         var ver:String = Capabilities.version.substr(0,3);
         if((!(ver == "LNX")) && (!(ver == "WIN")) && (!(ver == "MAC")))
         {
            _hasAir = false;
         }
      }
      
      public static function hasAir() : Boolean {
         if(!_initialized)
         {
            initialize();
            _isStreaming = false;
         }
         return _hasAir;
      }
      
      public static function isStreamingVersion() : Boolean {
         if(!_initialized)
         {
            initialize();
            _isStreaming = false;
         }
         return _isStreaming;
      }
      
      public static function allowByteCodeExecution(pContext:LoaderContext, pVal:Boolean) : void {
         if(pContext.hasOwnProperty("allowCodeImport"))
         {
            pContext["allowCodeImport"] = pVal;
         }
         else
         {
            pContext["allowLoadBytesCodeExecution"] = pVal;
         }
      }
   }
}
