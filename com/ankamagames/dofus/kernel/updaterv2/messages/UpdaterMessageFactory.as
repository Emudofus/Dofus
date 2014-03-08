package com.ankamagames.dofus.kernel.updaterv2.messages
{
   import com.ankamagames.dofus.kernel.updaterv2.messages.impl.StepMessage;
   import com.ankamagames.dofus.kernel.updaterv2.messages.impl.ProgressMessage;
   import com.ankamagames.dofus.kernel.updaterv2.messages.impl.FinishedMessage;
   import com.ankamagames.dofus.kernel.updaterv2.messages.impl.ComponentListMessage;
   import com.ankamagames.dofus.kernel.updaterv2.messages.impl.ErrorMessage;
   
   public class UpdaterMessageFactory extends Object
   {
      
      public function UpdaterMessageFactory() {
         super();
      }
      
      public static function getUpdaterMessage(msg:Object) : IUpdaterInputMessage {
         var uim:IUpdaterInputMessage = null;
         switch(msg["_msg_id"])
         {
            case UpdaterMessageIDEnum.STEP:
               uim = new StepMessage();
               break;
            case UpdaterMessageIDEnum.PROGRESS:
               uim = new ProgressMessage();
               break;
            case UpdaterMessageIDEnum.FINISHED:
               uim = new FinishedMessage();
               break;
            case UpdaterMessageIDEnum.COMPONENTS_LIST:
               uim = new ComponentListMessage();
               break;
            case UpdaterMessageIDEnum.ERROR_MESSAGE:
               uim = new ErrorMessage();
               break;
         }
         if(uim)
         {
            uim.deserialize(msg);
         }
         return uim;
      }
   }
}
