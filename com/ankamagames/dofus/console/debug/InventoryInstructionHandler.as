package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.datacenter.items.Item;
    import com.ankamagames.dofus.network.messages.authorized.AdminQuietCommandMessage;
    import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
    import com.ankamagames.jerakine.utils.misc.Chrono;
    import com.ankamagames.jerakine.utils.misc.StringUtils;
    import com.ankamagames.dofus.misc.utils.GameDataQuery;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.jerakine.console.ConsoleHandler;

    public class InventoryInstructionHandler implements ConsoleInstructionHandler 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(InventoryInstructionHandler));


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var _local_4:Array;
            var _local_5:String;
            var _local_6:Vector.<uint>;
            var _local_7:Vector.<Object>;
            var _local_8:Array;
            var _local_9:uint;
            var item:ItemWrapper;
            var currentItem:Item;
            var currentItem2:Item;
            var aqcmsg:AdminQuietCommandMessage;
            switch (cmd)
            {
                case "listinventory":
                    for each (item in InventoryManager.getInstance().realInventory)
                    {
                        console.output(((((((("[UID: " + item.objectUID) + ", ID:") + item.objectGID) + "] ") + item.quantity) + " x ") + item["name"]));
                    };
                    return;
                case "searchitem":
                    if (args.length < 1)
                    {
                        console.output((cmd + " need an argument to search for"));
                        return;
                    };
                    Chrono.start("Général");
                    _local_4 = new Array();
                    _local_5 = StringUtils.noAccent(args.join(" ").toLowerCase());
                    Chrono.start("Query");
                    _local_6 = GameDataQuery.queryString(Item, "name", _local_5);
                    Chrono.stop();
                    Chrono.start("Instance");
                    _local_7 = GameDataQuery.returnInstance(Item, _local_6);
                    Chrono.stop();
                    Chrono.start("Add");
                    for each (currentItem in _local_7)
                    {
                        _local_4.push((((("\t" + currentItem.name) + " ( id : ") + currentItem.id) + " )"));
                    };
                    Chrono.stop();
                    Chrono.stop();
                    _log.debug((("sur " + _local_7.length) + " iterations"));
                    _local_4.sort(Array.CASEINSENSITIVE);
                    console.output(_local_4.join("\n"));
                    console.output((("\tRESULT : " + _local_4.length) + " items founded"));
                    return;
                case "makeinventory":
                    _local_8 = Item.getItems();
                    _local_9 = parseInt(args[0], 10);
                    for each (currentItem2 in _local_8)
                    {
                        if (!!(currentItem2))
                        {
                            if (!(_local_9)) break;
                            aqcmsg = new AdminQuietCommandMessage();
                            aqcmsg.initAdminQuietCommandMessage(((("item * " + currentItem2.id) + " ") + Math.ceil((Math.random() * 10))));
                            ConnectionsHandler.getConnection().send(aqcmsg);
                            _local_9--;
                        };
                    };
                    return;
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "listinventory":
                    return ("List player inventory content.");
                case "searchitem":
                    return ("Search item name/id, param : [part of searched item name]");
                case "makeinventory":
                    return ("Create an inventory");
            };
            return ((("Unknown command '" + cmd) + "'."));
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            return ([]);
        }


    }
}//package com.ankamagames.dofus.console.debug

