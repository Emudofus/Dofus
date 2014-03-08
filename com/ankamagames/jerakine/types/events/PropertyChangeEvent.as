package com.ankamagames.jerakine.types.events
{
   import flash.events.Event;
   
   public class PropertyChangeEvent extends Event
   {
      
      public function PropertyChangeEvent(param1:*, param2:String, param3:*, param4:*) {
         super(PROPERTY_CHANGED,false,false);
         this._watchedClassInstance = param1;
         this._propertyName = param2;
         this._propertyValue = param3;
         this._propertyOldValue = param4;
      }
      
      public static var PROPERTY_CHANGED:String = "watchPropertyChanged";
      
      private var _watchedClassInstance;
      
      private var _propertyName:String;
      
      private var _propertyValue;
      
      private var _propertyOldValue;
      
      public function get watchedClassInstance() : * {
         return this._watchedClassInstance;
      }
      
      public function get propertyName() : String {
         return this._propertyName;
      }
      
      public function get propertyValue() : * {
         return this._propertyValue;
      }
      
      public function get propertyOldValue() : * {
         return this._propertyOldValue;
      }
   }
}
