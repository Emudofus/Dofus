package com.ankamagames.dofus.network.types.game.data.items.effects
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectEffectCreature extends ObjectEffect implements INetworkType
    {
        public var monsterFamilyId:uint = 0;
        public static const protocolId:uint = 71;

        public function ObjectEffectCreature()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 71;
        }// end function

        public function initObjectEffectCreature(param1:uint = 0, param2:uint = 0) : ObjectEffectCreature
        {
            super.initObjectEffect(param1);
            this.monsterFamilyId = param2;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.monsterFamilyId = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ObjectEffectCreature(param1);
            return;
        }// end function

        public function serializeAs_ObjectEffectCreature(param1:IDataOutput) : void
        {
            super.serializeAs_ObjectEffect(param1);
            if (this.monsterFamilyId < 0)
            {
                throw new Error("Forbidden value (" + this.monsterFamilyId + ") on element monsterFamilyId.");
            }
            param1.writeShort(this.monsterFamilyId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectEffectCreature(param1);
            return;
        }// end function

        public function deserializeAs_ObjectEffectCreature(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.monsterFamilyId = param1.readShort();
            if (this.monsterFamilyId < 0)
            {
                throw new Error("Forbidden value (" + this.monsterFamilyId + ") on element of ObjectEffectCreature.monsterFamilyId.");
            }
            return;
        }// end function

    }
}
