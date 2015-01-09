package com.ankamagames.dofus.network.types.game.data.items.effects
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ObjectEffectCreature extends ObjectEffect implements INetworkType 
    {

        public static const protocolId:uint = 71;

        public var monsterFamilyId:uint = 0;


        override public function getTypeId():uint
        {
            return (71);
        }

        public function initObjectEffectCreature(actionId:uint=0, monsterFamilyId:uint=0):ObjectEffectCreature
        {
            super.initObjectEffect(actionId);
            this.monsterFamilyId = monsterFamilyId;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.monsterFamilyId = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ObjectEffectCreature(output);
        }

        public function serializeAs_ObjectEffectCreature(output:ICustomDataOutput):void
        {
            super.serializeAs_ObjectEffect(output);
            if (this.monsterFamilyId < 0)
            {
                throw (new Error((("Forbidden value (" + this.monsterFamilyId) + ") on element monsterFamilyId.")));
            };
            output.writeVarShort(this.monsterFamilyId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ObjectEffectCreature(input);
        }

        public function deserializeAs_ObjectEffectCreature(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.monsterFamilyId = input.readVarUhShort();
            if (this.monsterFamilyId < 0)
            {
                throw (new Error((("Forbidden value (" + this.monsterFamilyId) + ") on element of ObjectEffectCreature.monsterFamilyId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.data.items.effects

