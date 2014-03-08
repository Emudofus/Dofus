package com.ankamagames.dofus.logic.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.network.messages.ServerConnectionClosedMessage;
   import com.ankamagames.jerakine.network.messages.WrongSocketClosureReasonMessage;
   import com.ankamagames.jerakine.network.messages.UnexpectedSocketClosureMessage;
   import com.ankamagames.dofus.logic.common.actions.ResetGameAction;
   import com.ankamagames.dofus.kernel.net.DisconnectionReason;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.DisconnectionReasonEnum;
   import com.ankamagames.jerakine.network.messages.ExpectedSocketClosureMessage;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.dofus.logic.common.actions.OpenPopupAction;
   import com.ankamagames.berilia.managers.UiModuleManager;
   
   public class DisconnectionHandlerFrame extends Object implements Frame
   {
      
      public function DisconnectionHandlerFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DisconnectionHandlerFrame));
      
      public static var messagesAfterReset:Array = new Array();
      
      public function get priority() : int {
         return Priority.LOW;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         var sccmsg:ServerConnectionClosedMessage = null;
         var wscrmsg:WrongSocketClosureReasonMessage = null;
         var uscmsg:UnexpectedSocketClosureMessage = null;
         var rgamsg:ResetGameAction = null;
         var commonMod:Object = null;
         var reason:DisconnectionReason = null;
         var tabMsg:Array = null;
         switch(true)
         {
            case msg is ServerConnectionClosedMessage:
               sccmsg = msg as ServerConnectionClosedMessage;
               if(sccmsg.closedConnection == ConnectionsHandler.getConnection().getSubConnection(sccmsg))
               {
                  _log.trace("The connection was closed. Checking reasons.");
                  if(ConnectionsHandler.hasReceivedMsg)
                  {
                     reason = ConnectionsHandler.handleDisconnection();
                     if(!reason.expected)
                     {
                        _log.warn("The connection was closed unexpectedly. Reseting.");
                        if(messagesAfterReset.length == 0)
                        {
                           messagesAfterReset.unshift(new UnexpectedSocketClosureMessage());
                        }
                        Kernel.getInstance().reset();
                     }
                     else
                     {
                        _log.trace("The connection closure was expected (reason: " + reason.reason + "). Dispatching the message.");
                        if((reason.reason == DisconnectionReasonEnum.DISCONNECTED_BY_POPUP) || (reason.reason == DisconnectionReasonEnum.SWITCHING_TO_HUMAN_VENDOR))
                        {
                           Kernel.getInstance().reset();
                        }
                        else
                        {
                           Kernel.getWorker().process(new ExpectedSocketClosureMessage(reason.reason));
                        }
                     }
                  }
                  else
                  {
                     _log.warn("The connection hasn\'t even start.");
                     KernelEventsManager.getInstance().processCallback(HookList.ServerConnectionFailed,DisconnectionReasonEnum.NEVER_CONNECTED);
                  }
               }
               return true;
            case msg is WrongSocketClosureReasonMessage:
               wscrmsg = msg as WrongSocketClosureReasonMessage;
               _log.error("Expecting socket closure for reason " + wscrmsg.expectedReason + ", got reason " + wscrmsg.gotReason + "! Reseting.");
               Kernel.getInstance().reset([new UnexpectedSocketClosureMessage()]);
               return true;
            case msg is UnexpectedSocketClosureMessage:
               uscmsg = msg as UnexpectedSocketClosureMessage;
               _log.debug("go hook UnexpectedSocketClosure");
               KernelEventsManager.getInstance().processCallback(HookList.UnexpectedSocketClosure);
               return true;
            case msg is ResetGameAction:
               rgamsg = msg as ResetGameAction;
               _log.fatal("ResetGameAction");
               SoundManager.getInstance().manager.removeAllSounds();
               ConnectionsHandler.closeConnection();
               if(rgamsg.messageToShow != "")
               {
                  tabMsg = [OpenPopupAction.create(rgamsg.messageToShow)];
                  Kernel.getInstance().reset(tabMsg);
               }
               else
               {
                  Kernel.getInstance().reset();
               }
               return true;
            case msg is OpenPopupAction:
               commonMod = UiModuleManager.getInstance().getModule("Ankama_Common");
               if(commonMod == null)
               {
                  messagesAfterReset.push(msg);
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(HookList.InformationPopup,[(msg as OpenPopupAction).messageToShow]);
               }
               return true;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
   }
}
