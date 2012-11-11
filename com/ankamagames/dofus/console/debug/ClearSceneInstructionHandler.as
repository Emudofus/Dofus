package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.tiphon.display.*;
    import flash.display.*;
    import flash.system.*;
    import flash.utils.*;

    public class ClearSceneInstructionHandler extends Object implements ConsoleInstructionHandler
    {

        public function ClearSceneInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = undefined;
            switch(param2)
            {
                case "clearscene":
                {
                    if (param3.length > 0)
                    {
                        param1.output("No arguments needed.");
                    }
                    _loc_4 = Dofus.getInstance().getWorldContainer();
                    while (_loc_4.numChildren > 0)
                    {
                        
                        _loc_4.removeChildAt(0);
                    }
                    param1.output("Scene cleared.");
                    break;
                }
                case "clearentities":
                {
                    _loc_5 = 0;
                    for each (_loc_6 in EntitiesManager.getInstance().entities)
                    {
                        
                        _loc_5 = _loc_5 + 1;
                    }
                    param1.output("EntitiesManager : " + _loc_5 + " entities");
                    Atouin.getInstance().clearEntities();
                    Atouin.getInstance().display(PlayedCharacterManager.getInstance().currentMap);
                    System.gc();
                    setTimeout(this.asynchInfo, 2000, param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function asynchInfo(param1:ConsoleHandler) : void
        {
            var _loc_3:* = undefined;
            var _loc_2:* = TiphonSprite.MEMORY_LOG;
            for (_loc_3 in _loc_2)
            {
                
                param1.output(_loc_3 + " : " + TiphonSprite(_loc_3).look);
            }
            return;
        }// end function

        public function getHelp(param1:String) : String
        {
            switch(param1)
            {
                case "clearscene":
                {
                    return "Clear the World Scene.";
                }
                case "clearentities":
                {
                    return "Clear all entities from the scene.";
                }
                default:
                {
                    break;
                }
            }
            return "No help for command \'" + param1 + "\'";
        }// end function

        public function getParamPossibilities(param1:String, param2:uint = 0, param3:Array = null) : Array
        {
            return [];
        }// end function

    }
}
