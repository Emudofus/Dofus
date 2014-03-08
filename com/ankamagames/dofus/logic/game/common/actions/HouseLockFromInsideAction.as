package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseLockFromInsideAction extends Object implements Action
   {
      
      public function HouseLockFromInsideAction() {
         super();
      }
      
      public static function create(param1:String) : HouseLockFromInsideAction {
         var _loc2_:HouseLockFromInsideAction = new HouseLockFromInsideAction();
         _loc2_.code = param1;
         return _loc2_;
      }
      
      public var code:String;
   }
}
