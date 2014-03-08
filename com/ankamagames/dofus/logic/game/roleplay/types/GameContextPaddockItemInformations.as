package com.ankamagames.dofus.logic.game.roleplay.types
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.dofus.network.types.game.mount.ItemDurability;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   
   public class GameContextPaddockItemInformations extends GameRolePlayActorInformations
   {
      
      public function GameContextPaddockItemInformations(param1:int, param2:TiphonEntityLook, param3:uint, param4:ItemDurability, param5:Item) {
         super();
         this.contextualId = param1;
         this._durability = param4;
         this._name = param5.name;
         this._item = param5;
         this.look = EntityLookAdapter.toNetwork(param2);
         disposition.direction = 1;
         disposition.cellId = param3;
      }
      
      private var _durability:ItemDurability;
      
      private var _name:String;
      
      private var _item:Item;
      
      public function get name() : String {
         return this._name;
      }
      
      public function get durability() : ItemDurability {
         return this._durability;
      }
      
      public function get item() : Item {
         return this._item;
      }
   }
}
