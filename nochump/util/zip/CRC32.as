package nochump.util.zip
{
   import flash.utils.ByteArray;
   
   public class CRC32 extends Object
   {
      
      public function CRC32() {
         super();
      }
      
      private static var crcTable:Array = makeCrcTable();
      
      private static function makeCrcTable() : Array {
         var c:uint = 0;
         var k:* = 0;
         var crcTable:Array = new Array(256);
         var n:int = 0;
         while(n < 256)
         {
            c = n;
            k = 8;
            while(--k >= 0)
            {
               if((c & 1) != 0)
               {
                  c = 3.988292384E9 ^ c >>> 1;
               }
               else
               {
                  c = c >>> 1;
               }
            }
            crcTable[n] = c;
            n++;
         }
         return crcTable;
      }
      
      private var crc:uint;
      
      public function getValue() : uint {
         return this.crc & 4.294967295E9;
      }
      
      public function reset() : void {
         this.crc = 0;
      }
      
      public function update(buf:ByteArray) : void {
         var off:uint = 0;
         var len:uint = buf.length;
         var c:uint = ~this.crc;
         while(--len >= 0)
         {
            c = crcTable[(c ^ buf[off++]) & 255] ^ c >>> 8;
         }
         this.crc = ~c;
      }
   }
}
