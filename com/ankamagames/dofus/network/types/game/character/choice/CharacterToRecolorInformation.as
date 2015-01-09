package com.ankamagames.dofus.network.types.game.character.choice
{
    import com.ankamagames.dofus.network.types.game.character.AbstractCharacterInformation;
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class CharacterToRecolorInformation extends AbstractCharacterInformation implements INetworkType 
    {

        public static const protocolId:uint = 212;

        public var colors:Vector.<int>;

        public function CharacterToRecolorInformation()
        {
            this.colors = new Vector.<int>();
            super();
        }

        override public function getTypeId():uint
        {
            return (212);
        }

        public function initCharacterToRecolorInformation(id:uint=0, colors:Vector.<int>=null):CharacterToRecolorInformation
        {
            super.initAbstractCharacterInformation(id);
            this.colors = colors;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.colors = new Vector.<int>();
        }

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_CharacterToRecolorInformation(output);
        }

        public function serializeAs_CharacterToRecolorInformation(output:IDataOutput):void
        {
            super.serializeAs_AbstractCharacterInformation(output);
            output.writeShort(this.colors.length);
            var _i1:uint;
            while (_i1 < this.colors.length)
            {
                output.writeInt(this.colors[_i1]);
                _i1++;
            };
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_CharacterToRecolorInformation(input);
        }

        public function deserializeAs_CharacterToRecolorInformation(input:IDataInput):void
        {
            var _val1:int;
            super.deserialize(input);
            var _colorsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _colorsLen)
            {
                _val1 = input.readInt();
                this.colors.push(_val1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.character.choice

