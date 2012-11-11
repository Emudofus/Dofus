package com.ankamagames.dofus.network.types.game.paddock
{
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.mount.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PaddockItem extends ObjectItemInRolePlay implements INetworkType
    {
        public var durability:ItemDurability;
        public static const protocolId:uint = 185;

        public function PaddockItem()
        {
            this.durability = new ItemDurability();
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 185;
        }// end function

        public function initPaddockItem(param1:uint = 0, param2:uint = 0, param3:ItemDurability = null) : PaddockItem
        {
            super.initObjectItemInRolePlay(param1, param2);
            this.durability = param3;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.durability = new ItemDurability();
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_PaddockItem(param1);
            return;
        }// end function

        public function serializeAs_PaddockItem(param1:IDataOutput) : void
        {
            super.serializeAs_ObjectItemInRolePlay(param1);
            this.durability.serializeAs_ItemDurability(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PaddockItem(param1);
            return;
        }// end function

        public function deserializeAs_PaddockItem(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.durability = new ItemDurability();
            this.durability.deserialize(param1);
            return;
        }// end function

    }
}
