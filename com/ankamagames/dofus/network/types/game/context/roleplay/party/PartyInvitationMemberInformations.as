package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;


   public class PartyInvitationMemberInformations extends CharacterBaseInformations implements INetworkType
   {
         

      public function PartyInvitationMemberInformations() {
         super();
      }

      public static const protocolId:uint = 376;

      public var worldX:int = 0;

      public var worldY:int = 0;

      public var mapId:int = 0;

      public var subAreaId:uint = 0;

      override public function getTypeId() : uint {
         return 376;
      }

      public function initPartyInvitationMemberInformations(id:uint=0, level:uint=0, name:String="", entityLook:EntityLook=null, breed:int=0, sex:Boolean=false, worldX:int=0, worldY:int=0, mapId:int=0, subAreaId:uint=0) : PartyInvitationMemberInformations {
         super.initCharacterBaseInformations(id,level,name,entityLook,breed,sex);
         this.worldX=worldX;
         this.worldY=worldY;
         this.mapId=mapId;
         this.subAreaId=subAreaId;
         return this;
      }

      override public function reset() : void {
         super.reset();
         this.worldX=0;
         this.worldY=0;
         this.mapId=0;
         this.subAreaId=0;
      }

      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_PartyInvitationMemberInformations(output);
      }

      public function serializeAs_PartyInvitationMemberInformations(output:IDataOutput) : void {
         super.serializeAs_CharacterBaseInformations(output);
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
                  return;
               }
            }
         }
      }

      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyInvitationMemberInformations(input);
      }

      public function deserializeAs_PartyInvitationMemberInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.worldX=input.readShort();
         if((this.worldX>-255)||(this.worldX<255))
         {
            throw new Error("Forbidden value ("+this.worldX+") on element of PartyInvitationMemberInformations.worldX.");
         }
         else
         {
            this.worldY=input.readShort();
            if((this.worldY>-255)||(this.worldY<255))
            {
               throw new Error("Forbidden value ("+this.worldY+") on element of PartyInvitationMemberInformations.worldY.");
            }
            else
            {
               this.mapId=input.readInt();
               this.subAreaId=input.readShort();
               if(this.subAreaId<0)
               {
                  throw new Error("Forbidden value ("+this.subAreaId+") on element of PartyInvitationMemberInformations.subAreaId.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }

}