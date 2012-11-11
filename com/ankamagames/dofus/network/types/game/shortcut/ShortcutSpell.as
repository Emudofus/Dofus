package com.ankamagames.dofus.network.types.game.shortcut
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ShortcutSpell extends Shortcut implements INetworkType
    {
        public var spellId:uint = 0;
        public static const protocolId:uint = 368;

        public function ShortcutSpell()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 368;
        }// end function

        public function initShortcutSpell(param1:uint = 0, param2:uint = 0) : ShortcutSpell
        {
            super.initShortcut(param1);
            this.spellId = param2;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.spellId = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ShortcutSpell(param1);
            return;
        }// end function

        public function serializeAs_ShortcutSpell(param1:IDataOutput) : void
        {
            super.serializeAs_Shortcut(param1);
            if (this.spellId < 0)
            {
                throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
            }
            param1.writeShort(this.spellId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ShortcutSpell(param1);
            return;
        }// end function

        public function deserializeAs_ShortcutSpell(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.spellId = param1.readShort();
            if (this.spellId < 0)
            {
                throw new Error("Forbidden value (" + this.spellId + ") on element of ShortcutSpell.spellId.");
            }
            return;
        }// end function

    }
}
