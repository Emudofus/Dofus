package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.companion.PartyCompanionMemberInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import __AS3__.vec.*;
   
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
      
      public function initPartyMemberInformations(id:uint=0, level:uint=0, name:String="", entityLook:EntityLook=null, breed:int=0, sex:Boolean=false, lifePoints:uint=0, maxLifePoints:uint=0, prospecting:uint=0, regenRate:uint=0, initiative:uint=0, alignmentSide:int=0, worldX:int=0, worldY:int=0, mapId:int=0, subAreaId:uint=0, status:PlayerStatus=null, companions:Vector.<PartyCompanionMemberInformations>=null) : PartyMemberInformations {
         super.initCharacterBaseInformations(id,level,name,entityLook,breed,sex);
         this.lifePoints = lifePoints;
         this.maxLifePoints = maxLifePoints;
         this.prospecting = prospecting;
         this.regenRate = regenRate;
         this.initiative = initiative;
         this.alignmentSide = alignmentSide;
         this.worldX = worldX;
         this.worldY = worldY;
         this.mapId = mapId;
         this.subAreaId = subAreaId;
         this.status = status;
         this.companions = companions;
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_PartyMemberInformations(output);
      }
      
      public function serializeAs_PartyMemberInformations(output:IDataOutput) : void {
         super.serializeAs_CharacterBaseInformations(output);
         if(this.lifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.lifePoints + ") on element lifePoints.");
         }
         else
         {
            output.writeInt(this.lifePoints);
            if(this.maxLifePoints < 0)
            {
               throw new Error("Forbidden value (" + this.maxLifePoints + ") on element maxLifePoints.");
            }
            else
            {
               output.writeInt(this.maxLifePoints);
               if(this.prospecting < 0)
               {
                  throw new Error("Forbidden value (" + this.prospecting + ") on element prospecting.");
               }
               else
               {
                  output.writeShort(this.prospecting);
                  if((this.regenRate < 0) || (this.regenRate > 255))
                  {
                     throw new Error("Forbidden value (" + this.regenRate + ") on element regenRate.");
                  }
                  else
                  {
                     output.writeByte(this.regenRate);
                     if(this.initiative < 0)
                     {
                        throw new Error("Forbidden value (" + this.initiative + ") on element initiative.");
                     }
                     else
                     {
                        output.writeShort(this.initiative);
                        output.writeByte(this.alignmentSide);
                        if((this.worldX < -255) || (this.worldX > 255))
                        {
                           throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
                        }
                        else
                        {
                           output.writeShort(this.worldX);
                           if((this.worldY < -255) || (this.worldY > 255))
                           {
                              throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
                           }
                           else
                           {
                              output.writeShort(this.worldY);
                              output.writeInt(this.mapId);
                              if(this.subAreaId < 0)
                              {
                                 throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
                              }
                              else
                              {
                                 output.writeShort(this.subAreaId);
                                 output.writeShort(this.status.getTypeId());
                                 this.status.serialize(output);
                                 output.writeShort(this.companions.length);
                                 _i12 = 0;
                                 while(_i12 < this.companions.length)
                                 {
                                    (this.companions[_i12] as PartyCompanionMemberInformations).serializeAs_PartyCompanionMemberInformations(output);
                                    _i12++;
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
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyMemberInformations(input);
      }
      
      public function deserializeAs_PartyMemberInformations(input:IDataInput) : void {
         var _item12:PartyCompanionMemberInformations = null;
         super.deserialize(input);
         this.lifePoints = input.readInt();
         if(this.lifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.lifePoints + ") on element of PartyMemberInformations.lifePoints.");
         }
         else
         {
            this.maxLifePoints = input.readInt();
            if(this.maxLifePoints < 0)
            {
               throw new Error("Forbidden value (" + this.maxLifePoints + ") on element of PartyMemberInformations.maxLifePoints.");
            }
            else
            {
               this.prospecting = input.readShort();
               if(this.prospecting < 0)
               {
                  throw new Error("Forbidden value (" + this.prospecting + ") on element of PartyMemberInformations.prospecting.");
               }
               else
               {
                  this.regenRate = input.readUnsignedByte();
                  if((this.regenRate < 0) || (this.regenRate > 255))
                  {
                     throw new Error("Forbidden value (" + this.regenRate + ") on element of PartyMemberInformations.regenRate.");
                  }
                  else
                  {
                     this.initiative = input.readShort();
                     if(this.initiative < 0)
                     {
                        throw new Error("Forbidden value (" + this.initiative + ") on element of PartyMemberInformations.initiative.");
                     }
                     else
                     {
                        this.alignmentSide = input.readByte();
                        this.worldX = input.readShort();
                        if((this.worldX < -255) || (this.worldX > 255))
                        {
                           throw new Error("Forbidden value (" + this.worldX + ") on element of PartyMemberInformations.worldX.");
                        }
                        else
                        {
                           this.worldY = input.readShort();
                           if((this.worldY < -255) || (this.worldY > 255))
                           {
                              throw new Error("Forbidden value (" + this.worldY + ") on element of PartyMemberInformations.worldY.");
                           }
                           else
                           {
                              this.mapId = input.readInt();
                              this.subAreaId = input.readShort();
                              if(this.subAreaId < 0)
                              {
                                 throw new Error("Forbidden value (" + this.subAreaId + ") on element of PartyMemberInformations.subAreaId.");
                              }
                              else
                              {
                                 _id11 = input.readUnsignedShort();
                                 this.status = ProtocolTypeManager.getInstance(PlayerStatus,_id11);
                                 this.status.deserialize(input);
                                 _companionsLen = input.readUnsignedShort();
                                 _i12 = 0;
                                 while(_i12 < _companionsLen)
                                 {
                                    _item12 = new PartyCompanionMemberInformations();
                                    _item12.deserialize(input);
                                    this.companions.push(_item12);
                                    _i12++;
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
