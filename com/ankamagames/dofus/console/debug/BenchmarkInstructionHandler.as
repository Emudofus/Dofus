package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.entities.interfaces.IAnimated;
    import com.ankamagames.dofus.misc.utils.frames.LuaScriptRecorderFrame;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
    import com.ankamagames.dofus.types.entities.BenchmarkCharacter;
    import com.ankamagames.dofus.logic.common.frames.DebugBotFrame;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.dofus.misc.BenchmarkMovementBehavior;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.tiphon.engine.TiphonDebugManager;
    import com.ankamagames.dofus.logic.common.frames.FightBotFrame;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import com.ankamagames.dofus.logic.game.fight.managers.TacticModeManager;
    import com.ankamagames.jerakine.console.ConsoleHandler;
    import com.ankamagames.tiphon.display.TiphonSprite;

    public class BenchmarkInstructionHandler implements ConsoleInstructionHandler 
    {

        private static var id:uint = 50000;

        protected var _log:Logger;

        public function BenchmarkInstructionHandler()
        {
            this._log = Log.getLogger(getQualifiedClassName(BenchmarkInstructionHandler));
            super();
        }

        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var _local_4:IAnimated;
            var _local_5:LuaScriptRecorderFrame;
            var _local_6:IAnimated;
            var _local_7:FpsManager;
            var _local_8:String;
            var _local_9:Boolean;
            var _local_10:int;
            var _local_11:Boolean;
            var _local_12:Boolean;
            var _local_13:Boolean;
            var _local_14:Boolean;
            var _local_15:Boolean;
            var _local_16:Boolean;
            var rpCharEntity:BenchmarkCharacter;
            var _local_18:DebugBotFrame;
            var _local_19:int;
            var time:int;
            var _local_21:Boolean;
            var arg:String;
            var valueTab:Array;
            var cmdValue:String;
            switch (cmd)
            {
                case "addmovingcharacter":
                    if (args.length > 0)
                    {
                        rpCharEntity = new BenchmarkCharacter(id++, TiphonEntityLook.fromString(args[0]));
                        rpCharEntity.position = MapPoint.fromCellId(int((Math.random() * 300)));
                        rpCharEntity.display();
                        rpCharEntity.move(BenchmarkMovementBehavior.getRandomPath(rpCharEntity));
                    };
                    return;
                case "setanimation":
                    _local_4 = (DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as IAnimated);
                    _local_5 = (Kernel.getWorker().getFrame(LuaScriptRecorderFrame) as LuaScriptRecorderFrame);
                    if (Kernel.getWorker().getFrame(LuaScriptRecorderFrame))
                    {
                        _local_5.createLine("player", "setAnimation", args[0], true);
                    };
                    _local_4.setAnimation(args[0]);
                    return;
                case "setdirection":
                    _local_6 = (DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as IAnimated);
                    _local_6.setDirection(args[0]);
                    return;
                case "tiphon-error":
                    TiphonDebugManager.disable();
                    return;
                case "bot-spectator":
                    if (Kernel.getWorker().contains(DebugBotFrame))
                    {
                        Kernel.getWorker().removeFrame(DebugBotFrame.getInstance());
                        console.output((("Arret du bot-spectator, " + DebugBotFrame.getInstance().fightCount) + " combat(s) vu"));
                    }
                    else
                    {
                        _local_18 = DebugBotFrame.getInstance();
                        _local_19 = args.indexOf("debugchat");
                        if (_local_19 != -1)
                        {
                            time = 500;
                            if (args.length > (_local_19 + 1))
                            {
                                time = args[(_local_19 + 1)];
                            };
                            _local_18.enableChatMessagesBot(true, time);
                        };
                        Kernel.getWorker().addFrame(_local_18);
                        console.output("Démarrage du bot-spectator ");
                    };
                    return;
                case "bot-fight":
                    if (Kernel.getWorker().contains(FightBotFrame))
                    {
                        Kernel.getWorker().removeFrame(FightBotFrame.getInstance());
                        console.output((("Arret du bot-fight, " + FightBotFrame.getInstance().fightCount) + " combat(s) effectué"));
                    }
                    else
                    {
                        Kernel.getWorker().addFrame(FightBotFrame.getInstance());
                        console.output("Démarrage du bot-fight ");
                    };
                    return;
                case "fpsmanager":
                    _local_7 = FpsManager.getInstance();
                    if (StageShareManager.stage.contains(_local_7))
                    {
                        _local_7.hide();
                    }
                    else
                    {
                        _local_21 = !((args.indexOf("external") == -1));
                        if (_local_21)
                        {
                            console.output("Fps Manager External");
                        };
                        _local_7.display(_local_21);
                    };
                    return;
                case "tacticmode":
                    TacticModeManager.getInstance().hide();
                    _local_9 = false;
                    _local_10 = 0;
                    _local_11 = false;
                    _local_12 = false;
                    _local_13 = false;
                    _local_14 = false;
                    _local_15 = true;
                    _local_16 = true;
                    for each (arg in args)
                    {
                        valueTab = arg.split("=");
                        if (valueTab == null)
                        {
                        }
                        else
                        {
                            cmdValue = valueTab[1];
                            if (((!((arg.search("fightzone") == -1))) && ((valueTab.length > 1))))
                            {
                                _local_11 = (((cmdValue.toLowerCase() == "true")) ? true : false);
                            }
                            else
                            {
                                if (((!((arg.search("clearcache") == -1))) && ((valueTab.length > 1))))
                                {
                                    _local_9 = (((cmdValue.toLowerCase() == "true")) ? false : true);
                                }
                                else
                                {
                                    if (((!((arg.search("mode") == -1))) && ((valueTab.length > 1))))
                                    {
                                        _local_10 = (((cmdValue.toLowerCase() == "rp")) ? 1 : 0);
                                    }
                                    else
                                    {
                                        if (((!((arg.search("interactivecells") == -1))) && ((valueTab.length > 1))))
                                        {
                                            _local_12 = (((cmdValue.toLowerCase() == "true")) ? true : false);
                                        }
                                        else
                                        {
                                            if (((!((arg.search("scalezone") == -1))) && ((valueTab.length > 1))))
                                            {
                                                _local_14 = (((cmdValue.toLowerCase() == "true")) ? true : false);
                                            }
                                            else
                                            {
                                                if (((!((arg.search("show") == -1))) && ((valueTab.length > 1))))
                                                {
                                                    _local_13 = (((cmdValue.toLowerCase() == "true")) ? true : false);
                                                }
                                                else
                                                {
                                                    if (((!((arg.search("flattencells") == -1))) && ((valueTab.length > 1))))
                                                    {
                                                        _local_15 = (((cmdValue.toLowerCase() == "true")) ? true : false);
                                                    }
                                                    else
                                                    {
                                                        if (((!((arg.search("blocLDV") == -1))) && ((valueTab.length > 1))))
                                                        {
                                                            _local_16 = (((cmdValue.toLowerCase() == "true")) ? true : false);
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                    if (_local_13)
                    {
                        TacticModeManager.getInstance().setDebugMode(_local_11, _local_9, _local_10, _local_12, _local_14, _local_15, _local_16);
                        TacticModeManager.getInstance().show(PlayedCharacterManager.getInstance().currentMap, true);
                        _local_8 = "Activation";
                    }
                    else
                    {
                        _local_8 = "Désactivation";
                    };
                    _local_8 = (_local_8 + " du mode tactique.");
                    console.output(_local_8);
                    return;
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "addmovingcharacter":
                    return ("Add a new mobile character on scene.");
                case "fpsmanager":
                    return ("Displays the performance of the client. (external)");
                case "bot-spectator":
                    return (("Start/Stop the auto join fight spectator bot" + "\n    debugchat"));
                case "tiphon-error":
                    return ("Désactive l'affichage des erreurs du moteur d'animation.");
                case "tacticmode":
                    return (((((((("Active/Désactive le mode tactique" + "\n    show=[true|false]") + "\n    clearcache=[true|false]") + "\n    mode=[fight|RP]") + "\n    interactivecells=[true|false] ") + "\n    fightzone=[true|false]") + "\n    scalezone=[true|false]") + "\n    flattencells=[true|false]"));
            };
            return ("Unknow command");
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            var _local_4:TiphonSprite;
            var _local_5:Array;
            var _local_6:Array;
            var anim:String;
            switch (cmd)
            {
                case "tacticmode":
                    return (["show", "clearcache", "mode", "interactivecells", "fightzone", "scalezone", "flattencells"]);
                case "setanimation":
                    _local_4 = (DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as TiphonSprite);
                    _local_5 = _local_4.animationList;
                    _local_6 = [];
                    for each (anim in _local_5)
                    {
                        if (anim.indexOf("Anim") != -1)
                        {
                            _local_6.push(anim);
                        };
                    };
                    _local_6.sort();
                    return (_local_6);
            };
            return ([]);
        }


    }
}//package com.ankamagames.dofus.console.debug

