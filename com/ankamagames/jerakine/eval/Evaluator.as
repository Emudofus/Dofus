package com.ankamagames.jerakine.eval
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class Evaluator extends Object
   {
      
      public function Evaluator() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Evaluator));
      
      private static const NUMBER:uint = 0;
      
      private static const STRING:uint = 1;
      
      public function eval(param1:String) : * {
         return this.complexEval(param1);
      }
      
      private function simpleEval(param1:String) : * {
         var _loc2_:Function = null;
         var _loc4_:String = null;
         var _loc12_:Array = null;
         var _loc13_:* = undefined;
         var _loc15_:* = false;
         var _loc16_:* = false;
         var _loc17_:uint = 0;
         var _loc3_:* = "";
         var _loc5_:* = false;
         var _loc6_:* = false;
         var _loc7_:* = "";
         var _loc8_:uint = STRING;
         var _loc9_:Array = new Array();
         var _loc10_:uint = 0;
         while(_loc10_ < param1.length)
         {
            _loc4_ = param1.charAt(_loc10_);
            if(_loc4_ == "\'" && !_loc6_)
            {
               _loc8_ = STRING;
               _loc5_ = !_loc5_;
            }
            else
            {
               if(_loc4_ == "\\")
               {
                  _loc6_ = true;
               }
               else
               {
                  if(!_loc5_)
                  {
                     switch(_loc4_)
                     {
                        case "(":
                        case ")":
                        case " ":
                        case "\t":
                        case "\n":
                           break;
                        case "0":
                        case "1":
                        case "2":
                        case "3":
                        case "4":
                        case "5":
                        case "6":
                        case "7":
                        case "8":
                        case "9":
                           _loc8_ = NUMBER;
                           _loc3_ = "";
                           _loc2_ = null;
                           _loc7_ = _loc7_ + _loc4_;
                           break;
                        case ".":
                           _loc7_ = _loc7_ + ".";
                           break;
                        default:
                           if(_loc4_ == "-" || _loc4_ == "+")
                           {
                              if(!_loc7_.length)
                              {
                                 _loc7_ = _loc7_ + _loc4_;
                                 break;
                              }
                           }
                           _loc15_ = true;
                           _loc16_ = false;
                           _loc3_ = _loc3_ + _loc4_;
                           switch(_loc3_)
                           {
                              case "-":
                                 _loc2_ = this.minus;
                                 break;
                              case "+":
                                 _loc2_ = this.plus;
                                 break;
                              case "*":
                                 _loc2_ = this.multiply;
                                 break;
                              case "/":
                                 _loc2_ = this.divide;
                                 break;
                              case ">":
                                 if(param1.charAt(_loc10_ + 1) != "=")
                                 {
                                    _loc2_ = this.sup;
                                 }
                                 else
                                 {
                                    _loc16_ = true;
                                    _loc15_ = false;
                                 }
                                 break;
                              case ">=":
                                 _loc2_ = this.supOrEquals;
                                 break;
                              case "<":
                                 if(param1.charAt(_loc10_ + 1) != "=")
                                 {
                                    _loc2_ = this.inf;
                                 }
                                 else
                                 {
                                    _loc16_ = true;
                                    _loc15_ = false;
                                 }
                                 break;
                              case "<=":
                                 _loc2_ = this.infOrEquals;
                                 break;
                              case "&&":
                                 _loc2_ = this.and;
                                 break;
                              case "||":
                                 _loc2_ = this.or;
                                 break;
                              case "==":
                                 _loc2_ = this.equals;
                                 break;
                              case "!=":
                                 _loc2_ = this.diff;
                                 break;
                              case "?":
                                 _loc2_ = this.ternary;
                                 break;
                              case ":":
                                 _loc2_ = this.opElse;
                                 break;
                              case "|":
                              case "=":
                              case "&":
                              case "!":
                                 _loc16_ = true;
                              default:
                                 _loc15_ = false;
                           }
                           if(_loc15_)
                           {
                              if(_loc7_.length)
                              {
                                 if(_loc8_ == STRING)
                                 {
                                    _loc9_.push(_loc7_);
                                 }
                                 else
                                 {
                                    _loc9_.push(parseFloat(_loc7_));
                                 }
                                 _loc9_.push(_loc2_);
                              }
                              else
                              {
                                 _log.warn(this.showPosInExpr(_loc10_,param1));
                                 _log.warn("Expecting Number at char " + _loc10_ + ", but found operator " + _loc4_);
                              }
                              _loc7_ = "";
                           }
                           else
                           {
                              if(!_loc16_)
                              {
                                 _log.warn(this.showPosInExpr(_loc10_,param1));
                                 _log.warn("Bad character at " + _loc10_);
                              }
                           }
                     }
                  }
                  else
                  {
                     _loc3_ = "";
                     _loc2_ = null;
                     _loc7_ = _loc7_ + _loc4_;
                     _loc6_ = false;
                  }
               }
            }
            _loc10_++;
         }
         if(_loc7_.length)
         {
            if(_loc8_ == STRING)
            {
               _loc9_.push(_loc7_);
            }
            else
            {
               _loc9_.push(parseFloat(_loc7_));
            }
         }
         var _loc11_:Array = [this.divide,this.multiply,this.minus,this.plus,this.sup,this.inf,this.supOrEquals,this.infOrEquals,this.equals,this.diff,this.and,this.or,this.ternary];
         var _loc14_:uint = 0;
         while(_loc14_ < _loc11_.length)
         {
            _loc12_ = new Array();
            _loc17_ = 0;
            while(_loc17_ < _loc9_.length)
            {
               if(_loc9_[_loc17_] is Function && _loc9_[_loc17_] == _loc11_[_loc14_])
               {
                  _loc13_ = _loc12_[_loc12_.length-1];
                  if(_loc13_ is Number || (_loc9_[_loc17_] == this.plus || _loc9_[_loc17_] == this.ternary || _loc9_[_loc17_] == this.equals || _loc9_[_loc17_] == this.diff) && _loc13_ is String)
                  {
                     if(_loc9_[_loc17_ + 1] is Number || (_loc9_[_loc17_] == this.plus || _loc9_[_loc17_] == this.ternary || _loc9_[_loc17_] == this.equals || _loc9_[_loc17_] == this.diff) && _loc9_[_loc17_ + 1] is String)
                     {
                        if(_loc9_[_loc17_] === this.ternary)
                        {
                           if(_loc9_[_loc17_ + 2] == this.opElse)
                           {
                              _loc12_[_loc12_.length-1] = this.ternary(_loc13_,_loc9_[_loc17_ + 1],_loc9_[_loc17_ + 3]);
                              _loc17_ = _loc17_ + 2;
                           }
                           else
                           {
                              _log.warn("operator \':\' not found");
                           }
                        }
                        else
                        {
                           _loc12_[_loc12_.length-1] = _loc9_[_loc17_](_loc13_,_loc9_[_loc17_ + 1]);
                        }
                     }
                     else
                     {
                        _log.warn("Expect Number, but find [" + _loc9_[_loc17_ + 1] + "]");
                     }
                     _loc17_++;
                  }
                  else
                  {
                     _loc13_ = _loc9_[_loc17_-1];
                     if(_loc13_ is Number || (_loc9_[_loc17_] == this.plus || _loc9_[_loc17_] == this.ternary || _loc9_[_loc17_] == this.equals || _loc9_[_loc17_] == this.diff) && _loc13_ is String)
                     {
                        if(_loc9_[_loc17_ + 1] is Number || (_loc9_[_loc17_] == this.plus || _loc9_[_loc17_] == this.ternary || _loc9_[_loc17_] == this.equals || _loc9_[_loc17_] == this.diff) && _loc9_[_loc17_ + 1] is String)
                        {
                           if(_loc9_[_loc17_] === this.ternary)
                           {
                              if(_loc9_[_loc17_ + 2] == this.opElse)
                              {
                                 _loc12_[_loc12_.length-1] = this.ternary(_loc13_,_loc9_[_loc17_ + 1],_loc9_[_loc17_ + 3]);
                              }
                              else
                              {
                                 _log.warn("operator \':\' not found");
                              }
                           }
                           else
                           {
                              _loc12_.push(_loc9_[_loc17_](_loc13_,_loc9_[_loc17_ + 1]));
                           }
                        }
                        else
                        {
                           _log.warn("Expect Number,  but find [" + _loc9_[_loc17_ + 1] + "]");
                        }
                        _loc17_++;
                     }
                  }
               }
               else
               {
                  _loc12_.push(_loc9_[_loc17_]);
               }
               _loc17_++;
            }
            _loc9_ = _loc12_;
            _loc14_++;
         }
         return _loc9_[0];
      }
      
      private function complexEval(param1:String) : * {
         var _loc2_:* = 0;
         var _loc5_:* = undefined;
         var _loc6_:uint = 0;
         var param1:String = this.trim(param1);
         var _loc3_:* = true;
         var _loc4_:* = 0;
         while(_loc3_)
         {
            _loc3_ = false;
            _loc6_ = 0;
            while(_loc6_ < param1.length)
            {
               if(param1.charAt(_loc6_) == "(")
               {
                  if(!_loc4_)
                  {
                     _loc2_ = _loc6_;
                  }
                  _loc4_++;
               }
               if(param1.charAt(_loc6_) == ")")
               {
                  _loc4_--;
                  if(!_loc4_)
                  {
                     _loc5_ = this.complexEval(param1.substr(_loc2_ + 1,_loc6_ - _loc2_-1));
                     param1 = param1.substr(0,_loc2_) + (_loc5_ is Number?_loc5_:"\'" + _loc5_ + "\'") + param1.substr(_loc6_ + 1);
                     _loc3_ = true;
                     break;
                  }
               }
               _loc6_++;
            }
         }
         if(_loc4_)
         {
            _log.warn("Missing right parenthesis in " + param1);
         }
         return this.simpleEval(param1);
      }
      
      private function plus(param1:*, param2:*) : * {
         return param1 + param2;
      }
      
      private function minus(param1:Number, param2:Number) : Number {
         return param1 - param2;
      }
      
      private function multiply(param1:Number, param2:Number) : Number {
         return param1 * param2;
      }
      
      private function divide(param1:Number, param2:Number) : Number {
         return param1 / param2;
      }
      
      private function sup(param1:Number, param2:Number) : Number {
         return param1 > param2?1:0;
      }
      
      private function supOrEquals(param1:Number, param2:Number) : Number {
         return param1 >= param2?1:0;
      }
      
      private function inf(param1:Number, param2:Number) : Number {
         return param1 < param2?1:0;
      }
      
      private function infOrEquals(param1:Number, param2:Number) : Number {
         return param1 <= param2?1:0;
      }
      
      private function and(param1:Number, param2:Number) : Number {
         return (param1) && (param2)?1:0;
      }
      
      private function or(param1:Number, param2:Number) : Number {
         return (param1) || (param2)?1:0;
      }
      
      private function equals(param1:*, param2:*) : Number {
         return param1 == param2?1:0;
      }
      
      private function diff(param1:*, param2:*) : Number {
         return param1 != param2?1:0;
      }
      
      private function ternary(param1:Number, param2:*, param3:*) : * {
         return param1?param2:param3;
      }
      
      private function opElse() : void {
      }
      
      private function showPosInExpr(param1:uint, param2:String) : String {
         var _loc3_:* = param2 + "\n";
         var _loc4_:uint = 0;
         while(_loc4_ < param1)
         {
            _loc3_ = _loc3_ + " ";
            _loc4_++;
         }
         return _loc3_ + "^";
      }
      
      private function trim(param1:String) : String {
         var _loc5_:String = null;
         var _loc2_:* = "";
         var _loc3_:* = false;
         var _loc4_:* = false;
         var _loc6_:uint = 0;
         while(_loc6_ < param1.length)
         {
            _loc5_ = param1.charAt(_loc6_);
            if(_loc5_ == "\'" && !_loc3_)
            {
               _loc4_ = !_loc4_;
            }
            if(_loc5_ == "\\")
            {
               _loc3_ = true;
            }
            else
            {
               _loc3_ = false;
            }
            if(!(_loc5_ == " ") || (_loc4_))
            {
               _loc2_ = _loc2_ + _loc5_;
            }
            _loc6_++;
         }
         return _loc2_;
      }
   }
}
