package com.ankamagames.dofus.console.chat
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.context.*;
    import com.ankamagames.dofus.network.messages.game.context.fight.*;
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.data.*;

    public class FightInstructionHandler extends Object implements ConsoleInstructionHandler
    {

        public function FightInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            switch(param2)
            {
                case "spectator":
                {
                    if (PlayedCharacterManager.getInstance().isFighting)
                    {
                        _loc_5 = FightOptionsEnum.FIGHT_OPTION_SET_SECRET;
                        _loc_6 = new GameFightOptionToggleMessage();
                        _loc_6.initGameFightOptionToggleMessage(_loc_5);
                        ConnectionsHandler.getConnection().send(_loc_6);
                    }
                    break;
                }
                case "list":
                {
                    this.listFighters(param1);
                    break;
                }
                case "players":
                {
                    this.listFighters(param1);
                    break;
                }
                case "kick":
                {
                    if (param3.length != 2)
                    {
                        return;
                    }
                    _loc_4 = param3[1];
                    if (FightContextFrame.preFightIsActive)
                    {
                        _loc_7 = this.getFighterId(_loc_4);
                        if (_loc_7 != 0)
                        {
                            _loc_8 = new GameContextKickMessage();
                            _loc_8.initGameContextKickMessage(1);
                            ConnectionsHandler.getConnection().send(_loc_8);
                        }
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function getFighterId(param1:String) : int
        {
            var _loc_4:* = 0;
            var _loc_2:* = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
            var _loc_3:* = _loc_2.battleFrame.fightersList;
            for each (_loc_4 in _loc_3)
            {
                
                if (_loc_2.getFighterName(_loc_4) == param1)
                {
                    return _loc_4;
                }
            }
            return 0;
        }// end function

        private function listFighters(param1:ConsoleHandler) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            if (PlayedCharacterManager.getInstance().isFighting)
            {
                _loc_2 = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
                _loc_3 = _loc_2.battleFrame.fightersList;
                for each (_loc_4 in _loc_3)
                {
                    
                    param1.output(_loc_2.getFighterName(_loc_4));
                }
            }
            return;
        }// end function

        public function getHelp(param1:String) : String
        {
            switch(param1)
            {
                case "spectator":
                {
                    return I18n.getUiText("ui.chat.console.help.spectator");
                }
                case "list":
                {
                    return I18n.getUiText("ui.chat.console.help.list");
                }
                case "players":
                {
                    return I18n.getUiText("ui.chat.console.help.list");
                }
                case "kick":
                {
                    return I18n.getUiText("ui.chat.console.help.kick");
                }
                default:
                {
                    break;
                }
            }
            return I18n.getUiText("ui.chat.console.noHelp", [param1]);
        }// end function

        public function getParamPossibilities(param1:String, param2:uint = 0, param3:Array = null) : Array
        {
            return [];
        }// end function

    }
}
