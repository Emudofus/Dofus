package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.companion.PartyCompanionBaseInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class PartyInvitationMemberInformations extends CharacterBaseInformations implements INetworkType
   {
      
      public function PartyInvitationMemberInformations() {
         this.companions = new Vector.<PartyCompanionBaseInformations>();
         super();
      }
      
      public static const protocolId:uint = 376;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var mapId:int = 0;
      
      public var subAreaId:uint = 0;
      
      public var companions:Vector.<PartyCompanionBaseInformations>;
      
      override public function getTypeId() : uint {
         return 376;
      }
      
      public function initPartyInvitationMemberInformations(id:uint=0, level:uint=0, name:String="", entityLook:EntityLook=null, breed:int=0, sex:Boolean=false, worldX:int=0, worldY:int=0, mapId:int=0, subAreaId:uint=0, companions:Vector.<PartyCompanionBaseInformations>=null) : PartyInvitationMemberInformations {
         super.initCharacterBaseInformations(id,level,name,entityLook,breed,sex);
         this.worldX = worldX;
         this.worldY = worldY;
         this.mapId = mapId;
         this.subAreaId = subAreaId;
         this.companions = companions;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.worldX = 0;
         this.worldY = 0;
         this.mapId = 0;
         this.subAreaId = 0;
         this.companions = new Vector.<PartyCompanionBaseInformations>();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_PartyInvitationMemberInformations(output);
      }
      
      public function serializeAs_PartyInvitationMemberInformations(output:IDataOutput) : void {
         super.serializeAs_CharacterBaseInformations(output);
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
                  output.writeShort(this.companions.length);
                  _i5 = 0;
                  while(_i5 < this.companions.length)
                  {
                     (this.companions[_i5] as PartyCompanionBaseInformations).serializeAs_PartyCompanionBaseInformations(output);
                     _i5++;
                  }
                  return;
               }
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyInvitationMemberInformations(input);
      }
      
      public function deserializeAs_PartyInvitationMemberInformations(input:IDataInput) : void {
         var _item5:PartyCompanionBaseInformations = null;
         super.deserialize(input);
         this.worldX = input.readShort();
         if((this.worldX < -255) || (this.worldX > 255))
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of PartyInvitationMemberInformations.worldX.");
         }
         else
         {
            this.worldY = input.readShort();
            if((this.worldY < -255) || (this.worldY > 255))
            {
               throw new Error("Forbidden value (" + this.worldY + ") on element of PartyInvitationMemberInformations.worldY.");
            }
            else
            {
               this.mapId = input.readInt();
               this.subAreaId = input.readShort();
               if(this.subAreaId < 0)
               {
                  throw new Error("Forbidden value (" + this.subAreaId + ") on element of PartyInvitationMemberInformations.subAreaId.");
               }
               else
               {
                  _companionsLen = input.readUnsignedShort();
                  _i5 = 0;
                  while(_i5 < _companionsLen)
                  {
                     _item5 = new PartyCompanionBaseInformations();
                     _item5.deserialize(input);
                     this.companions.push(_item5);
                     _i5++;
                  }
                  return;
               }
            }
         }
      }
   }
}
