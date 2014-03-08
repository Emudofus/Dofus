package com.ankamagames.berilia.types.event
{
   import flash.utils.Dictionary;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   
   public class InstanceEvent extends Object
   {
      
      public function InstanceEvent(param1:DisplayObject, param2:Object) {
         super();
         this._doInstance = param1;
         this._aEvent = new Array();
         this._oCallback = param2;
         if(param1 is InteractiveObject)
         {
            InteractiveObject(param1).mouseEnabled = true;
         }
         MEMORY_LOG[this] = 1;
      }
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      private var _doInstance:DisplayObject;
      
      private var _aEvent:Array;
      
      private var _oCallback:Object;
      
      public function get instance() : DisplayObject {
         return this._doInstance;
      }
      
      public function get events() : Array {
         return this._aEvent;
      }
      
      public function get callbackObject() : Object {
         return this._oCallback;
      }
      
      public function set callbackObject(param1:Object) : void {
         this._oCallback = param1;
      }
      
      public function get haveEvent() : Boolean {
         return !(this._aEvent.length == 0);
      }
      
      public function push(param1:String) : void {
         this._aEvent[param1] = true;
      }
   }
}
