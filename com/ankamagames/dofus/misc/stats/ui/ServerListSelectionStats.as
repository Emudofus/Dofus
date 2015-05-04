package com.ankamagames.dofus.misc.stats.ui
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.connection.actions.ServerSelectionAction;
   import com.ankamagames.dofus.logic.connection.actions.AcquaintanceSearchAction;
   import com.ankamagames.berilia.types.data.Hook;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.network.enums.StatisticTypeEnum;
   
   public class ServerListSelectionStats extends Object implements IUiStats
   {
      
      public function ServerListSelectionStats(param1:UiRootContainer)
      {
         super();
         this._action = StatsAction.get(StatisticTypeEnum.STEP0100_CHOSE_SERVER);
         this._action.start();
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(ServerListSelectionStats));
      
      private var _action:StatsAction;
      
      public function process(param1:Message) : void
      {
         var _loc2_:ServerSelectionAction = null;
         switch(true)
         {
            case param1 is AcquaintanceSearchAction:
               this._action.addParam("Seek_A_Friend",true);
               break;
            case param1 is ServerSelectionAction:
               _loc2_ = param1 as ServerSelectionAction;
               this._action.addParam("Chosen_Server_ID",_loc2_.serverId);
               this._action.addParam("Automatic_Choice",false);
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
