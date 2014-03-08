package com.ankamagames.dofus.logic.connection.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Timer;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.handshake.ProtocolRequired;
   import com.ankamagames.dofus.logic.common.frames.AuthorizedFrame;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.Metadata;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.PanicMessages;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.jerakine.data.I18n;
   import flash.events.TimerEvent;
   import com.ankamagames.jerakine.messages.ConnectedMessage;
   import com.ankamagames.dofus.network.messages.common.basic.BasicPingMessage;
   
   public class HandshakeFrame extends Object implements Frame
   {
      
      public function HandshakeFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HandshakeFrame));
      
      private var _timeOutTimer:Timer;
      
      public function get priority() : int {
         return Priority.HIGHEST;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:ProtocolRequired = null;
         var _loc3_:AuthorizedFrame = null;
         var _loc4_:Object = null;
         ConnectionsHandler.hasReceivedMsg = true;
         if(param1 is INetworkMessage && (this._timeOutTimer))
         {
            this._timeOutTimer.stop();
         }
         switch(true)
         {
            case param1 is ProtocolRequired:
               _loc2_ = param1 as ProtocolRequired;
               if(_loc2_.requiredVersion > Metadata.PROTOCOL_BUILD)
               {
                  _log.fatal("Current protocol build is " + Metadata.PROTOCOL_BUILD + ", required build is " + _loc2_.requiredVersion + ".");
                  Kernel.panic(PanicMessages.PROTOCOL_TOO_OLD,[Metadata.PROTOCOL_BUILD,_loc2_.requiredVersion]);
               }
               if(_loc2_.currentVersion < Metadata.PROTOCOL_REQUIRED_BUILD)
               {
                  _log.fatal("Current protocol build (" + Metadata.PROTOCOL_BUILD + ") is too new for the server version (" + _loc2_.currentVersion + ").");
                  _loc3_ = Kernel.getWorker().getFrame(AuthorizedFrame) as AuthorizedFrame;
                  if(BuildInfos.BUILD_TYPE >= BuildTypeEnum.TESTING || (_loc3_.isFantomas()))
                  {
                     _loc4_ = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                     _loc4_.openPopup(I18n.getUiText("ui.popup.warning"),I18n.getUiText("ui.popup.protocolError",[Metadata.PROTOCOL_BUILD,_loc2_.currentVersion]),[I18n.getUiText("ui.common.ok")]);
                  }
               }
               Kernel.getWorker().removeFrame(this);
               return true;
            case param1 is ConnectedMessage:
               this._timeOutTimer = new Timer(3000,1);
               this._timeOutTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeOut);
               this._timeOutTimer.start();
               return true;
            default:
               return false;
         }
      }
      
      public function onTimeOut(param1:TimerEvent) : void {
         var _loc2_:BasicPingMessage = new BasicPingMessage();
         _loc2_.initBasicPingMessage(true);
         ConnectionsHandler.getConnection().send(_loc2_);
      }
      
      public function pulled() : Boolean {
         if(this._timeOutTimer)
         {
            this._timeOutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeOut);
         }
         return true;
      }
   }
}
