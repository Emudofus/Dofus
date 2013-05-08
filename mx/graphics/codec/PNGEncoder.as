package mx.graphics.codec
{
   import mx.core.mx_internal;
   import flash.utils.ByteArray;
   import flash.display.BitmapData;

   use namespace mx_internal;

   public class PNGEncoder extends Object implements IImageEncoder
   {
         

      public function PNGEncoder() {
         super();
         this.initializeCRCTable();
      }

      mx_internal  static const VERSION:String = "4.6.0.23201";

      private static const CONTENT_TYPE:String = "image/png";

      private var crcTable:Array;

      public function get contentType() : String {
         return CONTENT_TYPE;
      }

      public function encode(bitmapData:BitmapData) : ByteArray {
         return this.internalEncode(bitmapData,bitmapData.width,bitmapData.height,bitmapData.transparent);
      }

      public function encodeByteArray(byteArray:ByteArray, width:int, height:int, transparent:Boolean=true) : ByteArray {
         return this.internalEncode(byteArray,width,height,transparent);
      }

      private function initializeCRCTable() : void {
         var c:uint = 0;
         var k:uint = 0;
         this.crcTable=[];
         var n:uint = 0;
         while(n<256)
         {
            c=n;
            k=0;
            while(k<8)
            {
               if(c&1)
               {
                  c=uint(uint(3.988292384E9)^uint(c>>>1));
               }
               else
               {
                  c=uint(c>>>1);
               }
               k++;
            }
            this.crcTable[n]=c;
            n++;
         }
      }

      private function internalEncode(source:Object, width:int, height:int, transparent:Boolean=true) : ByteArray {
         var x:* = 0;
         var pixel:uint = 0;
         var sourceBitmapData:BitmapData = source as BitmapData;
         var sourceByteArray:ByteArray = source as ByteArray;
         if(sourceByteArray)
         {
            sourceByteArray.position=0;
         }
         var png:ByteArray = new ByteArray();
         png.writeUnsignedInt(2.303741511E9);
         png.writeUnsignedInt(218765834);
         var IHDR:ByteArray = new ByteArray();
         IHDR.writeInt(width);
         IHDR.writeInt(height);
         IHDR.writeByte(8);
         IHDR.writeByte(6);
         IHDR.writeByte(0);
         IHDR.writeByte(0);
         IHDR.writeByte(0);
         this.writeChunk(png,1229472850,IHDR);
         var IDAT:ByteArray = new ByteArray();
         var y:int = 0;
         while(y<height)
         {
            IDAT.writeByte(0);
            if(!transparent)
            {
               x=0;
               while(x<width)
               {
                  if(sourceBitmapData)
                  {
                     pixel=sourceBitmapData.getPixel(x,y);
                  }
                  else
                  {
                     pixel=sourceByteArray.readUnsignedInt();
                  }
                  IDAT.writeUnsignedInt(uint((pixel&16777215)<<8|255));
                  x++;
               }
            }
            else
            {
               x=0;
               while(x<width)
               {
                  if(sourceBitmapData)
                  {
                     pixel=sourceBitmapData.getPixel32(x,y);
                  }
                  else
                  {
                     pixel=sourceByteArray.readUnsignedInt();
                  }
                  IDAT.writeUnsignedInt(uint((pixel&16777215)<<8|pixel>>>24));
                  x++;
               }
            }
            y++;
         }
         IDAT.compress();
         this.writeChunk(png,1229209940,IDAT);
         this.writeChunk(png,1229278788,null);
         png.position=0;
         return png;
      }

      private function writeChunk(png:ByteArray, type:uint, data:ByteArray) : void {
         var len:uint = 0;
         if(data)
         {
            len=data.length;
         }
         png.writeUnsignedInt(len);
         var typePos:uint = png.position;
         png.writeUnsignedInt(type);
         if(data)
         {
            png.writeBytes(data);
         }
         var crcPos:uint = png.position;
         png.position=typePos;
         var crc:uint = 4.294967295E9;
         var i:uint = typePos;
         while(i<crcPos)
         {
            crc=uint(this.crcTable[(crc^png.readUnsignedByte())&uint(255)]^uint(crc>>>8));
            i++;
         }
         crc=uint(crc^uint(4.294967295E9));
         png.position=crcPos;
         png.writeUnsignedInt(crc);
      }
   }

}