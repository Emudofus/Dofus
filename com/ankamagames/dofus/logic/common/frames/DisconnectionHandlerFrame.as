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
      
      public function process(param1:Message) : Boolean {
         var _loc2_:ServerConnectionClosedMessage = null;
         var _loc3_:WrongSocketClosureReasonMessage = null;
         var _loc4_:UnexpectedSocketClosureMessage = null;
         var _loc5_:ResetGameAction = null;
         var _loc6_:Object = null;
         var _loc7_:DisconnectionReason = null;
         var _loc8_:Array = null;
         switch(true)
         {
            case param1 is ServerConnectionClosedMessage:
               _loc2_ = param1 as ServerConnectionClosedMessage;
               if(_loc2_.closedConnection == ConnectionsHandler.getConnection().getSubConnection(_loc2_))
               {
                  _log.trace("The connection was closed. Checking reasons.");
                  if(ConnectionsHandler.hasReceivedMsg)
                  {
                     _loc7_ = ConnectionsHandler.handleDisconnection();
                     if(!_loc7_.expected)
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
                        _log.trace("The connection closure was expected (reason: " + _loc7_.reason + "). Dispatching the message.");
                        if(_loc7_.reason == DisconnectionReasonEnum.DISCONNECTED_BY_POPUP || _loc7_.reason == DisconnectionReasonEnum.SWITCHING_TO_HUMAN_VENDOR)
                        {
                           Kernel.getInstance().reset();
                        }
                        else
                        {
                           Kernel.getWorker().process(new ExpectedSocketClosureMessage(_loc7_.reason));
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
            case param1 is WrongSocketClosureReasonMessage:
               _loc3_ = param1 as WrongSocketClosureReasonMessage;
               _log.error("Expecting socket closure for reason " + _loc3_.expectedReason + ", got reason " + _loc3_.gotReason + "! Reseting.");
               Kernel.getInstance().reset([new UnexpectedSocketClosureMessage()]);
               return true;
            case param1 is UnexpectedSocketClosureMessage:
               _loc4_ = param1 as UnexpectedSocketClosureMessage;
               _log.debug("go hook UnexpectedSocketClosure");
               KernelEventsManager.getInstance().processCallback(HookList.UnexpectedSocketClosure);
               return true;
            case param1 is ResetGameAction:
               _loc5_ = param1 as ResetGameAction;
               _log.fatal("ResetGameAction");
               SoundManager.getInstance().manager.removeAllSounds();
               ConnectionsHandler.closeConnection();
               if(_loc5_.messageToShow != "")
               {
                  _loc8_ = [OpenPopupAction.create(_loc5_.messageToShow)];
                  Kernel.getInstance().reset(_loc8_);
               }
               else
               {
                  Kernel.getInstance().reset();
               }
               return true;
            case param1 is OpenPopupAction:
               _loc6_ = UiModuleManager.getInstance().getModule("Ankama_Common");
               if(_loc6_ == null)
               {
                  messagesAfterReset.push(param1);
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(HookList.InformationPopup,[(param1 as OpenPopupAction).messageToShow]);
               }
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
