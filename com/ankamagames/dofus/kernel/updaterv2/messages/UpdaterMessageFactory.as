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
      
      public static function getUpdaterMessage(param1:Object) : IUpdaterInputMessage {
         var _loc2_:IUpdaterInputMessage = null;
         switch(param1["_msg_id"])
         {
            case UpdaterMessageIDEnum.STEP:
               _loc2_ = new StepMessage();
               break;
            case UpdaterMessageIDEnum.PROGRESS:
               _loc2_ = new ProgressMessage();
               break;
            case UpdaterMessageIDEnum.FINISHED:
               _loc2_ = new FinishedMessage();
               break;
            case UpdaterMessageIDEnum.COMPONENTS_LIST:
               _loc2_ = new ComponentListMessage();
               break;
            case UpdaterMessageIDEnum.ERROR_MESSAGE:
               _loc2_ = new ErrorMessage();
               break;
         }
         if(_loc2_)
         {
            _loc2_.deserialize(param1);
         }
         return _loc2_;
      }
   }
}
