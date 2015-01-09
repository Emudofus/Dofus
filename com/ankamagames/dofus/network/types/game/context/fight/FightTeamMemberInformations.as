package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class FightTeamMemberInformations implements INetworkType 
    {

        public static const protocolId:uint = 44;

        public var id:int = 0;


        public function getTypeId():uint
        {
            return (44);
        }

        public function initFightTeamMemberInformations(id:int=0):FightTeamMemberInformations
        {
            this.id = id;
            return (this);
        }

        public function reset():void
        {
            this.id = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_FightTeamMemberInformations(output);
        }

        public function serializeAs_FightTeamMemberInformations(output:ICustomDataOutput):void
        {
            output.writeInt(this.id);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_FightTeamMemberInformations(input);
        }

        public function deserializeAs_FightTeamMemberInformations(input:ICustomDataInput):void
        {
            this.id = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.fight

