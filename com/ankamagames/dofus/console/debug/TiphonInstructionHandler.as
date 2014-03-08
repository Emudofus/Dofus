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
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void {
         var _loc4_:String = null;
         var _loc5_:AdminQuietCommandMessage = null;
         switch(param2)
         {
            case "additem":
               if(param3.length != 0)
               {
                  param1.output("need 1 parameter (item ID)");
               }
               (DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as TiphonSprite).look.addSkin(parseInt(param3[0]));
               break;
            case "looklike":
               if(!_monsters)
               {
                  this.parseMonster();
               }
               _loc4_ = param3.join(" ").toLowerCase().split(" {npc}").join("").split(" {monster}").join("");
               if(_monsters[_loc4_])
               {
                  param1.output("look like " + _monsters[_loc4_]);
                  _loc5_ = new AdminQuietCommandMessage();
                  _loc5_.initAdminQuietCommandMessage("look * " + _monsters[_loc4_]);
                  if(PlayerManager.getInstance().hasRights)
                  {
                     ConnectionsHandler.getConnection().send(_loc5_);
                  }
               }
               break;
         }
      }
      
      public function getHelp(param1:String) : String {
         switch(param1)
         {
            case "looklike":
               return "look a npc or monster, param is monser\'s or pnc\'s name, you can use autocompletion";
            default:
               return null;
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint=0, param3:Array=null) : Array {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function parseMonster() : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
   }
}
