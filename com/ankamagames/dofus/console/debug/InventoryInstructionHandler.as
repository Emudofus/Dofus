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

      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void {
         var matchItems:Array = null;
         var searchWord:String = null;
         var ids:Vector.<uint> = null;
         var items:Vector.<Object> = null;
         var items2:Array = null;
         var len:uint = 0;
         var item:ItemWrapper = null;
         var currentItem:Item = null;
         var currentItem2:Item = null;
         var aqcmsg:AdminQuietCommandMessage = null;
         switch(cmd)
         {
            case "listinventory":
               for each (item in InventoryManager.getInstance().realInventory)
               {
                  console.output("[UID: "+item.objectUID+", ID:"+item.objectGID+"] "+item.quantity+" x "+item["name"]);
               }
               break;
            case "searchitem":
               if(args.length<1)
               {
                  console.output(cmd+" need an argument to search for");
               }
               else
               {
                  Chrono.start("G�n�ral");
                  matchItems=new Array();
                  searchWord=StringUtils.noAccent(args.join(" ").toLowerCase());
                  Chrono.start("Query");
                  ids=GameDataQuery.queryString(Item,"name",searchWord);
                  Chrono.stop();
                  Chrono.start("Instance");
                  items=GameDataQuery.returnInstance(Item,ids);
                  Chrono.stop();
                  Chrono.start("Add");
                  for each (currentItem in items)
                  {
                     matchItems.push("\t"+currentItem.name+" (id : "+currentItem.id+")");
                  }
                  Chrono.stop();
                  Chrono.stop();
                  _log.debug("sur "+items.length+" iterations");
                  matchItems.sort(Array.CASEINSENSITIVE);
                  console.output(matchItems.join("\n"));
                  console.output("\tRESULT : "+matchItems.length+" items founded");
               }
               break;
            case "makeinventory":
               items2=Item.getItems();
               len=parseInt(args[0],10);
               for each (currentItem2 in items2)
               {
                  if(!currentItem2)
                  {
                  }
                  else
                  {
                     if(!len)
                     {
                        break;
                     }
                     aqcmsg=new AdminQuietCommandMessage();
                     aqcmsg.initAdminQuietCommandMessage("item * "+currentItem2.id+" "+Math.ceil(Math.random()*10));
                     ConnectionsHandler.getConnection().send(aqcmsg);
                     len--;
                  }
               }
               break;
         }
      }

      public function getHelp(cmd:String) : String {
         switch(cmd)
         {
            case "listinventory":
               return "List player inventory content.";
            case "searchitem":
               return "Search item name/id, param : [part of searched item name]";
            case "makeinventory":
               return "Create an inventory";
            default:
               return "Unknown command \'"+cmd+"\'.";
         }
      }

      public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null) : Array {
         return [];
      }
   }

}