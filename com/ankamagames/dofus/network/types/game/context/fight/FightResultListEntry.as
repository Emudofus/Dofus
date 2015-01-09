package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class FightResultListEntry implements INetworkType 
    {

        public static const protocolId:uint = 16;

        public var outcome:uint = 0;
        public var wave:uint = 0;
        public var rewards:FightLoot;

        public function FightResultListEntry()
        {
            this.rewards = new FightLoot();
            super();
        }

        public function getTypeId():uint
        {
            return (16);
        }

        public function initFightResultListEntry(outcome:uint=0, wave:uint=0, rewards:FightLoot=null):FightResultListEntry
        {
            this.outcome = outcome;
            this.wave = wave;
            this.rewards = rewards;
            return (this);
        }

        public function reset():void
        {
            this.outcome = 0;
            this.wave = 0;
            this.rewards = new FightLoot();
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_FightResultListEntry(output);
        }

        public function serializeAs_FightResultListEntry(output:ICustomDataOutput):void
        {
            output.writeVarShort(this.outcome);
            if (this.wave < 0)
            {
                throw (new Error((("Forbidden value (" + this.wave) + ") on element wave.")));
            };
            output.writeByte(this.wave);
            this.rewards.serializeAs_FightLoot(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_FightResultListEntry(input);
        }

        public function deserializeAs_FightResultListEntry(input:ICustomDataInput):void
        {
            this.outcome = input.readVarUhShort();
            if (this.outcome < 0)
            {
                throw (new Error((("Forbidden value (" + this.outcome) + ") on element of FightResultListEntry.outcome.")));
            };
            this.wave = input.readByte();
            if (this.wave < 0)
            {
                throw (new Error((("Forbidden value (" + this.wave) + ") on element of FightResultListEntry.wave.")));
            };
            this.rewards = new FightLoot();
            this.rewards.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.fight

