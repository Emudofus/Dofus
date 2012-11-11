package com.ankamagames.dofus.network.types.game.shortcut
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ShortcutObjectItem extends ShortcutObject implements INetworkType
    {
        public var itemUID:int = 0;
        public var itemGID:int = 0;
        public static const protocolId:uint = 371;

        public function ShortcutObjectItem()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 371;
        }// end function

        public function initShortcutObjectItem(param1:uint = 0, param2:int = 0, param3:int = 0) : ShortcutObjectItem
        {
            super.initShortcutObject(param1);
            this.itemUID = param2;
            this.itemGID = param3;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.itemUID = 0;
            this.itemGID = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ShortcutObjectItem(param1);
            return;
        }// end function

        public function serializeAs_ShortcutObjectItem(param1:IDataOutput) : void
        {
            super.serializeAs_ShortcutObject(param1);
            param1.writeInt(this.itemUID);
            param1.writeInt(this.itemGID);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ShortcutObjectItem(param1);
            return;
        }// end function

        public function deserializeAs_ShortcutObjectItem(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.itemUID = param1.readInt();
            this.itemGID = param1.readInt();
            return;
        }// end function

    }
}
