package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GetPartInfoAction extends Object implements Action
   {
      
      public function GetPartInfoAction() {
         super();
      }
      
      public static function create(param1:String) : GetPartInfoAction {
         var _loc2_:GetPartInfoAction = new GetPartInfoAction();
         _loc2_.id = param1;
         return _loc2_;
      }
      
      public var id:String;
   }
}
