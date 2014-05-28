package com.ankamagames.berilia.types.shortcut
{
   public class ShortcutCategory extends Object
   {
      
      public function ShortcutCategory(name:String, description:String) {
         super();
         _caterogies[name] = this;
         this._name = name;
         this._description = description;
      }
      
      private static var _caterogies:Array;
      
      public static function create(name:String, description:String) : ShortcutCategory {
         var sc:ShortcutCategory = _caterogies[name];
         if(!sc)
         {
            sc = new ShortcutCategory(name,description);
         }
         else if(!_caterogies[name].description)
         {
            _caterogies[name]._description = description;
         }
         
         return sc;
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
