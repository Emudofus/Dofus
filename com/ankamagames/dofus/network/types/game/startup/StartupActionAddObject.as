package com.ankamagames.dofus.network.types.game.startup
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class StartupActionAddObject extends Object implements INetworkType
    {
        public var uid:uint = 0;
        public var title:String = "";
        public var text:String = "";
        public var descUrl:String = "";
        public var pictureUrl:String = "";
        public var items:Vector.<ObjectItemInformationWithQuantity>;
        public static const protocolId:uint = 52;

        public function StartupActionAddObject()
        {
            this.items = new Vector.<ObjectItemInformationWithQuantity>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 52;
        }// end function

        public function initStartupActionAddObject(param1:uint = 0, param2:String = "", param3:String = "", param4:String = "", param5:String = "", param6:Vector.<ObjectItemInformationWithQuantity> = null) : StartupActionAddObject
        {
            this.uid = param1;
            this.title = param2;
            this.text = param3;
            this.descUrl = param4;
            this.pictureUrl = param5;
            this.items = param6;
            return this;
        }// end function

        public function reset() : void
        {
            this.uid = 0;
            this.title = "";
            this.text = "";
            this.descUrl = "";
            this.pictureUrl = "";
            this.items = new Vector.<ObjectItemInformationWithQuantity>;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_StartupActionAddObject(param1);
            return;
        }// end function

        public function serializeAs_StartupActionAddObject(param1:IDataOutput) : void
        {
            if (this.uid < 0)
            {
                throw new Error("Forbidden value (" + this.uid + ") on element uid.");
            }
            param1.writeInt(this.uid);
            param1.writeUTF(this.title);
            param1.writeUTF(this.text);
            param1.writeUTF(this.descUrl);
            param1.writeUTF(this.pictureUrl);
            param1.writeShort(this.items.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.items.length)
            {
                
                (this.items[_loc_2] as ObjectItemInformationWithQuantity).serializeAs_ObjectItemInformationWithQuantity(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_StartupActionAddObject(param1);
            return;
        }// end function

        public function deserializeAs_StartupActionAddObject(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            this.uid = param1.readInt();
            if (this.uid < 0)
            {
                throw new Error("Forbidden value (" + this.uid + ") on element of StartupActionAddObject.uid.");
            }
            this.title = param1.readUTF();
            this.text = param1.readUTF();
            this.descUrl = param1.readUTF();
            this.pictureUrl = param1.readUTF();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new ObjectItemInformationWithQuantity();
                _loc_4.deserialize(param1);
                this.items.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
