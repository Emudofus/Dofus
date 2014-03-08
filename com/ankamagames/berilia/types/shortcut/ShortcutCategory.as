package com.ankamagames.berilia.types.shortcut
{
   public class ShortcutCategory extends Object
   {
      
      public function ShortcutCategory(param1:String, param2:String) {
         super();
         _caterogies[param1] = this;
         this._name = param1;
         this._description = param2;
      }
      
      private static var _caterogies:Array = new Array();
      
      public static function create(param1:String, param2:String) : ShortcutCategory {
         var _loc3_:ShortcutCategory = _caterogies[param1];
         if(!_loc3_)
         {
            _loc3_ = new ShortcutCategory(param1,param2);
         }
         else
         {
            if(!_caterogies[param1].description)
            {
               _caterogies[param1]._description = param2;
            }
         }
         return _loc3_;
      }
      
      private var _name:String;
      
      private var _description:String;
      
      public function get name() : String {
         return this._name;
      }
      
      public function get description() : String {
         return this._description;
      }
      
      public function toString() : String {
         return this._name;
      }
   }
}
