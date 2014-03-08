package com.ankamagames.berilia.types.data
{
   import __AS3__.vec.Vector;
   
   public class TreeData extends Object
   {
      
      public function TreeData(param1:*, param2:String, param3:Boolean=false, param4:Vector.<TreeData>=null, param5:TreeData=null) {
         super();
         this.value = param1;
         this.label = param2;
         this.expend = param3;
         this.children = param4;
         this.parent = param5;
      }
      
      public static function fromArray(param1:Object) : Vector.<TreeData> {
         var _loc2_:TreeData = new TreeData(null,null,true);
         _loc2_.children = _fromArray(param1,_loc2_);
         return _loc2_.children;
      }
      
      private static function _fromArray(param1:Object, param2:TreeData) : Vector.<TreeData> {
         var _loc4_:TreeData = null;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc3_:Vector.<TreeData> = new Vector.<TreeData>();
         for each (_loc6_ in param1)
         {
            if(Object(_loc6_).hasOwnProperty("children"))
            {
               _loc5_ = _loc6_.children;
            }
            else
            {
               _loc5_ = null;
            }
            _loc4_ = new TreeData(_loc6_,_loc6_.label,Object(_loc6_).hasOwnProperty("expend")?Object(_loc6_).expend:false);
            _loc4_.parent = param2;
            _loc4_.children = _fromArray(_loc5_,_loc4_);
            _loc3_.push(_loc4_);
         }
         return _loc3_;
      }
      
      public var value;
      
      public var label:String;
      
      public var expend:Boolean;
      
      public var children:Vector.<TreeData>;
      
      public var parent:TreeData;
      
      public function get depth() : uint {
         if(this.parent)
         {
            return this.parent.depth + 1;
         }
         return 0;
      }
   }
}
