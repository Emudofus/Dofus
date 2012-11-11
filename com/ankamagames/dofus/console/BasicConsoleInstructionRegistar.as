package com.ankamagames.dofus.console
{
    import com.ankamagames.dofus.console.debug.*;
    import com.ankamagames.jerakine.console.*;

    public class BasicConsoleInstructionRegistar extends Object implements ConsoleInstructionRegistar
    {

        public function BasicConsoleInstructionRegistar()
        {
            return;
        }// end function

        public function registerInstructions(param1:ConsoleHandler) : void
        {
            param1.addHandler("version", new VersionInstructionHandler());
            param1.addHandler("mapid", new DisplayMapInstructionHandler());
            param1.addHandler(["savereplaylog"], new MiscInstructionHandler());
            param1.addHandler(["loadui", "unloadui", "clearuicache", "useuicache", "uilist", "reloadui", "modulelist"], new UiHandlerInstructionHandler());
            param1.addHandler(["sendaction", "listactions", "sendhook"], new ActionsInstructionHandler());
            return;
        }// end function

    }
}
