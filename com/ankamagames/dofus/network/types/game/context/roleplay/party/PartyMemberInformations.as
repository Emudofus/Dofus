package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;


   public class PartyMemberInformations extends CharacterBaseInformations implements INetworkType
   {
         

      public function PartyMemberInformations() {
         this.status=new PlayerStatus();
         super();
      }

      public static const protocolId:uint = 90;

      public var lifePoints:uint = 0;

      public var maxLifePoints:uint = 0;

      public var prospecting:uint = 0;

      public var regenRate:uint = 0;

      public var initiative:uint = 0;

      public var pvpEnabled:Boolean = false;

      public var alignmentSide:int = 0;

      public var worldX:int = 0;

      public var worldY:int = 0;

      public var mapId:int = 0;

      public var subAreaId:uint = 0;

      public var status:PlayerStatus;

      override public function getTypeId() : uint {
         return 90;
      }

      public function initPartyMemberInformations(id:uint=0, level:uint=0, name:String="", entityLook:EntityLook=null, breed:int=0, sex:Boolean=false, lifePoints:uint=0, maxLifePoints:uint=0, prospecting:uint=0, regenRate:uint=0, initiative:uint=0, pvpEnabled:Boolean=false, alignmentSide:int=0, worldX:int=0, worldY:int=0, mapId:int=0, subAreaId:uint=0, status:PlayerStatus=null) : PartyMemberInformations {
         super.initCharacterBaseInformations(id,level,name,entityLook,breed,sex);
         this.lifePoints=lifePoints;
         this.maxLifePoints=maxLifePoints;
         this.prospecting=prospecting;
         this.regenRate=regenRate;
         this.initiative=initiative;
         this.pvpEnabled=pvpEnabled;
         this.alignmentSide=alignmentSide;
         this.worldX=worldX;
         this.worldY=worldY;
         this.mapId=mapId;
         this.subAreaId=subAreaId;
         this.status=status;
         return this;
      }

      override public function reset() : void {
         super.reset();
         this.lifePoints=0;
         this.maxLifePoints=0;
         this.prospecting=0;
         this.regenRate=0;
         this.initiative=0;
         this.pvpEnabled=false;
         this.alignmentSide=0;
         this.worldX=0;
         this.worldY=0;
         this.mapId=0;
         this.subAreaId=0;
         this.status=new PlayerStatus();
      }

      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_PartyMemberInformations(output);
      }

      public function serializeAs_PartyMemberInformations(output:IDataOutput) : void {
         super.serializeAs_CharacterBaseInformations(output);
         if(this.lifePoints<0)
         {
            throw new Error("Forbidden value ("+this.lifePoints+") on element lifePoints.");
         }
         else
         {
            output.writeInt(this.lifePoints);
            if(this.maxLifePoints<0)
            {
               throw new Error("Forbidden value ("+this.maxLifePoints+") on element maxLifePoints.");
            }
            else
            {
               output.writeInt(this.maxLifePoints);
               if(this.prospecting<0)
               {
                  throw new Error("Forbidden value ("+this.prospecting+") on element prospecting.");
               }
               else
               {
                  output.writeShort(this.prospecting);
                  if((this.regenRate>0)||(this.regenRate<255))
                  {
                     throw new Error("Forbidden value ("+this.regenRate+") on element regenRate.");
                  }
                  else
                  {
                     output.writeByte(this.regenRate);
                     if(this.initiative<0)
                     {
                        throw new Error("Forbidden value ("+this.initiative+") on element initiative.");
                     }
                     else
                     {
                        output.writeShort(this.initiative);
                        output.writeBoolean(this.pvpEnabled);
                        output.writeByte(this.alignmentSide);
                        if((this.worldX>-255)||(this.worldX<255))
                        {
                           throw new Error("Forbidden value ("+this.worldX+") on element worldX.");
                        }
                        else
                        {
                           output.writeShort(this.worldX);
                           if((this.worldY>-255)||(this.worldY<255))
                           {
                              throw new Error("Forbidden value ("+this.worldY+") on element worldY.");
                           }
                           else
                           {
                              output.writeShort(this.worldY);
                              output.writeInt(this.mapId);
                              if(this.subAreaId<0)
                              {
                                 throw new Error("Forbidden value ("+this.subAreaId+") on element subAreaId.");
                              }
                              else
                              {
                                 output.writeShort(this.subAreaId);
                                 output.writeShort(this.status.getTypeId());
                                 this.status.serialize(output);
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
         super.deserialize(input);
         this.lifePoints=input.readInt();
         if(this.lifePoints<0)
         {
            throw new Error("Forbidden value ("+this.lifePoints+") on element of PartyMemberInformations.lifePoints.");
         }
         else
         {
            this.maxLifePoints=input.readInt();
            if(this.maxLifePoints<0)
            {
               throw new Error("Forbidden value ("+this.maxLifePoints+") on element of PartyMemberInformations.maxLifePoints.");
            }
            else
            {
               this.prospecting=input.readShort();
               if(this.prospecting<0)
               {
                  throw new Error("Forbidden value ("+this.prospecting+") on element of PartyMemberInformations.prospecting.");
               }
               else
               {
                  this.regenRate=input.readUnsignedByte();
                  if((this.regenRate>0)||(this.regenRate<255))
                  {
                     throw new Error("Forbidden value ("+this.regenRate+") on element of PartyMemberInformations.regenRate.");
                  }
                  else
                  {
                     this.initiative=input.readShort();
                     if(this.initiative<0)
                     {
                        throw new Error("Forbidden value ("+this.initiative+") on element of PartyMemberInformations.initiative.");
                     }
                     else
                     {
                        this.pvpEnabled=input.readBoolean();
                        this.alignmentSide=input.readByte();
                        this.worldX=input.readShort();
                        if((this.worldX>-255)||(this.worldX<255))
                        {
                           throw new Error("Forbidden value ("+this.worldX+") on element of PartyMemberInformations.worldX.");
                        }
                        else
                        {
                           this.worldY=input.readShort();
                           if((this.worldY>-255)||(this.worldY<255))
                           {
                              throw new Error("Forbidden value ("+this.worldY+") on element of PartyMemberInformations.worldY.");
                           }
                           else
                           {
                              this.mapId=input.readInt();
                              this.subAreaId=input.readShort();
                              if(this.subAreaId<0)
                              {
                                 throw new Error("Forbidden value ("+this.subAreaId+") on element of PartyMemberInformations.subAreaId.");
                              }
                              else
                              {
                                 _id12=input.readUnsignedShort();
                                 this.status=ProtocolTypeManager.getInstance(PlayerStatus,_id12);
                                 this.status.deserialize(input);
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