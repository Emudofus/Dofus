package com.ankamagames.dofus.misc.stats.ui
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.dofus.logic.connection.actions.ServerSelectionAction;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.types.data.Hook;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.network.enums.StatisticTypeEnum;
   
   public class ServerSimpleSelectionStats extends Object implements IUiStats
   {
      
      public function ServerSimpleSelectionStats(pUi:UiRootContainer) {
         super();
         this._action = StatsAction.get(StatisticTypeEnum.STEP0100_CHOSE_SERVER);
         this._action.start();
      }
      
      private static const _log:Logger;
      
      private var _action:StatsAction;
      
      public function process(pMessage:Message) : void {
         var mcmsg:MouseClickMessage = null;
         var ssaction:ServerSelectionAction = null;
         switch(true)
         {
            case pMessage is MouseClickMessage:
               mcmsg = pMessage as MouseClickMessage;
               if((mcmsg.target.name == "btn_ok") && (Berilia.getInstance().getUi("serverPopup")))
               {
                  this._action.addParam("Automatic_Choice",true);
               }
               break;
            case pMessage is ServerSelectionAction:
               ssaction = pMessage as ServerSelectionAction;
               this._action.addParam("Chosen_Server_ID",ssaction.serverId);
               if(!this._action.hasParam("Seek_A_Friend"))
               {
                  this._action.addParam("Seek_A_Friend",false);
               }
               this._action.send();
               break;
         }
      }
      
      public function onHook(pHook:Hook, pArgs:Array) : void {
      }
      
      public function remove() : void {
      }
   }
}
