package com.ankamagames.dofus.network.types.game.character
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class CharacterMinimalPlusLookInformations extends CharacterMinimalInformations implements INetworkType 
    {

        public static const protocolId:uint = 163;

        public var entityLook:EntityLook;

        public function CharacterMinimalPlusLookInformations()
        {
            this.entityLook = new EntityLook();
            super();
        }

        override public function getTypeId():uint
        {
            return (163);
        }

        public function initCharacterMinimalPlusLookInformations(id:uint=0, level:uint=0, name:String="", entityLook:EntityLook=null):CharacterMinimalPlusLookInformations
        {
            super.initCharacterMinimalInformations(id, level, name);
            this.entityLook = entityLook;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.entityLook = new EntityLook();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_CharacterMinimalPlusLookInformations(output);
        }

        public function serializeAs_CharacterMinimalPlusLookInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_CharacterMinimalInformations(output);
            this.entityLook.serializeAs_EntityLook(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CharacterMinimalPlusLookInformations(input);
        }

        public function deserializeAs_CharacterMinimalPlusLookInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.entityLook = new EntityLook();
            this.entityLook.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.types.game.character

