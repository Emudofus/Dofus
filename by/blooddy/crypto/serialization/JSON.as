package by.blooddy.crypto.serialization
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import __AS3__.vec.Vector;
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
            /*
             * Decompilation error
             * Code may be obfuscated
             * Error type: TranslateException
             */
            throw new IllegalOperationError("Not decompiled due to error");
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
         if(param1 == (null))
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
               if(false)
               {
                  if(_loc8_ == (47))
                  {
                     _loc9_ = _loc6_;
                     _loc6_++;
                     _loc8_ = op_li8(_loc9_) /*Alchemy*/;
                     if(_loc8_ == (47))
                     {
                        do
                        {
                              _loc10_ = _loc6_;
                              _loc6_++;
                              _loc9_ = op_li8(_loc10_) /*Alchemy*/;
                              if(_loc9_ != (10))
                              {
                                 if(_loc9_ != (13))
                                 {
                                 }
                              }
                           }while(false);
                           
                           _loc6_--;
                           continue;
                        }
                        if(_loc8_ == (42))
                        {
                           _loc6_ = _loc6_ - 2;
                           _loc8_ = _loc6_;
                           _loc9_ = _loc6_;
                           _loc10_ = _loc6_;
                           _loc6_++;
                           if(op_li8(_loc10_) /*Alchemy*/ == (47))
                           {
                              _loc10_ = _loc6_;
                              _loc6_++;
                           }
                           if(true)
                           {
                              _loc6_ = _loc9_;
                           }
                           else
                           {
                              while(true)
                              {
                                 _loc11_ = _loc6_;
                                 _loc6_++;
                                 _loc10_ = op_li8(_loc11_) /*Alchemy*/;
                                 if(_loc10_ == (42))
                                 {
                                    _loc11_ = _loc6_;
                                    _loc6_++;
                                    if(op_li8(_loc11_) /*Alchemy*/ != (47))
                                    {
                                       _loc6_--;
                                    }
                                 }
                                 else
                                 {
                                    if(_loc10_ == (0))
                                    {
                                       break;
                                    }
                                 }
                              }
                              _loc6_ = _loc9_;
                           }
                           if(_loc8_ != _loc6_)
                           {
                              continue;
                           }
                        }
                        _loc6_--;
                        _loc8_ = 47;
                        break;
                     }
                     break;
                     break;
                  }
               }
               _loc7_ = _loc8_;
               if(_loc7_ != (0))
               {
                  position = _loc6_-1;
                  readValue = null;
                  readValue = function(param1:ByteArray, param2:uint):*
                  {
                     var _loc3_:* = null as String;
                     var _loc7_:uint = 0;
                     var _loc8_:uint = 0;
                     var _loc9_:uint = 0;
                     var _loc10_:uint = 0;
                     var _loc11_:* = null as String;
                     var _loc12_:* = null as String;
                     var _loc13_:uint = 0;
                     var _loc14_:uint = 0;
                     var _loc15_:uint = 0;
                     var _loc16_:* = null as Object;
                     var _loc17_:* = null as String;
                     var _loc18_:* = null as Array;
                     var _loc6_:* = undefined;
                     while(true)
                     {
                        _loc8_ = param2;
                        param2++;
                        _loc7_ = op_li8(_loc8_) /*Alchemy*/;
                        if(_loc7_ != (13))
                        {
                           if(_loc7_ != (10))
                           {
                              if(_loc7_ != (32))
                              {
                                 if(_loc7_ != (9))
                                 {
                                    if(_loc7_ != (11))
                                    {
                                       if(_loc7_ != (8))
                                       {
                                       }
                                    }
                                 }
                              }
                           }
                        }
                        if(false)
                        {
                           if(_loc7_ == (47))
                           {
                              _loc8_ = param2;
                              param2++;
                              _loc7_ = op_li8(_loc8_) /*Alchemy*/;
                              if(_loc7_ == (47))
                              {
                                 do
                                 {
                                       _loc9_ = param2;
                                       param2++;
                                       _loc8_ = op_li8(_loc9_) /*Alchemy*/;
                                       if(_loc8_ != (10))
                                       {
                                          if(_loc8_ != (13))
                                          {
                                          }
                                       }
                                    }while(false);
                                    
                                    param2--;
                                    continue;
                                 }
                                 if(_loc7_ == (42))
                                 {
                                    param2 = param2 - 2;
                                    _loc7_ = param2;
                                    _loc8_ = param2;
                                    _loc9_ = param2;
                                    param2++;
                                    if(op_li8(_loc9_) /*Alchemy*/ == (47))
                                    {
                                       _loc9_ = param2;
                                       param2++;
                                    }
                                    if(true)
                                    {
                                       param2 = _loc8_;
                                    }
                                    else
                                    {
                                       while(true)
                                       {
                                          _loc10_ = param2;
                                          param2++;
                                          _loc9_ = op_li8(_loc10_) /*Alchemy*/;
                                          if(_loc9_ == (42))
                                          {
                                             _loc10_ = param2;
                                             param2++;
                                             if(op_li8(_loc10_) /*Alchemy*/ != (47))
                                             {
                                                param2--;
                                             }
                                          }
                                          else
                                          {
                                             if(_loc9_ == (0))
                                             {
                                                break;
                                             }
                                          }
                                       }
                                       param2 = _loc8_;
                                    }
                                    if(_loc7_ != param2)
                                    {
                                       continue;
                                    }
                                 }
                                 param2--;
                                 _loc7_ = 47;
                                 break;
                              }
                              break;
                              break;
                           }
                        }
                        var _loc5_:uint = _loc7_;
                        if(_loc5_ != (39))
                        {
                        }
                        if(true)
                        {
                           param2--;
                           _loc7_ = param2;
                           _loc9_ = param2;
                           param2++;
                           _loc8_ = op_li8(_loc9_) /*Alchemy*/;
                           if(_loc8_ != (39))
                           {
                           }
                           if(false)
                           {
                              param2--;
                           }
                           else
                           {
                              _loc9_ = _loc7_ + 1;
                              _loc11_ = "";
                              while(true)
                              {
                                 _loc13_ = op_li8(param2) /*Alchemy*/;
                                 if(_loc13_ >= 128)
                                 {
                                    if((_loc13_ & 248) == 240)
                                    {
                                       param2++;
                                       param2++;
                                       param2++;
                                       _loc13_ = (_loc13_ & 7) << 18 | (op_li8(param2) /*Alchemy*/ & 63) << 12 | (op_li8(param2) /*Alchemy*/ & 63) << 6 | op_li8(param2) /*Alchemy*/ & 63;
                                    }
                                    else
                                    {
                                       if((_loc13_ & 240) == 224)
                                       {
                                          param2++;
                                          param2++;
                                          _loc13_ = (_loc13_ & 15) << 12 | (op_li8(param2) /*Alchemy*/ & 63) << 6 | op_li8(param2) /*Alchemy*/ & 63;
                                       }
                                       else
                                       {
                                          if((_loc13_ & 224) == 192)
                                          {
                                             param2++;
                                             _loc13_ = (_loc13_ & 31) << 6 | op_li8(param2) /*Alchemy*/ & 63;
                                          }
                                       }
                                    }
                                 }
                                 param2++;
                                 _loc10_ = _loc13_;
                                 if(_loc10_ == _loc8_)
                                 {
                                    break;
                                 }
                                 if(_loc10_ == (92))
                                 {
                                    param1.position = _loc9_;
                                    _loc11_ = _loc11_ + (param1.readUTFBytes(param2-1 - _loc9_));
                                    _loc13_ = param2;
                                    param2++;
                                    _loc10_ = op_li8(_loc13_) /*Alchemy*/;
                                    if(_loc10_ == (110))
                                    {
                                       _loc11_ = _loc11_ + "\n";
                                    }
                                    else
                                    {
                                       if(_loc10_ == (114))
                                       {
                                          _loc11_ = _loc11_ + "\r";
                                       }
                                       else
                                       {
                                          if(_loc10_ == (116))
                                          {
                                             _loc11_ = _loc11_ + "\t";
                                          }
                                          else
                                          {
                                             if(_loc10_ == (118))
                                             {
                                                _loc11_ = _loc11_ + "";
                                             }
                                             else
                                             {
                                                if(_loc10_ == (102))
                                                {
                                                   _loc11_ = _loc11_ + "\f";
                                                }
                                                else
                                                {
                                                   if(_loc10_ == (98))
                                                   {
                                                      _loc11_ = _loc11_ + "\b";
                                                   }
                                                   else
                                                   {
                                                      if(_loc10_ == (120))
                                                      {
                                                         _loc14_ = 0;
                                                         do
                                                         {
                                                               _loc15_ = param2;
                                                               param2++;
                                                               _loc13_ = op_li8(_loc15_) /*Alchemy*/;
                                                               if(_loc13_ >= (48))
                                                               {
                                                               }
                                                               if(true)
                                                               {
                                                                  if(_loc13_ >= (97))
                                                                  {
                                                                  }
                                                                  if(true)
                                                                  {
                                                                     if(_loc13_ >= (65))
                                                                     {
                                                                     }
                                                                  }
                                                               }
                                                               if(false)
                                                               {
                                                                  break;
                                                               }
                                                               _loc14_++;
                                                            }while(_loc14_ < 2);
                                                            
                                                            if(_loc14_ != 2)
                                                            {
                                                               param2 = param2 - (_loc14_ + 1);
                                                            }
                                                            else
                                                            {
                                                               param1.position = param2 - 2;
                                                            }
                                                            if(_loc14_ != 2)
                                                            {
                                                               _loc12_ = null;
                                                               if(_loc12_ != (null))
                                                               {
                                                                  _loc11_ = _loc11_ + (String.fromCharCode(parseInt(_loc12_,16)));
                                                               }
                                                               else
                                                               {
                                                                  _loc11_ = _loc11_ + "x";
                                                               }
                                                            }
                                                            else
                                                            {
                                                               _loc12_ = param1.readUTFBytes(2);
                                                               if(_loc12_ != (null))
                                                               {
                                                                  _loc11_ = _loc11_ + (String.fromCharCode(parseInt(_loc12_,16)));
                                                               }
                                                               else
                                                               {
                                                                  _loc11_ = _loc11_ + "x";
                                                               }
                                                            }
                                                         }
                                                         else
                                                         {
                                                            if(_loc10_ == (117))
                                                            {
                                                               _loc14_ = 0;
                                                               do
                                                               {
                                                                     _loc15_ = param2;
                                                                     param2++;
                                                                     _loc13_ = op_li8(_loc15_) /*Alchemy*/;
                                                                     if(_loc13_ >= (48))
                                                                     {
                                                                     }
                                                                     if(true)
                                                                     {
                                                                        if(_loc13_ >= (97))
                                                                        {
                                                                        }
                                                                        if(true)
                                                                        {
                                                                           if(_loc13_ >= (65))
                                                                           {
                                                                           }
                                                                        }
                                                                     }
                                                                     if(false)
                                                                     {
                                                                        break;
                                                                     }
                                                                     _loc14_++;
                                                                  }while(_loc14_ < 4);
                                                                  
                                                                  if(_loc14_ != 4)
                                                                  {
                                                                     param2 = param2 - (_loc14_ + 1);
                                                                  }
                                                                  else
                                                                  {
                                                                     param1.position = param2 - 4;
                                                                  }
                                                                  if(_loc14_ != 4)
                                                                  {
                                                                     _loc12_ = null;
                                                                     if(_loc12_ != (null))
                                                                     {
                                                                        _loc11_ = _loc11_ + (String.fromCharCode(parseInt(_loc12_,16)));
                                                                     }
                                                                     else
                                                                     {
                                                                        _loc11_ = _loc11_ + "u";
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc12_ = param1.readUTFBytes(4);
                                                                     if(_loc12_ != (null))
                                                                     {
                                                                        _loc11_ = _loc11_ + (String.fromCharCode(parseInt(_loc12_,16)));
                                                                     }
                                                                     else
                                                                     {
                                                                        _loc11_ = _loc11_ + "u";
                                                                     }
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  if(_loc10_ >= 128)
                                                                  {
                                                                     param2--;
                                                                     _loc13_ = op_li8(param2) /*Alchemy*/;
                                                                     if(_loc13_ >= 128)
                                                                     {
                                                                        if((_loc13_ & 248) == 240)
                                                                        {
                                                                           param2++;
                                                                           param2++;
                                                                           param2++;
                                                                           _loc13_ = (_loc13_ & 7) << 18 | (op_li8(param2) /*Alchemy*/ & 63) << 12 | (op_li8(param2) /*Alchemy*/ & 63) << 6 | op_li8(param2) /*Alchemy*/ & 63;
                                                                        }
                                                                        else
                                                                        {
                                                                           if((_loc13_ & 240) == 224)
                                                                           {
                                                                              param2++;
                                                                              param2++;
                                                                              _loc13_ = (_loc13_ & 15) << 12 | (op_li8(param2) /*Alchemy*/ & 63) << 6 | op_li8(param2) /*Alchemy*/ & 63;
                                                                           }
                                                                           else
                                                                           {
                                                                              if((_loc13_ & 224) == 192)
                                                                              {
                                                                                 param2++;
                                                                                 _loc13_ = (_loc13_ & 31) << 6 | op_li8(param2) /*Alchemy*/ & 63;
                                                                              }
                                                                           }
                                                                        }
                                                                     }
                                                                     param2++;
                                                                     _loc10_ = _loc13_;
                                                                  }
                                                                  _loc11_ = _loc11_ + (String.fromCharCode(_loc10_));
                                                               }
                                                            }
                                                         }
                                                      }
                                                   }
                                                }
                                             }
                                          }
                                          _loc9_ = param2;
                                       }
                                       else
                                       {
                                          if(_loc10_ != (0))
                                          {
                                             if(_loc10_ != (13))
                                             {
                                             }
                                          }
                                          if(true)
                                          {
                                             param2 = _loc7_;
                                             break;
                                          }
                                       }
                                    }
                                    if(param2 != _loc7_)
                                    {
                                       if(_loc9_ != param2-1)
                                       {
                                          param1.position = _loc9_;
                                          _loc11_ = _loc11_ + (param1.readUTFBytes(param2-1 - _loc9_));
                                       }
                                    }
                                 }
                                 if(false)
                                 {
                                    _loc3_ = null;
                                    if(_loc3_ != (null))
                                    {
                                       _loc6_ = _loc3_;
                                    }
                                    else
                                    {
                                       Error.throwError(Error,0);
                                    }
                                 }
                                 else
                                 {
                                    _loc3_ = param2 == _loc7_?null:_loc11_;
                                    if(_loc3_ != (null))
                                    {
                                       _loc6_ = _loc3_;
                                    }
                                    else
                                    {
                                       Error.throwError(Error,0);
                                    }
                                 }
                              }
                              else
                              {
                                 if(_loc5_ >= (48))
                                 {
                                 }
                                 if(false)
                                 {
                                 }
                                 if(true)
                                 {
                                    param2--;
                                    _loc11_ = null;
                                    _loc7_ = param2;
                                    _loc9_ = param2;
                                    param2++;
                                    _loc8_ = op_li8(_loc9_) /*Alchemy*/;
                                    if(_loc8_ == (48))
                                    {
                                       _loc10_ = param2;
                                       param2++;
                                       _loc8_ = op_li8(_loc10_) /*Alchemy*/;
                                       if(_loc8_ != (120))
                                       {
                                       }
                                       if(true)
                                       {
                                          _loc9_ = param2;
                                          do
                                          {
                                                _loc10_ = param2;
                                                param2++;
                                                _loc8_ = op_li8(_loc10_) /*Alchemy*/;
                                                if(_loc8_ >= (48))
                                                {
                                                }
                                                if(!false)
                                                {
                                                   if(_loc8_ >= (97))
                                                   {
                                                   }
                                                   if(!false)
                                                   {
                                                      if(_loc8_ >= (65))
                                                      {
                                                      }
                                                   }
                                                }
                                             }while(true);
                                             
                                             if(param2 == _loc9_ + 1)
                                             {
                                                param2 = _loc7_ + 1;
                                                _loc8_ = 48;
                                             }
                                             else
                                             {
                                                param2--;
                                                param1.position = _loc9_;
                                                _loc11_ = parseInt(param1.readUTFBytes(param2 - _loc9_),16);
                                             }
                                          }
                                          else
                                          {
                                             param2--;
                                             _loc8_ = 48;
                                          }
                                       }
                                       if(_loc11_ == (null))
                                       {
                                          while(true)
                                          {
                                             if(_loc8_ >= (48))
                                             {
                                             }
                                             if(!false)
                                             {
                                                break;
                                             }
                                             _loc10_ = param2;
                                             param2++;
                                             _loc8_ = op_li8(_loc10_) /*Alchemy*/;
                                          }
                                          if(_loc8_ == (46))
                                          {
                                             _loc9_ = param2;
                                             do
                                             {
                                                   _loc10_ = param2;
                                                   param2++;
                                                   _loc8_ = op_li8(_loc10_) /*Alchemy*/;
                                                   if(_loc8_ >= (48))
                                                   {
                                                   }
                                                }while(false);
                                                
                                                if(param2 == _loc9_ + 1)
                                                {
                                                   param2--;
                                                   _loc8_ = 46;
                                                }
                                             }
                                             if(_loc8_ != (101))
                                             {
                                             }
                                             if(true)
                                             {
                                                _loc10_ = param2;
                                                _loc13_ = param2;
                                                param2++;
                                                _loc8_ = op_li8(_loc13_) /*Alchemy*/;
                                                if(_loc8_ != (45))
                                                {
                                                }
                                                if(true)
                                                {
                                                   _loc13_ = param2;
                                                   param2++;
                                                   _loc8_ = op_li8(_loc13_) /*Alchemy*/;
                                                }
                                                _loc9_ = param2;
                                                while(true)
                                                {
                                                   if(_loc8_ >= (48))
                                                   {
                                                   }
                                                   if(!false)
                                                   {
                                                      break;
                                                   }
                                                   _loc13_ = param2;
                                                   param2++;
                                                   _loc8_ = op_li8(_loc13_) /*Alchemy*/;
                                                }
                                                if(param2 == _loc9_)
                                                {
                                                   param2 = _loc10_;
                                                }
                                             }
                                             param2--;
                                             if(param2 != _loc7_)
                                             {
                                                param1.position = _loc7_;
                                                _loc11_ = param1.readUTFBytes(param2 - _loc7_);
                                             }
                                          }
                                          _loc3_ = _loc11_;
                                          if(_loc3_ != (null))
                                          {
                                             _loc6_ = parseFloat(_loc3_);
                                          }
                                          else
                                          {
                                             Error.throwError(Error,0);
                                          }
                                       }
                                       else
                                       {
                                          if(_loc5_ == (45))
                                          {
                                             while(true)
                                             {
                                                _loc8_ = param2;
                                                param2++;
                                                _loc7_ = op_li8(_loc8_) /*Alchemy*/;
                                                if(_loc7_ != (13))
                                                {
                                                   if(_loc7_ != (10))
                                                   {
                                                      if(_loc7_ != (32))
                                                      {
                                                         if(_loc7_ != (9))
                                                         {
                                                            if(_loc7_ != (11))
                                                            {
                                                               if(_loc7_ != (8))
                                                               {
                                                               }
                                                            }
                                                         }
                                                      }
                                                   }
                                                }
                                                if(false)
                                                {
                                                   if(_loc7_ == (47))
                                                   {
                                                      _loc8_ = param2;
                                                      param2++;
                                                      _loc7_ = op_li8(_loc8_) /*Alchemy*/;
                                                      if(_loc7_ == (47))
                                                      {
                                                         do
                                                         {
                                                               _loc9_ = param2;
                                                               param2++;
                                                               _loc8_ = op_li8(_loc9_) /*Alchemy*/;
                                                               if(_loc8_ != (10))
                                                               {
                                                                  if(_loc8_ != (13))
                                                                  {
                                                                  }
                                                               }
                                                            }while(false);
                                                            
                                                            param2--;
                                                            continue;
                                                         }
                                                         if(_loc7_ == (42))
                                                         {
                                                            param2 = param2 - 2;
                                                            _loc7_ = param2;
                                                            _loc8_ = param2;
                                                            _loc9_ = param2;
                                                            param2++;
                                                            if(op_li8(_loc9_) /*Alchemy*/ == (47))
                                                            {
                                                               _loc9_ = param2;
                                                               param2++;
                                                            }
                                                            if(true)
                                                            {
                                                               param2 = _loc8_;
                                                            }
                                                            else
                                                            {
                                                               while(true)
                                                               {
                                                                  _loc10_ = param2;
                                                                  param2++;
                                                                  _loc9_ = op_li8(_loc10_) /*Alchemy*/;
                                                                  if(_loc9_ == (42))
                                                                  {
                                                                     _loc10_ = param2;
                                                                     param2++;
                                                                     if(op_li8(_loc10_) /*Alchemy*/ != (47))
                                                                     {
                                                                        param2--;
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     if(_loc9_ == (0))
                                                                     {
                                                                        break;
                                                                     }
                                                                  }
                                                               }
                                                               param2 = _loc8_;
                                                            }
                                                            if(_loc7_ != param2)
                                                            {
                                                               continue;
                                                            }
                                                         }
                                                         param2--;
                                                         _loc7_ = 47;
                                                         break;
                                                      }
                                                      break;
                                                      break;
                                                   }
                                                }
                                                _loc5_ = _loc7_;
                                                if(_loc5_ >= (48))
                                                {
                                                }
                                                if(false)
                                                {
                                                }
                                                if(true)
                                                {
                                                   param2--;
                                                   _loc11_ = null;
                                                   _loc7_ = param2;
                                                   _loc9_ = param2;
                                                   param2++;
                                                   _loc8_ = op_li8(_loc9_) /*Alchemy*/;
                                                   if(_loc8_ == (48))
                                                   {
                                                      _loc10_ = param2;
                                                      param2++;
                                                      _loc8_ = op_li8(_loc10_) /*Alchemy*/;
                                                      if(_loc8_ != (120))
                                                      {
                                                      }
                                                      if(true)
                                                      {
                                                         _loc9_ = param2;
                                                         do
                                                         {
                                                               _loc10_ = param2;
                                                               param2++;
                                                               _loc8_ = op_li8(_loc10_) /*Alchemy*/;
                                                               if(_loc8_ >= (48))
                                                               {
                                                               }
                                                               if(!false)
                                                               {
                                                                  if(_loc8_ >= (97))
                                                                  {
                                                                  }
                                                                  if(!false)
                                                                  {
                                                                     if(_loc8_ >= (65))
                                                                     {
                                                                     }
                                                                  }
                                                               }
                                                            }while(true);
                                                            
                                                            if(param2 == _loc9_ + 1)
                                                            {
                                                               param2 = _loc7_ + 1;
                                                               _loc8_ = 48;
                                                            }
                                                            else
                                                            {
                                                               param2--;
                                                               param1.position = _loc9_;
                                                               _loc11_ = parseInt(param1.readUTFBytes(param2 - _loc9_),16);
                                                            }
                                                         }
                                                         else
                                                         {
                                                            param2--;
                                                            _loc8_ = 48;
                                                         }
                                                      }
                                                      if(_loc11_ == (null))
                                                      {
                                                         while(true)
                                                         {
                                                            if(_loc8_ >= (48))
                                                            {
                                                            }
                                                            if(!false)
                                                            {
                                                               break;
                                                            }
                                                            _loc10_ = param2;
                                                            param2++;
                                                            _loc8_ = op_li8(_loc10_) /*Alchemy*/;
                                                         }
                                                         if(_loc8_ == (46))
                                                         {
                                                            _loc9_ = param2;
                                                            do
                                                            {
                                                                  _loc10_ = param2;
                                                                  param2++;
                                                                  _loc8_ = op_li8(_loc10_) /*Alchemy*/;
                                                                  if(_loc8_ >= (48))
                                                                  {
                                                                  }
                                                               }while(false);
                                                               
                                                               if(param2 == _loc9_ + 1)
                                                               {
                                                                  param2--;
                                                                  _loc8_ = 46;
                                                               }
                                                            }
                                                            if(_loc8_ != (101))
                                                            {
                                                            }
                                                            if(true)
                                                            {
                                                               _loc10_ = param2;
                                                               _loc13_ = param2;
                                                               param2++;
                                                               _loc8_ = op_li8(_loc13_) /*Alchemy*/;
                                                               if(_loc8_ != (45))
                                                               {
                                                               }
                                                               if(true)
                                                               {
                                                                  _loc13_ = param2;
                                                                  param2++;
                                                                  _loc8_ = op_li8(_loc13_) /*Alchemy*/;
                                                               }
                                                               _loc9_ = param2;
                                                               while(true)
                                                               {
                                                                  if(_loc8_ >= (48))
                                                                  {
                                                                  }
                                                                  if(!false)
                                                                  {
                                                                     break;
                                                                  }
                                                                  _loc13_ = param2;
                                                                  param2++;
                                                                  _loc8_ = op_li8(_loc13_) /*Alchemy*/;
                                                               }
                                                               if(param2 == _loc9_)
                                                               {
                                                                  param2 = _loc10_;
                                                               }
                                                            }
                                                            param2--;
                                                            if(param2 != _loc7_)
                                                            {
                                                               param1.position = _loc7_;
                                                               _loc11_ = param1.readUTFBytes(param2 - _loc7_);
                                                            }
                                                         }
                                                         _loc3_ = _loc11_;
                                                         if(_loc3_ != (null))
                                                         {
                                                            _loc6_ = -parseFloat(_loc3_);
                                                         }
                                                         else
                                                         {
                                                            Error.throwError(Error,0);
                                                         }
                                                      }
                                                      else
                                                      {
                                                         if(_loc5_ == (110))
                                                         {
                                                            if(op_li8(param2) /*Alchemy*/ == 117)
                                                            {
                                                            }
                                                            if(false)
                                                            {
                                                               param2 = param2 + 3;
                                                               _loc6_ = 0;
                                                            }
                                                            else
                                                            {
                                                               Error.throwError(Error,0);
                                                            }
                                                         }
                                                         else
                                                         {
                                                            if(_loc5_ == (117))
                                                            {
                                                               if(op_li32(param2) /*Alchemy*/ == 1717920878)
                                                               {
                                                               }
                                                               if(false)
                                                               {
                                                                  param2 = param2 + 8;
                                                                  _loc6_ = (Number).NaN;
                                                               }
                                                               else
                                                               {
                                                                  Error.throwError(Error,0);
                                                               }
                                                            }
                                                            else
                                                            {
                                                               if(_loc5_ == (78))
                                                               {
                                                                  if(op_li16(param2) /*Alchemy*/ == 20065)
                                                                  {
                                                                     param2 = param2 + 2;
                                                                     _loc6_ = (Number).NaN;
                                                                  }
                                                                  else
                                                                  {
                                                                     Error.throwError(Error,0);
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  Error.throwError(Error,0);
                                                               }
                                                            }
                                                         }
                                                      }
                                                   }
                                                   else
                                                   {
                                                      if(_loc5_ == (110))
                                                      {
                                                         if(op_li8(param2) /*Alchemy*/ == 117)
                                                         {
                                                         }
                                                         if(false)
                                                         {
                                                            param2 = param2 + 3;
                                                            _loc6_ = null;
                                                         }
                                                         else
                                                         {
                                                            Error.throwError(Error,0);
                                                         }
                                                      }
                                                      else
                                                      {
                                                         if(_loc5_ == (116))
                                                         {
                                                            if(op_li8(param2) /*Alchemy*/ == 114)
                                                            {
                                                            }
                                                            if(false)
                                                            {
                                                               param2 = param2 + 3;
                                                               _loc6_ = true;
                                                            }
                                                            else
                                                            {
                                                               Error.throwError(Error,0);
                                                            }
                                                         }
                                                         else
                                                         {
                                                            if(_loc5_ == (102))
                                                            {
                                                               if(op_li32(param2) /*Alchemy*/ == 1702063201)
                                                               {
                                                                  param2 = param2 + 4;
                                                                  _loc6_ = false;
                                                               }
                                                               else
                                                               {
                                                                  Error.throwError(Error,0);
                                                               }
                                                            }
                                                            else
                                                            {
                                                               if(_loc5_ == (117))
                                                               {
                                                                  if(op_li32(param2) /*Alchemy*/ == 1717920878)
                                                                  {
                                                                  }
                                                                  if(false)
                                                                  {
                                                                     param2 = param2 + 8;
                                                                  }
                                                                  else
                                                                  {
                                                                     Error.throwError(Error,0);
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  if(_loc5_ == (78))
                                                                  {
                                                                     if(op_li16(param2) /*Alchemy*/ == 20065)
                                                                     {
                                                                        param2 = param2 + 2;
                                                                        _loc6_ = (Number).NaN;
                                                                     }
                                                                     else
                                                                     {
                                                                        Error.throwError(Error,0);
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     if(_loc5_ == (123))
                                                                     {
                                                                        _loc16_ = new Object();
                                                                        _loc11_ = null;
                                                                        while(true)
                                                                        {
                                                                           _loc8_ = param2;
                                                                           param2++;
                                                                           _loc7_ = op_li8(_loc8_) /*Alchemy*/;
                                                                           if(_loc7_ != (13))
                                                                           {
                                                                              if(_loc7_ != (10))
                                                                              {
                                                                                 if(_loc7_ != (32))
                                                                                 {
                                                                                    if(_loc7_ != (9))
                                                                                    {
                                                                                       if(_loc7_ != (11))
                                                                                       {
                                                                                          if(_loc7_ != (8))
                                                                                          {
                                                                                          }
                                                                                       }
                                                                                    }
                                                                                 }
                                                                              }
                                                                           }
                                                                           if(false)
                                                                           {
                                                                              if(_loc7_ == (47))
                                                                              {
                                                                                 _loc8_ = param2;
                                                                                 param2++;
                                                                                 _loc7_ = op_li8(_loc8_) /*Alchemy*/;
                                                                                 if(_loc7_ == (47))
                                                                                 {
                                                                                    do
                                                                                    {
                                                                                          _loc9_ = param2;
                                                                                          param2++;
                                                                                          _loc8_ = op_li8(_loc9_) /*Alchemy*/;
                                                                                          if(_loc8_ != (10))
                                                                                          {
                                                                                             if(_loc8_ != (13))
                                                                                             {
                                                                                             }
                                                                                          }
                                                                                       }while(false);
                                                                                       
                                                                                       param2--;
                                                                                       continue;
                                                                                    }
                                                                                    if(_loc7_ == (42))
                                                                                    {
                                                                                       param2 = param2 - 2;
                                                                                       _loc7_ = param2;
                                                                                       _loc8_ = param2;
                                                                                       _loc9_ = param2;
                                                                                       param2++;
                                                                                       if(op_li8(_loc9_) /*Alchemy*/ == (47))
                                                                                       {
                                                                                          _loc9_ = param2;
                                                                                          param2++;
                                                                                       }
                                                                                       if(true)
                                                                                       {
                                                                                          param2 = _loc8_;
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          while(true)
                                                                                          {
                                                                                             _loc10_ = param2;
                                                                                             param2++;
                                                                                             _loc9_ = op_li8(_loc10_) /*Alchemy*/;
                                                                                             if(_loc9_ == (42))
                                                                                             {
                                                                                                _loc10_ = param2;
                                                                                                param2++;
                                                                                                if(op_li8(_loc10_) /*Alchemy*/ != (47))
                                                                                                {
                                                                                                   param2--;
                                                                                                }
                                                                                             }
                                                                                             else
                                                                                             {
                                                                                                if(_loc9_ == (0))
                                                                                                {
                                                                                                   break;
                                                                                                }
                                                                                             }
                                                                                          }
                                                                                          param2 = _loc8_;
                                                                                       }
                                                                                       if(_loc7_ != param2)
                                                                                       {
                                                                                          continue;
                                                                                       }
                                                                                    }
                                                                                    param2--;
                                                                                    _loc7_ = 47;
                                                                                    break;
                                                                                 }
                                                                                 break;
                                                                                 break;
                                                                              }
                                                                           }
                                                                           _loc5_ = _loc7_;
                                                                           if(_loc5_ != (125))
                                                                           {
                                                                              param2--;
                                                                              while(true)
                                                                              {
                                                                                 while(true)
                                                                                 {
                                                                                    _loc8_ = param2;
                                                                                    param2++;
                                                                                    _loc7_ = op_li8(_loc8_) /*Alchemy*/;
                                                                                    if(_loc7_ != (13))
                                                                                    {
                                                                                       if(_loc7_ != (10))
                                                                                       {
                                                                                          if(_loc7_ != (32))
                                                                                          {
                                                                                             if(_loc7_ != (9))
                                                                                             {
                                                                                                if(_loc7_ != (11))
                                                                                                {
                                                                                                   if(_loc7_ != (8))
                                                                                                   {
                                                                                                   }
                                                                                                }
                                                                                             }
                                                                                          }
                                                                                       }
                                                                                    }
                                                                                    if(false)
                                                                                    {
                                                                                       if(_loc7_ == (47))
                                                                                       {
                                                                                          _loc8_ = param2;
                                                                                          param2++;
                                                                                          _loc7_ = op_li8(_loc8_) /*Alchemy*/;
                                                                                          if(_loc7_ == (47))
                                                                                          {
                                                                                             do
                                                                                             {
                                                                                                   _loc9_ = param2;
                                                                                                   param2++;
                                                                                                   _loc8_ = op_li8(_loc9_) /*Alchemy*/;
                                                                                                   if(_loc8_ != (10))
                                                                                                   {
                                                                                                      if(_loc8_ != (13))
                                                                                                      {
                                                                                                      }
                                                                                                   }
                                                                                                }while(false);
                                                                                                
                                                                                                param2--;
                                                                                                continue;
                                                                                             }
                                                                                             if(_loc7_ == (42))
                                                                                             {
                                                                                                param2 = param2 - 2;
                                                                                                _loc7_ = param2;
                                                                                                _loc8_ = param2;
                                                                                                _loc9_ = param2;
                                                                                                param2++;
                                                                                                if(op_li8(_loc9_) /*Alchemy*/ == (47))
                                                                                                {
                                                                                                   _loc9_ = param2;
                                                                                                   param2++;
                                                                                                }
                                                                                                if(true)
                                                                                                {
                                                                                                   param2 = _loc8_;
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   while(true)
                                                                                                   {
                                                                                                      _loc10_ = param2;
                                                                                                      param2++;
                                                                                                      _loc9_ = op_li8(_loc10_) /*Alchemy*/;
                                                                                                      if(_loc9_ == (42))
                                                                                                      {
                                                                                                         _loc10_ = param2;
                                                                                                         param2++;
                                                                                                         if(op_li8(_loc10_) /*Alchemy*/ != (47))
                                                                                                         {
                                                                                                            param2--;
                                                                                                         }
                                                                                                      }
                                                                                                      else
                                                                                                      {
                                                                                                         if(_loc9_ == (0))
                                                                                                         {
                                                                                                            break;
                                                                                                         }
                                                                                                      }
                                                                                                   }
                                                                                                   param2 = _loc8_;
                                                                                                }
                                                                                                if(_loc7_ != param2)
                                                                                                {
                                                                                                   continue;
                                                                                                }
                                                                                             }
                                                                                             param2--;
                                                                                             _loc7_ = 47;
                                                                                             break;
                                                                                          }
                                                                                          break;
                                                                                          break;
                                                                                       }
                                                                                    }
                                                                                    _loc5_ = _loc7_;
                                                                                    if(_loc5_ != (39))
                                                                                    {
                                                                                    }
                                                                                    if(true)
                                                                                    {
                                                                                       param2--;
                                                                                       _loc7_ = param2;
                                                                                       _loc9_ = param2;
                                                                                       param2++;
                                                                                       _loc8_ = op_li8(_loc9_) /*Alchemy*/;
                                                                                       if(_loc8_ != (39))
                                                                                       {
                                                                                       }
                                                                                       if(false)
                                                                                       {
                                                                                          param2--;
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          _loc9_ = _loc7_ + 1;
                                                                                          _loc12_ = "";
                                                                                          while(true)
                                                                                          {
                                                                                             _loc13_ = op_li8(param2) /*Alchemy*/;
                                                                                             if(_loc13_ >= 128)
                                                                                             {
                                                                                                if((_loc13_ & 248) == 240)
                                                                                                {
                                                                                                   param2++;
                                                                                                   param2++;
                                                                                                   param2++;
                                                                                                   _loc13_ = (_loc13_ & 7) << 18 | (op_li8(param2) /*Alchemy*/ & 63) << 12 | (op_li8(param2) /*Alchemy*/ & 63) << 6 | op_li8(param2) /*Alchemy*/ & 63;
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   if((_loc13_ & 240) == 224)
                                                                                                   {
                                                                                                      param2++;
                                                                                                      param2++;
                                                                                                      _loc13_ = (_loc13_ & 15) << 12 | (op_li8(param2) /*Alchemy*/ & 63) << 6 | op_li8(param2) /*Alchemy*/ & 63;
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      if((_loc13_ & 224) == 192)
                                                                                                      {
                                                                                                         param2++;
                                                                                                         _loc13_ = (_loc13_ & 31) << 6 | op_li8(param2) /*Alchemy*/ & 63;
                                                                                                      }
                                                                                                   }
                                                                                                }
                                                                                             }
                                                                                             param2++;
                                                                                             _loc10_ = _loc13_;
                                                                                             if(_loc10_ == _loc8_)
                                                                                             {
                                                                                                break;
                                                                                             }
                                                                                             if(_loc10_ == (92))
                                                                                             {
                                                                                                param1.position = _loc9_;
                                                                                                _loc12_ = _loc12_ + (param1.readUTFBytes(param2-1 - _loc9_));
                                                                                                _loc13_ = param2;
                                                                                                param2++;
                                                                                                _loc10_ = op_li8(_loc13_) /*Alchemy*/;
                                                                                                if(_loc10_ == (110))
                                                                                                {
                                                                                                   _loc12_ = _loc12_ + "\n";
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   if(_loc10_ == (114))
                                                                                                   {
                                                                                                      _loc12_ = _loc12_ + "\r";
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      if(_loc10_ == (116))
                                                                                                      {
                                                                                                         _loc12_ = _loc12_ + "\t";
                                                                                                      }
                                                                                                      else
                                                                                                      {
                                                                                                         if(_loc10_ == (118))
                                                                                                         {
                                                                                                            _loc12_ = _loc12_ + "";
                                                                                                         }
                                                                                                         else
                                                                                                         {
                                                                                                            if(_loc10_ == (102))
                                                                                                            {
                                                                                                               _loc12_ = _loc12_ + "\f";
                                                                                                            }
                                                                                                            else
                                                                                                            {
                                                                                                               if(_loc10_ == (98))
                                                                                                               {
                                                                                                                  _loc12_ = _loc12_ + "\b";
                                                                                                               }
                                                                                                               else
                                                                                                               {
                                                                                                                  if(_loc10_ == (120))
                                                                                                                  {
                                                                                                                     _loc14_ = 0;
                                                                                                                     do
                                                                                                                     {
                                                                                                                           _loc15_ = param2;
                                                                                                                           param2++;
                                                                                                                           _loc13_ = op_li8(_loc15_) /*Alchemy*/;
                                                                                                                           if(_loc13_ >= (48))
                                                                                                                           {
                                                                                                                           }
                                                                                                                           if(true)
                                                                                                                           {
                                                                                                                              if(_loc13_ >= (97))
                                                                                                                              {
                                                                                                                              }
                                                                                                                              if(true)
                                                                                                                              {
                                                                                                                                 if(_loc13_ >= (65))
                                                                                                                                 {
                                                                                                                                 }
                                                                                                                              }
                                                                                                                           }
                                                                                                                           if(false)
                                                                                                                           {
                                                                                                                              break;
                                                                                                                           }
                                                                                                                           _loc14_++;
                                                                                                                        }while(_loc14_ < 2);
                                                                                                                        
                                                                                                                        if(_loc14_ != 2)
                                                                                                                        {
                                                                                                                           param2 = param2 - (_loc14_ + 1);
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                           param1.position = param2 - 2;
                                                                                                                        }
                                                                                                                        if(_loc14_ != 2)
                                                                                                                        {
                                                                                                                           _loc17_ = null;
                                                                                                                           if(_loc17_ != (null))
                                                                                                                           {
                                                                                                                              _loc12_ = _loc12_ + (String.fromCharCode(parseInt(_loc17_,16)));
                                                                                                                           }
                                                                                                                           else
                                                                                                                           {
                                                                                                                              _loc12_ = _loc12_ + "x";
                                                                                                                           }
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                           _loc17_ = param1.readUTFBytes(2);
                                                                                                                           if(_loc17_ != (null))
                                                                                                                           {
                                                                                                                              _loc12_ = _loc12_ + (String.fromCharCode(parseInt(_loc17_,16)));
                                                                                                                           }
                                                                                                                           else
                                                                                                                           {
                                                                                                                              _loc12_ = _loc12_ + "x";
                                                                                                                           }
                                                                                                                        }
                                                                                                                     }
                                                                                                                     else
                                                                                                                     {
                                                                                                                        if(_loc10_ == (117))
                                                                                                                        {
                                                                                                                           _loc14_ = 0;
                                                                                                                           do
                                                                                                                           {
                                                                                                                                 _loc15_ = param2;
                                                                                                                                 param2++;
                                                                                                                                 _loc13_ = op_li8(_loc15_) /*Alchemy*/;
                                                                                                                                 if(_loc13_ >= (48))
                                                                                                                                 {
                                                                                                                                 }
                                                                                                                                 if(true)
                                                                                                                                 {
                                                                                                                                    if(_loc13_ >= (97))
                                                                                                                                    {
                                                                                                                                    }
                                                                                                                                    if(true)
                                                                                                                                    {
                                                                                                                                       if(_loc13_ >= (65))
                                                                                                                                       {
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                                 if(false)
                                                                                                                                 {
                                                                                                                                    break;
                                                                                                                                 }
                                                                                                                                 _loc14_++;
                                                                                                                              }while(_loc14_ < 4);
                                                                                                                              
                                                                                                                              if(_loc14_ != 4)
                                                                                                                              {
                                                                                                                                 param2 = param2 - (_loc14_ + 1);
                                                                                                                              }
                                                                                                                              else
                                                                                                                              {
                                                                                                                                 param1.position = param2 - 4;
                                                                                                                              }
                                                                                                                              if(_loc14_ != 4)
                                                                                                                              {
                                                                                                                                 _loc17_ = null;
                                                                                                                                 if(_loc17_ != (null))
                                                                                                                                 {
                                                                                                                                    _loc12_ = _loc12_ + (String.fromCharCode(parseInt(_loc17_,16)));
                                                                                                                                 }
                                                                                                                                 else
                                                                                                                                 {
                                                                                                                                    _loc12_ = _loc12_ + "u";
                                                                                                                                 }
                                                                                                                              }
                                                                                                                              else
                                                                                                                              {
                                                                                                                                 _loc17_ = param1.readUTFBytes(4);
                                                                                                                                 if(_loc17_ != (null))
                                                                                                                                 {
                                                                                                                                    _loc12_ = _loc12_ + (String.fromCharCode(parseInt(_loc17_,16)));
                                                                                                                                 }
                                                                                                                                 else
                                                                                                                                 {
                                                                                                                                    _loc12_ = _loc12_ + "u";
                                                                                                                                 }
                                                                                                                              }
                                                                                                                           }
                                                                                                                           else
                                                                                                                           {
                                                                                                                              if(_loc10_ >= 128)
                                                                                                                              {
                                                                                                                                 param2--;
                                                                                                                                 _loc13_ = op_li8(param2) /*Alchemy*/;
                                                                                                                                 if(_loc13_ >= 128)
                                                                                                                                 {
                                                                                                                                    if((_loc13_ & 248) == 240)
                                                                                                                                    {
                                                                                                                                       param2++;
                                                                                                                                       param2++;
                                                                                                                                       param2++;
                                                                                                                                       _loc13_ = (_loc13_ & 7) << 18 | (op_li8(param2) /*Alchemy*/ & 63) << 12 | (op_li8(param2) /*Alchemy*/ & 63) << 6 | op_li8(param2) /*Alchemy*/ & 63;
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                       if((_loc13_ & 240) == 224)
                                                                                                                                       {
                                                                                                                                          param2++;
                                                                                                                                          param2++;
                                                                                                                                          _loc13_ = (_loc13_ & 15) << 12 | (op_li8(param2) /*Alchemy*/ & 63) << 6 | op_li8(param2) /*Alchemy*/ & 63;
                                                                                                                                       }
                                                                                                                                       else
                                                                                                                                       {
                                                                                                                                          if((_loc13_ & 224) == 192)
                                                                                                                                          {
                                                                                                                                             param2++;
                                                                                                                                             _loc13_ = (_loc13_ & 31) << 6 | op_li8(param2) /*Alchemy*/ & 63;
                                                                                                                                          }
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                                 param2++;
                                                                                                                                 _loc10_ = _loc13_;
                                                                                                                              }
                                                                                                                              _loc12_ = _loc12_ + (String.fromCharCode(_loc10_));
                                                                                                                           }
                                                                                                                        }
                                                                                                                     }
                                                                                                                  }
                                                                                                               }
                                                                                                            }
                                                                                                         }
                                                                                                      }
                                                                                                      _loc9_ = param2;
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      if(_loc10_ != (0))
                                                                                                      {
                                                                                                         if(_loc10_ != (13))
                                                                                                         {
                                                                                                         }
                                                                                                      }
                                                                                                      if(true)
                                                                                                      {
                                                                                                         param2 = _loc7_;
                                                                                                         break;
                                                                                                      }
                                                                                                   }
                                                                                                }
                                                                                                if(param2 != _loc7_)
                                                                                                {
                                                                                                   if(_loc9_ != param2-1)
                                                                                                   {
                                                                                                      param1.position = _loc9_;
                                                                                                      _loc12_ = _loc12_ + (param1.readUTFBytes(param2-1 - _loc9_));
                                                                                                   }
                                                                                                }
                                                                                             }
                                                                                             if(false)
                                                                                             {
                                                                                                _loc3_ = null;
                                                                                                if(_loc3_ != (null))
                                                                                                {
                                                                                                   _loc11_ = _loc3_;
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   Error.throwError(Error,0);
                                                                                                }
                                                                                             }
                                                                                             else
                                                                                             {
                                                                                                _loc3_ = param2 == _loc7_?null:_loc12_;
                                                                                                if(_loc3_ != (null))
                                                                                                {
                                                                                                   _loc11_ = _loc3_;
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   Error.throwError(Error,0);
                                                                                                }
                                                                                             }
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             if(_loc5_ >= (48))
                                                                                             {
                                                                                             }
                                                                                             if(false)
                                                                                             {
                                                                                             }
                                                                                             if(true)
                                                                                             {
                                                                                                param2--;
                                                                                                _loc12_ = null;
                                                                                                _loc7_ = param2;
                                                                                                _loc9_ = param2;
                                                                                                param2++;
                                                                                                _loc8_ = op_li8(_loc9_) /*Alchemy*/;
                                                                                                if(_loc8_ == (48))
                                                                                                {
                                                                                                   _loc10_ = param2;
                                                                                                   param2++;
                                                                                                   _loc8_ = op_li8(_loc10_) /*Alchemy*/;
                                                                                                   if(_loc8_ != (120))
                                                                                                   {
                                                                                                   }
                                                                                                   if(true)
                                                                                                   {
                                                                                                      _loc9_ = param2;
                                                                                                      do
                                                                                                      {
                                                                                                            _loc10_ = param2;
                                                                                                            param2++;
                                                                                                            _loc8_ = op_li8(_loc10_) /*Alchemy*/;
                                                                                                            if(_loc8_ >= (48))
                                                                                                            {
                                                                                                            }
                                                                                                            if(!false)
                                                                                                            {
                                                                                                               if(_loc8_ >= (97))
                                                                                                               {
                                                                                                               }
                                                                                                               if(!false)
                                                                                                               {
                                                                                                                  if(_loc8_ >= (65))
                                                                                                                  {
                                                                                                                  }
                                                                                                               }
                                                                                                            }
                                                                                                         }while(true);
                                                                                                         
                                                                                                         if(param2 == _loc9_ + 1)
                                                                                                         {
                                                                                                            param2 = _loc7_ + 1;
                                                                                                            _loc8_ = 48;
                                                                                                         }
                                                                                                         else
                                                                                                         {
                                                                                                            param2--;
                                                                                                            param1.position = _loc9_;
                                                                                                            _loc12_ = parseInt(param1.readUTFBytes(param2 - _loc9_),16);
                                                                                                         }
                                                                                                      }
                                                                                                      else
                                                                                                      {
                                                                                                         param2--;
                                                                                                         _loc8_ = 48;
                                                                                                      }
                                                                                                   }
                                                                                                   if(_loc12_ == (null))
                                                                                                   {
                                                                                                      while(true)
                                                                                                      {
                                                                                                         if(_loc8_ >= (48))
                                                                                                         {
                                                                                                         }
                                                                                                         if(!false)
                                                                                                         {
                                                                                                            break;
                                                                                                         }
                                                                                                         _loc10_ = param2;
                                                                                                         param2++;
                                                                                                         _loc8_ = op_li8(_loc10_) /*Alchemy*/;
                                                                                                      }
                                                                                                      if(_loc8_ == (46))
                                                                                                      {
                                                                                                         _loc9_ = param2;
                                                                                                         do
                                                                                                         {
                                                                                                               _loc10_ = param2;
                                                                                                               param2++;
                                                                                                               _loc8_ = op_li8(_loc10_) /*Alchemy*/;
                                                                                                               if(_loc8_ >= (48))
                                                                                                               {
                                                                                                               }
                                                                                                            }while(false);
                                                                                                            
                                                                                                            if(param2 == _loc9_ + 1)
                                                                                                            {
                                                                                                               param2--;
                                                                                                               _loc8_ = 46;
                                                                                                            }
                                                                                                         }
                                                                                                         if(_loc8_ != (101))
                                                                                                         {
                                                                                                         }
                                                                                                         if(true)
                                                                                                         {
                                                                                                            _loc10_ = param2;
                                                                                                            _loc13_ = param2;
                                                                                                            param2++;
                                                                                                            _loc8_ = op_li8(_loc13_) /*Alchemy*/;
                                                                                                            if(_loc8_ != (45))
                                                                                                            {
                                                                                                            }
                                                                                                            if(true)
                                                                                                            {
                                                                                                               _loc13_ = param2;
                                                                                                               param2++;
                                                                                                               _loc8_ = op_li8(_loc13_) /*Alchemy*/;
                                                                                                            }
                                                                                                            _loc9_ = param2;
                                                                                                            while(true)
                                                                                                            {
                                                                                                               if(_loc8_ >= (48))
                                                                                                               {
                                                                                                               }
                                                                                                               if(!false)
                                                                                                               {
                                                                                                                  break;
                                                                                                               }
                                                                                                               _loc13_ = param2;
                                                                                                               param2++;
                                                                                                               _loc8_ = op_li8(_loc13_) /*Alchemy*/;
                                                                                                            }
                                                                                                            if(param2 == _loc9_)
                                                                                                            {
                                                                                                               param2 = _loc10_;
                                                                                                            }
                                                                                                         }
                                                                                                         param2--;
                                                                                                         if(param2 != _loc7_)
                                                                                                         {
                                                                                                            param1.position = _loc7_;
                                                                                                            _loc12_ = param1.readUTFBytes(param2 - _loc7_);
                                                                                                         }
                                                                                                      }
                                                                                                      _loc3_ = _loc12_;
                                                                                                      if(_loc3_ != (null))
                                                                                                      {
                                                                                                         _loc11_ = parseFloat(_loc3_).toString();
                                                                                                      }
                                                                                                      else
                                                                                                      {
                                                                                                         Error.throwError(Error,0);
                                                                                                      }
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      if(_loc5_ == (110))
                                                                                                      {
                                                                                                         if(op_li8(param2) /*Alchemy*/ == 117)
                                                                                                         {
                                                                                                         }
                                                                                                      }
                                                                                                      if(!false)
                                                                                                      {
                                                                                                         if(_loc5_ == (116))
                                                                                                         {
                                                                                                            if(op_li8(param2) /*Alchemy*/ == 114)
                                                                                                            {
                                                                                                            }
                                                                                                         }
                                                                                                         if(!false)
                                                                                                         {
                                                                                                            if(_loc5_ == (102))
                                                                                                            {
                                                                                                            }
                                                                                                         }
                                                                                                      }
                                                                                                      if(true)
                                                                                                      {
                                                                                                         Error.throwError(Error,0);
                                                                                                      }
                                                                                                      else
                                                                                                      {
                                                                                                         param2--;
                                                                                                         _loc7_ = param2;
                                                                                                         _loc9_ = op_li8(param2) /*Alchemy*/;
                                                                                                         if(_loc9_ >= 128)
                                                                                                         {
                                                                                                            if((_loc9_ & 248) == 240)
                                                                                                            {
                                                                                                               param2++;
                                                                                                               param2++;
                                                                                                               param2++;
                                                                                                               _loc9_ = (_loc9_ & 7) << 18 | (op_li8(param2) /*Alchemy*/ & 63) << 12 | (op_li8(param2) /*Alchemy*/ & 63) << 6 | op_li8(param2) /*Alchemy*/ & 63;
                                                                                                            }
                                                                                                            else
                                                                                                            {
                                                                                                               if((_loc9_ & 240) == 224)
                                                                                                               {
                                                                                                                  param2++;
                                                                                                                  param2++;
                                                                                                                  _loc9_ = (_loc9_ & 15) << 12 | (op_li8(param2) /*Alchemy*/ & 63) << 6 | op_li8(param2) /*Alchemy*/ & 63;
                                                                                                               }
                                                                                                               else
                                                                                                               {
                                                                                                                  if((_loc9_ & 224) == 192)
                                                                                                                  {
                                                                                                                     param2++;
                                                                                                                     _loc9_ = (_loc9_ & 31) << 6 | op_li8(param2) /*Alchemy*/ & 63;
                                                                                                                  }
                                                                                                               }
                                                                                                            }
                                                                                                         }
                                                                                                         param2++;
                                                                                                         _loc8_ = _loc9_;
                                                                                                         if(_loc8_ >= (97))
                                                                                                         {
                                                                                                         }
                                                                                                         if(true)
                                                                                                         {
                                                                                                            if(_loc8_ >= (65))
                                                                                                            {
                                                                                                            }
                                                                                                            if(true)
                                                                                                            {
                                                                                                               if(_loc8_ != (36))
                                                                                                               {
                                                                                                                  if(_loc8_ != (95))
                                                                                                                  {
                                                                                                                  }
                                                                                                               }
                                                                                                            }
                                                                                                         }
                                                                                                         if(false)
                                                                                                         {
                                                                                                            param2 = _loc7_;
                                                                                                         }
                                                                                                         else
                                                                                                         {
                                                                                                            do
                                                                                                            {
                                                                                                                  _loc9_ = param2;
                                                                                                                  _loc10_ = op_li8(param2) /*Alchemy*/;
                                                                                                                  if(_loc10_ >= 128)
                                                                                                                  {
                                                                                                                     if((_loc10_ & 248) == 240)
                                                                                                                     {
                                                                                                                        param2++;
                                                                                                                        param2++;
                                                                                                                        param2++;
                                                                                                                        _loc10_ = (_loc10_ & 7) << 18 | (op_li8(param2) /*Alchemy*/ & 63) << 12 | (op_li8(param2) /*Alchemy*/ & 63) << 6 | op_li8(param2) /*Alchemy*/ & 63;
                                                                                                                     }
                                                                                                                     else
                                                                                                                     {
                                                                                                                        if((_loc10_ & 240) == 224)
                                                                                                                        {
                                                                                                                           param2++;
                                                                                                                           param2++;
                                                                                                                           _loc10_ = (_loc10_ & 15) << 12 | (op_li8(param2) /*Alchemy*/ & 63) << 6 | op_li8(param2) /*Alchemy*/ & 63;
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                           if((_loc10_ & 224) == 192)
                                                                                                                           {
                                                                                                                              param2++;
                                                                                                                              _loc10_ = (_loc10_ & 31) << 6 | op_li8(param2) /*Alchemy*/ & 63;
                                                                                                                           }
                                                                                                                        }
                                                                                                                     }
                                                                                                                  }
                                                                                                                  param2++;
                                                                                                                  _loc8_ = _loc10_;
                                                                                                                  if(_loc8_ >= (97))
                                                                                                                  {
                                                                                                                  }
                                                                                                                  if(!false)
                                                                                                                  {
                                                                                                                     if(_loc8_ >= (65))
                                                                                                                     {
                                                                                                                     }
                                                                                                                     if(!false)
                                                                                                                     {
                                                                                                                        if(_loc8_ >= (48))
                                                                                                                        {
                                                                                                                        }
                                                                                                                        if(!false)
                                                                                                                        {
                                                                                                                           if(_loc8_ != (36))
                                                                                                                           {
                                                                                                                              if(_loc8_ != (95))
                                                                                                                              {
                                                                                                                              }
                                                                                                                           }
                                                                                                                        }
                                                                                                                     }
                                                                                                                  }
                                                                                                               }while(true);
                                                                                                               
                                                                                                               param2 = _loc9_;
                                                                                                               param1.position = _loc7_;
                                                                                                            }
                                                                                                            if(false)
                                                                                                            {
                                                                                                               _loc3_ = null;
                                                                                                               if(_loc3_ != (null))
                                                                                                               {
                                                                                                                  _loc11_ = _loc3_;
                                                                                                               }
                                                                                                               else
                                                                                                               {
                                                                                                                  Error.throwError(Error,0);
                                                                                                               }
                                                                                                            }
                                                                                                            else
                                                                                                            {
                                                                                                               _loc3_ = param1.readUTFBytes(param2 - _loc7_);
                                                                                                               if(_loc3_ != (null))
                                                                                                               {
                                                                                                                  _loc11_ = _loc3_;
                                                                                                               }
                                                                                                               else
                                                                                                               {
                                                                                                                  Error.throwError(Error,0);
                                                                                                               }
                                                                                                            }
                                                                                                         }
                                                                                                      }
                                                                                                   }
                                                                                                   while(true)
                                                                                                   {
                                                                                                      _loc8_ = param2;
                                                                                                      param2++;
                                                                                                      _loc7_ = op_li8(_loc8_) /*Alchemy*/;
                                                                                                      if(_loc7_ != (13))
                                                                                                      {
                                                                                                         if(_loc7_ != (10))
                                                                                                         {
                                                                                                            if(_loc7_ != (32))
                                                                                                            {
                                                                                                               if(_loc7_ != (9))
                                                                                                               {
                                                                                                                  if(_loc7_ != (11))
                                                                                                                  {
                                                                                                                     if(_loc7_ != (8))
                                                                                                                     {
                                                                                                                     }
                                                                                                                  }
                                                                                                               }
                                                                                                            }
                                                                                                         }
                                                                                                      }
                                                                                                      if(false)
                                                                                                      {
                                                                                                         if(_loc7_ == (47))
                                                                                                         {
                                                                                                            _loc8_ = param2;
                                                                                                            param2++;
                                                                                                            _loc7_ = op_li8(_loc8_) /*Alchemy*/;
                                                                                                            if(_loc7_ == (47))
                                                                                                            {
                                                                                                               do
                                                                                                               {
                                                                                                                     _loc9_ = param2;
                                                                                                                     param2++;
                                                                                                                     _loc8_ = op_li8(_loc9_) /*Alchemy*/;
                                                                                                                     if(_loc8_ != (10))
                                                                                                                     {
                                                                                                                        if(_loc8_ != (13))
                                                                                                                        {
                                                                                                                        }
                                                                                                                     }
                                                                                                                  }while(false);
                                                                                                                  
                                                                                                                  param2--;
                                                                                                                  continue;
                                                                                                               }
                                                                                                               if(_loc7_ == (42))
                                                                                                               {
                                                                                                                  param2 = param2 - 2;
                                                                                                                  _loc7_ = param2;
                                                                                                                  _loc8_ = param2;
                                                                                                                  _loc9_ = param2;
                                                                                                                  param2++;
                                                                                                                  if(op_li8(_loc9_) /*Alchemy*/ == (47))
                                                                                                                  {
                                                                                                                     _loc9_ = param2;
                                                                                                                     param2++;
                                                                                                                  }
                                                                                                                  if(true)
                                                                                                                  {
                                                                                                                     param2 = _loc8_;
                                                                                                                  }
                                                                                                                  else
                                                                                                                  {
                                                                                                                     while(true)
                                                                                                                     {
                                                                                                                        _loc10_ = param2;
                                                                                                                        param2++;
                                                                                                                        _loc9_ = op_li8(_loc10_) /*Alchemy*/;
                                                                                                                        if(_loc9_ == (42))
                                                                                                                        {
                                                                                                                           _loc10_ = param2;
                                                                                                                           param2++;
                                                                                                                           if(op_li8(_loc10_) /*Alchemy*/ != (47))
                                                                                                                           {
                                                                                                                              param2--;
                                                                                                                           }
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                           if(_loc9_ == (0))
                                                                                                                           {
                                                                                                                              break;
                                                                                                                           }
                                                                                                                        }
                                                                                                                     }
                                                                                                                     param2 = _loc8_;
                                                                                                                  }
                                                                                                                  if(_loc7_ != param2)
                                                                                                                  {
                                                                                                                     continue;
                                                                                                                  }
                                                                                                               }
                                                                                                               param2--;
                                                                                                               _loc7_ = 47;
                                                                                                               break;
                                                                                                            }
                                                                                                            break;
                                                                                                            break;
                                                                                                         }
                                                                                                      }
                                                                                                      if(_loc7_ != (58))
                                                                                                      {
                                                                                                         Error.throwError(Error,0);
                                                                                                      }
                                                                                                      _loc16_[_loc11_] = readValue(param1,param2);
                                                                                                      param2 = position;
                                                                                                      while(true)
                                                                                                      {
                                                                                                         _loc8_ = param2;
                                                                                                         param2++;
                                                                                                         _loc7_ = op_li8(_loc8_) /*Alchemy*/;
                                                                                                         if(_loc7_ != (13))
                                                                                                         {
                                                                                                            if(_loc7_ != (10))
                                                                                                            {
                                                                                                               if(_loc7_ != (32))
                                                                                                               {
                                                                                                                  if(_loc7_ != (9))
                                                                                                                  {
                                                                                                                     if(_loc7_ != (11))
                                                                                                                     {
                                                                                                                        if(_loc7_ != (8))
                                                                                                                        {
                                                                                                                        }
                                                                                                                     }
                                                                                                                  }
                                                                                                               }
                                                                                                            }
                                                                                                         }
                                                                                                         if(false)
                                                                                                         {
                                                                                                            if(_loc7_ == (47))
                                                                                                            {
                                                                                                               _loc8_ = param2;
                                                                                                               param2++;
                                                                                                               _loc7_ = op_li8(_loc8_) /*Alchemy*/;
                                                                                                               if(_loc7_ == (47))
                                                                                                               {
                                                                                                                  do
                                                                                                                  {
                                                                                                                        _loc9_ = param2;
                                                                                                                        param2++;
                                                                                                                        _loc8_ = op_li8(_loc9_) /*Alchemy*/;
                                                                                                                        if(_loc8_ != (10))
                                                                                                                        {
                                                                                                                           if(_loc8_ != (13))
                                                                                                                           {
                                                                                                                           }
                                                                                                                        }
                                                                                                                     }while(false);
                                                                                                                     
                                                                                                                     param2--;
                                                                                                                     continue;
                                                                                                                  }
                                                                                                                  if(_loc7_ == (42))
                                                                                                                  {
                                                                                                                     param2 = param2 - 2;
                                                                                                                     _loc7_ = param2;
                                                                                                                     _loc8_ = param2;
                                                                                                                     _loc9_ = param2;
                                                                                                                     param2++;
                                                                                                                     if(op_li8(_loc9_) /*Alchemy*/ == (47))
                                                                                                                     {
                                                                                                                        _loc9_ = param2;
                                                                                                                        param2++;
                                                                                                                     }
                                                                                                                     if(true)
                                                                                                                     {
                                                                                                                        param2 = _loc8_;
                                                                                                                     }
                                                                                                                     else
                                                                                                                     {
                                                                                                                        while(true)
                                                                                                                        {
                                                                                                                           _loc10_ = param2;
                                                                                                                           param2++;
                                                                                                                           _loc9_ = op_li8(_loc10_) /*Alchemy*/;
                                                                                                                           if(_loc9_ == (42))
                                                                                                                           {
                                                                                                                              _loc10_ = param2;
                                                                                                                              param2++;
                                                                                                                              if(op_li8(_loc10_) /*Alchemy*/ != (47))
                                                                                                                              {
                                                                                                                                 param2--;
                                                                                                                              }
                                                                                                                           }
                                                                                                                           else
                                                                                                                           {
                                                                                                                              if(_loc9_ == (0))
                                                                                                                              {
                                                                                                                                 break;
                                                                                                                              }
                                                                                                                           }
                                                                                                                        }
                                                                                                                        param2 = _loc8_;
                                                                                                                     }
                                                                                                                     if(_loc7_ != param2)
                                                                                                                     {
                                                                                                                        continue;
                                                                                                                     }
                                                                                                                  }
                                                                                                                  param2--;
                                                                                                                  _loc7_ = 47;
                                                                                                                  break;
                                                                                                               }
                                                                                                               break;
                                                                                                               break;
                                                                                                            }
                                                                                                         }
                                                                                                         _loc5_ = _loc7_;
                                                                                                         if(_loc5_ == (125))
                                                                                                         {
                                                                                                            break;
                                                                                                         }
                                                                                                         if(_loc5_ != (44))
                                                                                                         {
                                                                                                            Error.throwError(Error,0);
                                                                                                         }
                                                                                                      }
                                                                                                   }
                                                                                                   _loc6_ = _loc16_;
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   if(_loc5_ == (91))
                                                                                                   {
                                                                                                      _loc18_ = [];
                                                                                                      while(true)
                                                                                                      {
                                                                                                         while(true)
                                                                                                         {
                                                                                                            _loc8_ = param2;
                                                                                                            param2++;
                                                                                                            _loc7_ = op_li8(_loc8_) /*Alchemy*/;
                                                                                                            if(_loc7_ != (13))
                                                                                                            {
                                                                                                               if(_loc7_ != (10))
                                                                                                               {
                                                                                                                  if(_loc7_ != (32))
                                                                                                                  {
                                                                                                                     if(_loc7_ != (9))
                                                                                                                     {
                                                                                                                        if(_loc7_ != (11))
                                                                                                                        {
                                                                                                                           if(_loc7_ != (8))
                                                                                                                           {
                                                                                                                           }
                                                                                                                        }
                                                                                                                     }
                                                                                                                  }
                                                                                                               }
                                                                                                            }
                                                                                                            if(false)
                                                                                                            {
                                                                                                               if(_loc7_ == (47))
                                                                                                               {
                                                                                                                  _loc8_ = param2;
                                                                                                                  param2++;
                                                                                                                  _loc7_ = op_li8(_loc8_) /*Alchemy*/;
                                                                                                                  if(_loc7_ == (47))
                                                                                                                  {
                                                                                                                     do
                                                                                                                     {
                                                                                                                           _loc9_ = param2;
                                                                                                                           param2++;
                                                                                                                           _loc8_ = op_li8(_loc9_) /*Alchemy*/;
                                                                                                                           if(_loc8_ != (10))
                                                                                                                           {
                                                                                                                              if(_loc8_ != (13))
                                                                                                                              {
                                                                                                                              }
                                                                                                                           }
                                                                                                                        }while(false);
                                                                                                                        
                                                                                                                        param2--;
                                                                                                                        continue;
                                                                                                                     }
                                                                                                                     if(_loc7_ == (42))
                                                                                                                     {
                                                                                                                        param2 = param2 - 2;
                                                                                                                        _loc7_ = param2;
                                                                                                                        _loc8_ = param2;
                                                                                                                        _loc9_ = param2;
                                                                                                                        param2++;
                                                                                                                        if(op_li8(_loc9_) /*Alchemy*/ == (47))
                                                                                                                        {
                                                                                                                           _loc9_ = param2;
                                                                                                                           param2++;
                                                                                                                        }
                                                                                                                        if(true)
                                                                                                                        {
                                                                                                                           param2 = _loc8_;
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                           while(true)
                                                                                                                           {
                                                                                                                              _loc10_ = param2;
                                                                                                                              param2++;
                                                                                                                              _loc9_ = op_li8(_loc10_) /*Alchemy*/;
                                                                                                                              if(_loc9_ == (42))
                                                                                                                              {
                                                                                                                                 _loc10_ = param2;
                                                                                                                                 param2++;
                                                                                                                                 if(op_li8(_loc10_) /*Alchemy*/ != (47))
                                                                                                                                 {
                                                                                                                                    param2--;
                                                                                                                                 }
                                                                                                                              }
                                                                                                                              else
                                                                                                                              {
                                                                                                                                 if(_loc9_ == (0))
                                                                                                                                 {
                                                                                                                                    break;
                                                                                                                                 }
                                                                                                                              }
                                                                                                                           }
                                                                                                                           param2 = _loc8_;
                                                                                                                        }
                                                                                                                        if(_loc7_ != param2)
                                                                                                                        {
                                                                                                                           continue;
                                                                                                                        }
                                                                                                                     }
                                                                                                                     param2--;
                                                                                                                     _loc7_ = 47;
                                                                                                                     break;
                                                                                                                  }
                                                                                                                  break;
                                                                                                                  break;
                                                                                                               }
                                                                                                            }
                                                                                                            _loc5_ = _loc7_;
                                                                                                            if(_loc5_ == (93))
                                                                                                            {
                                                                                                               break;
                                                                                                            }
                                                                                                            if(_loc5_ == (44))
                                                                                                            {
                                                                                                               _loc18_.push(undefined);
                                                                                                            }
                                                                                                            else
                                                                                                            {
                                                                                                               param2--;
                                                                                                               _loc18_.push(readValue(param1,param2));
                                                                                                               param2 = position;
                                                                                                               while(true)
                                                                                                               {
                                                                                                                  _loc8_ = param2;
                                                                                                                  param2++;
                                                                                                                  _loc7_ = op_li8(_loc8_) /*Alchemy*/;
                                                                                                                  if(_loc7_ != (13))
                                                                                                                  {
                                                                                                                     if(_loc7_ != (10))
                                                                                                                     {
                                                                                                                        if(_loc7_ != (32))
                                                                                                                        {
                                                                                                                           if(_loc7_ != (9))
                                                                                                                           {
                                                                                                                              if(_loc7_ != (11))
                                                                                                                              {
                                                                                                                                 if(_loc7_ != (8))
                                                                                                                                 {
                                                                                                                                 }
                                                                                                                              }
                                                                                                                           }
                                                                                                                        }
                                                                                                                     }
                                                                                                                  }
                                                                                                                  if(false)
                                                                                                                  {
                                                                                                                     if(_loc7_ == (47))
                                                                                                                     {
                                                                                                                        _loc8_ = param2;
                                                                                                                        param2++;
                                                                                                                        _loc7_ = op_li8(_loc8_) /*Alchemy*/;
                                                                                                                        if(_loc7_ == (47))
                                                                                                                        {
                                                                                                                           do
                                                                                                                           {
                                                                                                                                 _loc9_ = param2;
                                                                                                                                 param2++;
                                                                                                                                 _loc8_ = op_li8(_loc9_) /*Alchemy*/;
                                                                                                                                 if(_loc8_ != (10))
                                                                                                                                 {
                                                                                                                                    if(_loc8_ != (13))
                                                                                                                                    {
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                              }while(false);
                                                                                                                              
                                                                                                                              param2--;
                                                                                                                              continue;
                                                                                                                           }
                                                                                                                           if(_loc7_ == (42))
                                                                                                                           {
                                                                                                                              param2 = param2 - 2;
                                                                                                                              _loc7_ = param2;
                                                                                                                              _loc8_ = param2;
                                                                                                                              _loc9_ = param2;
                                                                                                                              param2++;
                                                                                                                              if(op_li8(_loc9_) /*Alchemy*/ == (47))
                                                                                                                              {
                                                                                                                                 _loc9_ = param2;
                                                                                                                                 param2++;
                                                                                                                              }
                                                                                                                              if(true)
                                                                                                                              {
                                                                                                                                 param2 = _loc8_;
                                                                                                                              }
                                                                                                                              else
                                                                                                                              {
                                                                                                                                 while(true)
                                                                                                                                 {
                                                                                                                                    _loc10_ = param2;
                                                                                                                                    param2++;
                                                                                                                                    _loc9_ = op_li8(_loc10_) /*Alchemy*/;
                                                                                                                                    if(_loc9_ == (42))
                                                                                                                                    {
                                                                                                                                       _loc10_ = param2;
                                                                                                                                       param2++;
                                                                                                                                       if(op_li8(_loc10_) /*Alchemy*/ != (47))
                                                                                                                                       {
                                                                                                                                          param2--;
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                       if(_loc9_ == (0))
                                                                                                                                       {
                                                                                                                                          break;
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                                 param2 = _loc8_;
                                                                                                                              }
                                                                                                                              if(_loc7_ != param2)
                                                                                                                              {
                                                                                                                                 continue;
                                                                                                                              }
                                                                                                                           }
                                                                                                                           param2--;
                                                                                                                           _loc7_ = 47;
                                                                                                                           break;
                                                                                                                        }
                                                                                                                        break;
                                                                                                                        break;
                                                                                                                     }
                                                                                                                  }
                                                                                                                  _loc5_ = _loc7_;
                                                                                                                  if(_loc5_ == (93))
                                                                                                                  {
                                                                                                                     break;
                                                                                                                  }
                                                                                                                  if(_loc5_ != (44))
                                                                                                                  {
                                                                                                                     Error.throwError(Error,0);
                                                                                                                  }
                                                                                                               }
                                                                                                            }
                                                                                                            _loc6_ = _loc18_;
                                                                                                         }
                                                                                                         else
                                                                                                         {
                                                                                                            Error.throwError(Error,0);
                                                                                                         }
                                                                                                      }
                                                                                                   }
                                                                                                }
                                                                                             }
                                                                                          }
                                                                                       }
                                                                                    }
                                                                                 }
                                                                              }
                                                                              position = param2;
                                                                              return _loc6_;
                                                                           };
                                                                           _loc12_ = false;
                                                                           _loc3_ = readValue(_loc5_,position);
                                                                           _loc6_ = position;
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
                                                                              if(false)
                                                                              {
                                                                                 if(_loc8_ == (47))
                                                                                 {
                                                                                    _loc9_ = _loc6_;
                                                                                    _loc6_++;
                                                                                    _loc8_ = op_li8(_loc9_) /*Alchemy*/;
                                                                                    if(_loc8_ == (47))
                                                                                    {
                                                                                       do
                                                                                       {
                                                                                             _loc10_ = _loc6_;
                                                                                             _loc6_++;
                                                                                             _loc9_ = op_li8(_loc10_) /*Alchemy*/;
                                                                                             if(_loc9_ != (10))
                                                                                             {
                                                                                                if(_loc9_ != (13))
                                                                                                {
                                                                                                }
                                                                                             }
                                                                                          }while(false);
                                                                                          
                                                                                          _loc6_--;
                                                                                          continue;
                                                                                       }
                                                                                       if(_loc8_ == (42))
                                                                                       {
                                                                                          _loc6_ = _loc6_ - 2;
                                                                                          _loc8_ = _loc6_;
                                                                                          _loc9_ = _loc6_;
                                                                                          _loc10_ = _loc6_;
                                                                                          _loc6_++;
                                                                                          if(op_li8(_loc10_) /*Alchemy*/ == (47))
                                                                                          {
                                                                                             _loc10_ = _loc6_;
                                                                                             _loc6_++;
                                                                                          }
                                                                                          if(true)
                                                                                          {
                                                                                             _loc6_ = _loc9_;
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             while(true)
                                                                                             {
                                                                                                _loc11_ = _loc6_;
                                                                                                _loc6_++;
                                                                                                _loc10_ = op_li8(_loc11_) /*Alchemy*/;
                                                                                                if(_loc10_ == (42))
                                                                                                {
                                                                                                   _loc11_ = _loc6_;
                                                                                                   _loc6_++;
                                                                                                   if(op_li8(_loc11_) /*Alchemy*/ != (47))
                                                                                                   {
                                                                                                      _loc6_--;
                                                                                                   }
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   if(_loc10_ == (0))
                                                                                                   {
                                                                                                      break;
                                                                                                   }
                                                                                                }
                                                                                             }
                                                                                             _loc6_ = _loc9_;
                                                                                          }
                                                                                          if(_loc8_ != _loc6_)
                                                                                          {
                                                                                             continue;
                                                                                          }
                                                                                       }
                                                                                       _loc6_--;
                                                                                       _loc8_ = 47;
                                                                                       break;
                                                                                    }
                                                                                    break;
                                                                                    break;
                                                                                 }
                                                                              }
                                                                              _loc7_ = _loc8_;
                                                                              if(_loc7_ == (0))
                                                                              {
                                                                                 _loc12_ = true;
                                                                              }
                                                                           }
                                                                           else
                                                                           {
                                                                              ApplicationDomain.currentDomain.domainMemory = _loc4_;
                                                                           }
                                                                        }
                                                                        return _loc3_;
                                                                     }
                                                                  }
                                                               }
