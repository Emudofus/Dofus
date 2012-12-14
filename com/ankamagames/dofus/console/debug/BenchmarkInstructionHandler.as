package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.managers.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.tiphon.engine.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.utils.*;

    public class BenchmarkInstructionHandler extends Object implements ConsoleInstructionHandler
    {
        protected var _log:Logger;
        private static var id:uint = 50000;

        public function BenchmarkInstructionHandler()
        {
            this._log = Log.getLogger(getQualifiedClassName(BenchmarkInstructionHandler));
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = false;
            var _loc_9:* = 0;
            var _loc_10:* = false;
            var _loc_11:* = false;
            var _loc_12:* = false;
            var _loc_13:* = false;
            var _loc_14:* = false;
            var _loc_15:* = false;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            var _loc_20:* = false;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            switch(param2)
            {
                case "addmovingcharacter":
                {
                    if (param3.length > 0)
                    {
                        _loc_16 = new BenchmarkCharacter(id++, TiphonEntityLook.fromString(param3[0]));
                        _loc_16.position = MapPoint.fromCellId(int(Math.random() * 300));
                        _loc_16.display();
                        _loc_16.move(BenchmarkMovementBehavior.getRandomPath(_loc_16));
                    }
                    break;
                }
                case "setanimation":
                {
                    _loc_4 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as IAnimated;
                    _loc_4.setAnimation(param3[0]);
                    break;
                }
                case "setdirection":
                {
                    _loc_5 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as IAnimated;
                    _loc_5.setDirection(param3[0]);
                    break;
                }
                case "tiphon-error":
                {
                    TiphonDebugManager.disable();
                    break;
                }
                case "bot-spectator":
                {
                    if (Kernel.getWorker().contains(DebugBotFrame))
                    {
                        Kernel.getWorker().removeFrame(DebugBotFrame.getInstance());
                        param1.output("Arret du bot-spectator, " + DebugBotFrame.getInstance().fightCount + " combat(s) vu");
                    }
                    else
                    {
                        _loc_17 = DebugBotFrame.getInstance();
                        _loc_18 = param3.indexOf("debugchat");
                        if (_loc_18 != -1)
                        {
                            _loc_19 = 500;
                            if (param3.length > (_loc_18 + 1))
                            {
                                _loc_19 = param3[(_loc_18 + 1)];
                            }
                            _loc_17.enableChatMessagesBot(true, _loc_19);
                        }
                        Kernel.getWorker().addFrame(_loc_17);
                        param1.output("Démarrage du bot-spectator ");
                    }
                    break;
                }
                case "bot-fight":
                {
                    if (Kernel.getWorker().contains(FightBotFrame))
                    {
                        Kernel.getWorker().removeFrame(FightBotFrame.getInstance());
                        param1.output("Arret du bot-fight, " + FightBotFrame.getInstance().fightCount + " combat(s) effectué");
                    }
                    else
                    {
                        Kernel.getWorker().addFrame(FightBotFrame.getInstance());
                        param1.output("Démarrage du bot-fight ");
                    }
                    break;
                }
                case "fpsmanager":
                {
                    _loc_6 = FpsManager.getInstance();
                    if (StageShareManager.stage.contains(_loc_6))
                    {
                        _loc_6.hide();
                    }
                    else
                    {
                        _loc_20 = param3.indexOf("external") != -1;
                        if (_loc_20)
                        {
                            param1.output("Fps Manager External");
                        }
                        _loc_6.display(_loc_20);
                    }
                    break;
                }
                case "fastanimfun":
                {
                    param1.output((AnimFunManager.getInstance().fastDelay ? ("Désactivation") : ("Activation")) + " de l\'exécution rapide des anims-funs");
                    AnimFunManager.getInstance().fastDelay = !AnimFunManager.getInstance().fastDelay;
                    break;
                }
                case "tacticmode":
                {
                    TacticModeManager.getInstance().hide();
                    _loc_8 = false;
                    _loc_9 = 0;
                    _loc_10 = false;
                    _loc_11 = false;
                    _loc_12 = false;
                    _loc_13 = false;
                    _loc_14 = true;
                    _loc_15 = true;
                    for each (_loc_21 in param3)
                    {
                        
                        _loc_22 = _loc_21.split("=");
                        if (_loc_22 == null)
                        {
                            continue;
                        }
                        _loc_23 = _loc_22[1];
                        if (_loc_21.search("fightzone") != -1 && _loc_22.length > 1)
                        {
                            _loc_10 = _loc_23.toLowerCase() == "true" ? (true) : (false);
                            continue;
                        }
                        if (_loc_21.search("clearcache") != -1 && _loc_22.length > 1)
                        {
                            _loc_8 = _loc_23.toLowerCase() == "true" ? (false) : (true);
                            continue;
                        }
                        if (_loc_21.search("mode") != -1 && _loc_22.length > 1)
                        {
                            _loc_9 = _loc_23.toLowerCase() == "rp" ? (1) : (0);
                            continue;
                        }
                        if (_loc_21.search("interactivecells") != -1 && _loc_22.length > 1)
                        {
                            _loc_11 = _loc_23.toLowerCase() == "true" ? (true) : (false);
                            continue;
                        }
                        if (_loc_21.search("scalezone") != -1 && _loc_22.length > 1)
                        {
                            _loc_13 = _loc_23.toLowerCase() == "true" ? (true) : (false);
                            continue;
                        }
                        if (_loc_21.search("show") != -1 && _loc_22.length > 1)
                        {
                            _loc_12 = _loc_23.toLowerCase() == "true" ? (true) : (false);
                            continue;
                        }
                        if (_loc_21.search("flattencells") != -1 && _loc_22.length > 1)
                        {
                            _loc_14 = _loc_23.toLowerCase() == "true" ? (true) : (false);
                            continue;
                        }
                        if (_loc_21.search("blocLDV") != -1 && _loc_22.length > 1)
                        {
                            _loc_15 = _loc_23.toLowerCase() == "true" ? (true) : (false);
                        }
                    }
                    if (_loc_12)
                    {
                        TacticModeManager.getInstance().setDebugMode(_loc_10, _loc_8, _loc_9, _loc_11, _loc_13, _loc_14, _loc_15);
                        TacticModeManager.getInstance().show(PlayedCharacterManager.getInstance().currentMap, true);
                        _loc_7 = "Activation";
                    }
                    else
                    {
                        _loc_7 = "Désactivation";
                    }
                    _loc_7 = _loc_7 + " du mode tactique.";
                    param1.output(_loc_7);
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
                case "addmovingcharacter":
                {
                    return "Add a new mobile character on scene.";
                }
                case "fpsmanager":
                {
                    return "Displays the performance of the client. (external)";
                }
                case "bot-spectator":
                {
                    return "Start/Stop the auto join fight spectator bot" + "\n    debugchat";
                }
                case "tiphon-error":
                {
                    return "Désactive l\'affichage des erreurs du moteur d\'animation.";
                }
                case "fastanimfun":
                {
                    return "Active/Désactive l\'exécution rapide des anims funs.";
                }
                case "tacticmode":
                {
                    return "Active/Désactive le mode tactique" + "\n    show=[true|false]" + "\n    clearcache=[true|false]" + "\n    mode=[fight|RP]" + "\n    interactivecells=[true|false] " + "\n    fightzone=[true|false]" + "\n    scalezone=[true|false]" + "\n    flattencells=[true|false]";
                }
                default:
                {
                    break;
                }
            }
            return "Unknow command";
        }// end function

        public function getParamPossibilities(param1:String, param2:uint = 0, param3:Array = null) : Array
        {
            switch(param1)
            {
                case "tacticmode":
                {
                    return ["show", "clearcache", "mode", "interactivecells", "fightzone", "scalezone", "flattencells"];
                }
                default:
                {
                    break;
                }
            }
            return [];
        }// end function

    }
}
