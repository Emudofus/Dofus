package com.ankamagames.dofus.kernel.updaterv2.messages.impl
{
   import com.ankamagames.dofus.kernel.updaterv2.messages.IUpdaterOutputMessage;
   import by.blooddy.crypto.serialization.JSON;
   import com.ankamagames.dofus.kernel.updaterv2.messages.UpdaterMessageIDEnum;
   
   public class GetSystemConfiguration extends Object implements IUpdaterOutputMessage
   {
      
      public function GetSystemConfiguration(key:String = "") {
         super();
         this._key = key;
      }
      
      private var _key:String = "";
      
      public function serialize() : String {
         return by.blooddy.crypto.serialization.JSON.encode(
            {
               "_msg_id":UpdaterMessageIDEnum.GET_SYSTEM_CONFIGURATION,
               "key":this._key
            });
      }
   }
}
