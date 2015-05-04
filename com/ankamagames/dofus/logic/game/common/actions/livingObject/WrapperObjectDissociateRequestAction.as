package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class WrapperObjectDissociateRequestAction extends Object implements Action
   {
      
      public function WrapperObjectDissociateRequestAction()
      {
         super();
      }
      
      public static function create(param1:uint, param2:uint) : WrapperObjectDissociateRequestAction
      {
         var _loc3_:WrapperObjectDissociateRequestAction = new WrapperObjectDissociateRequestAction();
         _loc3_.hostUID = param1;
         _loc3_.hostPosition = param2;
         return _loc3_;
      }
      
      public var hostUID:uint;
      
      public var hostPosition:uint;
   }
}
