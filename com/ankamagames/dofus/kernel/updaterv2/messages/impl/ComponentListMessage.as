package com.ankamagames.dofus.kernel.updaterv2.messages.impl
{
   import com.ankamagames.dofus.kernel.updaterv2.messages.IUpdaterInputMessage;
   import flash.utils.Dictionary;
   
   public class ComponentListMessage extends Object implements IUpdaterInputMessage
   {
      
      public function ComponentListMessage() {
         super();
      }
      
      private var _components:Dictionary;
      
      public function get components() : Dictionary {
         return this._components;
      }
      
      public function deserialize(param1:Object) : void {
         var _loc3_:* = 0;
         var _loc4_:Object = null;
         var _loc2_:Array = param1["components"];
         this._components = new Dictionary();
         if(_loc2_)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc4_ = _loc2_[_loc3_];
               this._components[_loc4_.name] = _loc4_;
               _loc3_++;
            }
         }
      }
   }
}
