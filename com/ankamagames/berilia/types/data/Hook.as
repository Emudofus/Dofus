package com.ankamagames.berilia.types.data
{
   import com.ankamagames.berilia.utils.errors.BeriliaError;
   
   public class Hook extends Object
   {
      
      public function Hook(name:String, trusted:Boolean, nativeHook:Boolean=true) {
         super();
         if(!_hookNameList)
         {
            _hookNameList = new Array();
         }
         _hookNameList[name] = this;
         this._name = name;
         this._trusted = trusted;
      }
      
      private static var _hookNameList:Array;
      
      public static function create(name:String, trusted:Boolean, nativeHook:Boolean=true) : Hook {
         var h:Hook = _hookNameList[name];
         if(h)
         {
            if(trusted)
            {
               throw new BeriliaError("Hook name (" + name + ") aleardy used, please rename it.");
            }
            else
            {
               return h;
            }
         }
         else
         {
            return new Hook(name,trusted,nativeHook);
         }
      }
      
      public static function getHookByName(name:String) : Hook {
         return _hookNameList[name];
      }
      
      private var _trusted:Boolean;
      
      private var _name:String;
      
      private var _nativeHook:Boolean;
      
      public function get trusted() : Boolean {
         return this._trusted;
      }
      
      public function get name() : String {
         return this._name;
      }
      
      public function get nativeHook() : Boolean {
         return this._nativeHook;
      }
   }
}
