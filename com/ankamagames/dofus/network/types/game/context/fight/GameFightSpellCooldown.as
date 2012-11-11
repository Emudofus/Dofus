package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightSpellCooldown extends Object implements INetworkType
    {
        public var spellId:int = 0;
        public var cooldown:uint = 0;
        public static const protocolId:uint = 205;

        public function GameFightSpellCooldown()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 205;
        }// end function

        public function initGameFightSpellCooldown(param1:int = 0, param2:uint = 0) : GameFightSpellCooldown
        {
            this.spellId = param1;
            this.cooldown = param2;
            return this;
        }// end function

        public function reset() : void
        {
            this.spellId = 0;
            this.cooldown = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameFightSpellCooldown(param1);
            return;
        }// end function

        public function serializeAs_GameFightSpellCooldown(param1:IDataOutput) : void
        {
            param1.writeInt(this.spellId);
            if (this.cooldown < 0)
            {
                throw new Error("Forbidden value (" + this.cooldown + ") on element cooldown.");
            }
            param1.writeByte(this.cooldown);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightSpellCooldown(param1);
            return;
        }// end function

        public function deserializeAs_GameFightSpellCooldown(param1:IDataInput) : void
        {
            this.spellId = param1.readInt();
            this.cooldown = param1.readByte();
            if (this.cooldown < 0)
            {
                throw new Error("Forbidden value (" + this.cooldown + ") on element of GameFightSpellCooldown.cooldown.");
            }
            return;
        }// end function

    }
}
