package com.ankamagames.dofus.network.types.game.shortcut
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ShortcutObject extends Shortcut implements INetworkType
    {
        public static const protocolId:uint = 367;

        public function ShortcutObject()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 367;
        }// end function

        public function initShortcutObject(param1:uint = 0) : ShortcutObject
        {
            super.initShortcut(param1);
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ShortcutObject(param1);
            return;
        }// end function

        public function serializeAs_ShortcutObject(param1:IDataOutput) : void
        {
            super.serializeAs_Shortcut(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ShortcutObject(param1);
            return;
        }// end function

        public function deserializeAs_ShortcutObject(param1:IDataInput) : void
        {
            super.deserialize(param1);
            return;
        }// end function

    }
}
