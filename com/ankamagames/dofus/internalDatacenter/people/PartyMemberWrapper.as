package com.ankamagames.dofus.internalDatacenter.people
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;


   public class PartyMemberWrapper extends Object implements IDataCenter
   {
         

      public function PartyMemberWrapper(id:int, name:String, status:uint, isMember:Boolean, isLeader:Boolean=false, level:int=0, entityLook:EntityLook=null, lifePoints:int=0, maxLifePoints:int=0, maxInitiative:int=0, prospecting:int=0, pvpEnabled:Boolean=false, alignmentSide:int=0, regenRate:int=0, rank:int=0, worldX:int=0, worldY:int=0, mapId:int=0, subAreaId:int=0) {
         super();
         this.id=id;
         this.name=name;
         this.isMember=isMember;
         this.isLeader=isLeader;
         this.level=level;
         this.entityLook=entityLook;
         this.lifePoints=lifePoints;
         this.maxLifePoints=maxLifePoints;
         this.maxInitiative=maxInitiative;
         this.prospecting=prospecting;
         this.pvpEnabled=pvpEnabled;
         this.alignmentSide=alignmentSide;
         this.regenRate=regenRate;
         this.rank=rank;
         this.worldX=worldX;
         this.worldY=worldY;
         this.mapId=mapId;
         this.subAreaId=subAreaId;
         this.status=status;
      }



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

      public var status:uint = 1;

      public function get initiative() : int {
         return this.maxInitiative*this.lifePoints/this.maxLifePoints;
      }
   }

}