package com.ankamagames.dofus.console.chat
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightOptionToggleMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextKickMessage;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.enums.FightOptionsEnum;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.data.I18n;
   
   public class FightInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function FightInstructionHandler() {
         super();
      }
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void {
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         var _loc6_:GameFightOptionToggleMessage = null;
         var _loc7_:* = 0;
         var _loc8_:GameContextKickMessage = null;
         switch(param2)
         {
            case "spectator":
               if(PlayedCharacterManager.getInstance().isFighting)
               {
                  _loc5_ = FightOptionsEnum.FIGHT_OPTION_SET_SECRET;
                  _loc6_ = new GameFightOptionToggleMessage();
                  _loc6_.initGameFightOptionToggleMessage(_loc5_);
                  ConnectionsHandler.getConnection().send(_loc6_);
               }
               break;
            case "list":
               this.listFighters(param1);
               break;
            case "players":
               this.listFighters(param1);
               break;
            case "kick":
               if(param3.length != 2)
               {
                  return;
               }
               _loc4_ = param3[1];
               if(FightContextFrame.preFightIsActive)
               {
                  _loc7_ = this.getFighterId(_loc4_);
                  if(_loc7_ != 0)
                  {
                     _loc8_ = new GameContextKickMessage();
                     _loc8_.initGameContextKickMessage(1);
                     ConnectionsHandler.getConnection().send(_loc8_);
                  }
               }
               break;
         }
      }
      
      private function getFighterId(param1:String) : int {
         var _loc4_:* = 0;
         var _loc2_:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         var _loc3_:Vector.<int> = _loc2_.battleFrame.fightersList;
         for each (_loc4_ in _loc3_)
         {
            if(_loc2_.getFighterName(_loc4_) == param1)
            {
               return _loc4_;
            }
         }
         return 0;
      }
      
      private function listFighters(param1:ConsoleHandler) : void {
         var _loc2_:FightContextFrame = null;
         var _loc3_:Vector.<int> = null;
         var _loc4_:* = 0;
         if(PlayedCharacterManager.getInstance().isFighting)
         {
            _loc2_ = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
            _loc3_ = _loc2_.battleFrame.fightersList;
            for each (_loc4_ in _loc3_)
            {
               param1.output(_loc2_.getFighterName(_loc4_));
            }
         }
      }
      
      public function getHelp(param1:String) : String {
         switch(param1)
         {
            case "spectator":
               return I18n.getUiText("ui.chat.console.help.spectator");
            case "list":
               return I18n.getUiText("ui.chat.console.help.list");
            case "players":
               return I18n.getUiText("ui.chat.console.help.list");
            case "kick":
               return I18n.getUiText("ui.chat.console.help.kick");
            default:
               return I18n.getUiText("ui.chat.console.noHelp",[param1]);
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint=0, param3:Array=null) : Array {
         return [];
      }
   }
}
