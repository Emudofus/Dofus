package com.ankamagames.dofus.misc.stats.ui
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.berilia.types.data.Hook;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.network.enums.StatisticTypeEnum;
   
   public class NicknameRegistrationStats extends Object implements IUiStats
   {
      
      public function NicknameRegistrationStats(pUi:UiRootContainer) {
         super();
         this._action = StatsAction.get(StatisticTypeEnum.STEP0000_CHOSE_NICKNAME);
         this._action.start();
      }
      
      private static const _log:Logger;
      
      private var _action:StatsAction;
      
      public function process(pMessage:Message) : void {
         var mcmsg:MouseClickMessage = null;
         switch(true)
         {
            case pMessage is MouseClickMessage:
               mcmsg = pMessage as MouseClickMessage;
               if(mcmsg.target.name == "btn_validate")
               {
                  this._action.send();
               }
               break;
         }
      }
      
      public function onHook(pHook:Hook, pArgs:Array) : void {
      }
      
      public function remove() : void {
      }
   }
}
