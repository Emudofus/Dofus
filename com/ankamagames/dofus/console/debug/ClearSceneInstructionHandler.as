package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import flash.display.DisplayObjectContainer;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.atouin.managers.EntitiesManager;
    import com.ankamagames.atouin.Atouin;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import flash.system.System;
    import flash.utils.setTimeout;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.jerakine.console.ConsoleHandler;
    import flash.utils.Dictionary;

    public class ClearSceneInstructionHandler implements ConsoleInstructionHandler 
    {


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var _local_4:DisplayObjectContainer;
            var _local_5:uint;
            var _local_6:uint;
            var _local_7:uint;
            var _local_8:uint;
            var _local_9:Array;
            var _local_10:RoleplayEntitiesFrame;
            var o:*;
            var entity:*;
            switch (cmd)
            {
                case "clearscene":
                    if (args.length > 0)
                    {
                        console.output("No arguments needed.");
                    };
                    _local_4 = Dofus.getInstance().getWorldContainer();
                    while (_local_4.numChildren > 0)
                    {
                        _local_4.removeChildAt(0);
                    };
                    console.output("Scene cleared.");
                    return;
                case "clearentities":
                    _local_5 = 0;
                    for each (o in EntitiesManager.getInstance().entities)
                    {
                        _local_5++;
                    };
                    console.output((("EntitiesManager : " + _local_5) + " entities"));
                    Atouin.getInstance().clearEntities();
                    Atouin.getInstance().display(PlayedCharacterManager.getInstance().currentMap);
                    System.gc();
                    setTimeout(this.asynchInfo, 2000, console);
                    return;
                case "countentities":
                    _local_6 = 0;
                    _local_7 = 0;
                    _local_8 = 0;
                    _local_9 = EntitiesManager.getInstance().entities;
                    for each (entity in _local_9)
                    {
                        _local_6++;
                        if ((entity is TiphonSprite))
                        {
                            if (entity.id >= 0)
                            {
                                _local_7++;
                            }
                            else
                            {
                                _local_8++;
                            };
                        };
                    };
                    console.output((((((_local_6 + " entities : ") + _local_7) + " characters, ") + _local_8) + " monsters & npc."));
                    _local_10 = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
                    if (_local_10)
                    {
                        console.output(((((("Switch to creature mode : " + _local_10.entitiesNumber) + " of ") + _local_10.creaturesLimit) + " -> ") + _local_10.creaturesMode));
                    };
                    return;
            };
        }

        private function asynchInfo(console:ConsoleHandler):void
        {
            var sprite:*;
            var ts:Dictionary = TiphonSprite.MEMORY_LOG;
            for (sprite in ts)
            {
                console.output(((sprite + " : ") + TiphonSprite(sprite).look));
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "clearscene":
                    return ("Clear the World Scene.");
                case "clearentities":
                    return ("Clear all entities from the scene.");
                case "countentities":
                    return ("Count all entities from the scene.");
            };
            return ((("No help for command '" + cmd) + "'"));
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            return ([]);
        }


    }
}//package com.ankamagames.dofus.console.debug

