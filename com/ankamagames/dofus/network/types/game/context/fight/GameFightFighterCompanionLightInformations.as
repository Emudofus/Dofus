package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class GameFightFighterCompanionLightInformations extends GameFightFighterLightInformations implements INetworkType 
    {

        public static const protocolId:uint = 454;

        public var companionId:uint = 0;
        public var masterId:int = 0;


        override public function getTypeId():uint
        {
            return (454);
        }

        public function initGameFightFighterCompanionLightInformations(id:int=0, wave:uint=0, level:uint=0, breed:int=0, sex:Boolean=false, alive:Boolean=false, companionId:uint=0, masterId:int=0):GameFightFighterCompanionLightInformations
        {
            super.initGameFightFighterLightInformations(id, wave, level, breed, sex, alive);
            this.companionId = companionId;
            this.masterId = masterId;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.companionId = 0;
            this.masterId = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameFightFighterCompanionLightInformations(output);
        }

        public function serializeAs_GameFightFighterCompanionLightInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_GameFightFighterLightInformations(output);
            if (this.companionId < 0)
            {
                throw (new Error((("Forbidden value (" + this.companionId) + ") on element companionId.")));
            };
            output.writeByte(this.companionId);
            output.writeInt(this.masterId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightFighterCompanionLightInformations(input);
        }

        public function deserializeAs_GameFightFighterCompanionLightInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.companionId = input.readByte();
            if (this.companionId < 0)
            {
                throw (new Error((("Forbidden value (" + this.companionId) + ") on element of GameFightFighterCompanionLightInformations.companionId.")));
            };
            this.masterId = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.fight

