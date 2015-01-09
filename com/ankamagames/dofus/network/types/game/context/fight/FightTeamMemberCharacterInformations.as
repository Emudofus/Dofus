package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class FightTeamMemberCharacterInformations extends FightTeamMemberInformations implements INetworkType 
    {

        public static const protocolId:uint = 13;

        public var name:String = "";
        public var level:uint = 0;


        override public function getTypeId():uint
        {
            return (13);
        }

        public function initFightTeamMemberCharacterInformations(id:int=0, name:String="", level:uint=0):FightTeamMemberCharacterInformations
        {
            super.initFightTeamMemberInformations(id);
            this.name = name;
            this.level = level;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.name = "";
            this.level = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_FightTeamMemberCharacterInformations(output);
        }

        public function serializeAs_FightTeamMemberCharacterInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_FightTeamMemberInformations(output);
            output.writeUTF(this.name);
            if ((((this.level < 0)) || ((this.level > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.level) + ") on element level.")));
            };
            output.writeByte(this.level);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_FightTeamMemberCharacterInformations(input);
        }

        public function deserializeAs_FightTeamMemberCharacterInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.name = input.readUTF();
            this.level = input.readUnsignedByte();
            if ((((this.level < 0)) || ((this.level > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.level) + ") on element of FightTeamMemberCharacterInformations.level.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.fight

