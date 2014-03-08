package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ValidateSpellForgetAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.spell.ValidateSpellForgetMessage;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   
   public class SpellForgetDialogFrame extends Object implements Frame
   {
      
      public function SpellForgetDialogFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellForgetDialogFrame));
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         var vsfa:ValidateSpellForgetAction = null;
         var vsfmsg:ValidateSpellForgetMessage = null;
         var ldm:LeaveDialogMessage = null;
         switch(true)
         {
            case msg is ValidateSpellForgetAction:
               vsfa = msg as ValidateSpellForgetAction;
               vsfmsg = new ValidateSpellForgetMessage();
               vsfmsg.initValidateSpellForgetMessage(vsfa.spellId);
               ConnectionsHandler.getConnection().send(vsfmsg);
               return true;
            case msg is LeaveDialogMessage:
               ldm = msg as LeaveDialogMessage;
               if(ldm.dialogType == DialogTypeEnum.DIALOG_SPELL_FORGET)
               {
                  Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
                  Kernel.getWorker().removeFrame(this);
               }
               return true;
         }
      }
      
      public function pulled() : Boolean {
         KernelEventsManager.getInstance().processCallback(HookList.LeaveDialog);
         return true;
      }
   }
}
