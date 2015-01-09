package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class GameFightMinimalStats implements INetworkType 
    {

        public static const protocolId:uint = 31;

        public var lifePoints:uint = 0;
        public var maxLifePoints:uint = 0;
        public var baseMaxLifePoints:uint = 0;
        public var permanentDamagePercent:uint = 0;
        public var shieldPoints:uint = 0;
        public var actionPoints:int = 0;
        public var maxActionPoints:int = 0;
        public var movementPoints:int = 0;
        public var maxMovementPoints:int = 0;
        public var summoner:int = 0;
        public var summoned:Boolean = false;
        public var neutralElementResistPercent:int = 0;
        public var earthElementResistPercent:int = 0;
        public var waterElementResistPercent:int = 0;
        public var airElementResistPercent:int = 0;
        public var fireElementResistPercent:int = 0;
        public var neutralElementReduction:int = 0;
        public var earthElementReduction:int = 0;
        public var waterElementReduction:int = 0;
        public var airElementReduction:int = 0;
        public var fireElementReduction:int = 0;
        public var criticalDamageFixedResist:int = 0;
        public var pushDamageFixedResist:int = 0;
        public var dodgePALostProbability:uint = 0;
        public var dodgePMLostProbability:uint = 0;
        public var tackleBlock:int = 0;
        public var tackleEvade:int = 0;
        public var invisibilityState:uint = 0;


        public function getTypeId():uint
        {
            return (31);
        }

        public function initGameFightMinimalStats(lifePoints:uint=0, maxLifePoints:uint=0, baseMaxLifePoints:uint=0, permanentDamagePercent:uint=0, shieldPoints:uint=0, actionPoints:int=0, maxActionPoints:int=0, movementPoints:int=0, maxMovementPoints:int=0, summoner:int=0, summoned:Boolean=false, neutralElementResistPercent:int=0, earthElementResistPercent:int=0, waterElementResistPercent:int=0, airElementResistPercent:int=0, fireElementResistPercent:int=0, neutralElementReduction:int=0, earthElementReduction:int=0, waterElementReduction:int=0, airElementReduction:int=0, fireElementReduction:int=0, criticalDamageFixedResist:int=0, pushDamageFixedResist:int=0, dodgePALostProbability:uint=0, dodgePMLostProbability:uint=0, tackleBlock:int=0, tackleEvade:int=0, invisibilityState:uint=0):GameFightMinimalStats
        {
            this.lifePoints = lifePoints;
            this.maxLifePoints = maxLifePoints;
            this.baseMaxLifePoints = baseMaxLifePoints;
            this.permanentDamagePercent = permanentDamagePercent;
            this.shieldPoints = shieldPoints;
            this.actionPoints = actionPoints;
            this.maxActionPoints = maxActionPoints;
            this.movementPoints = movementPoints;
            this.maxMovementPoints = maxMovementPoints;
            this.summoner = summoner;
            this.summoned = summoned;
            this.neutralElementResistPercent = neutralElementResistPercent;
            this.earthElementResistPercent = earthElementResistPercent;
            this.waterElementResistPercent = waterElementResistPercent;
            this.airElementResistPercent = airElementResistPercent;
            this.fireElementResistPercent = fireElementResistPercent;
            this.neutralElementReduction = neutralElementReduction;
            this.earthElementReduction = earthElementReduction;
            this.waterElementReduction = waterElementReduction;
            this.airElementReduction = airElementReduction;
            this.fireElementReduction = fireElementReduction;
            this.criticalDamageFixedResist = criticalDamageFixedResist;
            this.pushDamageFixedResist = pushDamageFixedResist;
            this.dodgePALostProbability = dodgePALostProbability;
            this.dodgePMLostProbability = dodgePMLostProbability;
            this.tackleBlock = tackleBlock;
            this.tackleEvade = tackleEvade;
            this.invisibilityState = invisibilityState;
            return (this);
        }

        public function reset():void
        {
            this.lifePoints = 0;
            this.maxLifePoints = 0;
            this.baseMaxLifePoints = 0;
            this.permanentDamagePercent = 0;
            this.shieldPoints = 0;
            this.actionPoints = 0;
            this.maxActionPoints = 0;
            this.movementPoints = 0;
            this.maxMovementPoints = 0;
            this.summoner = 0;
            this.summoned = false;
            this.neutralElementResistPercent = 0;
            this.earthElementResistPercent = 0;
            this.waterElementResistPercent = 0;
            this.airElementResistPercent = 0;
            this.fireElementResistPercent = 0;
            this.neutralElementReduction = 0;
            this.earthElementReduction = 0;
            this.waterElementReduction = 0;
            this.airElementReduction = 0;
            this.fireElementReduction = 0;
            this.criticalDamageFixedResist = 0;
            this.pushDamageFixedResist = 0;
            this.dodgePALostProbability = 0;
            this.dodgePMLostProbability = 0;
            this.tackleBlock = 0;
            this.tackleEvade = 0;
            this.invisibilityState = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameFightMinimalStats(output);
        }

        public function serializeAs_GameFightMinimalStats(output:ICustomDataOutput):void
        {
            if (this.lifePoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.lifePoints) + ") on element lifePoints.")));
            };
            output.writeVarInt(this.lifePoints);
            if (this.maxLifePoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxLifePoints) + ") on element maxLifePoints.")));
            };
            output.writeVarInt(this.maxLifePoints);
            if (this.baseMaxLifePoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.baseMaxLifePoints) + ") on element baseMaxLifePoints.")));
            };
            output.writeVarInt(this.baseMaxLifePoints);
            if (this.permanentDamagePercent < 0)
            {
                throw (new Error((("Forbidden value (" + this.permanentDamagePercent) + ") on element permanentDamagePercent.")));
            };
            output.writeVarInt(this.permanentDamagePercent);
            if (this.shieldPoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.shieldPoints) + ") on element shieldPoints.")));
            };
            output.writeVarInt(this.shieldPoints);
            output.writeVarShort(this.actionPoints);
            output.writeVarShort(this.maxActionPoints);
            output.writeVarShort(this.movementPoints);
            output.writeVarShort(this.maxMovementPoints);
            output.writeInt(this.summoner);
            output.writeBoolean(this.summoned);
            output.writeVarShort(this.neutralElementResistPercent);
            output.writeVarShort(this.earthElementResistPercent);
            output.writeVarShort(this.waterElementResistPercent);
            output.writeVarShort(this.airElementResistPercent);
            output.writeVarShort(this.fireElementResistPercent);
            output.writeVarShort(this.neutralElementReduction);
            output.writeVarShort(this.earthElementReduction);
            output.writeVarShort(this.waterElementReduction);
            output.writeVarShort(this.airElementReduction);
            output.writeVarShort(this.fireElementReduction);
            output.writeVarShort(this.criticalDamageFixedResist);
            output.writeVarShort(this.pushDamageFixedResist);
            if (this.dodgePALostProbability < 0)
            {
                throw (new Error((("Forbidden value (" + this.dodgePALostProbability) + ") on element dodgePALostProbability.")));
            };
            output.writeVarShort(this.dodgePALostProbability);
            if (this.dodgePMLostProbability < 0)
            {
                throw (new Error((("Forbidden value (" + this.dodgePMLostProbability) + ") on element dodgePMLostProbability.")));
            };
            output.writeVarShort(this.dodgePMLostProbability);
            output.writeVarShort(this.tackleBlock);
            output.writeVarShort(this.tackleEvade);
            output.writeByte(this.invisibilityState);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightMinimalStats(input);
        }

        public function deserializeAs_GameFightMinimalStats(input:ICustomDataInput):void
        {
            this.lifePoints = input.readVarUhInt();
            if (this.lifePoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.lifePoints) + ") on element of GameFightMinimalStats.lifePoints.")));
            };
            this.maxLifePoints = input.readVarUhInt();
            if (this.maxLifePoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxLifePoints) + ") on element of GameFightMinimalStats.maxLifePoints.")));
            };
            this.baseMaxLifePoints = input.readVarUhInt();
            if (this.baseMaxLifePoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.baseMaxLifePoints) + ") on element of GameFightMinimalStats.baseMaxLifePoints.")));
            };
            this.permanentDamagePercent = input.readVarUhInt();
            if (this.permanentDamagePercent < 0)
            {
                throw (new Error((("Forbidden value (" + this.permanentDamagePercent) + ") on element of GameFightMinimalStats.permanentDamagePercent.")));
            };
            this.shieldPoints = input.readVarUhInt();
            if (this.shieldPoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.shieldPoints) + ") on element of GameFightMinimalStats.shieldPoints.")));
            };
            this.actionPoints = input.readVarShort();
            this.maxActionPoints = input.readVarShort();
            this.movementPoints = input.readVarShort();
            this.maxMovementPoints = input.readVarShort();
            this.summoner = input.readInt();
            this.summoned = input.readBoolean();
            this.neutralElementResistPercent = input.readVarShort();
            this.earthElementResistPercent = input.readVarShort();
            this.waterElementResistPercent = input.readVarShort();
            this.airElementResistPercent = input.readVarShort();
            this.fireElementResistPercent = input.readVarShort();
            this.neutralElementReduction = input.readVarShort();
            this.earthElementReduction = input.readVarShort();
            this.waterElementReduction = input.readVarShort();
            this.airElementReduction = input.readVarShort();
            this.fireElementReduction = input.readVarShort();
            this.criticalDamageFixedResist = input.readVarShort();
            this.pushDamageFixedResist = input.readVarShort();
            this.dodgePALostProbability = input.readVarUhShort();
            if (this.dodgePALostProbability < 0)
            {
                throw (new Error((("Forbidden value (" + this.dodgePALostProbability) + ") on element of GameFightMinimalStats.dodgePALostProbability.")));
            };
            this.dodgePMLostProbability = input.readVarUhShort();
            if (this.dodgePMLostProbability < 0)
            {
                throw (new Error((("Forbidden value (" + this.dodgePMLostProbability) + ") on element of GameFightMinimalStats.dodgePMLostProbability.")));
            };
            this.tackleBlock = input.readVarShort();
            this.tackleEvade = input.readVarShort();
            this.invisibilityState = input.readByte();
            if (this.invisibilityState < 0)
            {
                throw (new Error((("Forbidden value (" + this.invisibilityState) + ") on element of GameFightMinimalStats.invisibilityState.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.fight

