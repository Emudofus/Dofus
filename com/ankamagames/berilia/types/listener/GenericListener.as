package com.ankamagames.berilia.types.listener
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   
   public class GenericListener extends Object
   {
      
      public function GenericListener(param1:String=null, param2:*=null, param3:Function=null, param4:int=0, param5:uint=1, param6:WeakReference=null) {
         super();
         if(param1 != null)
         {
            this._sEvent = param1;
         }
         if(param2 != null)
         {
            this.listener = param2;
         }
         if(param3 != null)
         {
            this._fCallback = param3;
         }
         this._nSortIndex = param4;
         this._nListenerType = param5;
         this._nListenerContext = param6;
      }
      
      public static const LISTENER_TYPE_UI:uint = 0;
      
      public static const LISTENER_TYPE_MODULE:uint = 1;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GenericListener));
      
      private var _sEvent:String;
      
      private var _oListener;
      
      private var _fCallback:Function;
      
      private var _nSortIndex:int;
      
      private var _nListenerType:uint;
      
      private var _nListenerContext:WeakReference;
      
      public function get event() : String {
         return this._sEvent;
      }
      
      public function set event(param1:String) : void {
         this._sEvent = param1;
      }
      
      public function get listener() : * {
         return this._oListener;
      }
      
      public function set listener(param1:*) : void {
         this._oListener = param1;
      }
      
      public function getCallback() : Function {
         return this._fCallback;
      }
      
      public function set callback(param1:Function) : void {
         this._fCallback = param1;
      }
      
      public function get sortIndex() : int {
         return this._nSortIndex;
      }
      
      public function set sortIndex(param1:int) : void {
         this._nSortIndex = param1;
      }
      
      public function get listenerType() : uint {
         return this._nListenerType;
      }
      
      public function get listenerContext() : WeakReference {
         return this._nListenerContext;
      }
   }
}
