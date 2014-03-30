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
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void {
         var player:String = null;
         var option:uint = 0;
         var gfotmsg:GameFightOptionToggleMessage = null;
         var fighterId:* = 0;
         var gckmsg:GameContextKickMessage = null;
         switch(cmd)
         {
            case "s":
            case "spectator":
               if(PlayedCharacterManager.getInstance().isFighting)
               {
                  option = FightOptionsEnum.FIGHT_OPTION_SET_SECRET;
                  gfotmsg = new GameFightOptionToggleMessage();
                  gfotmsg.initGameFightOptionToggleMessage(option);
                  ConnectionsHandler.getConnection().send(gfotmsg);
               }
               break;
            case "list":
               this.listFighters(console);
               break;
            case "players":
               this.listFighters(console);
               break;
            case "kick":
               if(args.length != 2)
               {
                  return;
               }
               player = args[1];
               if(FightContextFrame.preFightIsActive)
               {
                  fighterId = this.getFighterId(player);
                  if(fighterId != 0)
                  {
                     gckmsg = new GameContextKickMessage();
                     gckmsg.initGameContextKickMessage(1);
                     ConnectionsHandler.getConnection().send(gckmsg);
                  }
               }
               break;
         }
      }
      
      private function getFighterId(name:String) : int {
         var fighterId:* = 0;
         var fightFrame:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         var fighters:Vector.<int> = fightFrame.battleFrame.fightersList;
         for each (fighterId in fighters)
         {
            if(fightFrame.getFighterName(fighterId) == name)
            {
               return fighterId;
            }
         }
         return 0;
      }
      
      private function listFighters(console:ConsoleHandler) : void {
         var fightFrame:FightContextFrame = null;
         var fighters:Vector.<int> = null;
         var fighterId:* = 0;
         if(PlayedCharacterManager.getInstance().isFighting)
         {
            fightFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
            fighters = fightFrame.battleFrame.fightersList;
            for each (fighterId in fighters)
            {
               console.output(fightFrame.getFighterName(fighterId));
            }
         }
      }
      
      public function getHelp(cmd:String) : String {
         switch(cmd)
         {
            case "spectator":
               return I18n.getUiText("ui.chat.console.help.spectator");
            case "list":
               return I18n.getUiText("ui.chat.console.help.list");
            case "players":
               return I18n.getUiText("ui.chat.console.help.list");
            case "kick":
               return I18n.getUiText("ui.chat.console.help.kick");
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null) : Array {
         return [];
      }
   }
}
