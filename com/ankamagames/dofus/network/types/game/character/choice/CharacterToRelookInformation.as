package com.ankamagames.dofus.network.types.game.character.choice
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class CharacterToRelookInformation extends AbstractCharacterToRefurbishInformation implements INetworkType 
    {

        public static const protocolId:uint = 399;


        override public function getTypeId():uint
        {
            return (399);
        }

        public function initCharacterToRelookInformation(id:uint=0, colors:Vector.<int>=null, cosmeticId:uint=0):CharacterToRelookInformation
        {
            super.initAbstractCharacterToRefurbishInformation(id, colors, cosmeticId);
            return (this);
        }

        override public function reset():void
        {
            super.reset();
        }

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_CharacterToRelookInformation(output);
        }

        public function serializeAs_CharacterToRelookInformation(output:IDataOutput):void
        {
            super.serializeAs_AbstractCharacterToRefurbishInformation(output);
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_CharacterToRelookInformation(input);
        }

        public function deserializeAs_CharacterToRelookInformation(input:IDataInput):void
        {
            super.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.types.game.character.choice

