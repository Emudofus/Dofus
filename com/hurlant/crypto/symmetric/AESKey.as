package com.hurlant.crypto.symmetric
{
   import flash.utils.ByteArray;
   import com.hurlant.crypto.prng.Random;
   import com.hurlant.util.Memory;
   
   public class AESKey extends Object implements ISymmetricKey
   {
      
      {
         while(i < 256)
         {
            Sbox[i] = _Sbox[i];
            InvSbox[i] = _InvSbox[i];
            Xtime2Sbox[i] = _Xtime2Sbox[i];
            Xtime3Sbox[i] = _Xtime3Sbox[i];
            Xtime2[i] = _Xtime2[i];
            Xtime9[i] = _Xtime9[i];
            XtimeB[i] = _XtimeB[i];
            XtimeD[i] = _XtimeD[i];
            XtimeE[i] = _XtimeE[i];
            i++;
         }
         while(i < _Rcon.length)
         {
            Rcon[i] = _Rcon[i];
            i++;
         }
      }
      
      public function AESKey(key:ByteArray) {
         super();
         this.tmp = new ByteArray();
         this.state = new ByteArray();
         this.keyLength = key.length;
         this.key = new ByteArray();
         this.key.writeBytes(key);
         this.expandKey();
      }
      
      private static const Nb:uint = 4;
      
      private static const _Sbox:Array;
      
      private static const _InvSbox:Array;
      
      private static const _Xtime2Sbox:Array;
      
      private static const _Xtime3Sbox:Array;
      
      private static const _Xtime2:Array;
      
      private static const _Xtime9:Array;
      
      private static const _XtimeB:Array;
      
      private static const _XtimeD:Array;
      
      private static const _XtimeE:Array;
      
      private static var _Rcon:Array;
      
      private static var Sbox:ByteArray;
      
      private static var InvSbox:ByteArray;
      
      private static var Xtime2Sbox:ByteArray;
      
      private static var Xtime3Sbox:ByteArray;
      
      private static var Xtime2:ByteArray;
      
      private static var Xtime9:ByteArray;
      
      private static var XtimeB:ByteArray;
      
      private static var XtimeD:ByteArray;
      
      private static var XtimeE:ByteArray;
      
      private static var Rcon:ByteArray;
      
      private static var i:uint;
      
      private var key:ByteArray;
      
      private var keyLength:uint;
      
      private var Nr:uint;
      
      private var state:ByteArray;
      
      private var tmp:ByteArray;
      
      private function expandKey() : void {
         var tmp0:uint = 0;
         var tmp1:uint = 0;
         var tmp2:uint = 0;
         var tmp3:uint = 0;
         var tmp4:uint = 0;
         var idx:uint = 0;
         var Nk:uint = this.key.length / 4;
         this.Nr = Nk + 6;
         idx = Nk;
         while(idx < Nb * (this.Nr + 1))
         {
            tmp0 = this.key[4 * idx - 4];
            tmp1 = this.key[4 * idx - 3];
            tmp2 = this.key[4 * idx - 2];
            tmp3 = this.key[4 * idx - 1];
            if(!(idx % Nk))
            {
               tmp4 = tmp3;
               tmp3 = Sbox[tmp0];
               tmp0 = Sbox[tmp1] ^ Rcon[idx / Nk];
               tmp1 = Sbox[tmp2];
               tmp2 = Sbox[tmp4];
            }
            else if((Nk > 6) && (idx % Nk == 4))
            {
               tmp0 = Sbox[tmp0];
               tmp1 = Sbox[tmp1];
               tmp2 = Sbox[tmp2];
               tmp3 = Sbox[tmp3];
            }
            
            this.key[4 * idx + 0] = this.key[4 * idx - 4 * Nk + 0] ^ tmp0;
            this.key[4 * idx + 1] = this.key[4 * idx - 4 * Nk + 1] ^ tmp1;
            this.key[4 * idx + 2] = this.key[4 * idx - 4 * Nk + 2] ^ tmp2;
            this.key[4 * idx + 3] = this.key[4 * idx - 4 * Nk + 3] ^ tmp3;
            idx++;
         }
      }
      
      public function getBlockSize() : uint {
         return 16;
      }
      
      public function encrypt(block:ByteArray, index:uint = 0) : void {
         var round:uint = 0;
         this.state.position = 0;
         this.state.writeBytes(block,index,Nb * 4);
         this.addRoundKey(this.key,0);
         round = 1;
         while(round < this.Nr + 1)
         {
            if(round < this.Nr)
            {
               this.mixSubColumns();
            }
            else
            {
               this.shiftRows();
            }
            this.addRoundKey(this.key,round * Nb * 4);
            round++;
         }
         block.position = index;
         block.writeBytes(this.state);
      }
      
      public function decrypt(block:ByteArray, index:uint = 0) : void {
         var round:uint = 0;
         this.state.position = 0;
         this.state.writeBytes(block,index,Nb * 4);
         this.addRoundKey(this.key,this.Nr * Nb * 4);
         this.invShiftRows();
         round = this.Nr;
         while(round--)
         {
            this.addRoundKey(this.key,round * Nb * 4);
            if(round)
            {
               this.invMixSubColumns();
            }
         }
         block.position = index;
         block.writeBytes(this.state);
      }
      
      public function dispose() : void {
         var i:uint = 0;
         var r:Random = new Random();
         i = 0;
         while(i < this.key.length)
         {
            this.key[i] = r.nextByte();
            i++;
         }
         this.Nr = r.nextByte();
         i = 0;
         while(i < this.state.length)
         {
            this.state[i] = r.nextByte();
            i++;
         }
         i = 0;
         while(i < this.tmp.length)
         {
            this.tmp[i] = r.nextByte();
            i++;
         }
         this.key.length = 0;
         this.keyLength = 0;
         this.state.length = 0;
         this.tmp.length = 0;
         this.key = null;
         this.state = null;
         this.tmp = null;
         this.Nr = 0;
         Memory.gc();
      }
      
      protected function shiftRows() : void {
         var tmp:uint = 0;
         this.state[0] = Sbox[this.state[0]];
         this.state[4] = Sbox[this.state[4]];
         this.state[8] = Sbox[this.state[8]];
         this.state[12] = Sbox[this.state[12]];
         tmp = Sbox[this.state[1]];
         this.state[1] = Sbox[this.state[5]];
         this.state[5] = Sbox[this.state[9]];
         this.state[9] = Sbox[this.state[13]];
         this.state[13] = tmp;
         tmp = Sbox[this.state[2]];
         this.state[2] = Sbox[this.state[10]];
         this.state[10] = tmp;
         tmp = Sbox[this.state[6]];
         this.state[6] = Sbox[this.state[14]];
         this.state[14] = tmp;
         tmp = Sbox[this.state[15]];
         this.state[15] = Sbox[this.state[11]];
         this.state[11] = Sbox[this.state[7]];
         this.state[7] = Sbox[this.state[3]];
         this.state[3] = tmp;
      }
      
      protected function invShiftRows() : void {
         var tmp:uint = 0;
         this.state[0] = InvSbox[this.state[0]];
         this.state[4] = InvSbox[this.state[4]];
         this.state[8] = InvSbox[this.state[8]];
         this.state[12] = InvSbox[this.state[12]];
         tmp = InvSbox[this.state[13]];
         this.state[13] = InvSbox[this.state[9]];
         this.state[9] = InvSbox[this.state[5]];
         this.state[5] = InvSbox[this.state[1]];
         this.state[1] = tmp;
         tmp = InvSbox[this.state[2]];
         this.state[2] = InvSbox[this.state[10]];
         this.state[10] = tmp;
         tmp = InvSbox[this.state[6]];
         this.state[6] = InvSbox[this.state[14]];
         this.state[14] = tmp;
         tmp = InvSbox[this.state[3]];
         this.state[3] = InvSbox[this.state[7]];
         this.state[7] = InvSbox[this.state[11]];
         this.state[11] = InvSbox[this.state[15]];
         this.state[15] = tmp;
      }
      
      protected function mixSubColumns() : void {
         this.tmp.length = 0;
         this.tmp[0] = Xtime2Sbox[this.state[0]] ^ Xtime3Sbox[this.state[5]] ^ Sbox[this.state[10]] ^ Sbox[this.state[15]];
         this.tmp[1] = Sbox[this.state[0]] ^ Xtime2Sbox[this.state[5]] ^ Xtime3Sbox[this.state[10]] ^ Sbox[this.state[15]];
         this.tmp[2] = Sbox[this.state[0]] ^ Sbox[this.state[5]] ^ Xtime2Sbox[this.state[10]] ^ Xtime3Sbox[this.state[15]];
         this.tmp[3] = Xtime3Sbox[this.state[0]] ^ Sbox[this.state[5]] ^ Sbox[this.state[10]] ^ Xtime2Sbox[this.state[15]];
         this.tmp[4] = Xtime2Sbox[this.state[4]] ^ Xtime3Sbox[this.state[9]] ^ Sbox[this.state[14]] ^ Sbox[this.state[3]];
         this.tmp[5] = Sbox[this.state[4]] ^ Xtime2Sbox[this.state[9]] ^ Xtime3Sbox[this.state[14]] ^ Sbox[this.state[3]];
         this.tmp[6] = Sbox[this.state[4]] ^ Sbox[this.state[9]] ^ Xtime2Sbox[this.state[14]] ^ Xtime3Sbox[this.state[3]];
         this.tmp[7] = Xtime3Sbox[this.state[4]] ^ Sbox[this.state[9]] ^ Sbox[this.state[14]] ^ Xtime2Sbox[this.state[3]];
         this.tmp[8] = Xtime2Sbox[this.state[8]] ^ Xtime3Sbox[this.state[13]] ^ Sbox[this.state[2]] ^ Sbox[this.state[7]];
         this.tmp[9] = Sbox[this.state[8]] ^ Xtime2Sbox[this.state[13]] ^ Xtime3Sbox[this.state[2]] ^ Sbox[this.state[7]];
         this.tmp[10] = Sbox[this.state[8]] ^ Sbox[this.state[13]] ^ Xtime2Sbox[this.state[2]] ^ Xtime3Sbox[this.state[7]];
         this.tmp[11] = Xtime3Sbox[this.state[8]] ^ Sbox[this.state[13]] ^ Sbox[this.state[2]] ^ Xtime2Sbox[this.state[7]];
         this.tmp[12] = Xtime2Sbox[this.state[12]] ^ Xtime3Sbox[this.state[1]] ^ Sbox[this.state[6]] ^ Sbox[this.state[11]];
         this.tmp[13] = Sbox[this.state[12]] ^ Xtime2Sbox[this.state[1]] ^ Xtime3Sbox[this.state[6]] ^ Sbox[this.state[11]];
         this.tmp[14] = Sbox[this.state[12]] ^ Sbox[this.state[1]] ^ Xtime2Sbox[this.state[6]] ^ Xtime3Sbox[this.state[11]];
         this.tmp[15] = Xtime3Sbox[this.state[12]] ^ Sbox[this.state[1]] ^ Sbox[this.state[6]] ^ Xtime2Sbox[this.state[11]];
         this.state.position = 0;
         this.state.writeBytes(this.tmp,0,Nb * 4);
      }
      
      protected function invMixSubColumns() : void {
         var i:uint = 0;
         this.tmp.length = 0;
         this.tmp[0] = XtimeE[this.state[0]] ^ XtimeB[this.state[1]] ^ XtimeD[this.state[2]] ^ Xtime9[this.state[3]];
         this.tmp[5] = Xtime9[this.state[0]] ^ XtimeE[this.state[1]] ^ XtimeB[this.state[2]] ^ XtimeD[this.state[3]];
         this.tmp[10] = XtimeD[this.state[0]] ^ Xtime9[this.state[1]] ^ XtimeE[this.state[2]] ^ XtimeB[this.state[3]];
         this.tmp[15] = XtimeB[this.state[0]] ^ XtimeD[this.state[1]] ^ Xtime9[this.state[2]] ^ XtimeE[this.state[3]];
         this.tmp[4] = XtimeE[this.state[4]] ^ XtimeB[this.state[5]] ^ XtimeD[this.state[6]] ^ Xtime9[this.state[7]];
         this.tmp[9] = Xtime9[this.state[4]] ^ XtimeE[this.state[5]] ^ XtimeB[this.state[6]] ^ XtimeD[this.state[7]];
         this.tmp[14] = XtimeD[this.state[4]] ^ Xtime9[this.state[5]] ^ XtimeE[this.state[6]] ^ XtimeB[this.state[7]];
         this.tmp[3] = XtimeB[this.state[4]] ^ XtimeD[this.state[5]] ^ Xtime9[this.state[6]] ^ XtimeE[this.state[7]];
         this.tmp[8] = XtimeE[this.state[8]] ^ XtimeB[this.state[9]] ^ XtimeD[this.state[10]] ^ Xtime9[this.state[11]];
         this.tmp[13] = Xtime9[this.state[8]] ^ XtimeE[this.state[9]] ^ XtimeB[this.state[10]] ^ XtimeD[this.state[11]];
         this.tmp[2] = XtimeD[this.state[8]] ^ Xtime9[this.state[9]] ^ XtimeE[this.state[10]] ^ XtimeB[this.state[11]];
         this.tmp[7] = XtimeB[this.state[8]] ^ XtimeD[this.state[9]] ^ Xtime9[this.state[10]] ^ XtimeE[this.state[11]];
         this.tmp[12] = XtimeE[this.state[12]] ^ XtimeB[this.state[13]] ^ XtimeD[this.state[14]] ^ Xtime9[this.state[15]];
         this.tmp[1] = Xtime9[this.state[12]] ^ XtimeE[this.state[13]] ^ XtimeB[this.state[14]] ^ XtimeD[this.state[15]];
         this.tmp[6] = XtimeD[this.state[12]] ^ Xtime9[this.state[13]] ^ XtimeE[this.state[14]] ^ XtimeB[this.state[15]];
         this.tmp[11] = XtimeB[this.state[12]] ^ XtimeD[this.state[13]] ^ Xtime9[this.state[14]] ^ XtimeE[this.state[15]];
         i = 0;
         while(i < 4 * Nb)
         {
            this.state[i] = InvSbox[this.tmp[i]];
            i++;
         }
      }
      
      protected function addRoundKey(key:ByteArray, offset:uint) : void {
         var idx:uint = 0;
         idx = 0;
         while(idx < 16)
         {
            this.state[idx] = this.state[idx] ^ key[idx + offset];
            idx++;
         }
      }
      
      public function toString() : String {
         return "aes" + 8 * this.keyLength;
      }
   }
}
