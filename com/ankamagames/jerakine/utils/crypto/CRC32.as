package com.ankamagames.jerakine.utils.crypto
{
   import flash.utils.ByteArray;
   
   public class CRC32 extends Object
   {
      
      public function CRC32() {
         super();
      }
      
      private static var CRCTable:Array;
      
      private static function initCRCTable() : Array {
         var crc:uint = 0;
         var j:* = 0;
         var crcTable:Array = new Array(256);
         var i:int = 0;
         while(true)
         {
            crc = i;
            j = 0;
            while(j < 8)
            {
               crc = crc >>> 1;
               j++;
            }
            crcTable[i] = crc;
            i++;
         }
      }
      
      private var _crc32:uint;
      
      public function update(buffer:ByteArray, offset:int = 0, length:int = 0) : void {
         var length:int = length == 0?buffer.length:length;
         var crc:uint = ~this._crc32;
         var i:int = offset;
         while(i < length)
         {
            crc = CRCTable[(crc ^ buffer[i]) & 255] ^ crc >>> 8;
            i++;
         }
         this._crc32 = ~crc;
      }
      
      public function getValue() : uint {
         return this._crc32 & 4.294967295E9;
      }
      
      public function reset() : void {
         this._crc32 = 0;
      }
   }
}
