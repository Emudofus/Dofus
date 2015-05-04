package com.ankamagames.jerakine.network
{
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.utils.types.Int64;
   import flash.utils.IDataInput;
   import com.ankamagames.jerakine.network.utils.types.UInt64;
   import flash.utils.IDataOutput;
   
   public class CustomDataWrapper extends Object implements ICustomDataInput, ICustomDataOutput
   {
      
      public function CustomDataWrapper(param1:*)
      {
         super();
         this._data = param1;
      }
      
      private static const INT_SIZE:int = 32;
      
      private static const SHORT_SIZE:int = 16;
      
      private static const SHORT_MIN_VALUE:int = -32768;
      
      private static const SHORT_MAX_VALUE:int = 32767;
      
      private static const UNSIGNED_SHORT_MAX_VALUE:int = 65536;
      
      private static const CHUNCK_BIT_SIZE:int = 7;
      
      private static const MAX_ENCODING_LENGTH:int = Math.ceil(INT_SIZE / CHUNCK_BIT_SIZE);
      
      private static const MASK_10000000:int = 128;
      
      private static const MASK_01111111:int = 127;
      
      private var _data;
      
      public function set position(param1:uint) : void
      {
         this._data.position = param1;
      }
      
      public function get position() : uint
      {
         return this._data.position;
      }
      
      public function readVarInt() : int
      {
         var _loc4_:* = 0;
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = false;
         while(_loc2_ < INT_SIZE)
         {
            _loc4_ = this._data.readByte();
            _loc3_ = (_loc4_ & MASK_10000000) == MASK_10000000;
            if(_loc2_ > 0)
            {
               _loc1_ = _loc1_ + ((_loc4_ & MASK_01111111) << _loc2_);
            }
            else
            {
               _loc1_ = _loc1_ + (_loc4_ & MASK_01111111);
            }
            _loc2_ = _loc2_ + CHUNCK_BIT_SIZE;
            if(!_loc3_)
            {
               return _loc1_;
            }
         }
         throw new Error("Too much data");
      }
      
      public function readVarUhInt() : uint
      {
         return this.readVarInt();
      }
      
      public function readVarShort() : int
      {
         var _loc4_:* = 0;
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = false;
         while(_loc2_ < SHORT_SIZE)
         {
            _loc4_ = this._data.readByte();
            _loc3_ = (_loc4_ & MASK_10000000) == MASK_10000000;
            if(_loc2_ > 0)
            {
               _loc1_ = _loc1_ + ((_loc4_ & MASK_01111111) << _loc2_);
            }
            else
            {
               _loc1_ = _loc1_ + (_loc4_ & MASK_01111111);
            }
            _loc2_ = _loc2_ + CHUNCK_BIT_SIZE;
            if(!_loc3_)
            {
               if(_loc1_ > SHORT_MAX_VALUE)
               {
                  _loc1_ = _loc1_ - UNSIGNED_SHORT_MAX_VALUE;
               }
               return _loc1_;
            }
         }
         throw new Error("Too much data");
      }
      
      public function readVarUhShort() : uint
      {
         return this.readVarShort();
      }
      
      public function readVarLong() : Number
      {
         return this.readInt64(this._data).toNumber();
      }
      
      public function readVarUhLong() : Number
      {
         return this.readUInt64(this._data).toNumber();
      }
      
      public function readBytes(param1:ByteArray, param2:uint = 0, param3:uint = 0) : void
      {
         this._data.readBytes(param1,param2,param3);
      }
      
      public function readBoolean() : Boolean
      {
         return this._data.readBoolean();
      }
      
      public function readByte() : int
      {
         return this._data.readByte();
      }
      
      public function readUnsignedByte() : uint
      {
         return this._data.readUnsignedByte();
      }
      
      public function readShort() : int
      {
         return this._data.readShort();
      }
      
      public function readUnsignedShort() : uint
      {
         return this._data.readUnsignedShort();
      }
      
      public function readInt() : int
      {
         return this._data.readInt();
      }
      
      public function readUnsignedInt() : uint
      {
         return this._data.readUnsignedInt();
      }
      
      public function readFloat() : Number
      {
         return this._data.readFloat();
      }
      
      public function readDouble() : Number
      {
         return this._data.readDouble();
      }
      
      public function readMultiByte(param1:uint, param2:String) : String
      {
         return this._data.readMultiByte(param1,param2);
      }
      
      public function readUTF() : String
      {
         return this._data.readUTF();
      }
      
      public function readUTFBytes(param1:uint) : String
      {
         return this._data.readUTFBytes(param1);
      }
      
      public function get bytesAvailable() : uint
      {
         return this._data.bytesAvailable;
      }
      
      public function readObject() : *
      {
         return this._data.readObject();
      }
      
      public function get objectEncoding() : uint
      {
         return this._data.objectEncoding;
      }
      
      public function set objectEncoding(param1:uint) : void
      {
         this._data.objectEncoding = param1;
      }
      
      public function get endian() : String
      {
         return this._data.endian;
      }
      
      public function set endian(param1:String) : void
      {
         this._data.endian = param1;
      }
      
      public function writeVarInt(param1:int) : void
      {
         var _loc5_:* = 0;
         var _loc2_:ByteArray = new ByteArray();
         if(param1 >= 0 && param1 <= MASK_01111111)
         {
            _loc2_.writeByte(param1);
            this._data.writeBytes(_loc2_);
            return;
         }
         var _loc3_:int = param1;
         var _loc4_:ByteArray = new ByteArray();
         while(_loc3_ != 0)
         {
            _loc4_.writeByte(_loc3_ & MASK_01111111);
            _loc4_.position = _loc4_.length - 1;
            _loc5_ = _loc4_.readByte();
            _loc3_ = _loc3_ >>> CHUNCK_BIT_SIZE;
            if(_loc3_ > 0)
            {
               _loc5_ = _loc5_ | MASK_10000000;
            }
            _loc2_.writeByte(_loc5_);
         }
         this._data.writeBytes(_loc2_);
      }
      
      public function writeVarShort(param1:int) : void
      {
         var _loc5_:* = 0;
         if(param1 > SHORT_MAX_VALUE || param1 < SHORT_MIN_VALUE)
         {
            throw new Error("Forbidden value");
         }
         else
         {
            var _loc2_:ByteArray = new ByteArray();
            if(param1 >= 0 && param1 <= MASK_01111111)
            {
               _loc2_.writeByte(param1);
               this._data.writeBytes(_loc2_);
               return;
            }
            var _loc3_:* = param1 & 65535;
            var _loc4_:ByteArray = new ByteArray();
            while(_loc3_ != 0)
            {
               _loc4_.writeByte(_loc3_ & MASK_01111111);
               _loc4_.position = _loc4_.length - 1;
               _loc5_ = _loc4_.readByte();
               _loc3_ = _loc3_ >>> CHUNCK_BIT_SIZE;
               if(_loc3_ > 0)
               {
                  _loc5_ = _loc5_ | MASK_10000000;
               }
               _loc2_.writeByte(_loc5_);
            }
            this._data.writeBytes(_loc2_);
            return;
         }
      }
      
      public function writeVarLong(param1:Number) : void
      {
         var _loc3_:uint = 0;
         var _loc2_:Int64 = Int64.fromNumber(param1);
         if(_loc2_.high == 0)
         {
            this.writeint32(this._data,_loc2_.low);
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < 4)
            {
               this._data.writeByte(_loc2_.low & 127 | 128);
               _loc2_.low = _loc2_.low >>> 7;
               _loc3_++;
            }
            if((_loc2_.high & 268435455 << 3) == 0)
            {
               this._data.writeByte(_loc2_.high << 4 | _loc2_.low);
            }
            else
            {
               this._data.writeByte((_loc2_.high << 4 | _loc2_.low) & 127 | 128);
               this.writeint32(this._data,_loc2_.high >>> 3);
            }
         }
      }
      
      public function writeBytes(param1:ByteArray, param2:uint = 0, param3:uint = 0) : void
      {
         this._data.writeBytes(param1,param2,param3);
      }
      
      public function writeBoolean(param1:Boolean) : void
      {
         this._data.writeBoolean(param1);
      }
      
      public function writeByte(param1:int) : void
      {
         this._data.writeByte(param1);
      }
      
      public function writeShort(param1:int) : void
      {
         this._data.writeShort(param1);
      }
      
      public function writeInt(param1:int) : void
      {
         this._data.writeInt(param1);
      }
      
      public function writeUnsignedInt(param1:uint) : void
      {
         this._data.writeUnsignedInt(param1);
      }
      
      public function writeFloat(param1:Number) : void
      {
         this._data.writeFloat(param1);
      }
      
      public function writeDouble(param1:Number) : void
      {
         this._data.writeDouble(param1);
      }
      
      public function writeMultiByte(param1:String, param2:String) : void
      {
         this._data.writeMultiByte(param1,param2);
      }
      
      public function writeUTF(param1:String) : void
      {
         this._data.writeUTF(param1);
      }
      
      public function writeUTFBytes(param1:String) : void
      {
         this._data.writeUTFBytes(param1);
      }
      
      public function writeObject(param1:*) : void
      {
         this._data.writeObject(param1);
      }
      
      private function readInt64(param1:IDataInput) : Int64
      {
         var _loc3_:uint = 0;
         var _loc2_:Int64 = new Int64();
         var _loc4_:uint = 0;
         while(true)
         {
            _loc3_ = param1.readUnsignedByte();
            if(_loc4_ == 28)
            {
               break;
            }
            if(_loc3_ >= 128)
            {
               _loc2_.low = _loc2_.low | (_loc3_ & 127) << _loc4_;
               _loc4_ = _loc4_ + 7;
               continue;
            }
            _loc2_.low = _loc2_.low | _loc3_ << _loc4_;
            return _loc2_;
         }
         if(_loc3_ >= 128)
         {
            _loc3_ = _loc3_ & 127;
            _loc2_.low = _loc2_.low | _loc3_ << _loc4_;
            _loc2_.high = _loc3_ >>> 4;
            _loc4_ = 3;
            while(true)
            {
               _loc3_ = param1.readUnsignedByte();
               if(_loc4_ < 32)
               {
                  if(_loc3_ >= 128)
                  {
                     _loc2_.high = _loc2_.high | (_loc3_ & 127) << _loc4_;
                  }
                  else
                  {
                     break;
                  }
               }
               _loc4_ = _loc4_ + 7;
            }
            _loc2_.high = _loc2_.high | _loc3_ << _loc4_;
            return _loc2_;
         }
         _loc2_.low = _loc2_.low | _loc3_ << _loc4_;
         _loc2_.high = _loc3_ >>> 4;
         return _loc2_;
      }
      
      private function readUInt64(param1:IDataInput) : UInt64
      {
         var _loc3_:uint = 0;
         var _loc2_:UInt64 = new UInt64();
         var _loc4_:uint = 0;
         while(true)
         {
            _loc3_ = param1.readUnsignedByte();
            if(_loc4_ == 28)
            {
               break;
            }
            if(_loc3_ >= 128)
            {
               _loc2_.low = _loc2_.low | (_loc3_ & 127) << _loc4_;
               _loc4_ = _loc4_ + 7;
               continue;
            }
            _loc2_.low = _loc2_.low | _loc3_ << _loc4_;
            return _loc2_;
         }
         if(_loc3_ >= 128)
         {
            _loc3_ = _loc3_ & 127;
            _loc2_.low = _loc2_.low | _loc3_ << _loc4_;
            _loc2_.high = _loc3_ >>> 4;
            _loc4_ = 3;
            while(true)
            {
               _loc3_ = param1.readUnsignedByte();
               if(_loc4_ < 32)
               {
                  if(_loc3_ >= 128)
                  {
                     _loc2_.high = _loc2_.high | (_loc3_ & 127) << _loc4_;
                  }
                  else
                  {
                     break;
                  }
               }
               _loc4_ = _loc4_ + 7;
            }
            _loc2_.high = _loc2_.high | _loc3_ << _loc4_;
            return _loc2_;
         }
         _loc2_.low = _loc2_.low | _loc3_ << _loc4_;
         _loc2_.high = _loc3_ >>> 4;
         return _loc2_;
      }
      
      private function writeint32(param1:IDataOutput, param2:uint) : void
      {
         while(param2 >= 128)
         {
            param1.writeByte(param2 & 127 | 128);
            var param2:uint = param2 >>> 7;
         }
         param1.writeByte(param2);
      }
   }
}
