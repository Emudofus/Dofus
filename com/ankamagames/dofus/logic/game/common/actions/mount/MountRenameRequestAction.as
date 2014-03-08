package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MountRenameRequestAction extends Object implements Action
   {
      
      public function MountRenameRequestAction() {
         super();
      }
      
      public static function create(param1:String, param2:Number) : MountRenameRequestAction {
         var _loc3_:MountRenameRequestAction = new MountRenameRequestAction();
         _loc3_.newName = param1;
         _loc3_.mountId = param2;
         return _loc3_;
      }
      
      public var newName:String;
      
      public var mountId:Number;
   }
}
