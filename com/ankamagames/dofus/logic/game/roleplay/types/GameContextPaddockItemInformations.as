package com.ankamagames.dofus.logic.game.roleplay.types
{
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.mount.*;
    import com.ankamagames.tiphon.types.look.*;

    public class GameContextPaddockItemInformations extends GameRolePlayActorInformations
    {
        private var _durability:ItemDurability;
        private var _name:String;
        private var _item:Item;

        public function GameContextPaddockItemInformations(param1:int, param2:TiphonEntityLook, param3:uint, param4:ItemDurability, param5:Item)
        {
            this.contextualId = param1;
            this._durability = param4;
            this._name = param5.name;
            this._item = param5;
            this.look = EntityLookAdapter.toNetwork(param2);
            disposition.direction = 1;
            disposition.cellId = param3;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get durability() : ItemDurability
        {
            return this._durability;
        }// end function

        public function get item() : Item
        {
            return this._item;
        }// end function

    }
}
