package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AddEnemyAction extends Object implements Action
   {
      
      public function AddEnemyAction() {
         super();
      }
      
      public static function create(name:String) : AddEnemyAction {
         var a:AddEnemyAction = new AddEnemyAction();
         a.name = name;
         return a;
      }
      
      public var name:String;
   }
}
