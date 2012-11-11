package com.ankamagames.dofus.network.types.game.character.choice
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CharacterToRecolorInformation extends Object implements INetworkType
    {
        public var id:uint = 0;
        public var colors:Vector.<int>;
        public static const protocolId:uint = 212;

        public function CharacterToRecolorInformation()
        {
            this.colors = new Vector.<int>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 212;
        }// end function

        public function initCharacterToRecolorInformation(param1:uint = 0, param2:Vector.<int> = null) : CharacterToRecolorInformation
        {
            this.id = param1;
            this.colors = param2;
            return this;
        }// end function

        public function reset() : void
        {
            this.id = 0;
            this.colors = new Vector.<int>;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_CharacterToRecolorInformation(param1);
            return;
        }// end function

        public function serializeAs_CharacterToRecolorInformation(param1:IDataOutput) : void
        {
            if (this.id < 0)
            {
                throw new Error("Forbidden value (" + this.id + ") on element id.");
            }
            param1.writeInt(this.id);
            param1.writeShort(this.colors.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.colors.length)
            {
                
                param1.writeInt(this.colors[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CharacterToRecolorInformation(param1);
            return;
        }// end function

        public function deserializeAs_CharacterToRecolorInformation(param1:IDataInput) : void
        {
            var _loc_4:* = 0;
            this.id = param1.readInt();
            if (this.id < 0)
            {
                throw new Error("Forbidden value (" + this.id + ") on element of CharacterToRecolorInformation.id.");
            }
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
