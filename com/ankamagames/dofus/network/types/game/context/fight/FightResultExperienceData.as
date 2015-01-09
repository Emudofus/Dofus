package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class FightResultExperienceData extends FightResultAdditionalData implements INetworkType 
    {

        public static const protocolId:uint = 192;

        public var experience:Number = 0;
        public var showExperience:Boolean = false;
        public var experienceLevelFloor:Number = 0;
        public var showExperienceLevelFloor:Boolean = false;
        public var experienceNextLevelFloor:Number = 0;
        public var showExperienceNextLevelFloor:Boolean = false;
        public var experienceFightDelta:int = 0;
        public var showExperienceFightDelta:Boolean = false;
        public var experienceForGuild:uint = 0;
        public var showExperienceForGuild:Boolean = false;
        public var experienceForMount:uint = 0;
        public var showExperienceForMount:Boolean = false;
        public var isIncarnationExperience:Boolean = false;
        public var rerollExperienceMul:uint = 0;


        override public function getTypeId():uint
        {
            return (192);
        }

        public function initFightResultExperienceData(experience:Number=0, showExperience:Boolean=false, experienceLevelFloor:Number=0, showExperienceLevelFloor:Boolean=false, experienceNextLevelFloor:Number=0, showExperienceNextLevelFloor:Boolean=false, experienceFightDelta:int=0, showExperienceFightDelta:Boolean=false, experienceForGuild:uint=0, showExperienceForGuild:Boolean=false, experienceForMount:uint=0, showExperienceForMount:Boolean=false, isIncarnationExperience:Boolean=false, rerollExperienceMul:uint=0):FightResultExperienceData
        {
            this.experience = experience;
            this.showExperience = showExperience;
            this.experienceLevelFloor = experienceLevelFloor;
            this.showExperienceLevelFloor = showExperienceLevelFloor;
            this.experienceNextLevelFloor = experienceNextLevelFloor;
            this.showExperienceNextLevelFloor = showExperienceNextLevelFloor;
            this.experienceFightDelta = experienceFightDelta;
            this.showExperienceFightDelta = showExperienceFightDelta;
            this.experienceForGuild = experienceForGuild;
            this.showExperienceForGuild = showExperienceForGuild;
            this.experienceForMount = experienceForMount;
            this.showExperienceForMount = showExperienceForMount;
            this.isIncarnationExperience = isIncarnationExperience;
            this.rerollExperienceMul = rerollExperienceMul;
            return (this);
        }

        override public function reset():void
        {
            this.experience = 0;
            this.showExperience = false;
            this.experienceLevelFloor = 0;
            this.showExperienceLevelFloor = false;
            this.experienceNextLevelFloor = 0;
            this.showExperienceNextLevelFloor = false;
            this.experienceFightDelta = 0;
            this.showExperienceFightDelta = false;
            this.experienceForGuild = 0;
            this.showExperienceForGuild = false;
            this.experienceForMount = 0;
            this.showExperienceForMount = false;
            this.isIncarnationExperience = false;
            this.rerollExperienceMul = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_FightResultExperienceData(output);
        }

        public function serializeAs_FightResultExperienceData(output:ICustomDataOutput):void
        {
            super.serializeAs_FightResultAdditionalData(output);
            var _box0:uint;
            _box0 = BooleanByteWrapper.setFlag(_box0, 0, this.showExperience);
            _box0 = BooleanByteWrapper.setFlag(_box0, 1, this.showExperienceLevelFloor);
            _box0 = BooleanByteWrapper.setFlag(_box0, 2, this.showExperienceNextLevelFloor);
            _box0 = BooleanByteWrapper.setFlag(_box0, 3, this.showExperienceFightDelta);
            _box0 = BooleanByteWrapper.setFlag(_box0, 4, this.showExperienceForGuild);
            _box0 = BooleanByteWrapper.setFlag(_box0, 5, this.showExperienceForMount);
            _box0 = BooleanByteWrapper.setFlag(_box0, 6, this.isIncarnationExperience);
            output.writeByte(_box0);
            if ((((this.experience < 0)) || ((this.experience > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.experience) + ") on element experience.")));
            };
            output.writeVarLong(this.experience);
            if ((((this.experienceLevelFloor < 0)) || ((this.experienceLevelFloor > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.experienceLevelFloor) + ") on element experienceLevelFloor.")));
            };
            output.writeVarLong(this.experienceLevelFloor);
            if ((((this.experienceNextLevelFloor < 0)) || ((this.experienceNextLevelFloor > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.experienceNextLevelFloor) + ") on element experienceNextLevelFloor.")));
            };
            output.writeDouble(this.experienceNextLevelFloor);
            output.writeVarInt(this.experienceFightDelta);
            if (this.experienceForGuild < 0)
            {
                throw (new Error((("Forbidden value (" + this.experienceForGuild) + ") on element experienceForGuild.")));
            };
            output.writeVarInt(this.experienceForGuild);
            if (this.experienceForMount < 0)
            {
                throw (new Error((("Forbidden value (" + this.experienceForMount) + ") on element experienceForMount.")));
            };
            output.writeVarInt(this.experienceForMount);
            if (this.rerollExperienceMul < 0)
            {
                throw (new Error((("Forbidden value (" + this.rerollExperienceMul) + ") on element rerollExperienceMul.")));
            };
            output.writeByte(this.rerollExperienceMul);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_FightResultExperienceData(input);
        }

        public function deserializeAs_FightResultExperienceData(input:ICustomDataInput):void
        {
            super.deserialize(input);
            var _box0:uint = input.readByte();
            this.showExperience = BooleanByteWrapper.getFlag(_box0, 0);
            this.showExperienceLevelFloor = BooleanByteWrapper.getFlag(_box0, 1);
            this.showExperienceNextLevelFloor = BooleanByteWrapper.getFlag(_box0, 2);
            this.showExperienceFightDelta = BooleanByteWrapper.getFlag(_box0, 3);
            this.showExperienceForGuild = BooleanByteWrapper.getFlag(_box0, 4);
            this.showExperienceForMount = BooleanByteWrapper.getFlag(_box0, 5);
            this.isIncarnationExperience = BooleanByteWrapper.getFlag(_box0, 6);
            this.experience = input.readVarUhLong();
            if ((((this.experience < 0)) || ((this.experience > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.experience) + ") on element of FightResultExperienceData.experience.")));
            };
            this.experienceLevelFloor = input.readVarUhLong();
            if ((((this.experienceLevelFloor < 0)) || ((this.experienceLevelFloor > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.experienceLevelFloor) + ") on element of FightResultExperienceData.experienceLevelFloor.")));
            };
            this.experienceNextLevelFloor = input.readDouble();
            if ((((this.experienceNextLevelFloor < 0)) || ((this.experienceNextLevelFloor > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.experienceNextLevelFloor) + ") on element of FightResultExperienceData.experienceNextLevelFloor.")));
            };
            this.experienceFightDelta = input.readVarInt();
            this.experienceForGuild = input.readVarUhInt();
            if (this.experienceForGuild < 0)
            {
                throw (new Error((("Forbidden value (" + this.experienceForGuild) + ") on element of FightResultExperienceData.experienceForGuild.")));
            };
            this.experienceForMount = input.readVarUhInt();
            if (this.experienceForMount < 0)
            {
                throw (new Error((("Forbidden value (" + this.experienceForMount) + ") on element of FightResultExperienceData.experienceForMount.")));
            };
            this.rerollExperienceMul = input.readByte();
            if (this.rerollExperienceMul < 0)
            {
                throw (new Error((("Forbidden value (" + this.rerollExperienceMul) + ") on element of FightResultExperienceData.rerollExperienceMul.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.fight

