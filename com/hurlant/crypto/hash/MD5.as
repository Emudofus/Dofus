package com.hurlant.crypto.hash
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class MD5 extends Object implements IHash
   {
      
      public function MD5()
      {
         super();
      }
      
      public static const HASH_SIZE:int = 16;
      
      public var pad_size:int = 48;
      
      public function getInputSize() : uint
      {
         return 64;
      }
      
      public function getHashSize() : uint
      {
         return HASH_SIZE;
      }
      
      public function getPadSize() : int
      {
         return this.pad_size;
      }
      
      public function hash(param1:ByteArray) : ByteArray
      {
         var _loc2_:uint = param1.length * 8;
         var _loc3_:String = param1.endian;
         while(param1.length % 4 != 0)
         {
            param1[param1.length] = 0;
         }
         param1.position = 0;
         var _loc4_:Array = [];
         param1.endian = Endian.LITTLE_ENDIAN;
         var _loc5_:uint = 0;
         while(_loc5_ < param1.length)
         {
            _loc4_.push(param1.readUnsignedInt());
            _loc5_ = _loc5_ + 4;
         }
         var _loc6_:Array = this.core_md5(_loc4_,_loc2_);
         var _loc7_:ByteArray = new ByteArray();
         _loc7_.endian = Endian.LITTLE_ENDIAN;
         _loc5_ = 0;
         while(_loc5_ < 4)
         {
            _loc7_.writeUnsignedInt(_loc6_[_loc5_]);
            _loc5_++;
         }
         param1.length = _loc2_ / 8;
         param1.endian = _loc3_;
         return _loc7_;
      }
      
      private function core_md5(param1:Array, param2:uint) : Array
      {
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         param1[param2 >> 5] = param1[param2 >> 5] | 128 << param2 % 32;
         param1[(param2 + 64 >>> 9 << 4) + 14] = param2;
         var _loc3_:uint = 1732584193;
         var _loc4_:uint = 4.023233417E9;
         var _loc5_:uint = 2.562383102E9;
         var _loc6_:uint = 271733878;
         var _loc7_:uint = 0;
         while(_loc7_ < param1.length)
         {
            param1[_loc7_] = param1[_loc7_] || 0;
            param1[_loc7_ + 1] = param1[_loc7_ + 1] || 0;
            param1[_loc7_ + 2] = param1[_loc7_ + 2] || 0;
            param1[_loc7_ + 3] = param1[_loc7_ + 3] || 0;
            param1[_loc7_ + 4] = param1[_loc7_ + 4] || 0;
            param1[_loc7_ + 5] = param1[_loc7_ + 5] || 0;
            param1[_loc7_ + 6] = param1[_loc7_ + 6] || 0;
            param1[_loc7_ + 7] = param1[_loc7_ + 7] || 0;
            param1[_loc7_ + 8] = param1[_loc7_ + 8] || 0;
            param1[_loc7_ + 9] = param1[_loc7_ + 9] || 0;
            param1[_loc7_ + 10] = param1[_loc7_ + 10] || 0;
            param1[_loc7_ + 11] = param1[_loc7_ + 11] || 0;
            param1[_loc7_ + 12] = param1[_loc7_ + 12] || 0;
            param1[_loc7_ + 13] = param1[_loc7_ + 13] || 0;
            param1[_loc7_ + 14] = param1[_loc7_ + 14] || 0;
            param1[_loc7_ + 15] = param1[_loc7_ + 15] || 0;
            _loc8_ = _loc3_;
            _loc9_ = _loc4_;
            _loc10_ = _loc5_;
            _loc11_ = _loc6_;
            _loc3_ = this.ff(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 0],7,3.61409036E9);
            _loc6_ = this.ff(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 1],12,3.90540271E9);
            _loc5_ = this.ff(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 2],17,606105819);
            _loc4_ = this.ff(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 3],22,3.250441966E9);
            _loc3_ = this.ff(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 4],7,4.118548399E9);
            _loc6_ = this.ff(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 5],12,1200080426);
            _loc5_ = this.ff(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 6],17,2.821735955E9);
            _loc4_ = this.ff(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 7],22,4.249261313E9);
            _loc3_ = this.ff(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 8],7,1770035416);
            _loc6_ = this.ff(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 9],12,2.336552879E9);
            _loc5_ = this.ff(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 10],17,4.294925233E9);
            _loc4_ = this.ff(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 11],22,2.304563134E9);
            _loc3_ = this.ff(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 12],7,1804603682);
            _loc6_ = this.ff(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 13],12,4.254626195E9);
            _loc5_ = this.ff(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 14],17,2.792965006E9);
            _loc4_ = this.ff(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 15],22,1236535329);
            _loc3_ = this.gg(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 1],5,4.129170786E9);
            _loc6_ = this.gg(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 6],9,3.225465664E9);
            _loc5_ = this.gg(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 11],14,643717713);
            _loc4_ = this.gg(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 0],20,3.921069994E9);
            _loc3_ = this.gg(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 5],5,3.593408605E9);
            _loc6_ = this.gg(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 10],9,38016083);
            _loc5_ = this.gg(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 15],14,3.634488961E9);
            _loc4_ = this.gg(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 4],20,3.889429448E9);
            _loc3_ = this.gg(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 9],5,568446438);
            _loc6_ = this.gg(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 14],9,3.275163606E9);
            _loc5_ = this.gg(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 3],14,4.107603335E9);
            _loc4_ = this.gg(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 8],20,1163531501);
            _loc3_ = this.gg(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 13],5,2.850285829E9);
            _loc6_ = this.gg(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 2],9,4.243563512E9);
            _loc5_ = this.gg(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 7],14,1735328473);
            _loc4_ = this.gg(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 12],20,2.368359562E9);
            _loc3_ = this.hh(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 5],4,4.294588738E9);
            _loc6_ = this.hh(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 8],11,2.272392833E9);
            _loc5_ = this.hh(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 11],16,1839030562);
            _loc4_ = this.hh(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 14],23,4.25965774E9);
            _loc3_ = this.hh(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 1],4,2.763975236E9);
            _loc6_ = this.hh(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 4],11,1272893353);
            _loc5_ = this.hh(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 7],16,4.139469664E9);
            _loc4_ = this.hh(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 10],23,3.200236656E9);
            _loc3_ = this.hh(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 13],4,681279174);
            _loc6_ = this.hh(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 0],11,3.936430074E9);
            _loc5_ = this.hh(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 3],16,3.572445317E9);
            _loc4_ = this.hh(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 6],23,76029189);
            _loc3_ = this.hh(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 9],4,3.654602809E9);
            _loc6_ = this.hh(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 12],11,3.873151461E9);
            _loc5_ = this.hh(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 15],16,530742520);
            _loc4_ = this.hh(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 2],23,3.299628645E9);
            _loc3_ = this.ii(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 0],6,4.096336452E9);
            _loc6_ = this.ii(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 7],10,1126891415);
            _loc5_ = this.ii(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 14],15,2.878612391E9);
            _loc4_ = this.ii(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 5],21,4.237533241E9);
            _loc3_ = this.ii(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 12],6,1700485571);
            _loc6_ = this.ii(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 3],10,2.39998069E9);
            _loc5_ = this.ii(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 10],15,4.293915773E9);
            _loc4_ = this.ii(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 1],21,2.240044497E9);
            _loc3_ = this.ii(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 8],6,1873313359);
            _loc6_ = this.ii(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 15],10,4.264355552E9);
            _loc5_ = this.ii(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 6],15,2.734768916E9);
            _loc4_ = this.ii(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 13],21,1309151649);
            _loc3_ = this.ii(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 4],6,4.149444226E9);
            _loc6_ = this.ii(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 11],10,3.174756917E9);
            _loc5_ = this.ii(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 2],15,718787259);
            _loc4_ = this.ii(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 9],21,3.951481745E9);
            _loc3_ = _loc3_ + _loc8_;
            _loc4_ = _loc4_ + _loc9_;
            _loc5_ = _loc5_ + _loc10_;
            _loc6_ = _loc6_ + _loc11_;
            _loc7_ = _loc7_ + 16;
         }
         return [_loc3_,_loc4_,_loc5_,_loc6_];
      }
      
      private function rol(param1:uint, param2:uint) : uint
      {
         return param1 << param2 | param1 >>> 32 - param2;
      }
      
      private function cmn(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint) : uint
      {
         return this.rol(param2 + param1 + param4 + param6,param5) + param3;
      }
      
      private function ff(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint) : uint
      {
         return this.cmn(param2 & param3 | ~param2 & param4,param1,param2,param5,param6,param7);
      }
      
      private function gg(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint) : uint
      {
         return this.cmn(param2 & param4 | param3 & ~param4,param1,param2,param5,param6,param7);
      }
      
      private function hh(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint) : uint
      {
         return this.cmn(param2 ^ param3 ^ param4,param1,param2,param5,param6,param7);
      }
      
      private function ii(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint) : uint
      {
         return this.cmn(param3 ^ (param2 | ~param4),param1,param2,param5,param6,param7);
      }
      
      public function toString() : String
      {
         return "md5";
      }
   }
}
