package com.ankamagames.dofus.network.types.game.paddock
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PaddockContentInformations extends PaddockInformations implements INetworkType
    {
        public var paddockId:int = 0;
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var mapId:int = 0;
        public var subAreaId:uint = 0;
        public var abandonned:Boolean = false;
        public var mountsInformations:Vector.<MountInformationsForPaddock>;
        public static const protocolId:uint = 183;

        public function PaddockContentInformations()
        {
            this.mountsInformations = new Vector.<MountInformationsForPaddock>;
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 183;
        }// end function

        public function initPaddockContentInformations(param1:uint = 0, param2:uint = 0, param3:int = 0, param4:int = 0, param5:int = 0, param6:int = 0, param7:uint = 0, param8:Boolean = false, param9:Vector.<MountInformationsForPaddock> = null) : PaddockContentInformations
        {
            super.initPaddockInformations(param1, param2);
            this.paddockId = param3;
            this.worldX = param4;
            this.worldY = param5;
            this.mapId = param6;
            this.subAreaId = param7;
            this.abandonned = param8;
            this.mountsInformations = param9;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.paddockId = 0;
            this.worldX = 0;
            this.worldY = 0;
            this.mapId = 0;
            this.subAreaId = 0;
            this.abandonned = false;
            this.mountsInformations = new Vector.<MountInformationsForPaddock>;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_PaddockContentInformations(param1);
            return;
        }// end function

        public function serializeAs_PaddockContentInformations(param1:IDataOutput) : void
        {
            super.serializeAs_PaddockInformations(param1);
            param1.writeInt(this.paddockId);
            if (this.worldX < -255 || this.worldX > 255)
            {
                throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
            }
            param1.writeShort(this.worldX);
            if (this.worldY < -255 || this.worldY > 255)
            {
                throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
            }
            param1.writeShort(this.worldY);
            param1.writeInt(this.mapId);
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
            }
            param1.writeShort(this.subAreaId);
            param1.writeBoolean(this.abandonned);
            param1.writeShort(this.mountsInformations.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.mountsInformations.length)
            {
                
                (this.mountsInformations[_loc_2] as MountInformationsForPaddock).serializeAs_MountInformationsForPaddock(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PaddockContentInformations(param1);
            return;
        }// end function

        public function deserializeAs_PaddockContentInformations(param1:IDataInput) : void
        {
            var _loc_4:MountInformationsForPaddock = null;
            super.deserialize(param1);
            this.paddockId = param1.readInt();
            this.worldX = param1.readShort();
            if (this.worldX < -255 || this.worldX > 255)
            {
                throw new Error("Forbidden value (" + this.worldX + ") on element of PaddockContentInformations.worldX.");
            }
            this.worldY = param1.readShort();
            if (this.worldY < -255 || this.worldY > 255)
            {
                throw new Error("Forbidden value (" + this.worldY + ") on element of PaddockContentInformations.worldY.");
            }
            this.mapId = param1.readInt();
            this.subAreaId = param1.readShort();
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element of PaddockContentInformations.subAreaId.");
            }
            this.abandonned = param1.readBoolean();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new MountInformationsForPaddock();
                _loc_4.deserialize(param1);
                this.mountsInformations.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
