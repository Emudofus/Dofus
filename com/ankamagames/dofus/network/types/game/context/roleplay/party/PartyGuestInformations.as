package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.companion.PartyCompanionBaseInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class PartyGuestInformations extends Object implements INetworkType
   {
      
      public function PartyGuestInformations()
      {
         this.guestLook = new EntityLook();
         this.status = new PlayerStatus();
         this.companions = new Vector.<PartyCompanionBaseInformations>();
         super();
      }
      
      public static const protocolId:uint = 374;
      
      public var guestId:uint = 0;
      
      public var hostId:uint = 0;
      
      public var name:String = "";
      
      public var guestLook:EntityLook;
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public var status:PlayerStatus;
      
      public var companions:Vector.<PartyCompanionBaseInformations>;
      
      public function getTypeId() : uint
      {
         return 374;
      }
      
      public function initPartyGuestInformations(param1:uint = 0, param2:uint = 0, param3:String = "", param4:EntityLook = null, param5:int = 0, param6:Boolean = false, param7:PlayerStatus = null, param8:Vector.<PartyCompanionBaseInformations> = null) : PartyGuestInformations
      {
         this.guestId = param1;
         this.hostId = param2;
         this.name = param3;
         this.guestLook = param4;
         this.breed = param5;
         this.sex = param6;
         this.status = param7;
         this.companions = param8;
         return this;
      }
      
      public function reset() : void
      {
         this.guestId = 0;
         this.hostId = 0;
         this.name = "";
         this.guestLook = new EntityLook();
         this.sex = false;
         this.status = new PlayerStatus();
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_PartyGuestInformations(param1);
      }
      
      public function serializeAs_PartyGuestInformations(param1:ICustomDataOutput) : void
      {
         if(this.guestId < 0)
         {
            throw new Error("Forbidden value (" + this.guestId + ") on element guestId.");
         }
         else
         {
            param1.writeInt(this.guestId);
            if(this.hostId < 0)
            {
               throw new Error("Forbidden value (" + this.hostId + ") on element hostId.");
            }
            else
            {
               param1.writeInt(this.hostId);
               param1.writeUTF(this.name);
               this.guestLook.serializeAs_EntityLook(param1);
               param1.writeByte(this.breed);
               param1.writeBoolean(this.sex);
               param1.writeShort(this.status.getTypeId());
               this.status.serialize(param1);
               param1.writeShort(this.companions.length);
               var _loc2_:uint = 0;
               while(_loc2_ < this.companions.length)
               {
                  (this.companions[_loc2_] as PartyCompanionBaseInformations).serializeAs_PartyCompanionBaseInformations(param1);
                  _loc2_++;
               }
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_PartyGuestInformations(param1);
      }
      
      public function deserializeAs_PartyGuestInformations(param1:ICustomDataInput) : void
      {
         var _loc5_:PartyCompanionBaseInformations = null;
         this.guestId = param1.readInt();
         if(this.guestId < 0)
         {
            throw new Error("Forbidden value (" + this.guestId + ") on element of PartyGuestInformations.guestId.");
         }
         else
         {
            this.hostId = param1.readInt();
            if(this.hostId < 0)
            {
               throw new Error("Forbidden value (" + this.hostId + ") on element of PartyGuestInformations.hostId.");
            }
            else
            {
               this.name = param1.readUTF();
               this.guestLook = new EntityLook();
               this.guestLook.deserialize(param1);
               this.breed = param1.readByte();
               this.sex = param1.readBoolean();
               var _loc2_:uint = param1.readUnsignedShort();
               this.status = ProtocolTypeManager.getInstance(PlayerStatus,_loc2_);
               this.status.deserialize(param1);
               var _loc3_:uint = param1.readUnsignedShort();
               var _loc4_:uint = 0;
               while(_loc4_ < _loc3_)
               {
                  _loc5_ = new PartyCompanionBaseInformations();
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
