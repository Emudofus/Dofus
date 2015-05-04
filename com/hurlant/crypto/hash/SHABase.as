package com.hurlant.crypto.hash
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class SHABase extends Object implements IHash
   {
      
      public function SHABase()
      {
         super();
      }
      
      public var pad_size:int = 40;
      
      public function getInputSize() : uint
      {
         return 64;
      }
      
      public function getHashSize() : uint
      {
         return 0;
      }
      
      public function getPadSize() : int
      {
         return this.pad_size;
      }
      
      public function hash(param1:ByteArray) : ByteArray
      {
         var _loc2_:uint = param1.length;
         var _loc3_:String = param1.endian;
         param1.endian = Endian.BIG_ENDIAN;
         var _loc4_:uint = _loc2_ * 8;
         while(param1.length % 4 != 0)
         {
            param1[param1.length] = 0;
         }
         param1.position = 0;
         var _loc5_:Array = [];
         var _loc6_:uint = 0;
         while(_loc6_ < param1.length)
         {
            _loc5_.push(param1.readUnsignedInt());
            _loc6_ = _loc6_ + 4;
         }
         var _loc7_:Array = this.core(_loc5_,_loc4_);
         var _loc8_:ByteArray = new ByteArray();
         var _loc9_:uint = this.getHashSize() / 4;
         _loc6_ = 0;
         while(_loc6_ < _loc9_)
         {
            _loc8_.writeUnsignedInt(_loc7_[_loc6_]);
            _loc6_++;
         }
         param1.length = _loc2_;
         param1.endian = _loc3_;
         return _loc8_;
      }
      
      protected function core(param1:Array, param2:uint) : Array
      {
         return null;
      }
      
      public function toString() : String
      {
         return "sha";
      }
   }
}
