package com.ankamagames.dofus.network.types.game.mount
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.data.items.effects.*;
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.jerakine.network.utils.*;
    import flash.utils.*;

    public class MountClientData extends Object implements INetworkType
    {
        public var id:Number = 0;
        public var model:uint = 0;
        public var ancestor:Vector.<uint>;
        public var behaviors:Vector.<uint>;
        public var name:String = "";
        public var sex:Boolean = false;
        public var ownerId:uint = 0;
        public var experience:Number = 0;
        public var experienceForLevel:Number = 0;
        public var experienceForNextLevel:Number = 0;
        public var level:uint = 0;
        public var isRideable:Boolean = false;
        public var maxPods:uint = 0;
        public var isWild:Boolean = false;
        public var stamina:uint = 0;
        public var staminaMax:uint = 0;
        public var maturity:uint = 0;
        public var maturityForAdult:uint = 0;
        public var energy:uint = 0;
        public var energyMax:uint = 0;
        public var serenity:int = 0;
        public var aggressivityMax:int = 0;
        public var serenityMax:uint = 0;
        public var love:uint = 0;
        public var loveMax:uint = 0;
        public var fecondationTime:int = 0;
        public var isFecondationReady:Boolean = false;
        public var boostLimiter:uint = 0;
        public var boostMax:Number = 0;
        public var reproductionCount:int = 0;
        public var reproductionCountMax:uint = 0;
        public var effectList:Vector.<ObjectEffectInteger>;
        public static const protocolId:uint = 178;

        public function MountClientData()
        {
            this.ancestor = new Vector.<uint>;
            this.behaviors = new Vector.<uint>;
            this.effectList = new Vector.<ObjectEffectInteger>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 178;
        }// end function

        public function initMountClientData(param1:Number = 0, param2:uint = 0, param3:Vector.<uint> = null, param4:Vector.<uint> = null, param5:String = "", param6:Boolean = false, param7:uint = 0, param8:Number = 0, param9:Number = 0, param10:Number = 0, param11:uint = 0, param12:Boolean = false, param13:uint = 0, param14:Boolean = false, param15:uint = 0, param16:uint = 0, param17:uint = 0, param18:uint = 0, param19:uint = 0, param20:uint = 0, param21:int = 0, param22:int = 0, param23:uint = 0, param24:uint = 0, param25:uint = 0, param26:int = 0, param27:Boolean = false, param28:uint = 0, param29:Number = 0, param30:int = 0, param31:uint = 0, param32:Vector.<ObjectEffectInteger> = null) : MountClientData
        {
            this.id = param1;
            this.model = param2;
            this.ancestor = param3;
            this.behaviors = param4;
            this.name = param5;
            this.sex = param6;
            this.ownerId = param7;
            this.experience = param8;
            this.experienceForLevel = param9;
            this.experienceForNextLevel = param10;
            this.level = param11;
            this.isRideable = param12;
            this.maxPods = param13;
            this.isWild = param14;
            this.stamina = param15;
            this.staminaMax = param16;
            this.maturity = param17;
            this.maturityForAdult = param18;
            this.energy = param19;
            this.energyMax = param20;
            this.serenity = param21;
            this.aggressivityMax = param22;
            this.serenityMax = param23;
            this.love = param24;
            this.loveMax = param25;
            this.fecondationTime = param26;
            this.isFecondationReady = param27;
            this.boostLimiter = param28;
            this.boostMax = param29;
            this.reproductionCount = param30;
            this.reproductionCountMax = param31;
            this.effectList = param32;
            return this;
        }// end function

        public function reset() : void
        {
            this.id = 0;
            this.model = 0;
            this.ancestor = new Vector.<uint>;
            this.behaviors = new Vector.<uint>;
            this.name = "";
            this.sex = false;
            this.ownerId = 0;
            this.experience = 0;
            this.experienceForLevel = 0;
            this.experienceForNextLevel = 0;
            this.level = 0;
            this.isRideable = false;
            this.maxPods = 0;
            this.isWild = false;
            this.stamina = 0;
            this.staminaMax = 0;
            this.maturity = 0;
            this.maturityForAdult = 0;
            this.energy = 0;
            this.energyMax = 0;
            this.serenity = 0;
            this.aggressivityMax = 0;
            this.serenityMax = 0;
            this.love = 0;
            this.loveMax = 0;
            this.fecondationTime = 0;
            this.isFecondationReady = false;
            this.boostLimiter = 0;
            this.boostMax = 0;
            this.reproductionCount = 0;
            this.reproductionCountMax = 0;
            this.effectList = new Vector.<ObjectEffectInteger>;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_MountClientData(param1);
            return;
        }// end function

        public function serializeAs_MountClientData(param1:IDataOutput) : void
        {
            var _loc_2:* = 0;
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 0, this.sex);
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 1, this.isRideable);
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 2, this.isWild);
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 3, this.isFecondationReady);
            param1.writeByte(_loc_2);
            param1.writeDouble(this.id);
            if (this.model < 0)
            {
                throw new Error("Forbidden value (" + this.model + ") on element model.");
            }
            param1.writeInt(this.model);
            param1.writeShort(this.ancestor.length);
            var _loc_3:* = 0;
            while (_loc_3 < this.ancestor.length)
            {
                
                if (this.ancestor[_loc_3] < 0)
                {
                    throw new Error("Forbidden value (" + this.ancestor[_loc_3] + ") on element 3 (starting at 1) of ancestor.");
                }
                param1.writeInt(this.ancestor[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            param1.writeShort(this.behaviors.length);
            var _loc_4:* = 0;
            while (_loc_4 < this.behaviors.length)
            {
                
                if (this.behaviors[_loc_4] < 0)
                {
                    throw new Error("Forbidden value (" + this.behaviors[_loc_4] + ") on element 4 (starting at 1) of behaviors.");
                }
                param1.writeInt(this.behaviors[_loc_4]);
                _loc_4 = _loc_4 + 1;
            }
            param1.writeUTF(this.name);
            if (this.ownerId < 0)
            {
                throw new Error("Forbidden value (" + this.ownerId + ") on element ownerId.");
            }
            param1.writeInt(this.ownerId);
            param1.writeDouble(this.experience);
            param1.writeDouble(this.experienceForLevel);
            param1.writeDouble(this.experienceForNextLevel);
            if (this.level < 0)
            {
                throw new Error("Forbidden value (" + this.level + ") on element level.");
            }
            param1.writeByte(this.level);
            if (this.maxPods < 0)
            {
                throw new Error("Forbidden value (" + this.maxPods + ") on element maxPods.");
            }
            param1.writeInt(this.maxPods);
            if (this.stamina < 0)
            {
                throw new Error("Forbidden value (" + this.stamina + ") on element stamina.");
            }
            param1.writeInt(this.stamina);
            if (this.staminaMax < 0)
            {
                throw new Error("Forbidden value (" + this.staminaMax + ") on element staminaMax.");
            }
            param1.writeInt(this.staminaMax);
            if (this.maturity < 0)
            {
                throw new Error("Forbidden value (" + this.maturity + ") on element maturity.");
            }
            param1.writeInt(this.maturity);
            if (this.maturityForAdult < 0)
            {
                throw new Error("Forbidden value (" + this.maturityForAdult + ") on element maturityForAdult.");
            }
            param1.writeInt(this.maturityForAdult);
            if (this.energy < 0)
            {
                throw new Error("Forbidden value (" + this.energy + ") on element energy.");
            }
            param1.writeInt(this.energy);
            if (this.energyMax < 0)
            {
                throw new Error("Forbidden value (" + this.energyMax + ") on element energyMax.");
            }
            param1.writeInt(this.energyMax);
            param1.writeInt(this.serenity);
            param1.writeInt(this.aggressivityMax);
            if (this.serenityMax < 0)
            {
                throw new Error("Forbidden value (" + this.serenityMax + ") on element serenityMax.");
            }
            param1.writeInt(this.serenityMax);
            if (this.love < 0)
            {
                throw new Error("Forbidden value (" + this.love + ") on element love.");
            }
            param1.writeInt(this.love);
            if (this.loveMax < 0)
            {
                throw new Error("Forbidden value (" + this.loveMax + ") on element loveMax.");
            }
            param1.writeInt(this.loveMax);
            param1.writeInt(this.fecondationTime);
            if (this.boostLimiter < 0)
            {
                throw new Error("Forbidden value (" + this.boostLimiter + ") on element boostLimiter.");
            }
            param1.writeInt(this.boostLimiter);
            param1.writeDouble(this.boostMax);
            param1.writeInt(this.reproductionCount);
            if (this.reproductionCountMax < 0)
            {
                throw new Error("Forbidden value (" + this.reproductionCountMax + ") on element reproductionCountMax.");
            }
            param1.writeInt(this.reproductionCountMax);
            param1.writeShort(this.effectList.length);
            var _loc_5:* = 0;
            while (_loc_5 < this.effectList.length)
            {
                
                (this.effectList[_loc_5] as ObjectEffectInteger).serializeAs_ObjectEffectInteger(param1);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MountClientData(param1);
            return;
        }// end function

        public function deserializeAs_MountClientData(param1:IDataInput) : void
        {
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_2:* = param1.readByte();
            this.sex = BooleanByteWrapper.getFlag(_loc_2, 0);
            this.isRideable = BooleanByteWrapper.getFlag(_loc_2, 1);
            this.isWild = BooleanByteWrapper.getFlag(_loc_2, 2);
            this.isFecondationReady = BooleanByteWrapper.getFlag(_loc_2, 3);
            this.id = param1.readDouble();
            this.model = param1.readInt();
            if (this.model < 0)
            {
                throw new Error("Forbidden value (" + this.model + ") on element of MountClientData.model.");
            }
            var _loc_3:* = param1.readUnsignedShort();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_9 = param1.readInt();
                if (_loc_9 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_9 + ") on elements of ancestor.");
                }
                this.ancestor.push(_loc_9);
                _loc_4 = _loc_4 + 1;
            }
            var _loc_5:* = param1.readUnsignedShort();
            var _loc_6:* = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_10 = param1.readInt();
                if (_loc_10 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_10 + ") on elements of behaviors.");
                }
                this.behaviors.push(_loc_10);
                _loc_6 = _loc_6 + 1;
            }
            this.name = param1.readUTF();
            this.ownerId = param1.readInt();
            if (this.ownerId < 0)
            {
                throw new Error("Forbidden value (" + this.ownerId + ") on element of MountClientData.ownerId.");
            }
            this.experience = param1.readDouble();
            this.experienceForLevel = param1.readDouble();
            this.experienceForNextLevel = param1.readDouble();
            this.level = param1.readByte();
            if (this.level < 0)
            {
                throw new Error("Forbidden value (" + this.level + ") on element of MountClientData.level.");
            }
            this.maxPods = param1.readInt();
            if (this.maxPods < 0)
            {
                throw new Error("Forbidden value (" + this.maxPods + ") on element of MountClientData.maxPods.");
            }
            this.stamina = param1.readInt();
            if (this.stamina < 0)
            {
                throw new Error("Forbidden value (" + this.stamina + ") on element of MountClientData.stamina.");
            }
            this.staminaMax = param1.readInt();
            if (this.staminaMax < 0)
            {
                throw new Error("Forbidden value (" + this.staminaMax + ") on element of MountClientData.staminaMax.");
            }
            this.maturity = param1.readInt();
            if (this.maturity < 0)
            {
                throw new Error("Forbidden value (" + this.maturity + ") on element of MountClientData.maturity.");
            }
            this.maturityForAdult = param1.readInt();
            if (this.maturityForAdult < 0)
            {
                throw new Error("Forbidden value (" + this.maturityForAdult + ") on element of MountClientData.maturityForAdult.");
            }
            this.energy = param1.readInt();
            if (this.energy < 0)
            {
                throw new Error("Forbidden value (" + this.energy + ") on element of MountClientData.energy.");
            }
            this.energyMax = param1.readInt();
            if (this.energyMax < 0)
            {
                throw new Error("Forbidden value (" + this.energyMax + ") on element of MountClientData.energyMax.");
            }
            this.serenity = param1.readInt();
            this.aggressivityMax = param1.readInt();
            this.serenityMax = param1.readInt();
            if (this.serenityMax < 0)
            {
                throw new Error("Forbidden value (" + this.serenityMax + ") on element of MountClientData.serenityMax.");
            }
            this.love = param1.readInt();
            if (this.love < 0)
            {
                throw new Error("Forbidden value (" + this.love + ") on element of MountClientData.love.");
            }
            this.loveMax = param1.readInt();
            if (this.loveMax < 0)
            {
                throw new Error("Forbidden value (" + this.loveMax + ") on element of MountClientData.loveMax.");
            }
            this.fecondationTime = param1.readInt();
            this.boostLimiter = param1.readInt();
            if (this.boostLimiter < 0)
            {
                throw new Error("Forbidden value (" + this.boostLimiter + ") on element of MountClientData.boostLimiter.");
            }
            this.boostMax = param1.readDouble();
            this.reproductionCount = param1.readInt();
            this.reproductionCountMax = param1.readInt();
            if (this.reproductionCountMax < 0)
            {
                throw new Error("Forbidden value (" + this.reproductionCountMax + ") on element of MountClientData.reproductionCountMax.");
            }
            var _loc_7:* = param1.readUnsignedShort();
            var _loc_8:* = 0;
            while (_loc_8 < _loc_7)
            {
                
                _loc_11 = new ObjectEffectInteger();
                _loc_11.deserialize(param1);
                this.effectList.push(_loc_11);
                _loc_8 = _loc_8 + 1;
            }
            return;
        }// end function

    }
}
