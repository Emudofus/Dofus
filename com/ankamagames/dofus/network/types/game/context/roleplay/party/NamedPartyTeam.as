package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class NamedPartyTeam extends Object implements INetworkType
   {
      
      public function NamedPartyTeam()
      {
         super();
      }
      
      public static const protocolId:uint = 469;
      
      public var teamId:uint = 2;
      
      public var partyName:String = "";
      
      public function getTypeId() : uint
      {
         return 469;
      }
      
      public function initNamedPartyTeam(param1:uint = 2, param2:String = "") : NamedPartyTeam
      {
         this.teamId = param1;
         this.partyName = param2;
         return this;
      }
      
      public function reset() : void
      {
         this.teamId = 2;
         this.partyName = "";
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_NamedPartyTeam(param1);
      }
      
      public function serializeAs_NamedPartyTeam(param1:ICustomDataOutput) : void
      {
         param1.writeByte(this.teamId);
         param1.writeUTF(this.partyName);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_NamedPartyTeam(param1);
      }
      
      public function deserializeAs_NamedPartyTeam(param1:ICustomDataInput) : void
      {
         this.teamId = param1.readByte();
         if(this.teamId < 0)
         {
            throw new Error("Forbidden value (" + this.teamId + ") on element of NamedPartyTeam.teamId.");
         }
         else
         {
            this.partyName = param1.readUTF();
            return;
         }
      }
   }
}
