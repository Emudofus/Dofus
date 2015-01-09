package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class GameRolePlayMutantInformations extends GameRolePlayHumanoidInformations implements INetworkType 
    {

        public static const protocolId:uint = 3;

        public var monsterId:uint = 0;
        public var powerLevel:int = 0;


        override public function getTypeId():uint
        {
            return (3);
        }

        public function initGameRolePlayMutantInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, name:String="", humanoidInfo:HumanInformations=null, accountId:uint=0, monsterId:uint=0, powerLevel:int=0):GameRolePlayMutantInformations
        {
            super.initGameRolePlayHumanoidInformations(contextualId, look, disposition, name, humanoidInfo, accountId);
            this.monsterId = monsterId;
            this.powerLevel = powerLevel;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.monsterId = 0;
            this.powerLevel = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameRolePlayMutantInformations(output);
        }

        public function serializeAs_GameRolePlayMutantInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_GameRolePlayHumanoidInformations(output);
            if (this.monsterId < 0)
            {
                throw (new Error((("Forbidden value (" + this.monsterId) + ") on element monsterId.")));
            };
            output.writeVarShort(this.monsterId);
            output.writeByte(this.powerLevel);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameRolePlayMutantInformations(input);
        }

        public function deserializeAs_GameRolePlayMutantInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.monsterId = input.readVarUhShort();
            if (this.monsterId < 0)
            {
                throw (new Error((("Forbidden value (" + this.monsterId) + ") on element of GameRolePlayMutantInformations.monsterId.")));
            };
            this.powerLevel = input.readByte();
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay

