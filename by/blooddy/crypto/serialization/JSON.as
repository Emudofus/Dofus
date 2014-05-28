package by.blooddy.crypto.serialization
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import flash.utils.Dictionary;
   import flash.xml.XMLDocument;
   import flash.errors.StackOverflowError;
   import flash.system.ApplicationDomain;
   
   public class JSON extends Object
   {
      
      public function JSON() {
      }
      
      public static function encode(param1:*) : String {
         var _loc2_:Object = XML.settings();
         XML.setSettings(
            {
               "ignoreComments":true,
               "ignoreProcessingInstructions":false,
               "ignoreWhitespace":true,
               "prettyIndent":false,
               "prettyPrinting":false
            });
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUTFBytes("0123456789abcdef");
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.endian = Endian.LITTLE_ENDIAN;
         var cvint:Class = (new Vector.<int>() as Object).constructor;
         var cvuint:Class = (new Vector.<uint>() as Object).constructor;
         var cvdouble:Class = (new Vector.<Number>() as Object).constructor;
         var cvobject:Class = (new Vector.<Object>() as Object).constructor;
         var writeValue:Function = null;
         writeValue = function(param1:Dictionary, param2:ByteArray, param3:ByteArray, param4:*):*
         {
            var _loc7_:* = 0;
            var _loc8_:* = 0;
            var _loc9_:* = NaN;
            var _loc10_:* = null as String;
            var _loc11_:* = false;
            var _loc12_:* = null as Array;
            var _loc13_:* = null;
            var _loc14_:* = null as Array;
            var _loc15_:* = 0;
            var _loc16_:* = null;
            var _loc17_:* = false;
            var _loc18_:uint = 0;
            var _loc19_:uint = 0;
            var _loc20_:uint = 0;
            var _loc21_:uint = 0;
            var _loc22_:uint = 0;
            var _loc6_:String = typeof param4;
            if(_loc6_ == "number")
            {
               if(isFinite(param4))
               {
                  if(param4 >= 0)
                  {
                     if(param4 <= 9)
                     {
                     }
                  }
                  param2.writeUTFBytes(param4.toString());
               }
               else
               {
                  param2.writeInt(1819047278);
               }
            }
            else if(_loc6_ == "boolean")
            {
               if(param4)
               {
                  param2.writeInt(1702195828);
               }
               else
               {
                  param2.writeInt(1936482662);
                  param2.writeByte(101);
               }
            }
            else
            {
               if(_loc6_ == "xml")
               {
                  param4 = param4.toXMLString();
                  _loc6_ = "string";
               }
               else if(param4)
               {
               }
               
               if(_loc6_ == "string")
               {
                  if((param4.length) <= 0)
                  {
                     param2.writeShort(8738);
                  }
                  else
                  {
                     param2.writeByte(34);
                     param3.position = 16;
                     param3.writeUTFBytes(param4);
                     _loc18_ = param3.position;
                     _loc19_ = 16;
                     _loc20_ = _loc19_;
                     do
                     {
                        _loc22_ = param3[_loc19_];
                        if(_loc22_ >= (32))
                        {
                           if(_loc22_ != (34))
                           {
                              if(_loc22_ != (47))
                              {
                              }
                           }
                        }
                        _loc21_ = _loc19_ - _loc20_;
                        if(_loc21_ > 0)
                        {
                           param2.writeBytes(param3,_loc20_,_loc21_);
                        }
                        _loc20_ = _loc19_ + 1;
                        if(_loc22_ == (10))
                        {
                           param2.writeShort(28252);
                        }
                        else if(_loc22_ == (13))
                        {
                           param2.writeShort(29276);
                        }
                        else if(_loc22_ == (9))
                        {
                           param2.writeShort(29788);
                        }
                        else if(_loc22_ == (34))
                        {
                           param2.writeShort(8796);
                        }
                        else if(_loc22_ == (47))
                        {
                           param2.writeShort(12124);
                        }
                        else if(_loc22_ == (92))
                        {
                           param2.writeShort(23644);
                        }
                        else if(_loc22_ == (11))
                        {
                           param2.writeShort(30300);
                        }
                        else if(_loc22_ == (8))
                        {
                           param2.writeShort(25180);
                        }
                        else if(_loc22_ == (12))
                        {
                           param2.writeShort(26204);
                        }
                        else
                        {
                           param2.writeInt(808482140);
                           param2.writeByte(param3[_loc22_ >>> 4]);
                           param2.writeByte(param3[_loc22_ & 15]);
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        _loc19_++;
                     }
                     while(_loc19_ < _loc18_);
                     
                     _loc21_ = _loc19_ - _loc20_;
                     if(_loc21_ > 0)
                     {
                        param2.writeBytes(param3,_loc20_,_loc21_);
                     }
                     param2.writeByte(34);
                  }
               }
               else if(!param4)
               {
                  param2.writeInt(1819047278);
               }
               
            }
            
         };
         XML.setSettings(_loc2_);
         var _loc5_:uint = _loc4_.position;
         _loc4_.position = 0;
         return _loc4_.readUTFBytes(_loc5_);
      }
      
      public static function decode(param1:String) : * {
         var _loc4_:* = null as ByteArray;
         var _loc5_:* = null as ByteArray;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:* = false;
         var _loc13_:* = null;
         if(param1 == null)
         {
            Error.throwError(TypeError,2007,"value");
         }
         var _loc3_:* = undefined;
         if(param1.length > 0)
         {
            _loc4_ = ApplicationDomain.currentDomain.domainMemory;
            _loc5_ = new ByteArray();
            _loc5_.writeUTFBytes(param1);
            _loc5_.writeByte(0);
            if(_loc5_.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
            {
               _loc5_.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
            }
            ApplicationDomain.currentDomain.domainMemory = _loc5_;
            _loc6_ = 0;
            while(true)
            {
               _loc9_ = _loc6_;
               _loc6_++;
               _loc8_ = op_li8(_loc9_) /*Alchemy*/;
               if(_loc8_ != (13))
               {
                  if(_loc8_ != (10))
                  {
                     if(_loc8_ != (32))
                     {
                        if(_loc8_ != (9))
                        {
                           if(_loc8_ != (11))
                           {
                              if(_loc8_ != (8))
                              {
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         else
         {
            return _loc3_;
         }
      }
   }
}
