package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    public class FightResultMutantListEntry extends FightResultFighterListEntry implements INetworkType 
    {

        public static const protocolId:uint = 216;

        public var level:uint = 0;


        override public function getTypeId():uint
        {
            return (216);
        }

        public function initFightResultMutantListEntry(outcome:uint=0, wave:uint=0, rewards:FightLoot=null, id:int=0, alive:Boolean=false, level:uint=0):FightResultMutantListEntry
        {
            super.initFightResultFighterListEntry(outcome, wave, rewards, id, alive);
            this.level = level;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.level = 0;
        }

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_FightResultMutantListEntry(output);
        }

        public function serializeAs_FightResultMutantListEntry(output:IDataOutput):void
        {
            super.serializeAs_FightResultFighterListEntry(output);
            if ((((this.level < 0)) || ((this.level > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.level) + ") on element level.")));
            };
            output.writeShort(this.level);
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_FightResultMutantListEntry(input);
        }

        public function deserializeAs_FightResultMutantListEntry(input:IDataInput):void
        {
            super.deserialize(input);
            this.level = input.readUnsignedShort();
            if ((((this.level < 0)) || ((this.level > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.level) + ") on element of FightResultMutantListEntry.level.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.fight

