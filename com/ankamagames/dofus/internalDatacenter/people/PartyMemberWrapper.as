package com.ankamagames.dofus.internalDatacenter.people
{
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class PartyMemberWrapper extends Object implements IDataCenter
    {
        public var id:int;
        public var name:String;
        public var isMember:Boolean;
        public var isLeader:Boolean;
        public var level:int;
        public var entityLook:EntityLook;
        public var lifePoints:int;
        public var maxLifePoints:int;
        public var maxInitiative:int;
        public var prospecting:int;
        public var rank:int;
        public var pvpEnabled:Boolean;
        public var alignmentSide:int;
        public var regenRate:int;
        public var hostId:int;
        public var hostName:String;
        public var breed:uint;
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var mapId:int = 0;
        public var subAreaId:uint = 0;

        public function PartyMemberWrapper(param1:int, param2:String, param3:Boolean, param4:Boolean = false, param5:int = 0, param6:EntityLook = null, param7:int = 0, param8:int = 0, param9:int = 0, param10:int = 0, param11:Boolean = false, param12:int = 0, param13:int = 0, param14:int = 0, param15:int = 0, param16:int = 0, param17:int = 0, param18:int = 0)
        {
            this.id = param1;
            this.name = param2;
            this.isMember = param3;
            this.isLeader = param4;
            this.level = param5;
            this.entityLook = param6;
            this.lifePoints = param7;
            this.maxLifePoints = param8;
            this.maxInitiative = param9;
            this.prospecting = param10;
            this.pvpEnabled = param11;
            this.alignmentSide = param12;
            this.regenRate = param13;
            this.rank = param14;
            this.worldX = param15;
            this.worldY = param16;
            this.mapId = param17;
            this.subAreaId = param18;
            return;
        }// end function

        public function get initiative() : int
        {
            return this.maxInitiative * this.lifePoints / this.maxLifePoints;
        }// end function

    }
}
