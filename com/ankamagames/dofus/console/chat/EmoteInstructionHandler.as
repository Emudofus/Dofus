package com.ankamagames.dofus.console.chat
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmotePlayRequestMessage;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.enums.PlayerLifeStatusEnum;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;


   public class EmoteInstructionHandler extends Object implements ConsoleInstructionHandler
   {
         

      public function EmoteInstructionHandler() {
         super();
      }



      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void {
         var eprmsg:EmotePlayRequestMessage = null;
         var playerManager:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         if((playerManager.state==PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING)&&(playerManager.isRidding)||(playerManager.isPetsMounting)||(playerManager.infos.entityLook.bonesId==1))
         {
            eprmsg=new EmotePlayRequestMessage();
            eprmsg.initEmotePlayRequestMessage(this.getEmoteId(cmd));
            ConnectionsHandler.getConnection().send(eprmsg);
         }
      }

      public function getHelp(cmd:String) : String {
         return null;
      }

      private function getEmoteId(cmd:String) : uint {
         var emote:Emoticon = null;
         for each (emote in Emoticon.getEmoticons())
         {
            if(emote.shortcut==cmd)
            {
               return emote.id;
            }
            if(emote.defaultAnim==cmd)
            {
               return emote.id;
            }
         }
         return 0;
      }

      public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null) : Array {
         return [];
      }
   }

}