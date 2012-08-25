package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.character.restriction.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class HumanInformations extends Object implements INetworkType
    {
        public var followingCharactersLook:Vector.<EntityLook>;
        public var emoteId:int = 0;
        public var emoteStartTime:Number = 0;
        public var restrictions:ActorRestrictionsInformations;
        public var titleId:uint = 0;
        public var titleParam:String = "";
        public static const protocolId:uint = 157;

        public function HumanInformations()
        {
            this.followingCharactersLook = new Vector.<EntityLook>;
            this.restrictions = new ActorRestrictionsInformations();
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 157;
        }// end function

        public function initHumanInformations(param1:Vector.<EntityLook> = null, param2:int = 0, param3:Number = 0, param4:ActorRestrictionsInformations = null, param5:uint = 0, param6:String = "") : HumanInformations
        {
            this.followingCharactersLook = param1;
            this.emoteId = param2;
            this.emoteStartTime = param3;
            this.restrictions = param4;
            this.titleId = param5;
            this.titleParam = param6;
            return this;
        }// end function

        public function reset() : void
        {
            this.followingCharactersLook = new Vector.<EntityLook>;
            this.emoteId = 0;
            this.emoteStartTime = 0;
            this.restrictions = new ActorRestrictionsInformations();
            this.titleParam = "";
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_HumanInformations(param1);
            return;
        }// end function

        public function serializeAs_HumanInformations(param1:IDataOutput) : void
        {
            param1.writeShort(this.followingCharactersLook.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.followingCharactersLook.length)
            {
                
                (this.followingCharactersLook[_loc_2] as EntityLook).serializeAs_EntityLook(param1);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeByte(this.emoteId);
            param1.writeDouble(this.emoteStartTime);
            this.restrictions.serializeAs_ActorRestrictionsInformations(param1);
            if (this.titleId < 0)
            {
                throw new Error("Forbidden value (" + this.titleId + ") on element titleId.");
            }
            param1.writeShort(this.titleId);
            param1.writeUTF(this.titleParam);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_HumanInformations(param1);
            return;
        }// end function

        public function deserializeAs_HumanInformations(param1:IDataInput) : void
        {
            var _loc_4:EntityLook = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new EntityLook();
                _loc_4.deserialize(param1);
                this.followingCharactersLook.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            this.emoteId = param1.readByte();
            this.emoteStartTime = param1.readDouble();
            this.restrictions = new ActorRestrictionsInformations();
            this.restrictions.deserialize(param1);
            this.titleId = param1.readShort();
            if (this.titleId < 0)
            {
                throw new Error("Forbidden value (" + this.titleId + ") on element of HumanInformations.titleId.");
            }
            this.titleParam = param1.readUTF();
            return;
        }// end function

    }
}
