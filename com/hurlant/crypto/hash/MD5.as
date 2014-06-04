package com.hurlant.crypto.hash
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class MD5 extends Object implements IHash
   {
      
      public function MD5() {
         super();
      }
      
      public static const HASH_SIZE:int = 16;
      
      public var pad_size:int = 48;
      
      public function getInputSize() : uint {
         return 64;
      }
      
      public function getHashSize() : uint {
         return HASH_SIZE;
      }
      
      public function getPadSize() : int {
         return this.pad_size;
      }
      
      public function hash(src:ByteArray) : ByteArray {
         var len:uint = src.length * 8;
         var savedEndian:String = src.endian;
         while(src.length % 4 != 0)
         {
            src[src.length] = 0;
         }
         src.position = 0;
         var a:Array = [];
         src.endian = Endian.LITTLE_ENDIAN;
         var i:uint = 0;
         while(i < src.length)
         {
            a.push(src.readUnsignedInt());
            i = i + 4;
         }
         var h:Array = this.core_md5(a,len);
         var out:ByteArray = new ByteArray();
         out.endian = Endian.LITTLE_ENDIAN;
         i = 0;
         while(i < 4)
         {
            out.writeUnsignedInt(h[i]);
            i++;
         }
         src.length = len / 8;
         src.endian = savedEndian;
         return out;
      }
      
      private function core_md5(x:Array, len:uint) : Array {
         var olda:uint = 0;
         var oldb:uint = 0;
         var oldc:uint = 0;
         var oldd:uint = 0;
         x[len >> 5] = x[len >> 5] | 128 << len % 32;
         x[(len + 64 >>> 9 << 4) + 14] = len;
         var a:uint = 1732584193;
         var b:uint = 4.023233417E9;
         var c:uint = 2.562383102E9;
         var d:uint = 271733878;
         var i:uint = 0;
         while(i < x.length)
         {
            x[i] = x[i] || 0;
            x[i + 1] = x[i + 1] || 0;
            x[i + 2] = x[i + 2] || 0;
            x[i + 3] = x[i + 3] || 0;
            x[i + 4] = x[i + 4] || 0;
            x[i + 5] = x[i + 5] || 0;
            x[i + 6] = x[i + 6] || 0;
            x[i + 7] = x[i + 7] || 0;
            x[i + 8] = x[i + 8] || 0;
            x[i + 9] = x[i + 9] || 0;
            x[i + 10] = x[i + 10] || 0;
            x[i + 11] = x[i + 11] || 0;
            x[i + 12] = x[i + 12] || 0;
            x[i + 13] = x[i + 13] || 0;
            x[i + 14] = x[i + 14] || 0;
            x[i + 15] = x[i + 15] || 0;
            olda = a;
            oldb = b;
            oldc = c;
            oldd = d;
            a = this.ff(a,b,c,d,x[i + 0],7,3.61409036E9);
            d = this.ff(d,a,b,c,x[i + 1],12,3.90540271E9);
            c = this.ff(c,d,a,b,x[i + 2],17,606105819);
            b = this.ff(b,c,d,a,x[i + 3],22,3.250441966E9);
            a = this.ff(a,b,c,d,x[i + 4],7,4.118548399E9);
            d = this.ff(d,a,b,c,x[i + 5],12,1200080426);
            c = this.ff(c,d,a,b,x[i + 6],17,2.821735955E9);
            b = this.ff(b,c,d,a,x[i + 7],22,4.249261313E9);
            a = this.ff(a,b,c,d,x[i + 8],7,1770035416);
            d = this.ff(d,a,b,c,x[i + 9],12,2.336552879E9);
            c = this.ff(c,d,a,b,x[i + 10],17,4.294925233E9);
            b = this.ff(b,c,d,a,x[i + 11],22,2.304563134E9);
            a = this.ff(a,b,c,d,x[i + 12],7,1804603682);
            d = this.ff(d,a,b,c,x[i + 13],12,4.254626195E9);
            c = this.ff(c,d,a,b,x[i + 14],17,2.792965006E9);
            b = this.ff(b,c,d,a,x[i + 15],22,1236535329);
            a = this.gg(a,b,c,d,x[i + 1],5,4.129170786E9);
            d = this.gg(d,a,b,c,x[i + 6],9,3.225465664E9);
            c = this.gg(c,d,a,b,x[i + 11],14,643717713);
            b = this.gg(b,c,d,a,x[i + 0],20,3.921069994E9);
            a = this.gg(a,b,c,d,x[i + 5],5,3.593408605E9);
            d = this.gg(d,a,b,c,x[i + 10],9,38016083);
            c = this.gg(c,d,a,b,x[i + 15],14,3.634488961E9);
            b = this.gg(b,c,d,a,x[i + 4],20,3.889429448E9);
            a = this.gg(a,b,c,d,x[i + 9],5,568446438);
            d = this.gg(d,a,b,c,x[i + 14],9,3.275163606E9);
            c = this.gg(c,d,a,b,x[i + 3],14,4.107603335E9);
            b = this.gg(b,c,d,a,x[i + 8],20,1163531501);
            a = this.gg(a,b,c,d,x[i + 13],5,2.850285829E9);
            d = this.gg(d,a,b,c,x[i + 2],9,4.243563512E9);
            c = this.gg(c,d,a,b,x[i + 7],14,1735328473);
            b = this.gg(b,c,d,a,x[i + 12],20,2.368359562E9);
            a = this.hh(a,b,c,d,x[i + 5],4,4.294588738E9);
            d = this.hh(d,a,b,c,x[i + 8],11,2.272392833E9);
            c = this.hh(c,d,a,b,x[i + 11],16,1839030562);
            b = this.hh(b,c,d,a,x[i + 14],23,4.25965774E9);
            a = this.hh(a,b,c,d,x[i + 1],4,2.763975236E9);
            d = this.hh(d,a,b,c,x[i + 4],11,1272893353);
            c = this.hh(c,d,a,b,x[i + 7],16,4.139469664E9);
            b = this.hh(b,c,d,a,x[i + 10],23,3.200236656E9);
            a = this.hh(a,b,c,d,x[i + 13],4,681279174);
            d = this.hh(d,a,b,c,x[i + 0],11,3.936430074E9);
            c = this.hh(c,d,a,b,x[i + 3],16,3.572445317E9);
            b = this.hh(b,c,d,a,x[i + 6],23,76029189);
            a = this.hh(a,b,c,d,x[i + 9],4,3.654602809E9);
            d = this.hh(d,a,b,c,x[i + 12],11,3.873151461E9);
            c = this.hh(c,d,a,b,x[i + 15],16,530742520);
            b = this.hh(b,c,d,a,x[i + 2],23,3.299628645E9);
            a = this.ii(a,b,c,d,x[i + 0],6,4.096336452E9);
            d = this.ii(d,a,b,c,x[i + 7],10,1126891415);
            c = this.ii(c,d,a,b,x[i + 14],15,2.878612391E9);
            b = this.ii(b,c,d,a,x[i + 5],21,4.237533241E9);
            a = this.ii(a,b,c,d,x[i + 12],6,1700485571);
            d = this.ii(d,a,b,c,x[i + 3],10,2.39998069E9);
            c = this.ii(c,d,a,b,x[i + 10],15,4.293915773E9);
            b = this.ii(b,c,d,a,x[i + 1],21,2.240044497E9);
            a = this.ii(a,b,c,d,x[i + 8],6,1873313359);
            d = this.ii(d,a,b,c,x[i + 15],10,4.264355552E9);
            c = this.ii(c,d,a,b,x[i + 6],15,2.734768916E9);
            b = this.ii(b,c,d,a,x[i + 13],21,1309151649);
            a = this.ii(a,b,c,d,x[i + 4],6,4.149444226E9);
            d = this.ii(d,a,b,c,x[i + 11],10,3.174756917E9);
            c = this.ii(c,d,a,b,x[i + 2],15,718787259);
            b = this.ii(b,c,d,a,x[i + 9],21,3.951481745E9);
            a = a + olda;
            b = b + oldb;
            c = c + oldc;
            d = d + oldd;
            i = i + 16;
         }
         return [a,b,c,d];
      }
      
      private function rol(num:uint, cnt:uint) : uint {
         return num << cnt | num >>> 32 - cnt;
      }
      
      private function cmn(q:uint, a:uint, b:uint, x:uint, s:uint, t:uint) : uint {
         return this.rol(a + q + x + t,s) + b;
      }
      
      private function ff(a:uint, b:uint, c:uint, d:uint, x:uint, s:uint, t:uint) : uint {
         return this.cmn(b & c | ~b & d,a,b,x,s,t);
      }
      
      private function gg(a:uint, b:uint, c:uint, d:uint, x:uint, s:uint, t:uint) : uint {
         return this.cmn(b & d | c & ~d,a,b,x,s,t);
      }
      
      private function hh(a:uint, b:uint, c:uint, d:uint, x:uint, s:uint, t:uint) : uint {
         return this.cmn(b ^ c ^ d,a,b,x,s,t);
      }
      
      private function ii(a:uint, b:uint, c:uint, d:uint, x:uint, s:uint, t:uint) : uint {
         return this.cmn(c ^ (b | ~d),a,b,x,s,t);
      }
      
      public function toString() : String {
         return "md5";
      }
   }
}
