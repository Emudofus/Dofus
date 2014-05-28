package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MountInformationInPaddockRequestAction extends Object implements Action
   {
      
      public function MountInformationInPaddockRequestAction() {
         super();
      }
      
      public static function create(mountId:uint) : MountInformationInPaddockRequestAction {
         var act:MountInformationInPaddockRequestAction = new MountInformationInPaddockRequestAction();
         act.mountId = mountId;
         return act;
      }
      
      public var mountId:uint;
   }
}
