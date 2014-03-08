package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MimicryObjectEraseRequestAction extends Object implements Action
   {
      
      public function MimicryObjectEraseRequestAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint) : MimicryObjectEraseRequestAction {
         var _loc3_:MimicryObjectEraseRequestAction = new MimicryObjectEraseRequestAction();
         _loc3_.hostUID = param1;
         _loc3_.hostPos = param2;
         return _loc3_;
      }
      
      public var hostUID:uint;
      
      public var hostPos:uint;
   }
}
