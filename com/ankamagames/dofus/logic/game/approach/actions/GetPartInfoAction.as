package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GetPartInfoAction extends Object implements Action
   {
      
      public function GetPartInfoAction() {
         super();
      }
      
      public static function create(id:String) : GetPartInfoAction {
         var a:GetPartInfoAction = new GetPartInfoAction();
         a.id = id;
         return a;
      }
      
      public var id:String;
   }
}
