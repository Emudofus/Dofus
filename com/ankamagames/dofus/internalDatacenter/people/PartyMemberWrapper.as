package com.ankamagames.dofus.internalDatacenter.people
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   
   public class PartyMemberWrapper extends Object implements IDataCenter
   {
      
      public function PartyMemberWrapper(param1:int, param2:String, param3:uint, param4:Boolean, param5:Boolean=false, param6:int=0, param7:EntityLook=null, param8:int=0, param9:int=0, param10:int=0, param11:int=0, param12:int=0, param13:int=0, param14:int=0, param15:int=0, param16:int=0, param17:int=0, param18:int=0, param19:int=0, param20:Array=null) {
         this.companions = new Array();
         super();
         this.id = param1;
         this.name = param2;
         this.isMember = param4;
         this.isLeader = param5;
         this.level = param6;
         this.entityLook = param7;
         this.breedId = param19;
         this.lifePoints = param8;
         this.maxLifePoints = param9;
         this.maxInitiative = param10;
         this.prospecting = param11;
         this.alignmentSide = param12;
         this.regenRate = param13;
         this.rank = param14;
         this.worldX = param15;
         this.worldY = param16;
         this.mapId = param17;
         this.subAreaId = param18;
         this.status = param3;
         if(!param20)
         {
            this.companions = new Array();
         }
         else
         {
            this.companions = param20;
         }
      }
      
      public var id:int;
      
      public var name:String;
      
      public var isMember:Boolean;
      
      public var isLeader:Boolean;
      
      public var level:int;
      
      public var breedId:int;
      
      public var entityLook:EntityLook;
      
      public var lifePoints:int;
      
      public var maxLifePoints:int;
      
      public var maxInitiative:int;
      
      public var prospecting:int;
      
      public var rank:int;
      
      public var alignmentSide:int;
      
      public var regenRate:int;
      
      public var hostId:int;
      
      public var hostName:String;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var mapId:int = 0;
      
      public var subAreaId:uint = 0;
      
      public var status:uint = 1;
      
      public var companions:Array;
      
      public function get initiative() : int {
         return this.maxInitiative * this.lifePoints / this.maxLifePoints;
      }
   }
}
