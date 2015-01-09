package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class GameFightMonsterInformations extends GameFightAIInformations implements INetworkType 
    {

        public static const protocolId:uint = 29;

        public var creatureGenericId:uint = 0;
        public var creatureGrade:uint = 0;


        override public function getTypeId():uint
        {
            return (29);
        }

        public function initGameFightMonsterInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, teamId:uint=2, wave:uint=0, alive:Boolean=false, stats:GameFightMinimalStats=null, previousPositions:Vector.<uint>=null, creatureGenericId:uint=0, creatureGrade:uint=0):GameFightMonsterInformations
        {
            super.initGameFightAIInformations(contextualId, look, disposition, teamId, wave, alive, stats, previousPositions);
            this.creatureGenericId = creatureGenericId;
            this.creatureGrade = creatureGrade;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.creatureGenericId = 0;
            this.creatureGrade = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameFightMonsterInformations(output);
        }

        public function serializeAs_GameFightMonsterInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_GameFightAIInformations(output);
            if (this.creatureGenericId < 0)
            {
                throw (new Error((("Forbidden value (" + this.creatureGenericId) + ") on element creatureGenericId.")));
            };
            output.writeVarShort(this.creatureGenericId);
            if (this.creatureGrade < 0)
            {
                throw (new Error((("Forbidden value (" + this.creatureGrade) + ") on element creatureGrade.")));
            };
            output.writeByte(this.creatureGrade);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightMonsterInformations(input);
        }

        public function deserializeAs_GameFightMonsterInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.creatureGenericId = input.readVarUhShort();
            if (this.creatureGenericId < 0)
            {
                throw (new Error((("Forbidden value (" + this.creatureGenericId) + ") on element of GameFightMonsterInformations.creatureGenericId.")));
            };
            this.creatureGrade = input.readByte();
            if (this.creatureGrade < 0)
            {
                throw (new Error((("Forbidden value (" + this.creatureGrade) + ") on element of GameFightMonsterInformations.creatureGrade.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.fight

