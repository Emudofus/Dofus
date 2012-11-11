package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.dofus.datacenter.spells.*;
    import com.ankamagames.jerakine.console.*;

    public class FightInstructionHandler extends Object implements ConsoleInstructionHandler
    {

        public function FightInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            switch(param2)
            {
                case "setspellscript":
                {
                    if (param3.length == 2 || param3.length == 3)
                    {
                        _loc_4 = Spell.getSpellById(parseInt(param3[0]));
                        if (!_loc_4)
                        {
                            param1.output("Spell " + param3[0] + " doesn\'t exist");
                        }
                        else
                        {
                            _loc_4.scriptId = parseInt(param3[1]);
                            if (param3.length == 3)
                            {
                                _loc_4.scriptIdCritical = parseInt(param3[2]);
                            }
                        }
                    }
                    else
                    {
                        param1.output("Param count error : #1 Spell id, #2 script id, #3 script id (critical hit)");
                    }
                    break;
                }
                case "setspellscriptparam":
                {
                    if (param3.length == 2 || param3.length == 3)
                    {
                        _loc_5 = Spell.getSpellById(parseInt(param3[0]));
                        if (!_loc_5)
                        {
                            param1.output("Spell " + param3[0] + " doesn\'t exist");
                        }
                        else
                        {
                            _loc_5.scriptParams = param3[1];
                            if (param3.length == 3)
                            {
                                _loc_5.scriptParamsCritical = param3[2];
                            }
                            _loc_5.useParamCache = false;
                        }
                    }
                    else
                    {
                        param1.output("Param count error : #1 Spell id, #2 script string parametters, #3 script string parameters (critical hit)");
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

        public function getHelp(param1:String) : String
        {
            switch(param1)
            {
                case "setspellscriptparam":
                {
                    return "Change script parametters for given spell";
                }
                case "setspellscript":
                {
                    return "Change script id used for given spell";
                }
                default:
                {
                    break;
                }
            }
            return "Unknown command";
        }// end function

        public function getParamPossibilities(param1:String, param2:uint = 0, param3:Array = null) : Array
        {
            return [];
        }// end function

    }
}
