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
      
      public function ServerSimpleSelectionStats(param1:UiRootContainer)
      {
         super();
         this._action = StatsAction.get(StatisticTypeEnum.STEP0100_CHOSE_SERVER);
         this._action.start();
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(ServerSimpleSelectionStats));
      
      private var _action:StatsAction;
      
      public function process(param1:Message) : void
      {
         var _loc2_:MouseClickMessage = null;
         var _loc3_:ServerSelectionAction = null;
         switch(true)
         {
            case param1 is MouseClickMessage:
               _loc2_ = param1 as MouseClickMessage;
               if(_loc2_.target.name == "btn_ok" && (Berilia.getInstance().getUi("serverPopup")))
               {
                  this._action.addParam("Automatic_Choice",true);
               }
               break;
            case param1 is ServerSelectionAction:
               _loc3_ = param1 as ServerSelectionAction;
               this._action.addParam("Chosen_Server_ID",_loc3_.serverId);
               if(!this._action.hasParam("Seek_A_Friend"))
               {
                  this._action.addParam("Seek_A_Friend",false);
               }
               this._action.send();
               break;
         }
      }
      
      public function onHook(param1:Hook, param2:Array) : void
      {
      }
      
      public function remove() : void
      {
      }
   }
}
