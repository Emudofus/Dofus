package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   class CTypemap extends Object
   {
      
      function CTypemap() {
         super();
      }
      
      public static var AS3ValType:CAS3ValTypemap;
      
      public static var DoubleType:CDoubleTypemap;
      
      public static var VoidType:CVoidTypemap;
      
      public static var DoubleRefType:CRefTypemap;
      
      public static function getTypeByName(param1:String) : CTypemap {
         return CTypemap[param1];
      }
      
      public static var StrRefType:CRefTypemap;
      
      public static var IntRefType:CRefTypemap;
      
      public static var SizedStrType:CSizedStrUTF8Typemap;
      
      public static var IntType:CIntTypemap;
      
      public static var StrType:CStrUTF8Typemap;
      
      public static function getTypesByNames(param1:String) : Array {
         return CTypemap.getTypesByNameArray(param1.split(new RegExp("\\s*,\\s*")));
      }
      
      public static var PtrType:CPtrTypemap;
      
      public static function getTypesByNameArray(param1:Array) : Array {
         var _loc2_:Array = null;
         var _loc3_:* = undefined;
         _loc2_ = [];
         if(param1)
         {
            for each (_loc3_ in param1)
            {
               _loc2_.push(CTypemap.getTypeByName(_loc3_));
            }
         }
         return _loc2_;
      }
      
      public static var BufferType:CBufferTypemap;
      
      public function fromC(param1:Array) : * {
         return undefined;
      }
      
      public function writeValue(param1:int, param2:*) : void {
         var _loc3_:Array = null;
         var _loc4_:* = 0;
         _loc3_ = this.createC(param2);
         CTypemap.ds.position = param1;
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            CTypemap.ds.writeInt(_loc3_[_loc4_]);
            _loc4_++;
         }
      }
      
      public function readValue(param1:int) : * {
         var _loc2_:Array = null;
         var _loc3_:* = 0;
         _loc2_ = [];
         CTypemap.ds.position = param1;
         _loc3_ = 0;
         while(_loc3_ < this.typeSize)
         {
            _loc2_.push(CTypemap.ds.readInt());
            _loc3_++;
         }
         return this.fromC(_loc2_);
      }
      
      public function get ptrLevel() : int {
         return 0;
      }
      
      public function createC(param1:*, param2:int=0) : Array {
         return null;
      }
      
      public function fromReturnRegs(param1:Object) : * {
         var _loc2_:Array = null;
         var _loc3_:* = undefined;
         _loc2_ = [param1.eax];
         _loc3_ = this.fromC(_loc2_);
         this.destroyC(_loc2_);
         return _loc3_;
      }
      
      public function destroyC(param1:Array) : void {
      }
      
      public function toReturnRegs(param1:Object, param2:*, param3:int=0) : void {
         param1.eax = this.createC(param2,param3)[0];
      }
      
      public function get typeSize() : int {
         return 4;
      }
      
      public function getValueSize(param1:*) : int {
         return this.typeSize;
      }
   }
}
