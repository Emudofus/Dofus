package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.network.messages.authorized.*;
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.utils.*;

    public class InventoryInstructionHandler extends Object implements ConsoleInstructionHandler
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(InventoryInstructionHandler));

        public function InventoryInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            switch(param2)
            {
                case "listinventory":
                {
                    for each (_loc_9 in InventoryManager.getInstance().realInventory)
                    {
                        
                        param1.output("[UID: " + _loc_9.objectUID + ", ID:" + _loc_9.objectGID + "] " + _loc_9.quantity + " x " + _loc_9["name"]);
                    }
                    break;
                }
                case "searchitem":
                {
                    if (param3.length < 1)
                    {
                        param1.output(param2 + " need an argument to search for");
                        break;
                    }
                    Chrono.start();
                    _loc_4 = Item.getItems();
                    _loc_5 = new Array();
                    _loc_6 = param3.join(" ").toLowerCase();
                    for each (_loc_10 in _loc_4)
                    {
                        
                        if (_loc_10 && StringUtils.noAccent(_loc_10.name).toLowerCase().indexOf(StringUtils.noAccent(_loc_6)) != -1)
                        {
                            _loc_5.push("\t" + _loc_10.name + " (id : " + _loc_10.id + ")");
                        }
                    }
                    Chrono.stop();
                    _log.debug("sur " + _loc_4.length + " iterations");
                    _loc_5.sort(Array.CASEINSENSITIVE);
                    param1.output(_loc_5.join("\n"));
                    param1.output("\tRESULT : " + _loc_5.length + " items founded");
                    break;
                }
                case "makeinventory":
                {
                    _loc_7 = Item.getItems();
                    _loc_8 = parseInt(param3[0], 10);
                    for each (_loc_11 in _loc_7)
                    {
                        
                        if (!_loc_11)
                        {
                            continue;
                        }
                        if (!_loc_8)
                        {
                            break;
                        }
                        _loc_12 = new AdminQuietCommandMessage();
                        _loc_12.initAdminQuietCommandMessage("item * " + _loc_11.id + " " + Math.ceil(Math.random() * 10));
                        ConnectionsHandler.getConnection().send(_loc_12);
                        _loc_8 = _loc_8 - 1;
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
                case "listinventory":
                {
                    return "List player inventory content.";
                }
                case "searchitem":
                {
                    return "Search item name/id, param : [part of searched item name]";
                }
                case "makeinventory":
                {
                    return "Create an inventory";
                }
                default:
                {
                    break;
                }
            }
            return "Unknown command \'" + param1 + "\'.";
        }// end function

        public function getParamPossibilities(param1:String, param2:uint = 0, param3:Array = null) : Array
        {
            return [];
        }// end function

    }
}
