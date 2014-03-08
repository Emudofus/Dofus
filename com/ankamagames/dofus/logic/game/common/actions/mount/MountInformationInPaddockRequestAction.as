package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MountInformationInPaddockRequestAction extends Object implements Action
   {
      
      public function MountInformationInPaddockRequestAction() {
         super();
      }
      
      public static function create(param1:uint) : MountInformationInPaddockRequestAction {
         var _loc2_:MountInformationInPaddockRequestAction = new MountInformationInPaddockRequestAction();
         _loc2_.mountId = param1;
         return _loc2_;
      }
      
      public var mountId:uint;
   }
}
