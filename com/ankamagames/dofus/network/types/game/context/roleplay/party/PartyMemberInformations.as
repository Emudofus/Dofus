package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.companion.PartyCompanionMemberInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class PartyMemberInformations extends CharacterBaseInformations implements INetworkType
   {
      
      public function PartyMemberInformations() {
         this.status = new PlayerStatus();
         this.companions = new Vector.<PartyCompanionMemberInformations>();
         super();
      }
      
      public static const protocolId:uint = 90;
      
      public var lifePoints:uint = 0;
      
      public var maxLifePoints:uint = 0;
      
      public var prospecting:uint = 0;
      
      public var regenRate:uint = 0;
      
      public var initiative:uint = 0;
      
      public var alignmentSide:int = 0;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var mapId:int = 0;
      
      public var subAreaId:uint = 0;
      
      public var status:PlayerStatus;
      
      public var companions:Vector.<PartyCompanionMemberInformations>;
      
      override public function getTypeId() : uint {
         return 90;
      }
      
      public function initPartyMemberInformations(param1:uint=0, param2:uint=0, param3:String="", param4:EntityLook=null, param5:int=0, param6:Boolean=false, param7:uint=0, param8:uint=0, param9:uint=0, param10:uint=0, param11:uint=0, param12:int=0, param13:int=0, param14:int=0, param15:int=0, param16:uint=0, param17:PlayerStatus=null, param18:Vector.<PartyCompanionMemberInformations>=null) : PartyMemberInformations {
         super.initCharacterBaseInformations(param1,param2,param3,param4,param5,param6);
         this.lifePoints = param7;
         this.maxLifePoints = param8;
         this.prospecting = param9;
         this.regenRate = param10;
         this.initiative = param11;
         this.alignmentSide = param12;
         this.worldX = param13;
         this.worldY = param14;
         this.mapId = param15;
         this.subAreaId = param16;
         this.status = param17;
         this.companions = param18;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.lifePoints = 0;
         this.maxLifePoints = 0;
         this.prospecting = 0;
         this.regenRate = 0;
         this.initiative = 0;
         this.alignmentSide = 0;
         this.worldX = 0;
         this.worldY = 0;
         this.mapId = 0;
         this.subAreaId = 0;
         this.status = new PlayerStatus();
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_PartyMemberInformations(param1);
      }
      
      public function serializeAs_PartyMemberInformations(param1:IDataOutput) : void {
         super.serializeAs_CharacterBaseInformations(param1);
         if(this.lifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.lifePoints + ") on element lifePoints.");
         }
         else
         {
            param1.writeInt(this.lifePoints);
            if(this.maxLifePoints < 0)
            {
               throw new Error("Forbidden value (" + this.maxLifePoints + ") on element maxLifePoints.");
            }
            else
            {
               param1.writeInt(this.maxLifePoints);
               if(this.prospecting < 0)
               {
                  throw new Error("Forbidden value (" + this.prospecting + ") on element prospecting.");
               }
               else
               {
                  param1.writeShort(this.prospecting);
                  if(this.regenRate < 0 || this.regenRate > 255)
                  {
                     throw new Error("Forbidden value (" + this.regenRate + ") on element regenRate.");
                  }
                  else
                  {
                     param1.writeByte(this.regenRate);
                     if(this.initiative < 0)
                     {
                        throw new Error("Forbidden value (" + this.initiative + ") on element initiative.");
                     }
                     else
                     {
                        param1.writeShort(this.initiative);
                        param1.writeByte(this.alignmentSide);
                        if(this.worldX < -255 || this.worldX > 255)
                        {
                           throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
                        }
                        else
                        {
                           param1.writeShort(this.worldX);
                           if(this.worldY < -255 || this.worldY > 255)
                           {
                              throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
                           }
                           else
                           {
                              param1.writeShort(this.worldY);
                              param1.writeInt(this.mapId);
                              if(this.subAreaId < 0)
                              {
                                 throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
                              }
                              else
                              {
                                 param1.writeShort(this.subAreaId);
                                 param1.writeShort(this.status.getTypeId());
                                 this.status.serialize(param1);
                                 param1.writeShort(this.companions.length);
                                 _loc2_ = 0;
                                 while(_loc2_ < this.companions.length)
                                 {
                                    (this.companions[_loc2_] as PartyCompanionMemberInformations).serializeAs_PartyCompanionMemberInformations(param1);
                                    _loc2_++;
                                 }
                                 return;
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PartyMemberInformations(param1);
      }
      
      public function deserializeAs_PartyMemberInformations(param1:IDataInput) : void {
         var _loc5_:PartyCompanionMemberInformations = null;
         super.deserialize(param1);
         this.lifePoints = param1.readInt();
         if(this.lifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.lifePoints + ") on element of PartyMemberInformations.lifePoints.");
         }
         else
         {
            this.maxLifePoints = param1.readInt();
            if(this.maxLifePoints < 0)
            {
               throw new Error("Forbidden value (" + this.maxLifePoints + ") on element of PartyMemberInformations.maxLifePoints.");
            }
            else
            {
               this.prospecting = param1.readShort();
               if(this.prospecting < 0)
               {
                  throw new Error("Forbidden value (" + this.prospecting + ") on element of PartyMemberInformations.prospecting.");
               }
               else
               {
                  this.regenRate = param1.readUnsignedByte();
                  if(this.regenRate < 0 || this.regenRate > 255)
                  {
                     throw new Error("Forbidden value (" + this.regenRate + ") on element of PartyMemberInformations.regenRate.");
                  }
                  else
                  {
                     this.initiative = param1.readShort();
                     if(this.initiative < 0)
                     {
                        throw new Error("Forbidden value (" + this.initiative + ") on element of PartyMemberInformations.initiative.");
                     }
                     else
                     {
                        this.alignmentSide = param1.readByte();
                        this.worldX = param1.readShort();
                        if(this.worldX < -255 || this.worldX > 255)
                        {
                           throw new Error("Forbidden value (" + this.worldX + ") on element of PartyMemberInformations.worldX.");
                        }
                        else
                        {
                           this.worldY = param1.readShort();
                           if(this.worldY < -255 || this.worldY > 255)
                           {
                              throw new Error("Forbidden value (" + this.worldY + ") on element of PartyMemberInformations.worldY.");
                           }
                           else
                           {
                              this.mapId = param1.readInt();
                              this.subAreaId = param1.readShort();
                              if(this.subAreaId < 0)
                              {
                                 throw new Error("Forbidden value (" + this.subAreaId + ") on element of PartyMemberInformations.subAreaId.");
                              }
                              else
                              {
                                 _loc2_ = param1.readUnsignedShort();
                                 this.status = ProtocolTypeManager.getInstance(PlayerStatus,_loc2_);
                                 this.status.deserialize(param1);
                                 _loc3_ = param1.readUnsignedShort();
                                 _loc4_ = 0;
                                 while(_loc4_ < _loc3_)
                                 {
                                    _loc5_ = new PartyCompanionMemberInformations();
                                    _loc5_.deserialize(param1);
                                    this.companions.push(_loc5_);
                                    _loc4_++;
                                 }
                                 return;
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
   }
}
