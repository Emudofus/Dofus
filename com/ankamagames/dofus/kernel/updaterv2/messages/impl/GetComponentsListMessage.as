package com.ankamagames.dofus.kernel.updaterv2.messages.impl
{
   import com.ankamagames.dofus.kernel.updaterv2.messages.IUpdaterOutputMessage;
   import by.blooddy.crypto.serialization.JSON;
   import com.ankamagames.dofus.kernel.updaterv2.messages.UpdaterMessageIDEnum;
   
   public class GetComponentsListMessage extends Object implements IUpdaterOutputMessage
   {
      
      public function GetComponentsListMessage(project:String = "game") {
         super();
         this._project = project;
      }
      
      private var _project:String;
      
      public function serialize() : String {
         return by.blooddy.crypto.serialization.JSON.encode(
            {
               "_msg_id":UpdaterMessageIDEnum.GET_COMPONENTS_LIST,
               "project":this._project
            });
      }
   }
}
