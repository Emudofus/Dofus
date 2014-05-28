package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.context.GameContextCreateMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextQuitMessage;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.GameContextEnum;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.kernel.PanicMessages;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.actions.GameContextQuitAction;
   
   public class ContextChangeFrame extends Object implements Frame
   {
      
      public function ContextChangeFrame() {
         super();
      }
      
      protected static const _log:Logger;
      
      public function get priority() : int {
         return Priority.LOW;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         var gccmsg:GameContextCreateMessage = null;
         var gcqmsg:GameContextQuitMessage = null;
         switch(true)
         {
            case msg is GameContextCreateMessage:
               gccmsg = msg as GameContextCreateMessage;
               switch(gccmsg.context)
               {
                  case GameContextEnum.ROLE_PLAY:
                     Kernel.getWorker().addFrame(new RoleplayContextFrame());
                     KernelEventsManager.getInstance().processCallback(HookList.ContextChanged,GameContextEnum.ROLE_PLAY);
                     break;
                  case GameContextEnum.FIGHT:
                     Kernel.getWorker().addFrame(new FightContextFrame());
                     KernelEventsManager.getInstance().processCallback(HookList.ContextChanged,GameContextEnum.FIGHT);
                     break;
                  default:
                     Kernel.panic(PanicMessages.WRONG_CONTEXT_CREATED,[gccmsg.context]);
               }
               return true;
            case msg is GameContextQuitAction:
               gcqmsg = new GameContextQuitMessage();
               ConnectionsHandler.getConnection().send(gcqmsg);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
   }
}
