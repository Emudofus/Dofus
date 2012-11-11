package com.ankamagames.dofus.network.types.game.character.choice
{
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CharacterHardcoreInformations extends CharacterBaseInformations implements INetworkType
    {
        public var deathState:uint = 0;
        public var deathCount:uint = 0;
        public var deathMaxLevel:uint = 0;
        public static const protocolId:uint = 86;

        public function CharacterHardcoreInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 86;
        }// end function

        public function initCharacterHardcoreInformations(param1:uint = 0, param2:uint = 0, param3:String = "", param4:EntityLook = null, param5:int = 0, param6:Boolean = false, param7:uint = 0, param8:uint = 0, param9:uint = 0) : CharacterHardcoreInformations
        {
            super.initCharacterBaseInformations(param1, param2, param3, param4, param5, param6);
            this.deathState = param7;
            this.deathCount = param8;
            this.deathMaxLevel = param9;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.deathState = 0;
            this.deathCount = 0;
            this.deathMaxLevel = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_CharacterHardcoreInformations(param1);
            return;
        }// end function

        public function serializeAs_CharacterHardcoreInformations(param1:IDataOutput) : void
        {
            super.serializeAs_CharacterBaseInformations(param1);
            param1.writeByte(this.deathState);
            if (this.deathCount < 0)
            {
                throw new Error("Forbidden value (" + this.deathCount + ") on element deathCount.");
            }
            param1.writeShort(this.deathCount);
            if (this.deathMaxLevel < 1 || this.deathMaxLevel > 200)
            {
                throw new Error("Forbidden value (" + this.deathMaxLevel + ") on element deathMaxLevel.");
            }
            param1.writeByte(this.deathMaxLevel);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CharacterHardcoreInformations(param1);
            return;
        }// end function

        public function deserializeAs_CharacterHardcoreInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.deathState = param1.readByte();
            if (this.deathState < 0)
            {
                throw new Error("Forbidden value (" + this.deathState + ") on element of CharacterHardcoreInformations.deathState.");
            }
            this.deathCount = param1.readShort();
            if (this.deathCount < 0)
            {
                throw new Error("Forbidden value (" + this.deathCount + ") on element of CharacterHardcoreInformations.deathCount.");
            }
            this.deathMaxLevel = param1.readUnsignedByte();
            if (this.deathMaxLevel < 1 || this.deathMaxLevel > 200)
            {
                throw new Error("Forbidden value (" + this.deathMaxLevel + ") on element of CharacterHardcoreInformations.deathMaxLevel.");
            }
            return;
        }// end function

    }
}
