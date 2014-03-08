package com.ankamagames.dofus.console
{
   import com.ankamagames.jerakine.console.ConsoleInstructionRegistar;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.dofus.console.chat.InfoInstructionHandler;
   import com.ankamagames.dofus.console.common.LatencyInstructionHandler;
   import com.ankamagames.dofus.console.chat.SocialInstructionHandler;
   import com.ankamagames.dofus.console.chat.MessagingInstructionHandler;
   import com.ankamagames.dofus.console.chat.FightInstructionHandler;
   import com.ankamagames.dofus.console.chat.EmoteInstructionHandler;
   import com.ankamagames.dofus.console.chat.OptionsInstructionHandler;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.console.debug.MiscInstructionHandler;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.console.chat.StatusInstructionHandler;
   
   public class ChatConsoleInstructionRegistrar extends Object implements ConsoleInstructionRegistar
   {
      
      public function ChatConsoleInstructionRegistrar() {
         super();
      }
      
      public function registerInstructions(param1:ConsoleHandler) : void {
         var _loc3_:* = undefined;
         var _loc2_:Array = new Array();
         for each (_loc3_ in Emoticon.getEmoticons())
         {
            _loc2_.push(_loc3_.shortcut);
         }
         param1.addHandler(["whois","version","ver","about","whoami","mapid","cellid","time","mlog"],new InfoInstructionHandler());
         param1.addHandler(["aping","ping"],new LatencyInstructionHandler());
         param1.addHandler(["f","ignore","invite"],new SocialInstructionHandler());
         param1.addHandler(["w","whisper","msg","t","g","p","a","r","b","m"],new MessagingInstructionHandler());
         param1.addHandler(["spectator","list","players","kick"],new FightInstructionHandler());
         param1.addHandler(_loc2_,new EmoteInstructionHandler());
         param1.addHandler(["tab","clear"],new OptionsInstructionHandler());
         if(BuildInfos.BUILD_TYPE != BuildTypeEnum.RELEASE)
         {
            param1.addHandler(["savereplaylog","sd","showsmilies","shieldmax","shieldmoy","shieldmin"],new MiscInstructionHandler());
         }
         else
         {
            param1.addHandler(["savereplaylog","showsmilies","shieldmax","shieldmoy","shieldmin"],new MiscInstructionHandler());
         }
         param1.addHandler(["away",I18n.getUiText("ui.chat.status.away").toLocaleLowerCase(),I18n.getUiText("ui.chat.status.solo").toLocaleLowerCase(),I18n.getUiText("ui.chat.status.private").toLocaleLowerCase(),I18n.getUiText("ui.chat.status.availiable").toLocaleLowerCase(),"invisible","release"],new StatusInstructionHandler());
      }
   }
}
