package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ContactLookRequestByIdAction extends Object implements Action
   {
      
      public function ContactLookRequestByIdAction() {
         super();
      }
      
      public static function create(pContactType:uint, pEntityId:uint) : ContactLookRequestByIdAction {
         var clrbia:ContactLookRequestByIdAction = new ContactLookRequestByIdAction();
         clrbia._contactType = pContactType;
         clrbia._entityId = pEntityId;
         return clrbia;
      }
      
      private var _contactType:uint;
      
      public function get contactType() : uint {
         return this._contactType;
      }
      
      private var _entityId:uint;
      
      public function get entityId() : uint {
         return this._entityId;
      }
   }
}
