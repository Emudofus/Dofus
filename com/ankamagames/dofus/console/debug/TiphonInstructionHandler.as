package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.dofus.datacenter.monsters.*;
    import com.ankamagames.dofus.datacenter.npcs.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.network.messages.authorized.*;
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.tiphon.display.*;
    import flash.utils.*;

    public class TiphonInstructionHandler extends Object implements ConsoleInstructionHandler
    {
        private static var _monsters:Dictionary;
        private static var _monsterNameList:Array;

        public function TiphonInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var _loc_4:String = null;
            var _loc_5:AdminQuietCommandMessage = null;
            switch(param2)
            {
                case "additem":
                {
                    if (param3.length != 0)
                    {
                        param1.output("need 1 parameter (item ID)");
                    }
                    (DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as TiphonSprite).look.addSkin(parseInt(param3[0]));
                    break;
                }
                case "looklike":
                {
                    if (!_monsters)
                    {
                        this.parseMonster();
                    }
                    _loc_4 = param3.join(" ").toLowerCase().split(" {npc}").join("").split(" {monster}").join("");
                    if (_monsters[_loc_4])
                    {
                        param1.output("look like " + _monsters[_loc_4]);
                        _loc_5 = new AdminQuietCommandMessage();
                        _loc_5.initAdminQuietCommandMessage("look * " + _monsters[_loc_4]);
                        if (PlayerManager.getInstance().hasRights)
                        {
                            ConnectionsHandler.getConnection().send(_loc_5);
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

        public function getHelp(param1:String) : String
        {
            switch(param1)
            {
                case "looklike":
                {
                    return "look a npc or monster, param is monser\'s or pnc\'s name, you can use autocompletion";
                }
                default:
                {
                    break;
                }
            }
            return null;
        }// end function

        public function getParamPossibilities(param1:String, param2:uint = 0, param3:Array = null) : Array
        {
            var _loc_4:Array = null;
            var _loc_5:String = null;
            var _loc_6:String = null;
            switch(param1)
            {
                case "looklike":
                {
                    if (!_monsters)
                    {
                        this.parseMonster();
                    }
                    _loc_4 = [];
                    _loc_5 = param3.join(" ").toLowerCase();
                    for each (_loc_6 in _monsterNameList)
                    {
                        
                        if (_loc_6.indexOf(_loc_5) != -1)
                        {
                            _loc_4.push(_loc_6);
                        }
                    }
                    return _loc_4;
                }
                default:
                {
                    break;
                }
            }
            return [];
        }// end function

        private function parseMonster() : void
        {
            var _loc_2:Monster = null;
            var _loc_3:Npc = null;
            _monsters = new Dictionary();
            _monsterNameList = [];
            var _loc_1:* = Monster.getMonsters();
            for each (_loc_2 in _loc_1)
            {
                
                _monsterNameList.push(_loc_2.name.toLowerCase() + " {monster}");
                _monsters[_loc_2.name.toLowerCase()] = _loc_2.look;
            }
            _loc_1 = Npc.getNpcs();
            for each (_loc_3 in _loc_1)
            {
                
                _monsterNameList.push(_loc_3.name.toLowerCase() + " {npc}");
                _monsters[_loc_3.name.toLowerCase()] = _loc_3.look;
            }
            return;
        }// end function

    }
}
