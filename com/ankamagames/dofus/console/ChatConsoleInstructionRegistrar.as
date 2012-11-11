package com.ankamagames.dofus.console
{
    import com.ankamagames.dofus.console.chat.*;
    import com.ankamagames.dofus.console.common.*;
    import com.ankamagames.dofus.console.debug.*;
    import com.ankamagames.dofus.datacenter.communication.*;
    import com.ankamagames.jerakine.console.*;

    public class ChatConsoleInstructionRegistrar extends Object implements ConsoleInstructionRegistar
    {

        public function ChatConsoleInstructionRegistrar()
        {
            return;
        }// end function

        public function registerInstructions(param1:ConsoleHandler) : void
        {
            var _loc_3:* = undefined;
            var _loc_2:* = new Array();
            for each (_loc_3 in Emoticon.getEmoticons())
            {
                
                _loc_2.push(_loc_3.shortcut);
            }
            param1.addHandler(["whois", "version", "ver", "about", "whoami", "mapid", "cellid", "time", "mlog"], new InfoInstructionHandler());
            param1.addHandler(["aping", "ping"], new LatencyInstructionHandler());
            param1.addHandler(["f", "ignore", "invite"], new SocialInstructionHandler());
            param1.addHandler(["w", "whisper", "msg", "t", "g", "p", "a", "r", "b", "m"], new MessagingInstructionHandler());
            param1.addHandler(["spectator", "list", "players", "kick"], new FightInstructionHandler());
            param1.addHandler(_loc_2, new EmoteInstructionHandler());
            param1.addHandler(["tab", "clear"], new OptionsInstructionHandler());
            param1.addHandler(["savereplaylog"], new MiscInstructionHandler());
            param1.addHandler(["away", "invisible", "release"], new StatusInstructionHandler());
            return;
        }// end function

    }
}
