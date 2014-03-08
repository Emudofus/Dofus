package com.ankamagames.jerakine.script
{
   import flash.utils.ByteArray;
   
   public class BinaryScript extends Object
   {
      
      public function BinaryScript(data:ByteArray, path:String) {
         super();
         this._data = data;
         this.path = path;
      }
      
      private var _data:ByteArray;
      
      public function get data() : ByteArray {
         this._data.position = 0;
         return this._data;
      }
      
      public var path:String;
   }
}
