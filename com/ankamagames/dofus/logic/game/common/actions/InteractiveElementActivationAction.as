package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class InteractiveElementActivationAction extends Object implements Action
   {
      
      public function InteractiveElementActivationAction() {
         super();
      }
      
      public static function create(ie:InteractiveElement, position:MapPoint, skillInstanceId:uint) : InteractiveElementActivationAction {
         var a:InteractiveElementActivationAction = new InteractiveElementActivationAction();
         a.interactiveElement = ie;
         a.position = position;
         a.skillInstanceId = skillInstanceId;
         return a;
      }
      
      public var interactiveElement:InteractiveElement;
      
      public var position:MapPoint;
      
      public var skillInstanceId:uint;
   }
}
