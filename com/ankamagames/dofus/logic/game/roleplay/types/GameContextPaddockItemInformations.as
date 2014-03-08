package com.ankamagames.dofus.logic.game.roleplay.types
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.dofus.network.types.game.mount.ItemDurability;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   
   public class GameContextPaddockItemInformations extends GameRolePlayActorInformations
   {
      
      public function GameContextPaddockItemInformations(contextualId:int, look:TiphonEntityLook, cellId:uint, durability:ItemDurability, item:Item) {
         super();
         this.contextualId = contextualId;
         this._durability = durability;
         this._name = item.name;
         this._item = item;
         this.look = EntityLookAdapter.toNetwork(look);
         disposition.direction = 1;
         disposition.cellId = cellId;
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
