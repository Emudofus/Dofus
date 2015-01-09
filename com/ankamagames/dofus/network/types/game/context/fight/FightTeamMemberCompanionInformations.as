package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class FightTeamMemberCompanionInformations extends FightTeamMemberInformations implements INetworkType 
    {

        public static const protocolId:uint = 451;

        public var companionId:uint = 0;
        public var level:uint = 0;
        public var masterId:int = 0;


        override public function getTypeId():uint
        {
            return (451);
        }

        public function initFightTeamMemberCompanionInformations(id:int=0, companionId:uint=0, level:uint=0, masterId:int=0):FightTeamMemberCompanionInformations
        {
            super.initFightTeamMemberInformations(id);
            this.companionId = companionId;
            this.level = level;
            this.masterId = masterId;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.companionId = 0;
            this.level = 0;
            this.masterId = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_FightTeamMemberCompanionInformations(output);
        }

        public function serializeAs_FightTeamMemberCompanionInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_FightTeamMemberInformations(output);
            if (this.companionId < 0)
            {
                throw (new Error((("Forbidden value (" + this.companionId) + ") on element companionId.")));
            };
            output.writeByte(this.companionId);
            if ((((this.level < 1)) || ((this.level > 200))))
            {
                throw (new Error((("Forbidden value (" + this.level) + ") on element level.")));
            };
            output.writeByte(this.level);
            output.writeInt(this.masterId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_FightTeamMemberCompanionInformations(input);
        }

        public function deserializeAs_FightTeamMemberCompanionInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.companionId = input.readByte();
            if (this.companionId < 0)
            {
                throw (new Error((("Forbidden value (" + this.companionId) + ") on element of FightTeamMemberCompanionInformations.companionId.")));
            };
            this.level = input.readUnsignedByte();
            if ((((this.level < 1)) || ((this.level > 200))))
            {
                throw (new Error((("Forbidden value (" + this.level) + ") on element of FightTeamMemberCompanionInformations.level.")));
            };
            this.masterId = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.fight

