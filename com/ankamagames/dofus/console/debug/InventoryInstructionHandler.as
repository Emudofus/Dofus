package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.network.messages.authorized.AdminQuietCommandMessage;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.jerakine.utils.misc.Chrono;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.dofus.misc.utils.GameDataQuery;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   
   public class InventoryInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function InventoryInstructionHandler() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(InventoryInstructionHandler));
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void {
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:Vector.<uint> = null;
         var _loc7_:Vector.<Object> = null;
         var _loc8_:Array = null;
         var _loc9_:uint = 0;
         var _loc10_:ItemWrapper = null;
         var _loc11_:Item = null;
         var _loc12_:Item = null;
         var _loc13_:AdminQuietCommandMessage = null;
         switch(param2)
         {
            case "listinventory":
               for each (_loc10_ in InventoryManager.getInstance().realInventory)
               {
                  param1.output("[UID: " + _loc10_.objectUID + ", ID:" + _loc10_.objectGID + "] " + _loc10_.quantity + " x " + _loc10_["name"]);
               }
               break;
            case "searchitem":
               if(param3.length < 1)
               {
                  param1.output(param2 + " need an argument to search for");
                  break;
               }
               Chrono.start("Général");
               _loc4_ = new Array();
               _loc5_ = StringUtils.noAccent(param3.join(" ").toLowerCase());
               Chrono.start("Query");
               _loc6_ = GameDataQuery.queryString(Item,"name",_loc5_);
               Chrono.stop();
               Chrono.start("Instance");
               _loc7_ = GameDataQuery.returnInstance(Item,_loc6_);
               Chrono.stop();
               Chrono.start("Add");
               for each (_loc11_ in _loc7_)
               {
                  _loc4_.push("\t" + _loc11_.name + " (id : " + _loc11_.id + ")");
               }
               Chrono.stop();
               Chrono.stop();
               _log.debug("sur " + _loc7_.length + " iterations");
               _loc4_.sort(Array.CASEINSENSITIVE);
               param1.output(_loc4_.join("\n"));
               param1.output("\tRESULT : " + _loc4_.length + " items founded");
               break;
            case "makeinventory":
               _loc8_ = Item.getItems();
               _loc9_ = parseInt(param3[0],10);
               for each (_loc12_ in _loc8_)
               {
                  if(_loc12_)
                  {
                     if(!_loc9_)
                     {
                        break;
                     }
                     _loc13_ = new AdminQuietCommandMessage();
                     _loc13_.initAdminQuietCommandMessage("item * " + _loc12_.id + " " + Math.ceil(Math.random() * 10));
                     ConnectionsHandler.getConnection().send(_loc13_);
                     _loc9_--;
                  }
               }
               break;
         }
      }
      
      public function getHelp(param1:String) : String {
         switch(param1)
         {
            case "listinventory":
               return "List player inventory content.";
            case "searchitem":
               return "Search item name/id, param : [part of searched item name]";
            case "makeinventory":
               return "Create an inventory";
            default:
               return "Unknown command \'" + param1 + "\'.";
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint=0, param3:Array=null) : Array {
         return [];
      }
   }
}
