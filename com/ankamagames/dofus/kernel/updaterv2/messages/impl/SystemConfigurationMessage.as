package com.ankamagames.dofus.kernel.updaterv2.messages.impl
{
   import com.ankamagames.dofus.kernel.updaterv2.messages.IUpdaterInputMessage;
   
   public class SystemConfigurationMessage extends Object implements IUpdaterInputMessage
   {
      
      public function SystemConfigurationMessage()
      {
         super();
      }
      
      private var _config;
      
      public function get config() : *
      {
         return this._config;
      }
      
      public function deserialize(param1:Object) : void
      {
         this._config = param1;
      }
   }
}
