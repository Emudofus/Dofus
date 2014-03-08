package com.hurlant.util.der
{
   import flash.utils.ByteArray;
   
   public class DER extends Object
   {
      
      public function DER() {
         super();
      }
      
      public static var indent:String = "";
      
      public static function parse(param1:ByteArray, param2:*=null) : IAsn1Type {
         var _loc3_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:ByteArray = null;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:Sequence = null;
         var _loc10_:Array = null;
         var _loc11_:Set = null;
         var _loc12_:ByteString = null;
         var _loc13_:PrintableString = null;
         var _loc14_:UTCTime = null;
         var _loc15_:Object = null;
         var _loc16_:* = false;
         var _loc17_:* = false;
         var _loc18_:String = null;
         var _loc19_:* = undefined;
         var _loc20_:IAsn1Type = null;
         var _loc21_:* = 0;
         var _loc22_:ByteArray = null;
         _loc3_ = param1.readUnsignedByte();
         var _loc4_:* = !((_loc3_ & 32) == 0);
         _loc3_ = _loc3_ & 31;
         _loc5_ = param1.readUnsignedByte();
         if(_loc5_ >= 128)
         {
            _loc7_ = _loc5_ & 127;
            _loc5_ = 0;
            while(_loc7_ > 0)
            {
               _loc5_ = _loc5_ << 8 | param1.readUnsignedByte();
               _loc7_--;
            }
         }
         switch(_loc3_)
         {
            case 0:
            case 16:
               _loc8_ = param1.position;
               _loc9_ = new Sequence(_loc3_,_loc5_);
               _loc10_ = param2 as Array;
               if(_loc10_ != null)
               {
                  _loc10_ = _loc10_.concat();
               }
               while(param1.position < _loc8_ + _loc5_)
               {
                  _loc15_ = null;
                  if(_loc10_ != null)
                  {
                     _loc15_ = _loc10_.shift();
                  }
                  if(_loc15_ != null)
                  {
                     while((_loc15_) && (_loc15_.optional))
                     {
                        _loc16_ = _loc15_.value is Array;
                        _loc17_ = isConstructedType(param1);
                        if(_loc16_ != _loc17_)
                        {
                           _loc9_.push(_loc15_.defaultValue);
                           _loc9_[_loc15_.name] = _loc15_.defaultValue;
                           _loc15_ = _loc10_.shift();
                           continue;
                        }
                        break;
                     }
                  }
                  if(_loc15_ != null)
                  {
                     _loc18_ = _loc15_.name;
                     _loc19_ = _loc15_.value;
                     if(_loc15_.extract)
                     {
                        _loc21_ = getLengthOfNextElement(param1);
                        _loc22_ = new ByteArray();
                        _loc22_.writeBytes(param1,param1.position,_loc21_);
                        _loc9_[_loc18_ + "_bin"] = _loc22_;
                     }
                     _loc20_ = DER.parse(param1,_loc19_);
                     _loc9_.push(_loc20_);
                     _loc9_[_loc18_] = _loc20_;
                  }
                  else
                  {
                     _loc9_.push(DER.parse(param1));
                  }
               }
               return _loc9_;
            case 17:
               _loc8_ = param1.position;
               _loc11_ = new Set(_loc3_,_loc5_);
               while(param1.position < _loc8_ + _loc5_)
               {
                  _loc11_.push(DER.parse(param1));
               }
               return _loc11_;
            case 2:
               _loc6_ = new ByteArray();
               param1.readBytes(_loc6_,0,_loc5_);
               _loc6_.position = 0;
               return new Integer(_loc3_,_loc5_,_loc6_);
            case 6:
               _loc6_ = new ByteArray();
               param1.readBytes(_loc6_,0,_loc5_);
               _loc6_.position = 0;
               return new ObjectIdentifier(_loc3_,_loc5_,_loc6_);
            case 3:
               trace("I DONT KNOW HOW TO HANDLE DER stuff of TYPE " + _loc3_);
            case 4:
               if(param1[param1.position] == 0)
               {
                  param1.position++;
                  _loc5_--;
               }
            case 5:
               _loc12_ = new ByteString(_loc3_,_loc5_);
               param1.readBytes(_loc12_,0,_loc5_);
               return _loc12_;
            case 19:
               return null;
            case 34:
               _loc13_ = new PrintableString(_loc3_,_loc5_);
               _loc13_.setString(param1.readMultiByte(_loc5_,"US-ASCII"));
               return _loc13_;
            case 20:
            case 23:
               _loc13_ = new PrintableString(_loc3_,_loc5_);
               _loc13_.setString(param1.readMultiByte(_loc5_,"latin1"));
               return _loc13_;
            default:
               _loc14_ = new UTCTime(_loc3_,_loc5_);
               _loc14_.setUTCTime(param1.readMultiByte(_loc5_,"US-ASCII"));
               return _loc14_;
         }
      }
      
      private static function getLengthOfNextElement(param1:ByteArray) : int {
         var _loc4_:* = 0;
         var _loc2_:uint = param1.position;
         param1.position++;
         var _loc3_:int = param1.readUnsignedByte();
         if(_loc3_ >= 128)
         {
            _loc4_ = _loc3_ & 127;
            _loc3_ = 0;
            while(_loc4_ > 0)
            {
               _loc3_ = _loc3_ << 8 | param1.readUnsignedByte();
               _loc4_--;
            }
         }
         _loc3_ = _loc3_ + (param1.position - _loc2_);
         param1.position = _loc2_;
         return _loc3_;
      }
      
      private static function isConstructedType(param1:ByteArray) : Boolean {
         var _loc2_:int = param1[param1.position];
         return !((_loc2_ & 32) == 0);
      }
      
      public static function wrapDER(param1:int, param2:ByteArray) : ByteArray {
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeByte(param1);
         var _loc4_:int = param2.length;
         if(_loc4_ < 128)
         {
            _loc3_.writeByte(_loc4_);
         }
         else
         {
            if(_loc4_ < 256)
            {
               _loc3_.writeByte(1 | 128);
               _loc3_.writeByte(_loc4_);
            }
            else
            {
               if(_loc4_ < 65536)
               {
                  _loc3_.writeByte(2 | 128);
                  _loc3_.writeByte(_loc4_ >> 8);
                  _loc3_.writeByte(_loc4_);
               }
               else
               {
                  if(_loc4_ < 65536 * 256)
                  {
                     _loc3_.writeByte(3 | 128);
                     _loc3_.writeByte(_loc4_ >> 16);
                     _loc3_.writeByte(_loc4_ >> 8);
                     _loc3_.writeByte(_loc4_);
                  }
                  else
                  {
                     _loc3_.writeByte(4 | 128);
                     _loc3_.writeByte(_loc4_ >> 24);
                     _loc3_.writeByte(_loc4_ >> 16);
                     _loc3_.writeByte(_loc4_ >> 8);
                     _loc3_.writeByte(_loc4_);
                  }
               }
            }
         }
         _loc3_.writeBytes(param2);
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}
