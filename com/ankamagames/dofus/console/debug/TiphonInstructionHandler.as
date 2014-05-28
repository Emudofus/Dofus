package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.dofus.network.messages.authorized.AdminQuietCommandMessage;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.npcs.Npc;
   
   public class TiphonInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function TiphonInstructionHandler() {
         super();
      }
      
      private static var _monsters:Dictionary;
      
      private static var _monsterNameList:Array;
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void {
         var monsterName:String = null;
         var aqcmsg:AdminQuietCommandMessage = null;
         switch(cmd)
         {
            case "additem":
               if(args.length != 0)
               {
                  console.output("need 1 parameter (item ID)");
               }
               (DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as TiphonSprite).look.addSkin(parseInt(args[0]));
               break;
            case "looklike":
               if(!_monsters)
               {
                  this.parseMonster();
               }
               monsterName = args.join(" ").toLowerCase().split(" {npc}").join("").split(" {monster}").join("");
               if(_monsters[monsterName])
               {
                  console.output("look like " + _monsters[monsterName]);
                  aqcmsg = new AdminQuietCommandMessage();
                  aqcmsg.initAdminQuietCommandMessage("look * " + _monsters[monsterName]);
                  if(PlayerManager.getInstance().hasRights)
                  {
                     ConnectionsHandler.getConnection().send(aqcmsg);
                  }
               }
               break;
         }
      }
      
      public function getHelp(cmd:String) : String {
         switch(cmd)
         {
            case "looklike":
               return "look a npc or monster, param is monser\'s or pnc\'s name, you can use autocompletion";
            default:
               return null;
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array {
         var result:Array = null;
         var searchTerm:String = null;
         var name:String = null;
         switch(cmd)
         {
            case "looklike":
               if(!_monsters)
               {
                  this.parseMonster();
               }
               result = [];
               searchTerm = currentParams.join(" ").toLowerCase();
               for each(name in _monsterNameList)
               {
                  if(name.indexOf(searchTerm) != -1)
                  {
                     result.push(name);
                  }
               }
               return result;
            default:
               return [];
         }
      }
      
      private function parseMonster() : void {
         var monster:Monster = null;
         var npc:Npc = null;
         _monsters = new Dictionary();
         _monsterNameList = [];
         var monsters:Array = Monster.getMonsters();
         for each(monster in monsters)
         {
            _monsterNameList.push(monster.name.toLowerCase() + " {monster}");
            _monsters[monster.name.toLowerCase()] = monster.look;
         }
         monsters = Npc.getNpcs();
         for each(npc in monsters)
         {
            _monsterNameList.push(npc.name.toLowerCase() + " {npc}");
            _monsters[npc.name.toLowerCase()] = npc.look;
         }
      }
   }
}
