package com.ankamagames.dofus.network.types.game.character.choice
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class CharacterToRecolorInformation extends AbstractCharacterToRefurbishInformation implements INetworkType 
    {

        public static const protocolId:uint = 212;


        override public function getTypeId():uint
        {
            return (212);
        }

        public function initCharacterToRecolorInformation(id:uint=0, colors:Vector.<int>=null, cosmeticId:uint=0):CharacterToRecolorInformation
        {
            super.initAbstractCharacterToRefurbishInformation(id, colors, cosmeticId);
            return (this);
        }

        override public function reset():void
        {
            super.reset();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_CharacterToRecolorInformation(output);
        }

        public function serializeAs_CharacterToRecolorInformation(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractCharacterToRefurbishInformation(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CharacterToRecolorInformation(input);
        }

        public function deserializeAs_CharacterToRecolorInformation(input:ICustomDataInput):void
        {
            super.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.types.game.character.choice

