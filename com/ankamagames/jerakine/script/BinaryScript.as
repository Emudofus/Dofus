package com.ankamagames.jerakine.script
{
   import flash.utils.ByteArray;
   
   public class BinaryScript extends Object
   {
      
      public function BinaryScript(param1:ByteArray, param2:String) {
         super();
         this._data = param1;
         this.path = param2;
      }
      
      private var _data:ByteArray;
      
      public function get data() : ByteArray {
         this._data.position = 0;
         return this._data;
      }
      
      public var path:String;
   }
}
