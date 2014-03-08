package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.companion.PartyCompanionBaseInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
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
      
      public function initPartyInvitationMemberInformations(param1:uint=0, param2:uint=0, param3:String="", param4:EntityLook=null, param5:int=0, param6:Boolean=false, param7:int=0, param8:int=0, param9:int=0, param10:uint=0, param11:Vector.<PartyCompanionBaseInformations>=null) : PartyInvitationMemberInformations {
         super.initCharacterBaseInformations(param1,param2,param3,param4,param5,param6);
         this.worldX = param7;
         this.worldY = param8;
         this.mapId = param9;
         this.subAreaId = param10;
         this.companions = param11;
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_PartyInvitationMemberInformations(param1);
      }
      
      public function serializeAs_PartyInvitationMemberInformations(param1:IDataOutput) : void {
         super.serializeAs_CharacterBaseInformations(param1);
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
                  param1.writeShort(this.companions.length);
                  _loc2_ = 0;
                  while(_loc2_ < this.companions.length)
                  {
                     (this.companions[_loc2_] as PartyCompanionBaseInformations).serializeAs_PartyCompanionBaseInformations(param1);
                     _loc2_++;
                  }
                  return;
               }
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PartyInvitationMemberInformations(param1);
      }
      
      public function deserializeAs_PartyInvitationMemberInformations(param1:IDataInput) : void {
         var _loc4_:PartyCompanionBaseInformations = null;
         super.deserialize(param1);
         this.worldX = param1.readShort();
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of PartyInvitationMemberInformations.worldX.");
         }
         else
         {
            this.worldY = param1.readShort();
            if(this.worldY < -255 || this.worldY > 255)
            {
               throw new Error("Forbidden value (" + this.worldY + ") on element of PartyInvitationMemberInformations.worldY.");
            }
            else
            {
               this.mapId = param1.readInt();
               this.subAreaId = param1.readShort();
               if(this.subAreaId < 0)
               {
                  throw new Error("Forbidden value (" + this.subAreaId + ") on element of PartyInvitationMemberInformations.subAreaId.");
               }
               else
               {
                  _loc2_ = param1.readUnsignedShort();
                  _loc3_ = 0;
                  while(_loc3_ < _loc2_)
                  {
                     _loc4_ = new PartyCompanionBaseInformations();
                     _loc4_.deserialize(param1);
                     this.companions.push(_loc4_);
                     _loc3_++;
                  }
                  return;
               }
            }
         }
      }
   }
}
