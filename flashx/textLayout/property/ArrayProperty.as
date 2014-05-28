package flashx.textLayout.property
{
   import flashx.textLayout.formats.FormatValue;
   import flashx.textLayout.tlf_internal;
   import __AS3__.vec.Vector;
   
   use namespace tlf_internal;
   
   public class ArrayProperty extends Property
   {
      
      public function ArrayProperty(param1:String, param2:Array, param3:Boolean, param4:Vector.<String>, param5:Class) {
         super(param1,param2,param3,param4);
         this._memberType = param5;
      }
      
      private var _memberType:Class;
      
      public function get memberType() : Class {
         return this._memberType;
      }
      
      protected function checkArrayTypes(param1:Object) : Boolean {
         var _loc2_:Object = null;
         if(param1 == null)
         {
            return true;
         }
         if(!(param1 is Array))
         {
            return false;
         }
         if(this._memberType == null)
         {
            return true;
         }
         for each (_loc2_ in param1 as Array)
         {
            if(!(_loc2_ is this._memberType))
            {
               return false;
            }
         }
         return true;
      }
      
      override public function get defaultValue() : * {
         return super.defaultValue == null?null:(super.defaultValue as Array).slice();
      }
      
      override public function setHelper(param1:*, param2:*) : * {
         if(param2 === null)
         {
            param2 = undefined;
         }
         if(param2 == undefined || param2 == FormatValue.INHERIT)
         {
            return param2;
         }
         if(param2 is String)
         {
            param2 = this.valueFromString(String(param2));
         }
         if(!this.checkArrayTypes(param2))
         {
            Property.errorHandler(this,param2);
            return param1;
         }
         return (param2 as Array).slice();
      }
      
      override public function concatInheritOnlyHelper(param1:*, param2:*) : * {
         return (inherited) && (param1 === undefined) || param1 == FormatValue.INHERIT?param2 is Array?(param2 as Array).slice():param2:param1;
      }
      
      override public function concatHelper(param1:*, param2:*) : * {
         if(inherited)
         {
            return param1 === undefined || param1 == FormatValue.INHERIT?param2 is Array?(param2 as Array).slice():param2:param1;
         }
         if(param1 === undefined)
         {
            return this.defaultValue;
         }
         return param1 == FormatValue.INHERIT?param2 is Array?(param2 as Array).slice():param2:param1;
      }
      
      override public function equalHelper(param1:*, param2:*) : Boolean {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Object = null;
         var _loc6_:* = 0;
         if(this._memberType != null)
         {
            _loc3_ = param1 as Array;
            _loc4_ = param2 as Array;
            if((_loc3_) && (_loc4_))
            {
               if(_loc3_.length == _loc4_.length)
               {
                  _loc5_ = this._memberType.description;
                  _loc6_ = 0;
                  while(_loc6_ < _loc3_.length)
                  {
                     if(!Property.equalAllHelper(_loc5_,param1[_loc6_],param2[_loc6_]))
                     {
                        return false;
                     }
                     _loc6_++;
                  }
                  return true;
               }
            }
         }
         return param1 == param2;
      }
      
      override public function toXMLString(param1:Object) : String {
         var _loc5_:Object = null;
         var _loc6_:* = false;
         var _loc7_:Property = null;
         if(param1 == FormatValue.INHERIT)
         {
            return String(param1);
         }
         var _loc2_:Object = this._memberType.description;
         var _loc3_:* = "";
         var _loc4_:* = false;
         for each (_loc5_ in param1)
         {
            if(_loc4_)
            {
               _loc3_ = _loc3_ + "; ";
            }
            _loc6_ = false;
            for each (_loc7_ in _loc2_)
            {
               param1 = _loc5_[_loc7_.name];
               if(param1 != null)
               {
                  if(_loc6_)
                  {
                     _loc3_ = _loc3_ + ", ";
                  }
                  _loc3_ = _loc3_ + (_loc7_.name + ":" + _loc7_.toXMLString(param1));
                  _loc6_ = true;
               }
            }
            _loc4_ = true;
         }
         return _loc3_;
      }
      
      private function valueFromString(param1:String) : * {
         var _loc5_:String = null;
         var _loc6_:Object = null;
         var _loc7_:Array = null;
         var _loc8_:String = null;
         var _loc9_:Array = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:Property = null;
         if(param1 == null || param1 == "")
         {
            return null;
         }
         if(param1 == FormatValue.INHERIT)
         {
            return param1;
         }
         var _loc2_:Array = new Array();
         var _loc3_:Object = this._memberType.description;
         var _loc4_:Array = param1.split("; ");
         for each (_loc5_ in _loc4_)
         {
            _loc6_ = new this._memberType();
            _loc7_ = _loc5_.split(", ");
            for each (_loc8_ in _loc7_)
            {
               _loc9_ = _loc8_.split(":");
               _loc10_ = _loc9_[0];
               _loc11_ = _loc9_[1];
               for each (_loc12_ in _loc3_)
               {
                  if(_loc12_.name == _loc10_)
                  {
                     _loc6_[_loc10_] = _loc12_.setHelper(_loc11_,_loc6_[_loc10_]);
                     break;
                  }
               }
            }
            _loc2_.push(_loc6_);
         }
         return _loc2_;
      }
   }
}
