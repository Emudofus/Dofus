﻿package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class MonsterInGroupLightInformations implements INetworkType 
    {

        public static const protocolId:uint = 395;

        public var creatureGenericId:int = 0;
        public var grade:uint = 0;


        public function getTypeId():uint
        {
            return (395);
        }

        public function initMonsterInGroupLightInformations(creatureGenericId:int=0, grade:uint=0):MonsterInGroupLightInformations
        {
            this.creatureGenericId = creatureGenericId;
            this.grade = grade;
            return (this);
        }

        public function reset():void
        {
            this.creatureGenericId = 0;
            this.grade = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_MonsterInGroupLightInformations(output);
        }

        public function serializeAs_MonsterInGroupLightInformations(output:ICustomDataOutput):void
        {
            output.writeInt(this.creatureGenericId);
            if (this.grade < 0)
            {
                throw (new Error((("Forbidden value (" + this.grade) + ") on element grade.")));
            };
            output.writeByte(this.grade);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MonsterInGroupLightInformations(input);
        }

        public function deserializeAs_MonsterInGroupLightInformations(input:ICustomDataInput):void
        {
            this.creatureGenericId = input.readInt();
            this.grade = input.readByte();
            if (this.grade < 0)
            {
                throw (new Error((("Forbidden value (" + this.grade) + ") on element of MonsterInGroupLightInformations.grade.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay

