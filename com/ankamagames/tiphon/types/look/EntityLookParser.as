package com.ankamagames.tiphon.types.look
{
   import __AS3__.vec.Vector;
   
   public class EntityLookParser extends Object
   {
      
      public function EntityLookParser() {
         super();
      }
      
      public static const CURRENT_FORMAT_VERSION:uint = 0;
      
      public static const DEFAULT_NUMBER_BASE:uint = 10;
      
      public static function fromString(param1:String, param2:uint=0, param3:uint=10, param4:TiphonEntityLook=null) : TiphonEntityLook {
         var _loc9_:String = null;
         var _loc10_:Array = null;
         var _loc11_:Array = null;
         var _loc12_:String = null;
         var _loc13_:Array = null;
         var _loc14_:String = null;
         var _loc15_:Array = null;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:Array = null;
         var _loc19_:* = NaN;
         var _loc20_:String = null;
         var _loc21_:uint = 0;
         var _loc22_:Array = null;
         var _loc23_:String = null;
         var _loc24_:* = 0;
         var _loc25_:String = null;
         var _loc26_:String = null;
         var _loc27_:Array = null;
         var _loc28_:uint = 0;
         var _loc29_:uint = 0;
         var _loc5_:TiphonEntityLook = param4?param4:new TiphonEntityLook();
         _loc5_.lock();
         var _loc6_:uint = CURRENT_FORMAT_VERSION;
         var _loc7_:uint = DEFAULT_NUMBER_BASE;
         if(param1.charAt(0) == "[")
         {
            _loc9_ = param1.substring(1,param1.indexOf("]"));
            if(_loc9_.indexOf(",") > 0)
            {
               _loc10_ = _loc9_.split(",");
               if(_loc10_.length != 2)
               {
                  throw new Error("Malformated headers in an Entity Look string.");
               }
               else
               {
                  _loc6_ = uint(_loc10_[0]);
                  _loc7_ = getNumberBase(_loc10_[1]);
               }
            }
            else
            {
               _loc6_ = uint(_loc9_);
            }
            param1 = param1.substr(param1.indexOf("]") + 1);
         }
         if(!(param1.charAt(0) == "{") || !(param1.charAt(param1.length-1) == "}"))
         {
            throw new Error("Malformed body in an Entity Look string.");
         }
         else
         {
            param1 = param1.substring(1,param1.length-1);
            _loc8_ = param1.split("|");
            _loc5_.setBone(parseInt(_loc8_[0],_loc7_));
            if(_loc8_.length > 1 && _loc8_[1].length > 0)
            {
               _loc11_ = _loc8_[1].split(",");
               for each (_loc12_ in _loc11_)
               {
                  _loc5_.addSkin(parseInt(_loc12_,_loc7_));
               }
            }
            if(_loc8_.length > 2 && _loc8_[2].length > 0)
            {
               _loc13_ = _loc8_[2].split(",");
               for each (_loc14_ in _loc13_)
               {
                  _loc15_ = _loc14_.split("=");
                  if(_loc15_.length != 2)
                  {
                     throw new Error("Malformed color in an Entity Look string.");
                  }
                  else
                  {
                     _loc16_ = parseInt(_loc15_[0],_loc7_);
                     _loc17_ = 0;
                     if(_loc15_[1].charAt(0) == "#")
                     {
                        _loc17_ = parseInt(_loc15_[1].substr(1),16);
                     }
                     else
                     {
                        _loc17_ = parseInt(_loc15_[1],_loc7_);
                     }
                     _loc5_.setColor(_loc16_,_loc17_);
                     continue;
                  }
               }
            }
            if(_loc8_.length > 3 && _loc8_[3].length > 0)
            {
               _loc18_ = _loc8_[3].split(",");
               if(_loc18_.length == 1)
               {
                  _loc19_ = parseInt(_loc18_[0],_loc7_) / 100;
                  _loc5_.setScales(_loc19_,_loc19_);
               }
               else
               {
                  if(_loc18_.length == 2)
                  {
                     _loc5_.setScales(parseInt(_loc18_[0],_loc7_) / 100,parseInt(_loc18_[1],_loc7_) / 100);
                  }
                  else
                  {
                     throw new Error("Malformed scale in an Entity Look string.");
                  }
               }
            }
            else
            {
               _loc5_.setScales(1,1);
            }
            if(_loc8_.length > 4 && _loc8_[4].length > 0)
            {
               _loc20_ = "";
               _loc21_ = 4;
               while(_loc21_ < _loc8_.length)
               {
                  _loc20_ = _loc20_ + (_loc8_[_loc21_] + "|");
                  _loc21_++;
               }
               _loc20_ = _loc20_.substr(0,_loc20_.length-1);
               _loc22_ = [];
               while(true)
               {
                  _loc24_ = _loc20_.indexOf("}");
                  if(_loc24_ == -1)
                  {
                     break;
                  }
                  _loc22_.push(_loc20_.substr(0,_loc24_ + 1));
                  _loc20_ = _loc20_.substr(_loc24_ + 1);
               }
               for each (_loc23_ in _loc22_)
               {
                  _loc25_ = _loc23_.substring(0,_loc23_.indexOf("="));
                  _loc26_ = _loc23_.substr(_loc23_.indexOf("=") + 1);
                  _loc27_ = _loc25_.split("@");
                  if(_loc27_.length != 2)
                  {
                     throw new Error("Malformed subentity binding in an Entity Look string.");
                  }
                  else
                  {
                     _loc28_ = parseInt(_loc27_[0],_loc7_);
                     _loc29_ = parseInt(_loc27_[1],_loc7_);
                     _loc5_.addSubEntity(_loc28_,_loc29_,EntityLookParser.fromString(_loc26_,_loc6_,_loc7_));
                     continue;
                  }
               }
            }
            _loc5_.unlock(true);
            return _loc5_;
         }
      }
      
      public static function toString(param1:TiphonEntityLook) : String {
         var _loc8_:uint = 0;
         var _loc9_:* = false;
         var _loc10_:uint = 0;
         var _loc11_:* = false;
         var _loc12_:String = null;
         var _loc13_:* = false;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc16_:TiphonEntityLook = null;
         var _loc2_:* = "{";
         _loc2_ = _loc2_ + param1.getBone().toString(DEFAULT_NUMBER_BASE);
         _loc2_ = _loc2_ + "|";
         var _loc3_:Vector.<uint> = param1.getSkins(true);
         if(_loc3_ != null)
         {
            _loc8_ = 0;
            _loc9_ = true;
            for each (_loc10_ in _loc3_)
            {
               if(!(_loc8_++ == 0 && !(param1.defaultSkin == -1)))
               {
                  if(_loc9_)
                  {
                     _loc9_ = false;
                  }
                  else
                  {
                     _loc2_ = _loc2_ + ",";
                  }
                  _loc2_ = _loc2_ + _loc10_.toString(DEFAULT_NUMBER_BASE);
               }
            }
         }
         _loc2_ = _loc2_ + "|";
         var _loc4_:Array = param1.getColors(true);
         if(_loc4_ != null)
         {
            _loc11_ = true;
            for (_loc12_ in _loc4_)
            {
               if(_loc11_)
               {
                  _loc11_ = false;
               }
               else
               {
                  _loc2_ = _loc2_ + ",";
               }
               _loc2_ = _loc2_ + (uint(_loc12_).toString(DEFAULT_NUMBER_BASE) + "=" + uint(_loc4_[_loc12_]).toString(DEFAULT_NUMBER_BASE));
            }
         }
         _loc2_ = _loc2_ + "|";
         var _loc5_:Number = param1.getScaleX();
         var _loc6_:Number = param1.getScaleY();
         if(!(_loc5_ == 1) || !(_loc6_ == 1))
         {
            _loc2_ = _loc2_ + Math.round(_loc5_ * 100).toString(DEFAULT_NUMBER_BASE);
            if(_loc6_ != _loc5_)
            {
               _loc2_ = _loc2_ + ("," + Math.round(_loc6_ * 100).toString(DEFAULT_NUMBER_BASE));
            }
         }
         _loc2_ = _loc2_ + "|";
         var _loc7_:Array = param1.getSubEntities(true);
         if(_loc7_ != null)
         {
            _loc13_ = true;
            for (_loc14_ in _loc7_)
            {
               for (_loc15_ in _loc7_[_loc14_])
               {
                  _loc16_ = _loc7_[_loc14_][_loc15_];
                  if(_loc13_)
                  {
                     _loc13_ = false;
                  }
                  else
                  {
                     _loc2_ = _loc2_ + ",";
                  }
                  _loc2_ = _loc2_ + (uint(_loc14_).toString(DEFAULT_NUMBER_BASE) + "@" + uint(_loc15_).toString(DEFAULT_NUMBER_BASE) + "=" + _loc16_.toString());
               }
            }
         }
         while(_loc2_.charAt(_loc2_.length-1) == "|")
         {
            _loc2_ = _loc2_.substr(0,_loc2_.length-1);
         }
         return _loc2_ + "}";
      }
      
      private static function getNumberBase(param1:String) : uint {
         switch(param1)
         {
            case "A":
               return 10;
            case "G":
               return 16;
            case "Z":
               return 36;
            default:
               throw new Error("Unknown number base type \'" + param1 + "\' in an Entity Look string.");
         }
      }
   }
}
