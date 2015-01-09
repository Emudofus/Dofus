package com.ankamagames.dofus.network.types.game.character
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class AbstractCharacterInformation implements INetworkType 
    {

        public static const protocolId:uint = 400;

        public var id:uint = 0;


        public function getTypeId():uint
        {
            return (400);
        }

        public function initAbstractCharacterInformation(id:uint=0):AbstractCharacterInformation
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
            this.serializeAs_AbstractCharacterInformation(output);
        }

        public function serializeAs_AbstractCharacterInformation(output:ICustomDataOutput):void
        {
            if (this.id < 0)
            {
                throw (new Error((("Forbidden value (" + this.id) + ") on element id.")));
            };
            output.writeVarInt(this.id);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AbstractCharacterInformation(input);
        }

        public function deserializeAs_AbstractCharacterInformation(input:ICustomDataInput):void
        {
            this.id = input.readVarUhInt();
            if (this.id < 0)
            {
                throw (new Error((("Forbidden value (" + this.id) + ") on element of AbstractCharacterInformation.id.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.character

