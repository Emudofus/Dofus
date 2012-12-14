package com.ankamagames.dofus.network.types.game.character.choice
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.character.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CharacterToRecolorInformation extends AbstractCharacterInformation implements INetworkType
    {
        public var colors:Vector.<int>;
        public static const protocolId:uint = 212;

        public function CharacterToRecolorInformation()
        {
            this.colors = new Vector.<int>;
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 212;
        }// end function

        public function initCharacterToRecolorInformation(param1:uint = 0, param2:Vector.<int> = null) : CharacterToRecolorInformation
        {
            super.initAbstractCharacterInformation(param1);
            this.colors = param2;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.colors = new Vector.<int>;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_CharacterToRecolorInformation(param1);
            return;
        }// end function

        public function serializeAs_CharacterToRecolorInformation(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractCharacterInformation(param1);
            param1.writeShort(this.colors.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.colors.length)
            {
                
                param1.writeInt(this.colors[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CharacterToRecolorInformation(param1);
            return;
        }// end function

        public function deserializeAs_CharacterToRecolorInformation(param1:IDataInput) : void
        {
            var _loc_4:* = 0;
            super.deserialize(param1);
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readInt();
                this.colors.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
