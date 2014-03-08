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
      
      public function deserialize(data:Object) : void {
         var i:* = 0;
         var o:Object = null;
         var components:Array = data["components"];
         this._components = new Dictionary();
         if(components)
         {
            i = 0;
            while(i < components.length)
            {
               o = components[i];
               this._components[o.name] = o;
               i++;
            }
         }
      }
   }
}
