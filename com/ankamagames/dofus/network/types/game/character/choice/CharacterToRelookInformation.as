package com.ankamagames.dofus.network.types.game.character.choice
{
    import com.ankamagames.dofus.network.types.game.character.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CharacterToRelookInformation extends AbstractCharacterInformation implements INetworkType
    {
        public var cosmeticId:uint = 0;
        public static const protocolId:uint = 399;

        public function CharacterToRelookInformation()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 399;
        }// end function

        public function initCharacterToRelookInformation(param1:uint = 0, param2:uint = 0) : CharacterToRelookInformation
        {
            super.initAbstractCharacterInformation(param1);
            this.cosmeticId = param2;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.cosmeticId = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_CharacterToRelookInformation(param1);
            return;
        }// end function

        public function serializeAs_CharacterToRelookInformation(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractCharacterInformation(param1);
            if (this.cosmeticId < 0)
            {
                throw new Error("Forbidden value (" + this.cosmeticId + ") on element cosmeticId.");
            }
            param1.writeInt(this.cosmeticId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CharacterToRelookInformation(param1);
            return;
        }// end function

        public function deserializeAs_CharacterToRelookInformation(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.cosmeticId = param1.readInt();
            if (this.cosmeticId < 0)
            {
                throw new Error("Forbidden value (" + this.cosmeticId + ") on element of CharacterToRelookInformation.cosmeticId.");
            }
            return;
        }// end function

    }
}
